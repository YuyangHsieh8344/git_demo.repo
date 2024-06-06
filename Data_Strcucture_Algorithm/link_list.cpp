#include <iostream>

struct Node {
    int data;
    Node* next;
};

Node* head;

void Insert(int x) {
    Node* temp = new Node();
    temp->data = x;
    temp->next = head;
    head = temp;
}

void Print() {
    Node* temp = head;
    std::cout << "List is: ";
    while (temp != NULL) {
        std::cout << " " << temp->data;
        temp = temp->next;
    }
    std::cout << "\n";
}

int main() {
    head = NULL;
    std::cout << "How many numbers?\n";
    int n, x;
    std::cin >> n;
    for (int i = 0; i < n; i++) {
        std::cout << "Enter the number\n";
        std::cin >> x;
        Insert(x);
        Print();
    }
    return 0;
}
