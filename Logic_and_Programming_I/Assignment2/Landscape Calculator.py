#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   The Landscape Calculator
Description:     A program that computes the price of landscaping for a new housing development.
"""

def main(): #<-- Don't change this line!
    #Write your code below. It must be indented!

    #Welcome Message
    print("Welcome to the Landscape Calculator!")
    
    #Information Message
    print("Enter the requested values below to get the price of landscaping.")
    print(" ")

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
    addGrassCharge = 500
    numOfTrees = 0
    treeCharge = 100
    totalTreeCharge = 0.0
    baseLabour = 1000.0
    totalCharge = 0.0
    totalMSG = "Total cost for house {0} is: ${1:.2f}"

    #Ask the user what country they are from
    houseNumber = input("Enter House Number: ")
    propLength = float(input("Enter property depth (feet): "))
    propWidth = float(input("Enter property length (feet): "))
    typeOfGrass = input("Enter type of grass (fescue, bentgrass, campus): ")
    numOfTrees = int(input("Enter the number of trees: "))

    #Getting the surface using length x width
    surface = propLength * propWidth

    #Determine which type of grass is given as an input

    #FESCUE --> charge = Surface * cost per sq foot of fescue
    if typeOfGrass.lower() == "fescue":
        grassCharge = surface * fescueCost
    
    #BENTGRASS --> charge = surface * cost per sq foot of bentgrass
    elif typeOfGrass.lower() == "bentgrass":
        grassCharge = surface * bentgrassCost

    #CAMPUS --> charge = surface * cost per sq foot of campus
    elif typeOfGrass.lower() == "campus":
        grassCharge = surface * campusCost

    #Determine if the square surface is over 5000 sq feet.
    #If it is more than 5000 sq feet, add $500.
    if surface > maxSurface:
        totalGrassCharge = grassCharge + addGrassCharge

    else:
        totalGrassCharge = grassCharge

    totalTreeCharge = numOfTrees * treeCharge

    totalCharge = baseLabour + totalGrassCharge + totalTreeCharge

    #Print total Cost
    print(totalMSG.format(houseNumber, totalCharge))

    #Goodbye message
    print("Thank you! Have a nice day!")


    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()