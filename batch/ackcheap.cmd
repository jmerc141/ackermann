::ackcheap.cmd
@echo off

SET result=0

if %1==0 goto m0
if %1==1 goto m1
if %1==2 goto m2
if %1==3 goto m3
if %1==4 goto m4
if %1==5 goto m5


:m0
set /a result=%2+1
echo %result%
exit 0

:m1
set /a result=%2+2
echo %result%
exit 0

:m2
:: calculate x^n
SET x=2
SET n=%2
set result=1
FOR /L %%i IN (1,1,%n%) DO SET /A result*=x
set /a result+=3
ECHO %result%
exit 0

:m3
SET x=2
SET /a n=%2+3
set result=1
FOR /L %%i IN (1,1,%n%) DO SET /A result*=x
set /a result-=3
ECHO %result%
exit 0

:m4
if %2==0 ( echo 13 && exit 0)
SET x=2
SET n=%2
set result=1
FOR /L %%i IN (1,1,%n%) DO SET /A result*=x
FOR /L %%i IN (1,1,%n%) DO SET /A result*=%result%
FOR /L %%i IN (1,1,%n%) DO SET /A result*=%result%
FOR /L %%i IN (1,1,%n%) DO SET /A result*=%result%
FOR /L %%i IN (1,1,%n%) DO SET /A result*=%result%
set /a result-=3
ECHO %result%
exit 0

:m5
if %2==0 ( echo 65533 && exit 0 )
if %2==1 ( echo good luck && exit 0)




