def char_frequency(str1):
    # initializing a dict
    dict = {}
    # operation for finding characters and counting the frequency
    for n in str1:
        keys = dict.keys()
        if n in keys:
            dict[n] += 1
        else:
            dict[n] = 1

    print(type(dict))
    return dict

# Driver Code
if __name__ == "__main__":
    print(char_frequency('abba'))
