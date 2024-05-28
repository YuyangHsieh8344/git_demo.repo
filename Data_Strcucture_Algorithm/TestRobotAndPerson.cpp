#include <iostream>
#include <string>

class Robot {
public:
    std::string name;
    std::string color;
    int weight;

    Robot(const std::string& n, const std::string& c, int w) : name(n), color(c), weight(w) {}

    void introduceSelf() {
        std::cout << "My name is " << name << std::endl;
    }
};

class Person {
public:
    std::string name;
    std::string personality;
    bool isSitting;
    Robot* robotOwned;

    Person(const std::string& n, const std::string& p, bool i) : name(n), personality(p), isSitting(i), robotOwned(nullptr) {}

    void sitDown() {
        isSitting = true;
    }

    void standUp() {
        isSitting = false;
    }
};

int main() {
    Robot r1("Tom", "red", 30);
    Robot r2("Jerry", "blue", 40);

    r1.introduceSelf();
    r2.introduceSelf();

    Person p1("Alice", "aggressive", false);
    Person p2("Becky", "talkative", true);

    p1.robotOwned = &r2;
    p2.robotOwned = &r1;

    p1.robotOwned->introduceSelf();
    p2.robotOwned->introduceSelf();

    return 0;
}
