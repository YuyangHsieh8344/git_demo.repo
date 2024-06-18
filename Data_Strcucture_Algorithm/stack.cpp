#include <iostream>
using namespace std;

struct Node{
    int data;
    Node* link;
}

Node* top = nullptr;

void push(int x){
    Node* temp = new Node();
    temp -> data = x;
    temp -> link = top;
    top = temp;
}

void pop() {
    Node *temp;
    if (top == nullptr)
        return;
    temp = top;
    top = top -> link;
    free(temp); 
}