::acks.cmd
@echo off
setlocal EnableDelayedExpansion

set x[0]=%1
set res=%2
set /a i=0

:loop

set tmp=!x[%i%]!

if !tmp! gtr 0 (
	if !res! gtr 0 (
		set /a test=i+1
		set x[!test!]=!x[%i%]!
		set /a x[!i!]-=1
		set /a res-=1
		set /a i+=1
	)
)

if !tmp! gtr 0 (
	if !res! == 0 (
		set /a x[!i!]-=1
		set /a res=1
	)
) else (
	if !tmp! equ 0 (
		set /a res+=1
		set x[!i!]=
		set /a i-=1
	)
)

if defined x[0] (goto loop)

echo result: %res%
