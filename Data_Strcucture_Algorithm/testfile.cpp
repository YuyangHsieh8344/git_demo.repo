#include <iostream>
#include <vector>
#include <unordered_set>


class Solution {
public:
    bool containsDuplicate(std::vector<int>& nums) {
        std::unordered_set<int> check_duplicate;
        for (int num : nums) {
            //std::unordered_set::find() function returns an iterator pointing to the element if it is found in the set, 
            //and it returns std::unordered_set::end() if the element is not found
            if (check_duplicate.find(num) != check_duplicate.end()) {
                return true;
            }
            check_duplicate.insert(num);
        }
        return false;
    }
};


int main() {
    Solution solution;
    std::vector<int> nums = {1, 2, 3, 4, 5, 6, 7, 8, 9, 1}; // Example input
    bool result = solution.containsDuplicate(nums);
    if (result) {
        std::cout << "The array contains duplicates." << std::endl;
    } else {
        std::cout << "The array does not contain duplicates." << std::endl;
    }
    return 0;
}
