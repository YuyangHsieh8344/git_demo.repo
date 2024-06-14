#include <iostream>
#include <unordered_map>
#include <string>
#include <vector>
#include <algorithm>  // Needed for sort()
using namespace std;

struct Node {
    int data;
    Node* next;
};

Node* head;

// Function to reverse the linked list
Node* Reverse(Node* head) {
    Node *next, *prev, *current;
    current = head;
    prev = nullptr;
    while (current != nullptr) {
        next = current->next;
        current->next = prev;
        prev = current;
        current = next;
    }
    head = prev;
    return head;
}

// Function to reverse using recursion
void ReverseRecursion(Node* p) {
    if (p->next == nullptr) {
        head = p;
        return;
    }
    ReverseRecursion(p->next);
    Node* q = p->next;
    q->next = p;
    p->next = nullptr;
}

// Function to insert a new node at the beginning
Node* Insert(Node* head, int data) {
    Node* newNode = new Node();
    newNode->data = data;
    newNode->next = head;
    head = newNode;
    return head;
}

// Function to print the linked list
void Print(Node* head) {
    Node* temp = head;
    while (temp != nullptr) {
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << endl;
}

int main() {
    head = nullptr;
    head = Insert(head, 2);
    head = Insert(head, 4);
    head = Insert(head, 6);
    head = Insert(head, 8);
    
    cout << "Original list: ";
    Print(head);
    
    head = Reverse(head);
    cout << "Reversed list: ";
    Print(head);
    
    ReverseRecursion(head);
    cout << "Reversed list using recursion: ";
    Print(head);
    
    return 0;
}
