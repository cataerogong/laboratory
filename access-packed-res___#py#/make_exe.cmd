@echo off
echo **********************************************************
echo * ���뻷����                                             *
echo *   Python 2.7.15 (32bit)                                *
echo *   PyInstaller 3.5                           [pip ��װ] *
echo **********************************************************
pause

pyinstaller -F -c --add-data "res.txt;.\\" apr.py
