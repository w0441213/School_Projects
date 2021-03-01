#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:   Jamie Lu
Program Title:  Time Sheet Program
Description:    Program that accepts the number of hours worked on each of five days from the user
                and displays different information calculated about those entries as output.
"""

#function to calculate the average of a list of numbers
def averageCalculator(p_numbers):
    total = 0
    for count in range(len(p_numbers)):
        total = total + p_numbers[count]
    
    average = total/len(p_numbers)
    return average

def TimeSheetProgram():
    hours = [] #Declaring an empty list

    #Ask the user to input the number of hours worked on each day
    for count in range(5):
        hours.append(float(input("Enter hours worked on Day #{}: ".format(count + 1))))

    print("-------------------------------------------------------------------------")    

    #Get the day wherein the user worked the most 
    print("The most hours worked was on: ")
    maxHours = max(hours) #function to get the highest number of hours worked from the hours list
    for count in range(5):
        if hours[count] == maxHours:
            print("Day #{0} when you worked {1:.0f} hours.".format(count+1, maxHours))
        else:
            pass

    print("-------------------------------------------------------------------------")

    #Get the total number of hours worked
    total = 0
    normalHours = 7
    for hour in hours:
        total = total + hour
    print("The total number of hours worked was: {}".format(total))

    #Get the average number of hours worked using the averageCalculator function
    print("The average number of hours worked each day was: {}".format(averageCalculator(hours)))

    #Determine the days wherein the user worked less than the normalHours or 7 hours
    print("-------------------------------------------------------------------------")
    print("Days you slacked off (i.e. worked less than 7 hours):")
    for count in range(5):
        if int(hours[count]) < normalHours:
            print("Day #{0}: {1} hours".format(count+1, hours[count]))
        else:
            pass


def main():  #<-- Don't change this line!
    #Write your code below. It must be indented!
    TimeSheetProgram()

    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()



