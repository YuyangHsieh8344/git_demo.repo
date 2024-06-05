#include <unordered_map>
#include <iostream>
#include <string>

class Solution {
public:
    int romanToInt(std::string s) {
        std::unordered_map<char, int> m;

        // Define the values for each Roman numeral
        m['I'] = 1;
        m['V'] = 5;
        m['X'] = 10;
        m['L'] = 50;
        m['C'] = 100;
        m['D'] = 500;
        m['M'] = 1000;

        int ans = 0; 
        // Iterate through the string
        for (int i = 0; i < s.length(); i++) {
            // Check if the current value is less than the next value
            if (i < s.length() - 1 && m[s[i]] < m[s[i + 1]]) {
                ans -= m[s[i]];
            } else {
                ans += m[s[i]];
            }
        }
        return ans;
    }
};


int main() {
    Solution solution;
    std::string roman = "MCMXCIV"; // Example Roman numeral
    int result = solution.romanToInt(roman);
    std::cout << "The integer value of " << roman << " is: " << result << std::endl;

    return 0;
}
