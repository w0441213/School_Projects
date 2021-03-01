#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   Girl Guide Cookie Sell-Off Program
Description:     This program will print the guide list and prizes for the annual Girl Guide cookie sale event
"""

#Making a function to input the right amount of spaces in between two values
def StringFormatter(outString, MaximumLength):
    while len(outString) < MaximumLength:
        outString = outString + " "
    return outString

def averageCalculator(p_numbers):
    total = 0
    for count in range(len(p_numbers)):
        total = total + p_numbers[count]
    
    average = total/len(p_numbers)
    return average


def GirlGuideProgram():
    numGuideChecker = 0

    while numGuideChecker == 0:
    #Declaring an empty list, this list would be the main list to hold the information on the GirlGuideProgram (Making a 2D List)
        GirlGuideList = []
        numGuides = input("Enter the number of guides selling cookies: ")
        print()

        try:
            numGuideChecker = float(numGuides)
        except ValueError:
            print("Hey is it that hard to enter a number?")

    int_numGuides = int(numGuides)


    #Ask the user for the names of the guides and for the number of boxes they sold individually.
    #Make lists within the main list (GirlGuideList) that holds the values of the user's inputs (Guides and BoxesSold)
    for count in range (1):
        guide = []
        boxes = []
        for columnIndex in range (int_numGuides):
            nameGirlGuide = (input("Enter the name of guide #{}: ".format(columnIndex + 1)))
            guide.append(nameGirlGuide)
            boxesSold = int(input("Enter the number of boxes sold by {}: ".format(nameGirlGuide)))
            boxes.append(boxesSold)
            print()

    #Add the guide and boxes lists into the main list (GirlGuideList)        
        GirlGuideList.append(guide) 
        GirlGuideList.append(boxes)
     
    #Get the total amount of boxes sold
    totalSold = 0
    for numBoxes in boxes:
        totalSold = totalSold + int(numBoxes)

    #print the average number of boxes sold by each guide
    averageSold = averageCalculator(boxes)
    print("The average number of boxes sold by each guide was {0:.1f}".format(averageSold))
    print(" ")

    #Determine the longest name in the list of guides to aid in formatting the final output and set the number of spacing
    spacing = 20
    longestName = len(max(guide)) + spacing


    print("Guide:", '\t\t\t', "Prizes Won:")
    print("-----------------------------------------------------------------------------------------------------")

    #Get the highest number of boxes sold
    highestSold = max(boxes)
    prize = ""
    #Set the prizes to be won if they won a certain amount through conditions
    for count in range(int_numGuides):
        #If the guide sold the highest amount
        if boxes[count] == highestSold:
            prize = "Trip to Girl Guide Jamboree in Aruba!"
        #If the guide sold higher than the average amount but not the highest amount
        elif boxes[count] > averageSold and boxes[count] != highestSold:
            prize = "Super Seller Badge"
        #If the guide sold lower than the average amount
        elif boxes[count] <= averageSold and boxes[count] >= 1:
            prize = "Left over cookies"
        else:
            prize = " "

    #Using the StringFormatter function to correctly format the output with the correct spacing
        print(StringFormatter(guide[count], longestName) + " - " + prize)


def main():  #<-- Don't change this line!
    #Write your code below. It must be indented!
    GirlGuideProgram()

    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()