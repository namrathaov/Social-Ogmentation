# -*- coding: utf-8 -*-

from numpy import asarray

# TODO: Replace all TODO comments (yes, this one too!)

ENERGY_LEVEL = [1,-4,3,2]
#ENERGY_LEVEL = [100, 113, 110, 85, 105, 102, 86, 63, 81, 101, 94, 106, 101,79, 94, 90, 97]

# ==============================================================

# The brute force method to solve first problem


def find_significant_energy_increase_brute(A):

    """
    Return a tuple (i,j) where A[i:j] is the most significant energy
    increase period.
    time complexity = O(n^2)
    """
    max = float('-Inf')
    sum = 0
    for i in range(1,len(A)):
        sum=0
        for j in range(i+1,len(A)):
            sum = sum + (A[j] - A[j-1])
            if max < sum:
                max = sum
                max_i = i
                max_j = j
    return (max_i,max_j)

# ==============================================================

# The recursive method to solve first problem


def find_significant_energy_increase_recursive(A):

    """
    Return a tuple (i,j) where A[i:j] is the most significant
    energy increase period.
    time complexity = O (n logn)
    """
    # TODO
    if len(A)==1:
        return 0, 0
    if len(A)==2:
        return 0,1
    
    mid = int(len(A)/2)
    l_low,l_high = find_significant_energy_increase_recursive(A[0:mid]);
    r_low,r_high = find_significant_energy_increase_recursive(A[mid:]);
    o_low,o_high = find_significant_energy_increase_overlapping(A);
    left = 0
    right = 0
    overlap = 0
    for i in range(l_low+1,l_high+1):
        left += (A[i] - A[i-1])
    for i in range(mid+r_low+1,mid+r_high+1):
        right += (A[i] - A[i-1])
    for i in range(o_low+1,o_high+1):
        overlap += (A[i] - A[i-1])
    if left > right:
        if left > overlap:
            return l_low,l_high
    elif right > left:
        if right > overlap:
            return mid+r_low,mid+r_high
    return (o_low,o_high)

# ==============================================================
def find_significant_energy_increase_overlapping(A):
    sum = 0
    left = float('-inf')
    mid  = int(len(A)/2)
    max_i = -1
    max_j = -1
    for i in range(mid,1,-1):
        sum = sum + (A[i]-A[i-1])
        if(left < sum):
            left = sum;
            max_i = i-1
            
    sum = 0
    right = float('-inf')
    for i in range(mid-1,len(A)-1):
        sum+=(A[i+1] - A[i])
        if(right<sum):
            right = sum
            max_j = i+1
    return (max_i,max_j)


    # The iterative method to solve first problem


def find_significant_energy_increase_iterative(A):

    """
    Return a tuple (i,j) where A[i:j] is the most significant
    energy increase period.
    time complexity = O(n)
    """
    # TODO
    max = 0
    contig_sum = 0
    cur_max_i = 0
    for i in range(1, len(A)):
        contig_sum += (A[i] - A[i-1])
        if contig_sum < 0:
            contig_sum = 0
            cur_max_i = i 
        if(max < contig_sum):
            max = contig_sum
            max_i = cur_max_i
            max_j = i
    return (max_i,max_j)    


# ==============================================================

# The Strassen Algorithm to do the matrix multiplication


def square_matrix_multiply_strassens(A, B):

    """
    Return the product AB of matrix multiplication.
    Assume len(A) is a power of 2
    """

    A = asarray(A)

    B = asarray(B)
    print(A,B)
    assert A.shape == B.shape

    assert A.shape == A.T.shape

    assert (len(A) & (len(A) - 1)) == 0, "A is not a power of 2"
    
    #return square_matrix_multiply_strassens(A[0:len/2][0:len(A)/2

# ==============================================================

# Calculate the power of a matrix in O(k)


def power_of_matrix_navie(A, k):

    """
    Return A^k.
    time complexity = O(k)
    """
    # TODO

# ==============================================================

# Calculate the power of a matrix in O(log k)


def power_of_matrix_divide_and_conquer(A, k):

    """
    Return A^k.
    time complexity = O(log k)
    """
    # TODO

# ==============================================================


def test():
    #print(find_significant_energy_increase_brute(ENERGY_LEVEL));
    #print(find_significant_energy_increase_recursive(ENERGY_LEVEL));
    #print(find_significant_energy_increase_iterative(ENERGY_LEVEL));
    (square_matrix_multiply_strassens([[0, 1], [1, 1]],
            [[0, 1], [1, 1]]) ==
           asarray([[1, 1], [1, 2]])).all()
    #assert(find_significant_energy_increase_brute(ENERGY_LEVEL) == (7, 11))
    #assert(find_significant_energy_increase_recursive(ENERGY_LEVEL) == (7, 11))
    #assert(find_significant_energy_increase_iterative(ENERGY_LEVEL) == (7, 11))
    #assert((square_matrix_multiply_strassens([[0, 1], [1, 1]],
    #        [[0, 1], [1, 1]]) ==
    #       asarray([[1, 1], [1, 2]])).all())
    #assert((power_of_matrix_navie([[0, 1], [1, 1]], 3) ==
    #        asarray([[1, 2], [2, 3]])).all())
    #assert((power_of_matrix_divide_and_conquer([[0, 1], [1, 1]], 3) ==
    #        asarray([[1, 2], [2, 3]])).all())
    # TODO: Test all of the methods and print results.


if __name__ == '__assignment_2__':

    test()
test()
# ==============================================================
