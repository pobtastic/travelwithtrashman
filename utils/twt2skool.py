#!/usr/bin/env python3
import sys
import os
import argparse
import datetime
from collections import OrderedDict

try:
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool
except ImportError:
    SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
    if not SKOOLKIT_HOME:
        sys.stderr.write('SKOOLKIT_HOME is not set; aborting\n')
        sys.exit(1)
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}; directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool

TWT_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD_DIR = '{}/sources'.format(TWT_HOME)
TWT_Z80 = '{}/TravelWithTrashman.z80'.format(TWT_HOME)


class TravelWithTrashman:
    def __init__(self, snapshot):
        self.snapshot = snapshot

    def get_address(self, address):
        return (self.snapshot[address + 0x01] * 0x100) + self.snapshot[address]

    def get_location_data(self):
        lines = []

        locations = {
            0xAAAE: {
                'Name': 'Paris',
                'Data': 0x8EB2
            },
            0xB0CA: {
                'Name': 'Jerusalem',
                'Data': 0x8EF9
            },
            0xB496: {
                'Name': 'Madrid',
                'Data': 0x8E9A
            },
            0xBA76: {
                'Name': 'Munich',
                'Data': 0x8EC9
            },
            0xC146: {
                'Name': 'Hong Kong',
                'Data': 0x8F2D
            },
            0xC753: {
                'Name': 'Moscow',
                'Data': 0x8EE1
            },
            0xC9DD: {
                'Name': 'Alice Springs',
                'Data': 0x8F48
            },
            0xD1E8: {
                'Name': 'Samoa',
                'Data': 0x8F67
            },
            0xD67D: {
                'Name': 'Benares',
                'Data': 0x8F14
            },
            0xDA90: {
                'Name': 'Chichen Itza',
                'Data': 0x8F7E
            },
            0xDE4C: {
                'Name': 'New Orleans',
                'Data': 0x8F9C
            },
            0xE10B: {
                'Name': 'Kanyu',
                'Data': 0x8FB9
            },
            0xE716: {
                'Name': 'Sao Paulo',
                'Data': 0x8FD0
            }
        }

        for addr, location in locations.items():
            machine_name = ''.join(location['Name'].split())
            lines.append(f"g ${addr:04X} Sub-Game Data: {location['Name']}")
            lines.append(f'@ ${addr:04X} label={machine_name}_Data')
            lines.append(f"D ${addr:04X} #PUSHS #UDGTABLE {{ #LOCATION(${location['Data']:04X})({'-'.join(location['Name'].split()).lower()}) }} UDGTABLE# #POPS")

            one = self.get_address(addr)
            lines.append(f'W ${addr:04X},$02 #R${one:04X}')

            addr = addr + 0x02
            two = self.get_address(addr)
            lines.append(f'W ${addr:04X},$02 #R${two:04X}')

            addr = addr + 0x02
            three = self.get_address(addr)
            lines.append(f'W ${addr:04X},$02 #R${three:04X}')

            addr = addr + 0x02
            four = self.get_address(addr)
            lines.append(f'W ${addr:04X},$02 #R${four:04X}')

            addr = addr + 0x02
            lines.append(f'B ${addr:04X},$01')

            addr = addr + 0x01
            five = self.get_address(addr)
            lines.append(f'W ${addr:04X},$02 #R${five:04X}')

            addr = addr + 0x02
            lines.append(f'W ${addr:04X},$02')

            addr = addr + 0x02
            lines.append(f'W ${addr:04X},$02 Location subgame routine.')
            lines.append(f'@ ${addr:04X} label={machine_name}_SubGame')

            addr = addr + 0x02
            lines.append(f'W ${addr:04X},$02 Initialisation routine.')
            lines.append(f'@ ${addr:04X} label={machine_name}_SetUp')

            lines.append('')

            lines.append(f'b ${two:04X}')
            lines.append('')

            lines.append(f'b ${one:04X}')
            lines.append('')

        return '\n'.join(lines)

    def get_source_code_data(self):
        lines = []
        addr = 0x7800
        start = 0x7800
        end = 0x8000
        count = 0x00
        now = datetime.datetime.now()

        lines.append(f'; Copyright New Generation Software 1984, {now.strftime("%Y")} ArcadeGeek LTD.')
        lines.append('; NOTE: Disassembly is Work-In-Progress.')
        lines.append('; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.')
        lines.append('')
        lines.append(f't ${addr:04X} Source Code Remnants')

        while addr <= end:
            if self.snapshot[addr] == 0x0D:
                lines.append(f'  ${start:04X},${count:02X} "#STR(#PC,$04,${count:02X})".')
                lines.append(f'B ${addr:04X},$01 Newline.')
                start = addr + 0x01
                count = 0x00
            else:
                count+=0x01
            addr+=0x01

        lines.append('')
        lines.append('i $8000')

        return '\n'.join(lines)

def run(subcommand):
    if not os.path.isdir(BUILD_DIR):
        os.mkdir(BUILD_DIR)
    if not os.path.isfile(TWT_Z80):
        tap2sna.main(('-d', BUILD_DIR, '@{}/twt.t2s'.format(TWT_HOME)))
    twt = TravelWithTrashman(get_snapshot(TWT_Z80))
    ctlfile = '{}/{}.ctl'.format(BUILD_DIR, subcommand)
    with open(ctlfile, 'wt') as f:
        f.write(getattr(twt, methods[subcommand][0])())

###############################################################################
# Begin
###############################################################################
methods = OrderedDict((
    ('location_data', ('get_location_data', 'Location Data')),
    ('source_code', ('get_source_code_data', 'Source Code Remnants'))
))
subcommands = '\n'.join('  {} - {}'.format(k, v[1]) for k, v in methods.items())
parser = argparse.ArgumentParser(
    usage='%(prog)s SUBCOMMAND',
    description="Produce a skool file snippet for \"Travel With Trashman\". SUBCOMMAND must be one of:\n\n{}".format(
        subcommands),
    formatter_class=argparse.RawTextHelpFormatter,
    add_help=False
)
parser.add_argument('subcommand', help=argparse.SUPPRESS, nargs='?')
namespace, unknown_args = parser.parse_known_args()
if unknown_args or namespace.subcommand not in methods:
    parser.exit(2, parser.format_help())
run(namespace.subcommand)
