def arr_balance_point(arr):
    # Forming prefix sum array from 0
    if len(arr)>2:
        # Finding the length of array
        n = len(arr)
        prefixSum = [0] * n
        prefixSum[0] = arr[0]
        for i in range(1, n):
            prefixSum[i] = prefixSum[i - 1] + arr[i]

            # Forming suffix sum array from n-1
        suffixSum = [0] * n
        suffixSum[n - 1] = arr[n - 1]
        for i in range(n - 2, -1, -1):
            suffixSum[i] = suffixSum[i + 1] + arr[i]

        # Find the point where prefix and suffix sums are same.
        for i in range(1, n - 1, 1):
            if prefixSum[i] == suffixSum[i]:
                return True

        return False
    else:
        return False

# Driver Code
if __name__ == "__main__":
    # arr = [1, 4, 2, 5]
    arr =[1,6,5,1,2,3,1]
    # arr = [1,5,1]
    # arr = []
    print(arr_balance_point(arr))
