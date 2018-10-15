Where I compare the time due to various orders of loops index in Fortran

Just run the script. It will compile and produce results in terminal

### Example OUTPUT:
```bash
Results are given in sec and a score is attributed. The less the better.

gfortran main.f90
 do i; do j; do k; a(i,j,k)=s; needs   5.85811234     seconds. Speedup =   1.00000000    
 do i; do j; do k; a(k,j,i)=s :  0.788276672     seconds. Speedup =   7.43154335    
 implicit a(:,:,:)=s :  0.420728207     seconds. Speedup =   13.9237452    
 implicit a=s :  0.419656754     seconds. Speedup =   13.9592943    
 do concurrent i,j,k ; a(i,j,k)=s :  0.618951321     seconds. Speedup =   9.46457672    
 do concurrent i,j,k ; a(k,j,i)=s :   5.88013983E-39 seconds. Speedup =   1.61382878    
 forall i,j,k ; a(i,j,k)=s :  0.403955460     seconds. Speedup =   14.5018768    
 forall i,j,k ; a(k,j,i)=s :   3.74382687     seconds. Speedup =   1.56473911    

gfortran -O3 main.f90
 do i; do j; do k; a(i,j,k)=s; needs   3.77369189     seconds. Speedup =   1.00000000    
 do i; do j; do k; a(k,j,i)=s :  0.335234880     seconds. Speedup =   11.2568598    
 implicit a(:,:,:)=s :  0.344931126     seconds. Speedup =   10.9404211    
 implicit a=s :  0.339645863     seconds. Speedup =   11.1106663    
 do concurrent i,j,k ; a(i,j,k)=s :  0.339394093     seconds. Speedup =   11.1189089    
 do concurrent i,j,k ; a(k,j,i)=s :   0.00000000     seconds. Speedup =   1.09014201    
 forall i,j,k ; a(i,j,k)=s :  0.336804390     seconds. Speedup =   11.2044020    
 forall i,j,k ; a(k,j,i)=s :   3.38481712     seconds. Speedup =   1.11488795    

```

Conclusions
----------
- Loop order is of prime importance.
- Where possible, use implicit tables or `do concurrent(i,j,k); a(i,j,k)`. You'll reach a speedup of 10, in this case.
