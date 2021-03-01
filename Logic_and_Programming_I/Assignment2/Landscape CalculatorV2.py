#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   The Landscape Calculator
Description:     A program that computes the price of landscaping for a new housing development.
"""
#CREATING FUNCTIONS THAT CAN BE USED IN THE PROGRAM
def introMSG():
    #Welcome Message
    print("Welcome to the Landscape Calculator!")
    
    #Information Message
    print("Enter the requested values below to get the price of landscaping.")
    print(" ")

#Input function
def getINPUT(prm_inputMSG):
    userValue = input(prm_inputMSG)
    return userValue

def getSurface(prm_propLength, prm_propWidth):
    surface = prm_propLength * prm_propWidth
    return surface

def getTotalCharge(prm_baseLabour, prm_grassCharge, prm_totalTree):
    totalCharge = prm_baseLabour + prm_grassCharge + prm_totalTree
    return totalCharge



def main(): #<-- Don't change this line!
    #Write your code below. It must be indented!

    introMSG()

    #Variables:
    houseNumber = ""
    propLength = 0.0
    propWidth = 0.0
    surface = 0.0
    typeOfGrass = ""
    fescueCost = 0.05
    bentgrassCost = 0.02
    campusCost = 0.01
    grassCharge = 0.0
    maxSurface = 5000
    addGrassChargeRate = 500
    numOfTrees = 0
    treeCharge = 100
    totalTreeCharge = 0.0
    baseLabour = 1000.0
    totalCharge = 0.0
    totalMSG = "Total cost for house {0} is: ${1:.2f}"
    errorMSG = "Invalid Input. Please try again."

    #Ask the user what country they are from
    houseNumber = int(getINPUT("Enter House Number: "))
    propLength = float(getINPUT("Enter property depth (feet): "))
    propWidth = float(getINPUT("Enter property length (feet): "))
    typeOfGrass = getINPUT("Enter type of grass (fescue, bentgrass, campus): ")
    numOfTrees = int(getINPUT("Enter the number of trees: "))

    #Getting the surface using length x width
    surface = getSurface(propLength, propWidth)

    #Determine if the square surface is over 5000 sq feet.
    #If it is more than 5000 sq feet, add $500.
    if surface > maxSurface:
        addGrassCharge = float(addGrassChargeRate)

    elif surface <= maxSurface:
        addGrassCharge = 0.0

    #Determine which type of grass is given as an input

    #FESCUE --> charge = Surface * cost per sq foot of fescue
    if typeOfGrass.lower() == "fescue":
        grassCharge = surface * fescueCost + addGrassCharge
    
    #BENTGRASS --> charge = surface * cost per sq foot of bentgrass
    elif typeOfGrass.lower() == "bentgrass":
        grassCharge = surface * bentgrassCost + addGrassCharge

    #CAMPUS --> charge = surface * cost per sq foot of campus
    elif typeOfGrass.lower() == "campus":
        grassCharge = surface * campusCost + addGrassCharge

    else:
        totalMSG = errorMSG

    totalTreeCharge = numOfTrees * treeCharge

    totalCharge = getTotalCharge(baseLabour, grassCharge, totalTreeCharge)

    #Print total Cost
    print(totalMSG.format(houseNumber, totalCharge))

def endMSG():
    #Goodbye message
    print("Thank you! Have a nice day!")

    endMSG()
    


    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()