
#include <iostream>
#include <vector>
#include <queue>
using namespace std;
// Function to perform BFS
void bfs(vector<vector<int>>& graph, int start, vector<bool>& visited) {
    // Create a queue to keep track of the nodes to visit
    queue<int> q;
    
    // Mark the starting node as visited and push it onto the queue
    visited[start] = true;
    q.push(start);
    
    // Perform BFS
    while (!q.empty()) {
        // Dequeue the front node from the queue
        int current = q.front();
        q.pop();
        
        // Print the current node
        cout << current << " ";
        
        // Visit all the unvisited neighbors of the current node
        for (int neighbor : graph[current]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                q.push(neighbor);
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
    
    // Perform BFS starting from node 0
    vector<bool> visited(graph.size(), false);
    bfs(graph, 0, visited);
    
    return 0;
}
//output = 0 1 4 2 3 5 6 7 