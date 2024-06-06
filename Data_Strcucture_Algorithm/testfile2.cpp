#include <iostream>

struct Node {
    int data;
    Node* next;
};

Node* head = nullptr;

void Insert(int data, int n_position) {
    Node* temp1 = new Node();
    temp1->data = data;
    temp1->next = nullptr;

    if (n_position == 1) {
        temp1->next = head;
        head = temp1;
        return;
    }

    Node* temp2 = head;
    for (int i = 0; i < n_position - 2; i++) {
        temp2 = temp2->next;
    }
    temp1->next = temp2->next;
    temp2->next = temp1;
}

void Delete(int n_position) {
    if (head == nullptr) return;  // If the list is empty, do nothing

    Node* temp1 = head;

    if (n_position == 1) {
        head = temp1->next;  // Head now points to the second node
        delete temp1;
        return;
    }

    // Move temp1 to the (n-1)th node
    for (int i = 0; i < n_position - 2; i++) {
        temp1 = temp1->next;
        if (temp1 == nullptr) return;  // If position is greater than the length of the list, do nothing
    }

    Node* temp2 = temp1->next;  // nth node
    if (temp2 == nullptr) return;  // If nth node doesn't exist, do nothing
    temp1->next = temp2->next;  // (n+1)th node
    delete temp2;  // Delete the nth node
}


void Print() {
    Node* temp = head;
    std::cout << "List is: ";
    while (temp != nullptr) {
        std::cout << " " << temp->data;
        temp = temp->next;
    }
    std::cout << "\n";
}

int main() {
    // Creating an empty list
    head = nullptr;

    // Insert elements at different positions
    Insert(4, 1);  // List: 4
    Insert(6, 2);  // List: 4, 6
    Insert(9, 1);  // List: 9, 4, 6
    Insert(3, 2);  // List: 9, 3, 4, 6
    Print();  // Print the list

    // Delete a node at a certain position
    std::cout << "Enter a position to delete:\n";
    int n_position;
    std::cin >> n_position;
    Delete(n_position);
    Print();  // Print the updated list

    return 0;
}
