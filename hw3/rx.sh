#!/bin/bash

# Program name: "Sort Array". This program sort an array using modular
# components that manage, input, output and sort the array.
# Copyright (C) <2023>  <Dang Khoa Nguyen>

# This file is part of the software program "Sort Array".

# Sort Array is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Sort Array is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>. 

# Author information
#   Author name : Dang Khoa Nguyen
#   Author email: colormak3r@csu.fullerton.edu
#   Author CWID : 885089755

# This file use the asm sort_array

echo "Compiling the main file..."
# main in C++
g++ -c -m64 -Wall -fno-pie -no-pie -o main.o main.cpp
# main in C
# gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Compiling the director file..."
nasm -f elf64 -o director.o director.asm

echo "Compiling the input file..."
nasm -f elf64 -o input_array.o input_array.asm

echo "Compiling the output file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o output_array.o output_array.c -std=c17

echo "Compiling the asm sort file..."
nasm -f elf64 -o sort_array.o sort_array.asm

echo "Linking the object files..."
# main in C++
g++ -m64 -no-pie -o hw3 -std=c17 main.o director.o input_array.o output_array.o sort_array.o #-fno-pie -no-pie
# main in C
# gcc -m64 -no-pie -o hw3 -std=c17 main.o director.o input_array.o output_array.o sort_array.o #-fno-pie -no-pie

echo "Running hw3..."
./hw3
