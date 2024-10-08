import art
import sys
import os

TWT_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TWT_SKOOL = '{}/sources/twt.skool'.format(TWT_HOME)

SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
SKOOLKIT_TOOLS = "{}/tools".format(SKOOLKIT_HOME)
if SKOOLKIT_HOME:
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}: directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit import skool2asm, skool2html
else:
    try:
        from skoolkit import skool2asm, skool2html
    except ImportError:
        sys.stderr.write('Error: SKOOLKIT_HOME is not set, and SkoolKit is not installed\n')
        sys.exit(1)

sys.stderr.write("Found SkoolKit in {}\n".format(skool2html.PACKAGE_DIR))

def run_skool2asm():
    skool2asm.main(sys.argv[1:] + [TWT_SKOOL])

def run_skool2html():
    options = "-c Config/InitModule={}:publish -d {}/build/html".format(SKOOLKIT_TOOLS, TWT_HOME)
    art.tprint("Travel With Trashman")
    hex = '-H -c Config/GameDir=twt --var pub=2'
    dec = '-D -c Config/GameDir=twt/dec --var pub=4'
    skool2html.main(options.split() + hex.split() + sys.argv[1:] + [TWT_SKOOL])
    skool2html.main(options.split() + dec.split() + sys.argv[1:] + [TWT_SKOOL])
