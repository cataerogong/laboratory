# coding=utf-8

import os, sys

#生成资源文件目录访问路径
def resource_path(relative_path):
    if getattr(sys, 'frozen', False): #是否Bundle Resource
        base_path = sys._MEIPASS
    else:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

with open(resource_path('res.txt'), 'r') as f:
    l = f.readline()
    print(l)
