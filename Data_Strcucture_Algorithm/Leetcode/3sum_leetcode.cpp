

#include <iostream>
#include <vector>
using namespace std;

class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        int target = 0;
        sort(nums.begin(), nums.end());
        set <vector<int>> s;
        vector<vector<int>> output;
        for (int i = 0; i< nums.size(); i++)
        {
            int j = i +1;
            //the end of array
            int k = nums.size() -1;
            while (j < k)
            {
                int sum = nums[i] + nums[j] + nums[k];
                //if sum == 0
                if ( sum == target)
                {
                    s.insert({nums[i], nums[j], nums[k]});
                    j++;
                    k--;
                    //if sum < 0
                } else if (sum < target)
                {
                    j++;
                } else{
                    k--;
                }
            }
        }
        for (auto triplets : s)
        {
            output.push_back(triplets);
        }
        return output;
    }
};





int main() {
    Solution sol;
    vector<int> nums = {-1, 0, 1, 2, -1, -4};
    vector<vector<int>> result = sol.threeSum(nums);

    for (auto triplet : result) {
        for (int num : triplet) {
            cout << num << " ";
        }
        cout << endl;
    }
    return 0;
}