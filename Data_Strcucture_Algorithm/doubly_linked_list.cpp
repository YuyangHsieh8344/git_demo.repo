#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
    Node* prev; // Node* specifies that prev is a pointer to a Node type.
};

// Global variable - pointer to head node
Node* head;

// We want memory to remain so we store data in heap (dynamic memory)
Node* GetNewNode(int x) {
    // In C, it is malloc; this line stores in dynamic memory
    Node* newNode = new Node();
    newNode->data = x;
    newNode->prev = nullptr;
    newNode->next = nullptr;
    return newNode;
}

// Function to insert a new node at the head
void InsertAtHead(int x) {
    Node* newNode_head = GetNewNode(x);

    if (head == nullptr) {
        head = newNode_head;
        return;
    }
    head->prev = newNode_head;
    newNode_head->next = head;
    head = newNode_head;
}

// Function to insert a new node at the tail
void InsertAtTail(int x) {
    Node* newNode_tail = GetNewNode(x);

    if (head == nullptr) {
        head = newNode_tail;
        return;
    }

    Node* temp = head;
    //Use a temporary pointer (temp) to traverse the list until the last node (temp->next is nullptr).
    while (temp->next != nullptr) {
        temp = temp->next;
    }
    //Set the next pointer of the last node to the new node.
    temp->next = newNode_tail;
    //Set the prev pointer of the new node to the last node.
    newNode_tail->prev = temp;
}

// Function to reverse the linked list
Node* Reverse(Node* head) {
    Node *next, *prev = nullptr, *current = head;
    while (current != nullptr) {
        next = current->next;
        current->next = prev;
        current->prev = next;
        prev = current;
        current = next;
    }
    head = prev;
    return head;
}

// Function to reverse using recursion
void ReverseRecursion(Node* p) {
    if (p == nullptr) return;
    if (p->next == nullptr) {
        head = p;
        return;
    }
    ReverseRecursion(p->next);
    Node* q = p->next;
    q->next = p;
    p->prev = q;
    p->next = nullptr;
}

// Function to print the linked list forward
void Print(Node* head) {
    Node* temp = head;
    cout << "Forward: ";
    while (temp != nullptr) {
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << endl;
}

// Function to print the linked list in reverse
void ReversePrint(Node* head) {
    Node* temp = head;
    if (temp == nullptr) return;

    // Go to the last node
    while (temp->next != nullptr) {
        temp = temp->next;
    }

    // Print in reverse order
    cout << "Reverse: ";
    while (temp != nullptr) {
        cout << temp->data << " ";
        temp = temp->prev;
    }
    cout << endl;
}

int main() {
    // Head = empty initially
    head = nullptr;
    InsertAtHead(2); Print(head); ReversePrint(head);
    InsertAtHead(4); Print(head); ReversePrint(head);
    InsertAtHead(6); Print(head); ReversePrint(head);

    // Insert at tail
    InsertAtTail(8); Print(head); ReversePrint(head);
    InsertAtTail(10); Print(head); ReversePrint(head);

    // Free the allocated memory
    Node* temp;
    while (head != nullptr) {
        temp = head;
        head = head->next;
        delete temp;
    }

    return 0;
}
