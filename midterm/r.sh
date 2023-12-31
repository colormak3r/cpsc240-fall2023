#!/bin/bash

# Program name: "Rotate Array". This program rotate an array left using modular
# components that manage, input, output rotate, and sum the array.
# Copyright (C) <2023>  <Dang Khoa Nguyen>

# This file is part of the software program "Rotate Array".

# Rotate Array is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Rotate Array is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>. 

# Author information
#   Author name : Dang Khoa Nguyen
#   Author email: colormak3r@csu.fullerton.edu
#   Author section: 240-3
#   Author CWID : 885089755

echo "Compiling the welcome file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o welcome.o welcome.c -std=c17

echo "Compiling the manage file..."
nasm -f elf64 -o manage.o manage.asm

echo "Compiling the input file..."
nasm -f elf64 -o input_array.o input_array.asm

echo "Compiling the output file..."
nasm -f elf64 -o output_array.o output_array.asm

echo "Compiling the rotate left file..."
nasm -f elf64 -o rot_left.o rot_left.asm

echo "Compiling the sum file..."
nasm -f elf64 -o sum_array.o sum_array.asm

echo "Linking the object files..."
gcc -m64 -no-pie -o midterm -std=c17 welcome.o manage.o input_array.o output_array.o rot_left.o sum_array.o #-fno-pie

echo "Running midterm..."
./midterm