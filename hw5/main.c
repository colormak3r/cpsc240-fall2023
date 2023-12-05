// Program name: "Random Number Normalization". This program fill an array with up to
// element with a random number and normalize them into a number within the range of 
// 1.0 and 2.0
// Copyright (C) <2023>  <Dang Khoa Nguyen>

// This file is part of the software program "Random Number Normalization".

// Random Number Normalization is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// Random Number Normalization is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>. 

// Author information
//   Author name : Dang Khoa Nguyen
//   Author email: colormak3r@csu.fullerton.edu
//   Author section: 240-3
//   Author CWID : 885089755

#include "stdio.h"

extern char* executive();

int main()
{
    printf("Welcome to Random Number Normalization, LLC.\n");
    printf("This software is maintained by Khoa Nguyen\n\n");

    char* result = executive();

    printf("\nOh, %s. We hope you enjoyed your arrays. Do come again.\n", result);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}