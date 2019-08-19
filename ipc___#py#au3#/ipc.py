# coding: utf-8

import cmd, os, sys, threading, argparse, psutil

def Log(msg):
    print(msg)

class IpcHandler(cmd.Cmd):
    def __init__(self):
        cmd.Cmd.__init__(self)
        self.prompt = 'ipc-py>'

    # def do_help(self, arg):
    #     print('HELP [{}]'.format(arg))

    def do_hello(self, arg):
        'hello <name>'
        print('Hello, {}!'.format(arg))

    def do_exit(self, arg):
        print('Bye-bye')
        return True

    def default(self, arg):
        print('ERROR_CMD')

    # def precmd(self, line):
    #     print('Input line: {}'.format(line))
    #     return line

class Babysitter:
    def __init__(self, ppid):
        self.ppid = ppid

    def run(self):
        Log('Babysitter started <ppid:{}>'.format(self.ppid))
        try:
            pp = psutil.Process(self.ppid)
            Log('Babysitter: pp: {}'.format(pp.exe()))
            pp.wait()
        except Exception:
            Log('Babysitter: ERROR')
        finally:
            pass #Log('Babysitter exit...')

if __name__ == '__main__':
    psr = argparse.ArgumentParser()
    psr.add_argument('--ppid', dest='ppid', type=int, default=0)
    args = psr.parse_known_args()[0]
    pid = os.getppid()
    Log('ipc-py.exe: pid={}, ppid={}'.format(pid, args.ppid))
    if (args.ppid):
        hdlr = threading.Thread(target=IpcHandler().cmdloop, daemon=True)
        hdlr.start()
        Babysitter(args.ppid).run()
    else:
        IpcHandler().cmdloop()
