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

// Function to print the linked list
void Print(Node* head) {
    
    std::cout << "List is: ";
    while (head != nullptr) {
        std::cout << " " << head->data;
        head = head->next;
    }
    std::cout << "\n";
}

void ReversePrint(Node* head) {
    if (head == nullptr){
        std::cout << "List is: ";
        return;
   }
   ReversePrint(head -> next);
   std::cout << " " << head->data;
}

// Function to insert a new node at the beginning
Node* Insert(Node* head, int data) {
    Node* newNode = new Node();
    newNode->data = data;
    newNode->next = head;
    head = newNode;
    return head;
}

int main() {
    // Local variable
    Node* head = nullptr;
    head = Insert(head, 3);
    head = Insert(head, 5);
    head = Insert(head, 7);
    head = Insert(head, 9);
    Print(head);
    ReversePrint(head);

    return 0;
}
