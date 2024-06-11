#include <iostream>
#include <unordered_map>
#include <string>
#include <vector>
#include <algorithm>  // Needed for sort()

using namespace std;

class Solution {
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        unordered_map<string, vector<string>> mp;

        // Iterate over each string in the input list
        for (auto x : strs) {
            string word = x;  // Copy the current string
            sort(word.begin(), word.end());  // Sort the string to get the anagram key

            mp[word].push_back(x);  // Use the sorted string as the key and append the original string to the map
        }

        vector<vector<string>> ans;  // Prepare to collect the result
        for (auto x : mp) {
            ans.push_back(x.second);  // Append each group of anagrams to the result
        }

        return ans;
    }
};

int main() {
    vector<string> strs = {"eat", "tea", "tan", "ate", "nat", "bat"};
    Solution solution;
    vector<vector<string>> result = solution.groupAnagrams(strs);

    cout << "The group anagrams are: " << endl;
    for (const auto& group : result) {
        cout << "[ ";
        for (const auto& word : group) {
            cout << word << " ";
        }
        cout << "]" << endl;
    }

    return 0;
}
