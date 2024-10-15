# ackermann
Different implementations of the ackermann function in C, Python, and Java (32 and 64 bit)

# to install 32 bit libraries:

  sudo dpkg --add-architecture i386

  sudo apt update

  sudo apt install libgmp3-dev libgmp3-dev:i386 gcc-multilib

# compile c
  gcc -Wall -g ack.c -o ack.out
  
  32 bit: add -m32

# java
  java -Xss1g FILE m n

  uses 1GB of memory

# nasm
nasm -f win64 *.asm
F4240h = 1GB
golink /console /console {/stackinit 900000h} {/stacksize 900000h} *.obj /entry _start msvcr100.dll
