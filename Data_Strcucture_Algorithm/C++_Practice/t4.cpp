#include <iostream> 
#include <string>
#include <tuple>
#include <map>
using namespace std;


int main(){

	cout << "OUTPUT FOR TUPLE:  " << endl;
	tuple <int, string> time (20, "Time");

	cout << get<1>(time) << " is " << get<0>(time) << endl;

	tuple <int, float> t4 = make_tuple(1,2);
	cout << get<0>(t4) << endl;   

	cout << " " << endl;
	cout << "OUTPUT FOR MAP:  " << endl;
	map <char, int> mp = {
		{'L', 3},
		{'E', 7},
		{'O', 1}
	};

	pair <char, int> p1('N', 8);
	mp.insert(p1);
	//mp.clear();
	//mp.erase('E');
	cout << mp['N'] << endl;
	cout << mp['L'] << endl;
	cout << "check map size: " << mp.size() << endl;

	cout << " " << endl;
	cout << "OUTPUT FOR USING ITERATOR:  " << endl;
	cout << "(*itr).first == itr -> first "<< endl;
	//map<char, int>::iterator => auto
	for (auto itr = mp.begin(); itr != mp.end(); ++itr){
		cout << (*itr).first << endl;
		cout << itr -> second << endl;
	}

	//count the frequency of char in a string 
	cout << "count the frequency of char in a string:  " << endl;
	string test = "I am Iron Man. and I am going to save the world hahahaha!";
	map<char, int> freq;
	for(int i = 0; i< test.length(); ++i){
		char letter = test[i];
		//cout << letter << endl;
		//find letter in the map, if not exist it will return 0
		if(freq.find(letter) == freq.end()){
			freq[letter] = 0;
		}
		freq[letter]++;
		//cout << freq[letter] << ", " << letter << endl;
	}

	for (auto itr = freq.begin(); itr != freq.end(); ++itr){
		cout << itr -> first << ": " << itr->second << endl;
	}
}