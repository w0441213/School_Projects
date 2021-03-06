#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   Message Redaction Program
Description:     This program will remove all desired letters from any user-entered sentence or phrase.
"""
#Make a function to an input from the user
def getInput(prm_inputMSG):
    userValue = input(prm_inputMSG)
    return userValue


def MessageRedaction():

    execute = True
    while execute == True:
        #Get the phrase from the user
        phrase = getInput("Type a phrase (or quit to exit program): ")
        redactedPhrase = phrase.lower()
        #If the user would like to exit the program
        if phrase.lower() == "quit":
            print("End of Program. Bye!")
            execute = False
        else:
            #Get the letters the user would like to redact
            redactLetters = getInput("Type a comma-separated list of letters to redact: ").lower()
            
            for letter in redactLetters:
                if letter.lower() != ",":
                    #replace the letters the user wants to redact into an "_"
                    redactedPhrase = redactedPhrase.replace(letter,"_")
            
            #count the number of letters that were redacted by counting the number of "_"
            counter = redactedPhrase.count("_")

            #Get the final redacted phrase
            finalRedactedPhrase = ""
            for count in range (len(redactedPhrase)):
                if redactedPhrase[count] == "_":
                    finalRedactedPhrase = finalRedactedPhrase + "_"
                else:
                    finalRedactedPhrase = finalRedactedPhrase + phrase[count]
            print()
            print("Number of letters redacted: ", counter)
            print("Redacted phrase: ", finalRedactedPhrase)
            print()

def main():  #<-- Don't change this line!
    #Write your code below. It must be indented!
    MessageRedaction()

    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()