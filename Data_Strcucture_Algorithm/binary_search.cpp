#include <iostream>
#include <vector>
using namespace std;

int binary_search(vector<int> &nums, int target) {
    int left = 0;
    int right = nums.size() - 1;
    int result = -1; // Use this to store the position of the first occurrence

    while (left <= right) {
        int mid = left + (right - left) / 2; // To avoid potential overflow

        if (nums[mid] >= target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }

        // Check if the current mid is equal to the target
        if (nums[mid] == target) {
            result = mid; // Update the result with the current position
        }
    }
    
    // If target was found, result will have the position of its first occurrence
    // If target was not found, left will be the insertion point
    return (result != -1) ? result : left;
}

int main() {
    vector<int> nums = {1, 3, 4, 4, 4, 7, 8, 10};
    cout << binary_search(nums, 0)  << endl; // 0 <- Not found, return position 0
    cout << binary_search(nums, 1)  << endl; // 0
    cout << binary_search(nums, 3)  << endl; // 1
    cout << binary_search(nums, 4)  << endl; // 2 (first occurrence of 4)
    cout << binary_search(nums, 5)  << endl; // 5 <- Not found, return position 5 (where 5 can be inserted)
    cout << binary_search(nums, 7)  << endl; // 5
    cout << binary_search(nums, 8)  << endl; // 6
    cout << binary_search(nums, 10) << endl; // 7
    cout << binary_search(nums, 11) << endl; // 8 <- Out of range, but correct result (insertion point)
}
