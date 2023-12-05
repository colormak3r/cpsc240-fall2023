# !/bin/bash

# Program name: "Random Number Normalization". This program fill an array with up to
# element with a random number and normalize them into a number within the range of 
# 1.0 and 2.0
# Copyright (C) <2023>  <Dang Khoa Nguyen>

# This file is part of the software program "Random Number Normalization".

# Random Number Normalization is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Random Number Normalization is distributed in the hope that it will be useful,
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

echo "Compiling the main file..."
gcc -c -m64 -Wall -fno-pie -no-pie -o main.o main.c -std=c17

echo "Compiling the executive file..."
nasm -f elf64 -o executive.o executive.asm

echo "Compiling the show_array file..."
nasm -f elf64 -o show_array.o show_array.asm

echo "Compiling the normalize_array file..."
nasm -f elf64 -o normalize_array.o normalize_array.asm

echo "Compiling the fill_random_array file..."
nasm -f elf64 -o fill_random_array.o fill_random_array.asm

echo "Linking the object files..."
gcc -m64 -no-pie -o hw5.out -std=c17 show_array.o main.o executive.o fill_random_array.o normalize_array.o #-fno-pie

echo "Running hw5.."
./hw5.out