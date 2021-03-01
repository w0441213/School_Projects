#Don't forget to rename this file after copying the template
#for a new program!
"""
Student Name:    Jamie Lu 
Program Title:   Erewhon Mobile Data Plans
Description:     A program that computes the cost of the data usage
"""

#Welcome Message
def printINTRO():
    print("Welcome to the Erewhon Mobile!")

    
#Information Message
    print("Enter the requested values below to get the total charge for the data usage.")
    print(" ")

def main(): #<-- Don't change this line!
    #Write your code below. It must be indented!


    printINTRO()

    #Variables:
    dataUsage = 0.0
    totalCharge = 0.0
    flatRate200MBmax = 20.0
    perMB500MBmax = 0.105
    perMB1GBmax = 0.110
    flatRate1GBmin = 118.0
    totalChargeMSG = "Total charge is {0:.2f}"
    goodbyeMSG = "Thank you! Have a nice day!"



    #Ask the user the amount of data usage
    dataUsage = float(input("Enter data usage (Mb): "))

    #If the amount of data usage is 200 or less. 200 then there is 
    if dataUsage <= 200:
        totalCharge = flatRate200MBmax

    elif dataUsage <= 500:
        totalCharge = dataUsage * perMB500MBmax

    elif dataUsage <= 1024:
        totalCharge = dataUsage * perMB1GBmax

    elif dataUsage > 1024:
        totalCharge = flatRate1GBmin

    #Print total Charges formatted to 2 decimal places
    print(totalChargeMSG.format(totalCharge))

    #Goodbye message
    print(goodbyeMSG)


    #Your code ends on the line above

#Do not change any of the code below!
if __name__ == "__main__":
    main()