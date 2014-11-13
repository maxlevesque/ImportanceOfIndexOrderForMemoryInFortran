Where I compare the time due to various orders of loops index in Fortran

Just run the script. It will compile and produce results in terminal

### Example output:
```bash
Results are given in sec and a score is attributed. The less the better.

gfortran main.f90
 do i; do j; do k; a(i,j,k)=s; needs   5.45915604     seconds. Reference score:        1000
 do i; do j; do k; a(k,j,i)=s :  0.795019150     seconds. Score:         145
 implicit a(:,:,:)=s :  0.349738121     seconds. Score:          64
 implicit a=s :  0.353263855     seconds. Score:          64
 do concurrent i,j,k ; a(i,j,k)=s :  0.478909016     seconds. Score:          87
 do concurrent i,j,k ; a(k,j,i)=s :   5.88027435E-39 seconds. Score:         611
 forall i,j,k ; a(i,j,k)=s :  0.396711349     seconds. Score:          72
 forall i,j,k ; a(k,j,i)=s :   3.33094215     seconds. Score:         610

gfortran -O3 main.f90
 do i; do j; do k; a(i,j,k)=s; needs   3.53109002     seconds. Reference score:        1000
 do i; do j; do k; a(k,j,i)=s :  0.337677956     seconds. Score:          95
 implicit a(:,:,:)=s :  0.352410793     seconds. Score:          99
 implicit a=s :  0.341470242     seconds. Score:          96
 do concurrent i,j,k ; a(i,j,k)=s :  0.347651958     seconds. Score:          98
 do concurrent i,j,k ; a(k,j,i)=s :   0.00000000     seconds. Score:         943
 forall i,j,k ; a(i,j,k)=s :  0.337882042     seconds. Score:          95
 forall i,j,k ; a(k,j,i)=s :   3.33127975     seconds. Score:         943
```

Conclusion: Where possible, use `do concurrent(i,j,k); a(i,j,k)`
