::Ackermann.cmd
@echo off
setlocal enabledelayedexpansion
set "cache="
set depth=0

:ack
if defined cache[%1_%2] (
    exit /b !cache[%1_%2]!
)
if %1==0 goto m0
if %2==0 goto n0

:else
set /a n=%2-1
set /a depth+=1
call :ack %1 %n%
set t=%errorlevel%
set /a depth-=1
set /a m=%1-1
set /a depth+=1
call :ack %m% %t%
set t=%errorlevel%
set "cache[%1_%2]=%t%"
set /a depth-=1
if %depth%==0 ( exit %t% ) else ( exit /b %t% )

:m0
set/a n=%2+1
if %depth%==0 ( exit %n% ) else ( exit /b %n% )

:n0
set /a m=%1-1
set /a depth+=1
call :ack %m% 1
set t=%errorlevel%
set "cache[%1_%2]=%t%"
set /a depth-=1
if %depth%==0 ( exit %t% ) else ( exit /b %t% )

