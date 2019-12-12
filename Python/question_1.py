import  string

def is_anagram(word):
    # converting input word ito lower case
    word = word.lower()
    print(word)
    # reversing the word
    reversed_word = word[::-1]
    # initializing anagram boolean variable as False
    word_is_anagram = False
    # comparing input word with reversed word
    if word == reversed_word:
        word_is_anagram = True

    return word_is_anagram

# Driver Code
if __name__ == "__main__":
    print(is_anagram('Civic'))