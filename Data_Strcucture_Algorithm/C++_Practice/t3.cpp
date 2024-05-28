#include <iostream> 
#include <string>
using namespace std;

int main(){
	int a = 2;
	//b is reference of a 
	//basically pointing b to [2]
	int &b = a;
	//both will change what a and b point to
	a = 3;
	b = 4;
	cout << "referance &  " << endl;
	cout << a << endl;
	cout << b << endl;
	cout << "adress of a and b shoud be the same  " << endl;
	cout << &a << endl;
	cout << &b << endl;
	cout << " " << endl;

	cout << "pointer * " << endl;
	int x = 5;
	int *y = &x;
	cout << x << endl;
	cout << y << endl;
	cout << "point out the address of x and y " << endl;
	cout << &x << endl;
	cout << &y << endl;
	cout << "dereferance y " << endl;
	cout << *y << endl;

	cout << "" << endl;
	cout << "arr using pointer" << endl;
	int p[] = {4,5,6};
	//int *head = p;

	cout << *head << endl;
	cout << head << endl;
	cout << "" << endl;

	for (int i =0; i <3; ++i){
		head = p + i;
		cout << *head << endl;
		cout << head << endl;
	}

}