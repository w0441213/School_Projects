#Don't forget to rename this file after copying the template

#for a new program!

"""

Student Name: Jamie Lu   

Program Title:  Imperial to Metric Converter

Description:  This program will convert a weight given in tons, stones, and pounds into the metric equivalent in metric tons, kilograms, and grams.
"""



def main(): #<-- Don't change this line!

    #1.Welcome Message
        print("Welcome to the Imperial to Metric Converter!")

    #2.Information Message
        print("Please enter the amounts requested to start converting from Imperial to Metric.")

    #3.Variables Initialization
        tons = 0.0   #input
        stones = 0.0 #input
        pounds = 0.0 #input
        ounces = 0.0 #input
        tOunces= 0.0 #Total Ounces
        tKilos= 0.0 #Total Kilos
        mTons = 0.0 #Metric Tons

    #4.Ask user for tons, stones, pounds, ounces
        tons   = input("Enter the number of tons: ")
        stones = input("Enter the number of stone: ")          
        pounds = input("Enter the number of pounds: ") 
        ounces = input("Enter the number of ounces: ")

    #4a. Casting
        xtons = float(tons)
        xstones = float(stones)
        xpounds = float(pounds)
        xounces = float(ounces)
        xtOunces= float(tOunces)
        xtKilos= int(tKilos)
        xmTons= float(mTons)

    #5. Equations
    #5a.Getting the total ounces
        xtOunces = (35840*xtons) + (224*xstones) + (16*xpounds) + xounces
    #5b.Getting the total kilos
        xtKilos = xtOunces/35.274
    #5c.Getting the metric tons
        xmTons = int(xtKilos/1000)
    #5d.Getting the leftover tons to calculate for kilos after
        leftTons =float(xtKilos/1000)-xmTons
    #5e.Getting the leftover kilos to use as the final output
        leftKilos=(leftTons*1000)
    #5f.Getting the grams
        leftGrams=(leftKilos-int(leftKilos))*1000

    

    #6 Format Leftover Grams
        outString = "{0:.1f}".format(leftGrams)
    #7 Print Output: Metric Weight
        print("The metric weight is ", (int(xmTons)),"metric tons, ", (int(leftKilos)), "kilos, and ", outString, "grams.")
    


    

    






    #Your code ends on the line above



#Do not change any of the code below!

if __name__ == "__main__":

    main()
