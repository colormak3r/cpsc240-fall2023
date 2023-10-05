#!/bin/bash

# Author: Dang Khoa Nguyen
# CWID: 885089755

echo "Compiling the main file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Compiling the manage file..."
nasm -f elf64 -o manage.o manage.asm

echo "Compiling the input file..."
nasm -f elf64 -o input_array.o input_array.asm

echo "Compiling the output file..."
nasm -f elf64 -o output_array.o output_array.asm

echo "Compiling the sum file..."
nasm -f elf64 -o sum_array.o sum_array.asm

echo "Linking the object files..."
gcc -m64 -no-pie -o hw2 -std=c17 main.o manage.o input_array.o output_array.o sum_array.o #-fno-pie -no-pie

echo "Running hw2..."
./hw2
