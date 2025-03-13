# ackermann
Different implementations of the ackermann function in C, Python, and Java (32 and 64 bit)

# compile c

  recursive:
  
    windows: x86_64-w64-mingw32-gcc -Wl,--stack,4194304 -g file.c -o file
    
    linux: gcc -g ackr.c -o rec
  
  mem (n_bits=27):
  
    windows: x86_64-w64-mingw32-gcc -Wl,--stack,4194304 -g file.c -o file
    
    linux: gcc -g ackmem.c -o mem
  
  stack (size=214,748,364):
  
    windows: x86_64-w64-mingw32-gcc -g acks.c -o acks -lgmp
      include libgmp-10.dll
      
    linux: gcc -g acks.c -o ack -lgmp

  cheap:
  
    windows: x86_64-w64-mingw32-gcc -g cheap.c -o cheap -lgmp
      include libgmp-10.dll
      
    linux: gcc -g cheap.c -o cheap -lgmp
  
  32 bit: add -m32

# c++
  recursive:
  
    windows: x86_64-w64-mingw32-g++ -Wl,--stack,4194304 ackr.cpp -o rec -std=c++14 -O2
    
    linux: g++ -g ackr.cpp -o rec -std=c++14 -O2

  goal:
  
    windows: x86_64-w64-mingw32-g++ ack.cpp -o goal -std=c++14 -O2 -lgmpxx -lgmp
      include libgcc_s_seh-1.dll libgmp-10.dll libstdc++-6.dll libwinpthread-1.dll
      
    linux: g++ -g ack.cpp -o goal -std=c++14 -O2 -lgmp
  
  cheap:
  
    windows:
      x86_64-w64-mingw32-g++ cheap.cpp -o cheap -std=c++14 -O2 -lgmpxx -lgmp
      include libgcc_s_seh-1.dll libgmp-10.dll libstdc++-6.dll libwinpthread-1.dll
      
    linux: g++ -g cheap.cpp -o cheap -std=c++14 -O2 -lgmp
  
  mem:
  
    windows: x86_64-w64-mingw32-g++ -Wl,--stack,4194304 ackmem.cpp -o mem -std=c++14 -O2
    
    linux: g++ -g ackmem.cpp -o mem -std=c++14 -O2
  
  stack (size=214,748,364):
  
    size may need to be changed based on max RAM
    windows: x86_64-w64-mingw32-g++ acks.cpp -o acks -std=c++14 -O2 -lgmp
      include libgmp-10.dll
   
    linux: g++ -g acks.cpp -o st -std=c++14 -O2 -lgmp

# go

    go build file.go

# java 8

    javac FILE.java
    java -Xss1g FILE m n

    uses 1GB of memory

# nasm

  ## windows
  
    nasm -f win64 FILE.asm
    x86_64-w64-mingw32-gcc -Wl,--stack,9437184 -o FILE FILE.o
    
## linux

    nasm -f elf64 FILE.asm
    gcc -no-pie -Wl,-z,stack-size=9437184 FILE.o -o FILE
  
