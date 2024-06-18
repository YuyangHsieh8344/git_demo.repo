#include <iostream>
#include <vector>
#include <stack>

using namespace std;

// Function to visit a node (you can modify this as per your requirements)
void visit(int node) {
    cout << node << " ";
}

// Function to perform DFS
void dfs(vector<vector<int>>& graph, int start, vector<bool>& marked) {
    // Mark the starting node as visited
    marked[start] = true;
    
    // Visit the starting node
    visit(start);
    
    // Visit all the unvisited neighbors of the starting node
    for (int neighbor : graph[start]) {
        if (!marked[neighbor]) {
            dfs(graph, neighbor, marked);
        }
    }
}

int main() {
    // Create a sample graph
    vector<vector<int>> graph = {
        {1, 2},
        {0, 2, 3},
        {0, 1, 3},
        {1, 2}
    };
    
    // Perform DFS starting from node 0
    vector<bool> marked(graph.size(), false);
    dfs(graph, 0, marked);
    
    return 0;
}