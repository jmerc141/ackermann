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
  Download:
  https://www.nasm.us/pub/nasm/releasebuilds/2.16.03/win64/nasm-2.16.03-win64.zip
  
  http://www.godevtool.com/Golink.zip

  nasm -f win64 *.asm

  golink /console /console *.obj /entry _start msvcr100.dll

  some implementations require /stackinit xxxxh or /stacksize xxxxh
  
