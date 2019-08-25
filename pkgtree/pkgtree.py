#!/usr/bin/env python
import sys
import argparse
import pkg_resources

_installed = {}
for p in pkg_resources.working_set:
    _installed[p.key] = p

def _load_package_info(key):
    pass

def _print_package_info(key, indent=0, specs=[]):
    if key in _installed:
        pkg = _installed[key]
        print('  ' * indent + pkg.project_name, '==', pkg.version, '[{}]'.format(','.join([op+ver for op,ver in specs]) if len(specs) else '*'))
        for dep in pkg.requires():
            _print_package_info(dep.key, indent+1, dep.specs)
    else:
        print('  ' * indent + key, "== MISSED", '[{}]'.format(','.join([op+ver for op,ver in specs])))

def print_package_info(query=None):
    if query:
        keys = sorted([n.lower() for n in query])
    else:
        keys = sorted(_installed)

    for k in keys:
        _print_package_info(k)

def main():
    psr = argparse.ArgumentParser()
    sub_psrs = psr.add_subparsers()
    psr_list = sub_psrs.add_parser('list')
    psr_list.add_argument('-b', '--bare', action='store_true')
    psr_list.add_argument('-o', '--oneline', action='store_true')
    psr_list_grp = psr_list.add_mutually_exclusive_group()
    psr_list_grp.add_argument('-t', '--tops', nargs='*', metavar='pkg')
    psr_list_grp.add_argument('-f', '--tops-file', type=argparse.FileType('r'))
    psr_list.add_argument('package', type=str, nargs='*')
    psr_uninstall = sub_psrs.add_parser('uninstall')
    psr_uninstall.add_argument('-t', '--tops', nargs='*', metavar='pkg')
    psr_uninstall.add_argument('-f', '--tops-file', type=argparse.FileType('r'))
    psr_uninstall.add_argument('-x', '--exclude', nargs='*', metavar='pkg')
    psr_uninstall.add_argument('package', type=str, nargs='*')
    args = psr.parse_args()
    print(args)
    if len(sys.argv) > 1:
        print_package_info(sys.argv[1:])
    else:
        print_package_info()

if __name__ == '__main__':
    main()
