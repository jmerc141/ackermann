::IAck.cmd
@echo off
pushd
cd batch\mem
cmd /c amem.cmd %1 %2
echo Ackermann(%1, %2)=%errorlevel%
popd
exit /B 0
