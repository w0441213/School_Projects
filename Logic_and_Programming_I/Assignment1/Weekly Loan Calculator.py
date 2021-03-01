#Don't forget to rename this file after copying the template

#for a new program!

"""

Student Name: Jamie Lu   

Program Title:  The Weekly Loan Calculator

Description:  This program will calculate the weekly loan payment after the user inputs the loan amount, interest rate, and number of years in the loan

"""



def main(): #<-- Don't change this line!

    #1.Welcome Message
        print("Welcome to the Weekly Loan Calculator!")

    #2.Information Message
        print("Please complete the information below to find out the amount for the weekly payment.")

    #3.Variables Initialization
        Amount = 0.0 # loan amount
        Rate = 0.0 # interest rate
        NumYears = 0   # number of years
        I = 0.0 
        WeeklyPayment= 0.0 # Weekly Payment amount (output)

    #4.Ask user for the input, loan amount, interest rate, and number of years
        Amount = input("Enter the amount of the loan: $")
        Rate = input("Enter the interest rate (%): ")          
        NumYears = input("Enter the number of years: ") 

    #5. Casting
        xAmount = float(Amount)
        xRate = float(Rate)
        xNumYears = int(NumYears)
        xI = float(I)
        xWeeklyPayment= float(WeeklyPayment)

    #6. Equations
    #6a.Getting the value of "i"
        xI = (xRate/5200)
    #6b.Getting the weekly payment amount
        xWeeklyPayment= ((xI/(1-((1+xI)**(-52*xNumYears))))*xAmount)

    #7 Format Weekly Payment Amount
        outString = "Your weekly payment will be: ${0:.2f}".format(xWeeklyPayment)
    #8 Print Formatted Weekly Payment Amount
        print(outString)


    

    






    #Your code ends on the line above



#Do not change any of the code below!

if __name__ == "__main__":

    main()
