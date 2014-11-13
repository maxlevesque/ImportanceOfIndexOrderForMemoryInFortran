program main

  integer :: i, j, k
  integer, parameter :: n=700
  double precision, parameter :: s=acos(-1.d0)
  double precision :: a(n,n,n)
  real :: t(11), dtref

  it=1
  call cpu_time( t(it) )

  do i=1,n
      do j=1,n
          do k=1,n
              a(i,j,k)=s
          end do
      end do
  end do
  it = it+1
  call cpu_time( t(it) )
  dtref = t(it)-t(it-1)
  print*,"do i; do j; do k; a(i,j,k)=s; needs",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  do i=1,n
      do j=1,n
          do k=1,n
              a(k,j,i)=s
          end do
      end do
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do i; do j; do k; a(k,j,i)=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  a(:,:,:)=s
  it = it+1
  call cpu_time( t(it) )
  print*,"implicit a(:,:,:)=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  a=s
  it = it+1
  call cpu_time( t(it) )
  print*,"implicit a=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  do concurrent( i=1:n, j=1:n, k=1:n )
      a(i,j,k)=s
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do concurrent i,j,k ; a(i,j,k)=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  do concurrent( i=1:n, j=1:n, k=1:n)
      a(k,j,i)=s
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do concurrent i,j,k ; a(k,j,i)=s :",t5-t4,"seconds. Speedup =",dtref/(t(it)-t(it-1))

  forall( i=1:n, j=1:n, k=1:n )
      a(i,j,k)=s
  end forall
  it = it+1
  call cpu_time( t(it) )
  print*,"forall i,j,k ; a(i,j,k)=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

  forall( i=1:n, j=1:n, k=1:n )
      a(k,j,i)=s
  end forall
  it = it+1
  call cpu_time( t(it) )
  print*,"forall i,j,k ; a(k,j,i)=s :",t(it)-t(it-1),"seconds. Speedup =",dtref/(t(it)-t(it-1))

end program main
