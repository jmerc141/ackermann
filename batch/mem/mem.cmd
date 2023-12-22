::IAck.cmd
@echo off
cmd /c amem.cmd %1 %2
echo Ackermann(%1, %2)=%errorlevel%
