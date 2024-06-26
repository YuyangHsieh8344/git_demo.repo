#include <iostream>

struct Node
{
    int data;
    Node* next;
};


Node* front = nullptr;
Node* rear = nullptr;

void Enqueue(int x)
{

    Node* temp = new Node();
    temp -> data = x;
    temp -> next = nullptr;
    if(front == nullptr && rear == nullptr)
    {
        front = rear = temp;
        return;
    }
    rear -> next = temp;
    rear = temp;
}


void Dequeue() 
{
    if (front == nullptr) {
        std::cout << "Queue is Empty\n";
        return;
    }
    Node* temp = front;
    if (front == rear) {
        front = rear = nullptr;
    } else {
        front = front->next;
    }
    delete temp;
}

int Front() {
    if (front == nullptr) {
        std::cout << "Queue is empty\n";
        return -1; // Return -1 to indicate the queue is empty
    }
    return front->data;
}

void Print() {
    Node* temp = front;
    while (temp != nullptr) {
        std::cout << temp->data << " ";
        temp = temp->next;
    }
    std::cout << std::endl;
}

int main() {
    /* Drive code to test the implementation. */
    // Printing elements in Queue after each Enqueue or Dequeue 
    Enqueue(2); Print(); 
    Enqueue(4); Print();
    Enqueue(6); Print();
    Dequeue();  Print();
    Enqueue(8); Print();

    return 0;
}