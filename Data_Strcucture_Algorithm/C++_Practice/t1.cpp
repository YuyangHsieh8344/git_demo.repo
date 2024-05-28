#include <iostream>
#include <string>
using namespace std;

int main(){
	int num_sheep = 10;
	string animal_name = " sheeps ";

	const float gravity = -9.8;			//can't change gravity to another val

	cout << "insert a val to check if it is integer: "; 
	int type1, type2;
	cin >> type1;							//input a type (int, float bool...)
	//check if it is a integer 
	cout << cin.fail() << endl;
	//1 = fail; 0 = success	
	cout << "0 is TRUE 1 is FALSE\n";

	//clear if false
	cin.clear();
	//ignore 1000 char and skip to next line
	cin.ignore(1000, '\n');

	cout << "insert another val to check: ";
	cin >> type2;
	//check if it is a integer 
	cout << cin.fail() << endl;
	cout << "0 is TRUE 1 is FALSE\n";
	

	//simple calculator
	int num1, num2; 
	cout << "Enter a num: ";
	cin >> num1;
	cin.clear();
	cin.ignore(1000, '\n');
	cout << "Enter 2nd num: ";
	cin >> num2;
	int result = num1 * num2;
	cout << "The result is: " << result << endl;


	cout << num_sheep  << animal_name << endl;
	cout << "Hello World!" << " endl is going to the next line" << endl;
	cout << "Hello World!" << " Kurasa\n";
	cout << "The Earth's gravity is: " << gravity << " m/s^2";
	return 0;
}

	// int 16, 100, -5, -9999, 0
	// float 5.0, 6.3, -19.8, 0.1
	// bool true, false
	// string "h", "8.0"				// string is not included in std lib
	// char 'x', '0',                   //cant have two like 'ss' 