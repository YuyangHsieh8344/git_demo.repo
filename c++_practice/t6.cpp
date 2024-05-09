//t6.cpp
#include <iostream> 
#include <string>
#include <vector>
#include <set>
using namespace std;

//FUNCTION
int add(int x, int y){
	return x + y;
}

void test(){
	for (int i = 0; i <10; ++i){
		cout << i << endl;
	}
}

//have to add the referance(&) to x , y
void swap(int &x, int &y ){
	int temp = x;	//temp = 2
	x = y;   		//set x = 4
 	y = temp;		//y = 2
}

int main(){
	int result = add(2,3);
	cout << "result is: " << endl;
	cout << result << endl;

	cout << " " << endl;
	cout << "test value is: " << endl;
	test();

	cout << " " << endl;
	int a = 2;
	int b = 4;
	cout << a << endl;
	cout << b << endl;
	cout << "swapping " << endl;
	swap (a,b);
	cout << a << endl;
	cout << b << endl;

}