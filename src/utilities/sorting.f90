module  sort_mod
    private
    
    public :: sort, quick_sort
contains

        
    ! re-heapify a minheap ("a")
    subroutine siftdown(a, start, bottom)
      implicit none
      
      real, intent(in out) :: a(0:)
      integer, intent(in) :: start, bottom
      
      integer :: child, root
      real :: temp

      root = start
      do while(root*2 + 1 < bottom)
        child = root * 2 + 1

        if (child + 1 < bottom) then
          if (a(child) > a(child+1)) child = child + 1
        end if

        if (a(root) > a(child)) then
          temp = a(child)
          a(child) = a (root)
          a(root) = temp
          root = child
        else
          return
        end if  
      end do      

    end subroutine siftdown
    
    ! adds items one by one to a min-heap to sort them
    subroutine sort(input, output)
        implicit none
        real, intent(in),  dimension(:) :: input
        real, intent(out), dimension(:), allocatable :: output
        real, dimension(:), allocatable :: heap
        
        integer :: i,n, j
        real :: large_value
        
        n = size(input,1)
        
        allocate(heap(n))
        large_value = maxval(input) * 2
        heap = minval(input)
        
        if (.not.allocated(output)) then
            allocate(output(n))
        else
            if (size(output,1) /= n) then
                deallocate(output)
                allocate(output(n))
            endif
        endif
        
        do i=1,n
            heap(1) = input(i)
            ! siftdown re-heapifies the heap and the heap_index arrays
            call siftdown(heap,0,n)
        end do
        do i=1,n
            output(i) = heap(1)
            heap(1) = large_value
            ! siftdown re-heapifies the heap and the heap_index arrays
            call siftdown(heap,0,n)
        end do
        
    end subroutine sort

    subroutine quick_sort(input, output)
        implicit none
        real, intent(in),  dimension(:) :: input
        real, intent(out), dimension(:), allocatable :: output
        integer :: n
        
        n = size(input,1)
        
        if (.not.allocated(output)) then
            allocate(output(n))
        else
            if (size(output,1) /= n) then
                deallocate(output)
                allocate(output(n))
            endif
        endif
        
        output = qsort_reals(output)
        
    end subroutine quick_sort
    
    ! Quicksort implementation from FLIBS see license at end of file
    recursive function qsort_reals( data ) result( sorted )
        real, dimension(:), intent(in) :: data
        real, dimension(1:size(data))  :: sorted

        if ( size(data) > 1 ) then
            sorted = (/ qsort_reals( pack( data(2:), data(2:) > data(1) ) ), &
                        data(1),                                             &
                        qsort_reals( pack( data(2:), data(2:) <= data(1) ) ) /)
        else
            sorted = data
        endif
    end function
    ! end flibs quicksort 

    
end module sort_mod

! FLIBS Copyright and license
! Copyright (c) 2008, Arjen Markus
! 
! All rights reserved.
! 
! Redistribution and use in source and binary forms, with or without modification,
! are permitted provided that the following conditions are met:
! 
! Redistributions of source code must retain the above copyright notice,
! this list of conditions and the following disclaimer.
! Redistributions in binary form must reproduce the above copyright notice,
! this list of conditions and the following disclaimer in the documentation
! and/or other materials provided with the distribution.
! Neither the name of the author nor the names of the contributors
! may be used to endorse or promote products derived from this software
! without specific prior written permission.
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
! "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
! THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
! ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
! FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
! DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
! SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
! CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
! OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
! OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
