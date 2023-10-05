// Author: Dang Khoa Nguyen
// CWID: 885089755

// Disclaimer: This repository is for my personal use only. 
// You can research as you please, but DO NOT COPY WORD FOR WORD what I wrote. 
// Remember, I have the commit history to prove the timeline. 
// Avoid academic dishonesty.

#include <iostream>
using namespace std;

extern "C" double lasvegas();

int main()
{
    /* code */
    cout << "Welcome to Trip Advisor by Dang Khoa Nguyen." << endl;
    cout << "We help you plan your trip." << endl;
    
    double result = lasvegas();

    cout << "The main module received this number " 
    << result << " and will keep it for a while." << endl;
    cout << "A zero will be sent to your operating system." << endl;
    cout << "Good-bye. Have a great trip." << endl;

    return 0;
}
