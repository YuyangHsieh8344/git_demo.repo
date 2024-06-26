#include <iostream>
#include <stack>
#include <string>

using namespace std;

//function to evaluate postfix expression and return output
int EvaluatePostfix(string exp);

//function to perform operation
int Performoperation(char op, int op1, int op2);

//function to verify whether a charator is operand or not
bool IsOperator(char c);


//function to verify whether a char is numeric digit
bool IsNumericDigit(char c);

int main()
{
    string exp;
    cout << "enter Postfix Expression: " << endl;
    getline(cin, exp);
    int result = EvaluatePostfix(exp);
    cout << "Output = " << result << endl;
}



int EvaluatePostfix(string exp)
{
    stack<int> s;

    for (int i = 0; i< exp.length(); i++)
    {
        //check if it is dilimitter
        if (exp[i] == ' ' || exp[i] == ',')
            continue;
        //check if it is operator 
        else if (IsOperator(exp[i]))
        {
            //pop two operand
            int op1 = s.top(); s.pop();
            int op2 = s.top(); s.pop();

            int result = Performoperation(exp[i], op1, op2);
            //push result on the stack
            s.push(result);
        }
        //extract numric operand and keepp increment i if it is numeric
        else if (IsNumericDigit(exp[i]))
        {
            int operand = 0;
            while (i < exp.length() || IsNumericDigit(exp[i]))
            {
            //For a number with more than one digits, as we are scanning from left to right.
            //multiply current total in operand by 10
            operand = (operand * 10 ) + (exp[i] - '0');
            i++;
            }

            i--;
            s.push(operand);
        }
    }
    return s.top();
}

bool IsNumeric(char c)
{
    if (c >= '0' && c <= '9')
    {
        return true;
    }
    return false;
}


bool IsOperator(char c)
{
    if(c == '+' || c == '-' || c == '*' || c == '/')
    {
        return true;
    }
    return false;
}



int PerformOperation(char op, int op1, int op2)
{
    if(op == '+') return op1 +op2;
	else if(op == '-') return op1 - op2;
	else if(op == '*') return op1 * op2;
	else if(op == '/') return op1 / op2;

	else cout<<"Unexpected Error \n";
	return -1;
}