#include <stdio.h>
#include <stdbool.h>

int main(int argc, char const *argv[])
{
    int x, y, z, n, cero;
    cero = 0;
    n = 50;
    x = cero;
    y = cero;
    x++;

    while(true){
        z = y + x;
        if(z > n){
            break;
        }
        printf("%d\n", z);
        x = y;
        y = z;
    }
        
    
    return 0;
}
