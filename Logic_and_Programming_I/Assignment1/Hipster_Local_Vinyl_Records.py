#Don't forget to rename this file after copying the template

#for a new program!

"""

Student Name: Jamie Lu   

Program Title:  Hipster's Local Vinyl Records

Description:  A program that will calculate the purchase summary for Hipster's Local Vinyl Records

"""



def main(): #<-- Don't change this line!

    #1.Welcome Message
        print("Welcome to Hipster's Local Vinyl Records")

    #2.Information Message
        print("Please enter the requested information below to get the purchase summary.")

    #3.Variable Initialization
        CustomerName = ""         #input
        distKM = 0.0              #input
        costRec = 0.0             #input
        deliveryCost= 0.0         #output
        purchaseCost= 0.0         #output
        totalCost = 0.0           #output


    #4.Ask user for the input: customer name, distance in kilometers, and cost of the records purchased
        print(" ") #to provide spacing for the final display
        print("Hipster's Local Vinyl Records - Customer Order Details")
        CustomerName = input("Enter the customer's name: ")
        distKM = input("Enter the distance in kilometers for delivery: ") 
        costRec = input("Enter the cost of the records purchased: ") 

    #5.Casting to int or float for equation
        xdistKM = float(distKM)
        xcostRec = float(costRec)
        xdeliveryCost = float(deliveryCost)
        xpurchaseCost = float(purchaseCost)
        xtotalCost = float(totalCost)



    #6.Equation
        #delivery cost = distance in kilometers * 15 (rate per kilometer)
        xdeliveryCost = xdistKM * 15
        #Purchase cost = cost of Records * 1.14 (14% sales tax)
        xpurchaseCost = xcostRec * 1.14
        #total cost = delivery cost
        xtotalCost = xdeliveryCost + xpurchaseCost


    #7 Display the output
    #  Put in the purchase summary with the customer's name, delivery cost, purchase cost, and total cost

        print(" ") #to provide spacing for the final display
        print("Purchase summary for: ", CustomerName)
        outString = "Delivery Cost: $ {0:.2f}".format(xdeliveryCost)
        print(outString)
        outString1 = "Purchase Cost: $ {0:.2f}".format(xpurchaseCost)
        print(outString1)
        outString2 = "Total Cost: $ {0:.2f}".format(xtotalCost)
        print(outString2)


    

    






    #Your code ends on the line above



#Do not change any of the code below!

if __name__ == "__main__":

    main()
