::acks.cmd
@echo off

setlocal EnableDelayedExpansion

set x[0]=%1
set res=%2
set /a i=0
set /a test=0

:loop

rem echo i: %i%
rem echo res: %res%
rem call echo x: %%x[0]%%
	
if x[!i!] gtr 0 (if !res! gtr 0 (
echo first
set /a test=i+1
set x[!test!]=!x[%i%]!
set /a x[!i!]-=1
set /a res-=1
set /a i+=1

)) else (
if x[!i!] gtr 0 (if !res! == 0 (
echo sec
set /a x[!i!]-=1
set /a res=1

)) else (
if x[!i!] equ 0 (
echo third
set /a res+=1
set x[!i!]=
set /a i-=1

))
)

set "b=0"

:SymLoop
if defined x[%b%] (
call echo %b%: %%x[%b%]%%
set /a "b+=1"
GOTO :SymLoop
)

pause



if not defined x[0] (goto :loop)

echo res: %res%
