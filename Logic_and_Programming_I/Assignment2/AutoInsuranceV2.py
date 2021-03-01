#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   Auto Insurance
Description:     A program that can compute the monthly auto insurance according to the user's specific gender, age and price of vehicle.
"""

def introMSG():
    #Welcome Message
    print("Welcome to the Monthly Auto Insurance Calculator!")
    
    #Information Message
    print("Enter the requested values below to compute for the monthly auto insurance.")
    print(" ")

def gatherINFO(prm_MSG):
    userValue = input(prm_MSG)
    return userValue

def main(): #<-- Don't change this line!
    #Write your code below. It must be indented!

    introMSG()

    #Variables:
    gender = True
    age = 0
    vehiclePrice = 0.0
    monthlyInsurance = 0.0
    maleRate15to24 = 0.25 / 12
    maleRate25to39 = 0.17 / 12
    maleRate40to69 = 0.10 / 12
    femRate15to24 = 0.20 / 12
    femRate25to39 = 0.15 / 12
    femRate40to69 = 0.10 / 12
    inputErrorMSG = "Invalid Input. Try again."
    monthlyInsMSG = "Your monthly insurance will be ${0:.2f}"
    

    #Ask for the user input & putting conditions with functions in case the user puts the wrong input
    gender = gatherINFO("Are you male or female? ")
    if gender.lower() == "male" or gender.lower() == "female":
        age = int(gatherINFO ("Enter your age: "))
        if age >=15 and age <70:
            vehiclePrice = float(gatherINFO ("Enter the purchase price of the vehicle: "))
        else:
            print(inputErrorMSG)
            main()
    else:
        print(inputErrorMSG)
        main()

    #Conditions:
    #If the user is male
    if gender.lower() == "male":
        #If the user is less than 25
        if age <25:
            monthlyInsurance = vehiclePrice * (maleRate15to24)
        #If the user is less than 40
        elif age <40:
            monthlyInsurance = vehiclePrice * (maleRate25to39)
        #If he user is less than 70
        elif age <70:
            monthlyInsurance = vehiclePrice * (maleRate40to69)
        
    elif gender.lower() == "female":
        #If the user is less than 25
        if age <25:
            monthlyInsurance = vehiclePrice * (femRate15to24)
        #If the user is less than 40
        elif age <40:
            monthlyInsurance = vehiclePrice * (femRate25to39)
        #If he user is less than 70
        elif age <70:
                monthlyInsurance = vehiclePrice * (femRate40to69)


    #Print total Cost
    print(monthlyInsMSG.format(monthlyInsurance))

    #Goodbye message
    print("Have a nice day!")


    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()