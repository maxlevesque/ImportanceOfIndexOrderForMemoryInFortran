Where I compare the time due to various orders of loops index in Fortran

Just run the script. It will compile and produce results in terminal

### Example output:
```bash
Results are given in sec and a score is attributed. The less the better.

gfortran main.f90
 do i; do j; do k; a(i,j,k)=s; needs   5.46710110     seconds. Reference score:        1000
 do i; do j; do k; a(k,j,i)=s :  0.782495022     seconds. Speedup =   6.98675489    
 implicit a(:,:,:)=s :  0.339677811     seconds. Speedup =   16.0949612    
 implicit a=s :  0.340271950     seconds. Speedup =   16.0668583    
 do concurrent i,j,k ; a(i,j,k)=s :  0.473570824     seconds. Speedup =   11.5444212    
 do concurrent i,j,k ; a(k,j,i)=s :   5.88027435E-39 seconds. Speedup =   1.64268994    
 forall i,j,k ; a(i,j,k)=s :  0.401863098     seconds. Speedup =   13.6043873    
 forall i,j,k ; a(k,j,i)=s :   3.32125282     seconds. Speedup =   1.64609599    

gfortran -O3 main.f90
 do i; do j; do k; a(i,j,k)=s; needs   3.53243709     seconds. Reference score:        1000
 do i; do j; do k; a(k,j,i)=s :  0.338969946     seconds. Speedup =   10.4210920    
 implicit a(:,:,:)=s :  0.338504791     seconds. Speedup =   10.4354124    
 implicit a=s :  0.347027302     seconds. Speedup =   10.1791334    
 do concurrent i,j,k ; a(i,j,k)=s :  0.339870930     seconds. Speedup =   10.3934660    
 do concurrent i,j,k ; a(k,j,i)=s :   0.00000000     seconds. Speedup =   1.06270540    
 forall i,j,k ; a(i,j,k)=s :  0.342233658     seconds. Speedup =   10.3217115    
 forall i,j,k ; a(k,j,i)=s :   3.33900261     seconds. Speedup =   1.05793178    
```

Conclusions
----------
- Loop order is of prime importance.
- Where possible, use `do concurrent(i,j,k); a(i,j,k)`. You'll reach a speedup of 10, in this case.
