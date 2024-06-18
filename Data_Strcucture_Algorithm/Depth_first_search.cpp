#include <iostream>
#include <vector>
#include <stack>

using namespace std;

// Function to perform DFS
void dfs(vector<vector<int>>& graph, int start, vector<bool>& visited) {
    // Create a stack to keep track of the nodes to visit
    stack<int> s;
    
    // Mark the starting node as visited
    visited[start] = true;
    
    // Push the starting node onto the stack
    s.push(start);
    
    // Perform DFS
    while (!s.empty()) {
        // Pop the top node from the stack
        int current = s.top();
        s.pop();
        
        // Print the current node
        cout << current << " ";
        
        // Visit all the unvisited neighbors of the current node
        for (int neighbor : graph[current]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                s.push(neighbor);
            }
        }
    }
}

int main() {
    // Create a larger graph
    vector<vector<int>> graph = {
        {1, 4},       // Vertex 0 is connected to vertices 1 and 4
        {0, 2, 3, 4}, // Vertex 1 is connected to vertices 0, 2, 3, and 4
        {1, 3, 5},    // Vertex 2 is connected to vertices 1, 3, and 5
        {1, 2, 5, 6}, // Vertex 3 is connected to vertices 1, 2, 5, and 6
        {0, 1, 5},    // Vertex 4 is connected to vertices 0, 1, and 5
        {2, 3, 4, 6, 7}, // Vertex 5 is connected to vertices 2, 3, 4, 6, and 7
        {3, 5, 7},    // Vertex 6 is connected to vertices 3, 5, and 7
        {5, 6}        // Vertex 7 is connected to vertices 5 and 6
    };

    
    // Perform DFS starting from node 0
    vector<bool> visited(graph.size(), false);
    dfs(graph, 0, visited);
    
    return 0;
}