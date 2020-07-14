@echo off
echo ## run
echo.
echo ### main.py
echo.
echo ```console
call echo_md_run.cmd "python main.py --help"
call echo_md_run.cmd "python main.py main --help"
call echo_md_run.cmd "python main.py sub --help"
call echo_md_run.cmd "python main.py sub2 --help"
call echo_md_run.cmd "python main.py sub2 cmd1 --help"
call echo_md_run.cmd "python main.py sub2 cmd2 --help"
call echo_md_run.cmd "python main.py main sth"
call echo_md_run.cmd "python main.py sub sth"
call echo_md_run.cmd "python main.py sub2 cmd1 sth"
call echo_md_run.cmd "python main.py sub2 cmd2 sth"
echo ```
echo.
echo ### sub.py
echo.
echo ```console
call echo_md_run.cmd "python sub.py --help"
call echo_md_run.cmd "python sub.py sth"
echo ```
echo.
echo ### sub2.py
echo.
echo ```console
call echo_md_run.cmd "python sub2.py --help"
call echo_md_run.cmd "python sub2.py cmd1 --help"
call echo_md_run.cmd "python sub2.py cmd2 --help"
call echo_md_run.cmd "python sub2.py cmd1 sth"
call echo_md_run.cmd "python sub2.py cmd2 sth"
echo ```
