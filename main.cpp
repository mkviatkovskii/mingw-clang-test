#include <iostream>
#include <string>

#include "add.h"

using namespace math;

int main(int argc, char* argv[])
{
    std::cout << add(std::stoi(argv[1]), std::stoi(argv[2])) << std::endl;
    exit(0);
}
