//
//  C Functions.c
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 18.09.2022.
//

#include "C Functions.h"

long long c_for_each(long long arr[50000000]) {
    long summ = 0;
    long i;
    for(i = 0; i <= 50000000; i++) {
        summ += arr[i];
    }
    return summ;
};
