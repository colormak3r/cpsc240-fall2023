// Program name: "Work Calculator". This program calculate the work performed 
// based on volts, resistance and time with input validation for float input
// Copyright (C) <2023>  <Dang Khoa Nguyen>

// This file is part of the software program "Work Calculator".

// Work Calculator is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// Work Calculator is distributed in the hope that it will be useful,
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

extern double faraday();

int main()
{
    printf("Welcome to Majestic Power Systems, LLC\n");
    printf("Project Director, Sharon Winners, Senior Software Engineer.\n\n");

    double result = faraday();

    printf("\nThe main function received this number %lf and will keep it for future study.\n", result);
    printf("A zero will be returned to the operating system.  Bye.\n");

    return 0;
}