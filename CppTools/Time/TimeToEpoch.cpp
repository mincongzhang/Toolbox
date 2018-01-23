#include <ctime>
#include <iostream>

int main()
{
    struct tm t = {0};  // Initalize to all 0's
    t.tm_year = 118;  // This is year-1900, so 118 = 2018
    t.tm_mon = 1;
    t.tm_mday = 22;
    t.tm_hour = 15;
    t.tm_min = 30;
    t.tm_sec = 0;
    time_t timeSinceEpoch = mktime(&t);
    std::cout << std::asctime(std::localtime(&timeSinceEpoch))
              << timeSinceEpoch << " seconds since the Epoch"<<std::endl;
}
