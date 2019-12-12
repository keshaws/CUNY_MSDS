def temp_cal(temp_list):
    # Checking input list length
    list_length = len(temp_list)
    # print(sum(temp_list))
    # Calculating average temp of list
    avg_temp = sum(temp_list)/list_length
    # print(avg_temp)
    # initializing temperature feel variable
    temp_feel = ''
    # operations for temperature feel
    if (avg_temp>=60 and avg_temp<=75):
        temp_feel = 'perfect!'
    elif avg_temp < 60:
        temp_feel = 'colder'
    elif avg_temp >75:
        temp_feel = 'hotter'
    return temp_feel

# Driver Code
if __name__ == "__main__":
    print(temp_cal([87,90,88,92,94]))