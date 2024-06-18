#include <iostream>
#include <vector>
#include <queue>
#include <set>
using namespace std;

class Point {
public:
    int row;
    int col;
    Point(int r, int c) : row(r), col(c) {}
};

// Function to check if a pixel is valid and within the image boundaries
bool isValid(const vector<vector<int>>& img, int row, int col) {
    return row >= 0 && row < img.size() && col >= 0 && col < img[0].size();
}

// Function to find the neighbors that have the same color as the start pixel
vector<Point> neighbors(const vector<vector<int>>& img, int row, int col, int start) {
    vector<Point> validNeighbors;
    vector<Point> indices = { Point(row - 1, col), Point(row + 1, col), Point(row, col - 1), Point(row, col + 1) };

    for (const auto& p : indices) {
        if (isValid(img, p.row, p.col) && img[p.row][p.col] == start) {
            validNeighbors.push_back(p);
        }
    }

    return validNeighbors;
}

// Flood fill function using BFS
vector<vector<int>> floodfill(vector<vector<int>>& img, int row, int col, int newColor) {
    int start = img[row][col];
    if (start == newColor) return img; // No need to fill if the color is the same

    queue<Point> q;
    q.push(Point(row, col));

    while (!q.empty()) {
        Point p = q.front();
        q.pop();

        img[p.row][p.col] = newColor;

        for (const auto& n : neighbors(img, p.row, p.col, start)) {
            q.push(n);
        }
    }

    return img;
}

// Function to print the image
void printImage(const vector<vector<int>>& img) {
    for (const auto& row : img) {
        for (int pixel : row) {
            cout << pixel << " ";
        }
        cout << endl;
    }
}

int main() {
    // Example image
    vector<vector<int>> img = {
        {1, 1, 1, 2, 2},
        {1, 1, 0, 2, 2},
        {1, 0, 0, 2, 2},
        {1, 1, 0, 2, 2},
        {1, 1, 1, 2, 2}
    };

    cout << "Original image:" << endl;
    printImage(img);

    int row = 1, col = 2, newColor = 3;
    vector<vector<int>> result = floodfill(img, row, col, newColor);

    cout << "\nFlood filled image:" << endl;
    printImage(result);

    return 0;
}
