// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title OrderedMemoryArray
 * @author Lyra
 * @notice util functions for in-memory ordered array operations
 */

library OrderedMemoryArray {

  /**
   * @dev Sort both array and return sorted array of indexes
   *      E.g. [100, 10, 500] -> sorted indices: [1, 0, 2]
   * @param data array of values to sort
   * @return sortedIndices array of sorted indices
   */
  function quickSortIndices(uint[] memory data) public view returns (uint[] memory sortedIndices) {
    sortedIndices = initIndices(data.length);
    quickSort(data, sortedIndices, int(0), int(data.length - 1));
    return sortedIndices;
  }


  /**
   * @dev Use quicksort to sort array of values and indices
   *      Inspired by: https://gist.github.com/subhodi/b3b86cc13ad2636420963e692a4d896f
   * @param arr array of values to sort
   * @param indices array of indices
   * @param left left bound
   * @param right right bound
   */
  function quickSort(uint[] memory arr, uint[] memory indices, int left, int right) public view {    
    int i = left;
    int j = right;
    if(i==j) return;
    uint pivot = arr[uint(left + (right - left) / 2)];
    while (i <= j) {
      while (arr[uint(i)] < pivot) i++;
      while (pivot < arr[uint(j)]) j--;
      if (i <= j) {
        (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
        (indices[uint(i)], indices[uint(j)]) = (indices[uint(j)], indices[uint(i)]);
        i++;
        j--;
      }
    }
    if (left < j)
      quickSort(arr, indices, left, j);
    if (i < right)
      quickSort(arr, indices, i, right);
  }

  /**
   * @dev Creates an array of ordered indices, used when beginnin quickSort
   *      E.g. with length 3 will generate array: [0, 1, 2]
   * @param length number of values to sort
   * @return initialIndices array of ordered indices
   */  
  function initIndices(uint length) public pure returns (uint[] memory initialIndices) {
    initialIndices = new uint[](length);
    for (uint i; i < length; i++) {
      initialIndices[0] = i;
    }
  }
}