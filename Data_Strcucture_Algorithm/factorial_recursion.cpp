#include <iostream>
using namespace std;

// Function to calculate factorial of a given number n
int fact(int n) {
    // Assume that n is a positive integer or 0
    if (n >= 1) {
        return n * fact(n - 1);
    } else {
        return 1;
    }
}

int main() {
    int number;
    cout << "Enter a non-negative integer: ";
    cin >> number;

    if (number < 0) {
        cout << "Factorial is not defined for negative numbers." << endl;
    } else {
        int result = fact(number);
        cout << "The factorial of " << number << " is " << result << "." << endl;
    }

    return 0;
}
