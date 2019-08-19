# coding: utf-8

#-------------------------------------------
# 0. Prepare Function
#   SUCC must prepare the Log function explicitly
def PrepareLog(caller):
    def _(msg):
        print('[{}()] {}'.format(caller, msg))
    return _

def LogTest0(some_arg, another_arg):
    Log = PrepareLog('LogTest0')
    Log('{}, {}'.format(some_arg, another_arg))

LogTest0('aaa', 2)

#-------------------------------------------
# 1. BaseClass - for class method log
#   SUCC just class name, no method name
class LogBase1:
    def Log(self, msg):
        print('[{}()] {}'.format(self.__class__.__name__, msg))

class LogTest1(LogBase1):
    def Test(self):
        self.Log('Log 1')

LogTest1().Test()

#-------------------------------------------
# 2. decorator - for class method log
#   SUCC? thread unsafe
def log_method_deco(func):
    def wrapper(self, *args, **kw):
        self.Log = lambda s: print('[{}.{}()] {}'.format(self.__class__.__name__, func.__name__, s))
        return func(self, *args, **kw)
    return wrapper

class LogTest2:
    @log_method_deco
    def Test(self, some_arg, another_arg):
        self.Log('Log 2: {}, {}'.format(some_arg, another_arg))

LogTest2().Test(1, 2)

#-------------------------------------------
# 3. inspect - 
#   SUCC depends on arg_name 'self', which is just a convention
import inspect

def Log3(msg):
    f = inspect.currentframe()
    pf = f.f_back
    fname = pf.f_code.co_name
    if 'self' in pf.f_locals:
        cname = pf.f_locals['self'].__class__.__name__
    else:
        cname = ''
    del f
    del pf
    if cname:
        print('{}.{}() > {}'.format(cname, fname, msg))
    else:
        print('{}() > {}'.format(fname, msg))

class LogTest3:
    def Test(self, some_arg, another_arg):
        Log3('Log 3: {}, {}'.format(some_arg, another_arg))

def LogTest3Func(some_arg, another_arg):
    Log3('Log 3: {}, {}'.format(some_arg, another_arg))

LogTest3().Test('cccc', 3)
LogTest3Func(123, 'def')

