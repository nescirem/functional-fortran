module mod_iterfold_functions

implicit none

public

contains

pure integer(kind=int8) function sum_i1(x,y) result(res)
  use iso_fortran_env,only:int8
  integer(kind=int8),intent(in) :: x,y
  res = x + y
endfunction sum_i1

pure integer(kind=int16) function sum_i2(x,y) result(res)
  use iso_fortran_env,only:int16
  integer(kind=int16),intent(in) :: x,y
  res = x + y
endfunction sum_i2
  
pure integer(kind=int32) function sum_i4(x,y) result(res)
  use iso_fortran_env,only:int32
  integer(kind=int32),intent(in) :: x,y
  res = x + y
endfunction sum_i4
  
pure integer(kind=int64) function sum_i8(x,y) result(res)
  use iso_fortran_env,only:int64
  integer(kind=int64),intent(in) :: x,y
  res = x + y
endfunction sum_i8
  
pure real(kind=real32) function sum_r4(x,y) result(res)
  use iso_fortran_env,only:real32
  real(kind=real32),intent(in) :: x,y
  res = x + y
endfunction sum_r4
  
pure real(kind=real64) function sum_r8(x,y) result(res)
  use iso_fortran_env,only:real64
  real(kind=real64),intent(in) :: x,y
  res = x + y
endfunction sum_r8
  
pure real(kind=real128) function sum_r16(x,y) result(res)
  use iso_fortran_env,only:real128
  real(kind=real128),intent(in) :: x,y
  res = x + y
endfunction sum_r16
  
endmodule mod_iterfold_functions

program test_iterfold
use iso_fortran_env,only:int8,int16,int32,int64,real32,real64,real128
use mod_testing,only:assert,initialize_tests,report_tests
use mod_functional
use mod_iterfold_functions

implicit none

logical,dimension(:),allocatable :: tests
logical :: test_failed
integer :: n,norder,ntests
integer,parameter :: stdout = 6

n = 1
ntests = 7
call initialize_tests(tests,ntests)

tests(n) = assert(iterfold(sum_i1,0_int8,[3_int8,4_int8,5_int8]) == 12,&
                  'iterfold, int8')
n = n + 1

tests(n) = assert(iterfold(sum_i2,0_int16,[3_int16,4_int16,5_int16]) == 12,&
                  'iterfold, int16')
n = n + 1

tests(n) = assert(iterfold(sum_i4,0_int32,[3,4,5]) == 12,&
                  'iterfold, int32')
n = n + 1

tests(n) = assert(iterfold(sum_i8,0_int64,[3_int64,4_int64,5_int64]) == 12,&
                  'iterfold, int64')
n = n + 1

tests(n) = assert(iterfold(sum_r4,0._real32,[3.,4.,5.]) == 12,&
                  'iterfold, real32')
n = n + 1

tests(n) = assert(iterfold(sum_r8,0._real64,[3._real64,4._real64,5._real64]) == 12,&
                  'iterfold, real64')
n = n + 1

tests(n) = assert(iterfold(sum_r16,0._real128,[3._real128,4._real128,5._real128]) == 12,&
                  'iterfold, real128')
n = n + 1

test_failed = .false.
call report_tests(tests,test_failed)
if(test_failed)stop 1

endprogram test_iterfold
