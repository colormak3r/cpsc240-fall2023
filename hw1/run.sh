#!/bin/bash

# Author: Dang Khoa Nguyen
# CWID: 885089755

echo "Compiling the assembly file..."
nasm -f elf64 -l hw1l.lis -o hw1a.o hw1.asm

echo "Compiling the C++ file..."
g++ -c -m64 -Wall -o hw1c.o hw1.cpp -fno-pie -no-pie -std=c++17

echo "Linking the two object files..."
g++ -m64 -o hw1 hw1a.o hw1c.o -fno-pie -no-pie -std=c++17

echo "Running the programm..."
./hw1