::Ack.cmd
@echo off
pushd
cd batch\recursive
cmd/c ackermann.cmd %1 %2
echo Ackermann(%1, %2)=%errorlevel%
popd
exit /B 0
