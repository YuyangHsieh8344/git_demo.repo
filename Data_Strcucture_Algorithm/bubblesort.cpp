#include <iostream>
using namespace std;

// Function to perform Bubble Sort
void bubble_sort(int arr[], int n) {
    int temp;
    // Traverse through all elements in the array
    for (int i = 0; i < n-1; i++) {
        // Last i elements are already sorted, no need to check them
        for (int j = 0; j < n-i-1; j++) {
            // Swap if the element found is greater than the next element
            if (arr[j] > arr[j+1]) {
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

// Function to print an array
void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int n = sizeof(arr)/sizeof(arr[0]);
    cout << "Original array: " << endl;
    print_array(arr, n);
    
    bubble_sort(arr, n);
    
    cout << "Sorted array: " << endl;
    print_array(arr, n);
    return 0;
}
