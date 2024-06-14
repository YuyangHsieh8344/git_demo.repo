#include <iostream>
#include <vector>

using namespace std;

// Definition for singly-linked list.
struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

// Solution class with the mergeTwoLists function
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        if (l1 == nullptr) {
            return l2;
        }

        if (l2 == nullptr) {
            return l1;
        }

        if (l1->val <= l2->val) {
            l1->next = mergeTwoLists(l1->next, l2);
            return l1;
        } else {
            l2->next = mergeTwoLists(l1, l2->next);
            return l2;
        }
    }
};

// Helper function to create a linked list from a vector of integers
ListNode* createLinkedList(const vector<int>& vals) {
    if (vals.empty()) {
        return nullptr;
    }

    ListNode* head = new ListNode(vals[0]);
    ListNode* current = head;
    for (size_t i = 1; i < vals.size(); ++i) {
        current->next = new ListNode(vals[i]);
        current = current->next;
    }
    return head;
}

// Helper function to print a linked list
void printLinkedList(ListNode* head) {
    ListNode* current = head;
    while (current != nullptr) {
        cout << current->val;
        if (current->next != nullptr) {
            cout << " -> ";
        }
        current = current->next;
    }
    cout << endl;
}

int main() {
    // Create two linked lists from vectors
    vector<int> list1_vals = {1, 2, 4};
    vector<int> list2_vals = {1, 3, 4};

    ListNode* l1 = createLinkedList(list1_vals);
    ListNode* l2 = createLinkedList(list2_vals);

    // Print the original linked lists
    cout << "List 1: ";
    printLinkedList(l1);

    cout << "List 2: ";
    printLinkedList(l2);

    // Merge the two linked lists
    Solution solution;
    ListNode* mergedList = solution.mergeTwoLists(l1, l2);

    // Print the merged linked list
    cout << "Merged List: ";
    printLinkedList(mergedList);

    // Free the allocated memory for the merged list
    while (mergedList != nullptr) {
        ListNode* temp = mergedList;
        mergedList = mergedList->next;
        delete temp;
    }

    return 0;
}
