#include <iostream>
#include <vector>


int main (int argc, char *argv[])
{
    std::vector<int> vec {0, 1, 2};
    for (auto i: vec)
        std::cout << i << ' ';
    std::cout << "Hello World" << std::endl;
    return 0;
}
