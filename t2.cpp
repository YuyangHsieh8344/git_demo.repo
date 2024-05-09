#include <iostream> 
#include <string>
using namespace std;

int main(){

	int arr[] = {23213, 3, 4, 5, 6};


	cout << sizeof(arr) << endl;
	cout << "if i have 5 element in a arr, sizeof(arr) = 4x5 =20" << endl;
	cout << sizeof(arr[0]) << endl;
	cout << "every element use 4 bytes" << endl;
	cout << sizeof(arr)/sizeof(arr[0]) << endl;
	cout << "this will be 20/4 = 5" << endl;

	cout << "" << endl;
	cout << "for loop for arr[]: " << endl;
	for (int i =0; i < sizeof(arr)/sizeof(arr[0]); i++ ){
		cout << arr[i] << endl;
	}

	cout << "" << endl;
	cout << "continue function: " << endl;
	for (int i =0; i < 10; i++ ){
		if(i == 9 || i == 7){
			continue;
		}
		cout << i << endl;
	}

	 int c;
    cout << "Enter a case #: ";
    cin >> c;

    switch (c) {
        case 1:
            cout << "Cool" << endl;
            break;
        case 2:
            cout << "Awesome" << endl;
            break;
        case 3:
            cout << "Nice" << endl;
            break;
        default:
            cout << "End Case " << endl;
            break;
    }

    return 0;

}

/* 
 !  not
 && and
 || or  
*/ 
