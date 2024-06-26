#include <iostream>
#include <stack>
#include <string>

using namespace std;

bool arePair(char opening, char closing)
{
    if (opening == '(' && closing == ')')
        return true;
    else if (opening == '{' && closing == '}')
        return true;
    else if (opening == '[' && closing == ']')
        return true;
    else 
        return false;
}

bool areParenthesesBalanced(string exp)
{
    stack<char> s;
    for (int i = 0; i < exp.length(); i++)
    {
        if (exp[i] == '(' || exp[i] == '{' || exp[i] == '[')
            s.push(exp[i]);
        else if (exp[i] == ')' || exp[i] == '}' || exp[i] == ']')
        {
            if (s.empty() || !arePair(s.top(), exp[i]))
                return false;
            else
                s.pop();
        }    
    }

    return s.empty();
}

int main()
{
    string expression;
    cout << "Enter an expression:  "; // input expression from STDIN/Console
    getline(cin, expression);
    if (areParenthesesBalanced(expression))
        cout << "Balanced\n";
    else
        cout << "Not Balanced\n";
}
