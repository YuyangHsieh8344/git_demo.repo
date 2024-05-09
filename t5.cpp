#include <iostream> 
#include <string>
#include <vector>
#include <set>
using namespace std;

int main(){
	cout << "OUTPUT FOR VECTOR: " << endl;
	vector<int> v1 = {1,2,3};
	cout << v1[1] << endl;
	cout << "the start: " << v1.front() << endl;
	cout << "the end of vecotr: " << v1.back() << endl;
	v1.insert(v1.begin(), 5);

	cout << " " << endl;
	cout << "for loop vector: " << endl;
	for (int i = 0; i < v1.size(); ++i){
		cout << v1[i] << endl;
	}

	cout << " " << endl;
	cout << "iterate through vector: " << endl;
	for (auto itr = v1.begin(); itr != v1.end(); ++itr){
		cout << *itr  << endl;
	}

	cout << " " << endl;
	cout << "OUTPUT FOR SET: (sort unorganized set)" << endl;
	set<char> s1 = {'U' , 'S', 'B', '2', 'A', 'B'};
	for (auto itr = s1.begin(); itr != s1.end(); ++itr){
		cout << *itr  << endl;
	}

	//coding interview
	cout << " " << endl;
	cout << "coding interview: " << endl;
	string test = "Those people are watching TV in the living room. Lets join them!";
	string find = "Hello";
	set<char> findletters;

	//insert string find "Hello" into findletters set
	for(int i=0; i< find.length(); ++i){
		char letter = find[i];
		findletters.insert(letter);
	}

	//erase "Hello" from the string test
	for(int i=0; i< find.length(); ++i){
		char letter = find[i];
		findletters.erase(letter);
	}
	//if h e l l o are in string test then return YES
	if(findletters.size() > 0){
		cout << findletters.size() << endl;
		cout << "No! it does not have all letter! " << endl;
	} else{
		cout << "YES! it does! " << endl;
	}

}