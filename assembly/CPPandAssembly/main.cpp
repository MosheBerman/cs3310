#include <iostream>

using namespace std;

extern "C" int maxofthree(int, int, int);

int main()
{
    cout << maxofthree(-5, 10, 6);

    return 0;
}
