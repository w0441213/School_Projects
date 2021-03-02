# write a switch statement that tells a student if they pass or fail
# create an input array with the following grades {25, 35, 55, 65, 85, 100}
# the pass garde is >=65

#Creating the array
$array = 25, 35, 55, 65, 85, 100
$passingGrade = 65

#Switch Statement
Switch ($array) #ICE Build Func
{
    {$_ -ge $passingGrade} {"$_, you passed."} # passed, more than 65
    {$_ -lt $passingGrade} {"$_, you failed."} # failed, equal to or less than 65
}
