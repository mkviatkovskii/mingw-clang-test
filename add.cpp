#include "add.h"

#include <cmath>

#include <boost/random.hpp>

namespace math
{
    int add(const int a, const int b)
    {
        constexpr size_t RV_SIZE = 100;
        std::vector<double> random_values(RV_SIZE);
        boost::random::mt19937 gen;
        boost::random::uniform_real_distribution<double> dist(0.0, 1.0);

#       pragma omp parallel for
        for (auto i = 0; i< RV_SIZE; i++)
        {
            random_values[i] = std::sqrt(dist(gen));
            std::cout<< i;
        }

        int result = a + b;

#       pragma omp parallel for reduction(+: result)
        for (auto i = 0; i< RV_SIZE; i++)
        {
            result += static_cast<int>(random_values[i]);
        }
        return result;
    }
}

