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
  print*,"do i; do j; do k; a(i,j,k)=s; needs",t(it)-t(it-1),"seconds. Reference score:",int((t(it)-t(it-1))/dtref*1000)

  do i=1,n
      do j=1,n
          do k=1,n
              a(k,j,i)=s
          end do
      end do
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do i; do j; do k; a(k,j,i)=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  a(:,:,:)=s
  it = it+1
  call cpu_time( t(it) )
  print*,"implicit a(:,:,:)=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  a=s
  it = it+1
  call cpu_time( t(it) )
  print*,"implicit a=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  do concurrent( i=1:n, j=1:n, k=1:n )
      a(i,j,k)=s
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do concurrent i,j,k ; a(i,j,k)=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  do concurrent( i=1:n, j=1:n, k=1:n)
      a(k,j,i)=s
  end do
  it = it+1
  call cpu_time( t(it) )
  print*,"do concurrent i,j,k ; a(k,j,i)=s :",t5-t4,"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  forall( i=1:n, j=1:n, k=1:n )
      a(i,j,k)=s
  end forall
  it = it+1
  call cpu_time( t(it) )
  print*,"forall i,j,k ; a(i,j,k)=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

  forall( i=1:n, j=1:n, k=1:n )
      a(k,j,i)=s
  end forall
  it = it+1
  call cpu_time( t(it) )
  print*,"forall i,j,k ; a(k,j,i)=s :",t(it)-t(it-1),"seconds. Score:",int((t(it)-t(it-1))/dtref*1000)

end program main
