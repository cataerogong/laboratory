@echo off
echo **********************************************************
echo * 编译环境：                                             *
echo *   Python 2.7.15 (32bit)                                *
echo *   PyInstaller 3.5                           [pip 安装] *
echo **********************************************************
pause

pyinstaller -F -c --add-data "res.txt;.\\" apr.py
