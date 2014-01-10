program main

integer :: i, j, k
integer, parameter :: n=700
double precision, parameter :: s=1.119d0
double precision :: a(n,n,n)
double precision :: t0,t1,t2,t3,t4,t5,t6,t7,t8,t9

call cpu_time(t0)

do i=1,n  
    do j=1,n  
        do k=1,n  
            a(i,j,k)=s
        end do
    end do
end do

call cpu_time(t1)

print*,"i,j,k => a(i,j,k) :",t1-t0


do i=1,n
    do j=1,n
        do k=1,n
            a(k,j,i)=s
        end do
    end do
end do

call cpu_time(t2)

print*,"i,j,k => a(k,j,i) :",t2-t1

a=s

call cpu_time(t3)

print*,"implicit :",t3-t2

do concurrent( i=1:n, j=1:n, k=1:n )
    a(i,j,k)=s
end do

call cpu_time(t4)
print*,"concurrent i,j,k => a(i,j,k) :",t4-t3

do concurrent( i=1:n, j=1:n, k=1:n)
    a(k,j,i)=s
end do

call cpu_time(t5)
print*,"concurrent i,j,k => a(k,j,i) :",t5-t4

forall( i=1:n, j=1:n, k=1:n )
    a(i,j,k)=s
end forall

call cpu_time(t6)
print*,"forall i,j,k => a(i,j,k) :",t6-t5

forall( i=1:n, j=1:n, k=1:n )
    a(k,j,i)=s
end forall

call cpu_time(t7)
print*,"forall i,j,k => a(k,j,i) :",t7-t6

end program main
