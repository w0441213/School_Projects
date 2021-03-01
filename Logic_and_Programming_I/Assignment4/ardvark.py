#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:   Jamie Lu
Program Title:  The Itsy Bitsy Aardvark
Description:    Program that presents the user with a "Mad Libs" type game,
                where a random choice of words are read from a file,
                then interjected into a story red from another file.
"""
#Function for opening file and setting the access mode to read
def readingFile(p_file):
    content = []
    for line in open(p_file, "r"):
        content.append(line.replace("\n", ""))
    return content

def main(): #<-- Don't change this line!

    import csv

    #Use the readingFile function
    storyFile = readingFile('the_story_file.txt')
    choiceFile = readingFile('the_choices_file.csv')

    #read the choices file as csv
    choiceData = csv.reader(choiceFile) 

    #initialize list
    choices = []

    print("The Itsy Bitsy Aardvark")
    print(" ")

    #set a variable for the letters (a-e) to display before each choice
    letterChoice = ord("a")

    #print each group and their choices
    for eachGroup in choiceData:
        print("Please choose", eachGroup[0], ":")

        for counter in range(1, len(eachGroup)):
            print(chr(letterChoice + counter-1), ")", eachGroup[counter])

        #ask for the choice from the user
        inputChoice = input("Enter choice (a-e): ")
        if inputChoice.lower() == "a":
            choice = eachGroup[1]
            choices.append(choice.upper())
        elif inputChoice.lower() == "b":
            choice = eachGroup[2]
            choices.append(choice.upper())
        elif inputChoice.lower() == "c":
            choice = eachGroup[3]
            choices.append(choice.upper())
        elif inputChoice.lower() == "d":
            choice = eachGroup[4]
            choices.append(choice.upper())
        elif inputChoice.lower() == "e":
            choice = eachGroup[5]
            choices.append(choice.upper())
        else:
            print("Invalid Input. Please try again.")
            break


    #print the completed story
    print(" ")
    print("Your Completed Story: ")
    print(" ")

    #replace the numbers in the story file with the choices the user put in
    for line in storyFile:
        newLine = line
        for counter in range(len(choices)):
            newLine = newLine.replace("_" + str(counter + 1) + "_", choices[counter])
        print(newLine)


    #Your code ends on the line above



#Do not change any of the code below!

if __name__ == "__main__":

    main()

