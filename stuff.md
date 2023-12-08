# **Variables**

It's possible to specity the type of variable we want to use by typing:
``` powershell
PS > [Int]$age = 19
PS > [String]$name = "balbin"
``` 

Define multiple variables on one line using:
```powershell
PS > $name, $color, $date = "balbin", "blue", (Get-Date).DateTime
```

Get the type of data using:
```powershell
PS > $pwd.GetType().Name
PathInfo
```

## **Environment variables**
To list all our environment variable we write:
```powershell
PS > Get-ChildItem Env:
ALLUSERSPROFILE                C:\ProgramData
APPDATA                        C:\Users\USERNAME\AppData\Roaming
CommonProgramFiles             C:\Program Files\Common Files
CommonProgramFiles(x86)        C:\Program Files (x86)\Common Files
CommonProgramW6432             C:\Program Files\Common Files
COMPUTERNAME                   APSEC-PC1Q3WM9
ComSpec                        C:\WINDOWS\system32\cmd.exe
DriverData                     C:\Windows\System32\Drivers\DriverData
GIT_INSTALL_ROOT               C:\Users\USERNAME\scoop\apps\git\current
HOMEDRIVE                      C:
HOMEPATH                       \Users\USERNAME
...
```

To create a new environment variable called USERS we write:
```powershell
PS > $Env:USERS = "balbin"
PS> Get-Child-Item Env:
...
USERS                         balbin
...
```

If we only want to check the value(s) of the USERS env variable, we write:
```powershell
PS > $Env:USERS
balbin
```


## **Arithmetic operators**
```powershell
PS > 5 + 2
7
PS > 5 * 2
10
PS > 10 / 2
5
PS > 5 - 2
3
PS > 10 % 3
1
PS > 69.420 / 3
23.14
PS > "balbin" * 3
balbinbalbinbalbin
```

## **Assignment- and unary operators**
``+=``, ``-=``, ``/=``, ``*=`` and ``%=`` are called *compound* assignment operators.

*Unary* operators are ``++`` and ``--``.

The following script will always return *1*.
```powershell
Write-Host "Welcome, traveler!"

[Int]$original_number = Read-Host -Prompt "Type a number, any number"
$number = $original_number

$number *= 3
$number += 6
$number /= 3
$number -= $original_number
$number --

Write-Host "The final number is $number."
Write-Host "Is it 1? Magic!"
```

## **Equality Comparison Operators**

### Truth table
`-xor` returns `True` **only** when ONE statment is `True`

|  x  |  y  | x -and y | x -or y | x -xor y | -not x|
|:---:|:---:|:--------:|:-------:|:--------:|:-----:|
|  T  |  T  |     T    |    T    |     F    |   F   |
|  T  |  F  |     F    |    T    |     T    |   F   |
|  F  |  T  |     F    |    T    |     T    |   T   |
|  F  |  F  |     F    |    F    |     F    |   T   |

### `-not` and `!`
```powershell
PS > -not (2 -gt 5)
True
PS > !(17 -le 99)
False
PS > $var2 = "hello"
PS > $var1 = -not ($var2 -eq "edgar") # Checking if $var2 is NOT equal to "edgar"
True # It's True that $var2 is NOT equal to "edgar"
```



``-eq``, ``-ne``, ``-gt``, ``-lt``, ``-ge`` and ``-le`` are called *equality operators*.

|Operator|Description|Note|
|:-------|:----------|:---|
|``-eq`` |Checks if two operand values are an exact match|Same as ``==``|
|``-ne`` |Checks if two operand values are **not** and exact match|Same as ``!=``|
|``-gt`` |Checks if the left operand's value is greater than the right one|Same as ``>``|
|``-lt`` |Checks if the left operand's value is less than the right one|Same as ``<``|
|``-ge`` |Checks if the left operand's value is greater than or equal to the right one|Same as ``>=``|
|``-le`` |Checks if the left operand's value is less than or equal to the right one|Same as ``<=``|

```powershell

```


## **Operator precedence**
The same as with maths, order of the operators matter since they have different precedence.
The order of precedence is as follows:
- ``( )``
- ``++`` ``--``
- ``!`` ``-not``
- ``* / %``
- ``+ -``
- ``-is -isnot -as``
- ``-eq -ne -gt -ge -lt -le``
- ``-contains -notContains``
- ``-and -or -xor``
- ``= += -= *= /= %=``

```powershell
PS > 5 - 1 * 5
0
PS > (5 - 1) * 5
20
```

```powershell
$exp_1 = 5 % (2 + 4 * 2) - 1 # Remainder 4 from 5 % 10 -1 or 5 % 9
$exp_2 = (5 * 4) % (3 * (2 + 1)) # Remainder 2 from 20 % 3 * 3 or 20 % 9
$exp_3 = 3 + (2 -ne 5) -and (2 * 5 -gt 8) # Returns True
# 3 + (2 -ne 5) becomes 3 + True
# (2 * 5 -gt 8) becomes 10 -gt 8 which is also True
```

# Objects and arrays

## **Object properties**
To get all the `Property` members of an object, we write the following
```powershell
PS > "hello" | Get-Member -MemberType Property

   TypeName: System.String

Name   MemberType Definition
----   ---------- ----------
Length Property   int Length {get;}
```

---
## **Object methods**

Get all the `MemberType`s of a variable by piping it to `Get-Member`
```powershell
PS > $my_num = 5
PS > $my_num | Get-Member
```

Get only the methods of a variable by piping it to `Get-Member -MemberType Method`
```powershell
PS > $my_num = 5
PS > $my_num | Get-Member -MemberType Property

   TypeName: System.Int32

Name        MemberType Definition
----        ---------- ----------
...
GetType     Method     type GetType()
GetTypeCode Method     System.TypeCode GetTypeCode(), System.TypeCode IConvertible.GetTypeCode()
ToBoolean   Method     bool IConvertible.ToBoolean(System.IFormatProvider provider)
ToByte      Method     byte IConvertible.ToByte(System.IFormatProvider provider)
ToChar      Method     char IConvertible.ToChar(System.IFormatProvider provider)
ToDateTime  Method     datetime IConvertible.ToDateTime(System.IFormatProvider provider)
...
```

If we want to get the length of a variable we simply write this:
```powershell
PS > $name = "hobbyrum"
PS > $name.Length
6
```
---
### Adding properties

With the object created we can add methods and properties by using the `Add-Member` cmdlet. If we want to add a key-value pair (`-Name "Name -Value "hobbyrum"`) the `-MemberType` is `NoteProperty`.
```powershell
PS > $person | Add-Member -MemberType NoteProperty -Name "Name" -Value "hobbyrum"
PS > $person | Get-Member -MemberType NoteProperty

   TypeName: System.Management.Automation.PSCustomObject

Name MemberType   Definition
---- ----------   ----------
Name NoteProperty string Name=hobbyrum

PS > $person.Name
hobbyrum
```

```powershell
PS > $my_num = 5
PS > CompareTo(5)
0
PS > CompareTo(4)
1
PS > CompareTo(6)
-1
PS > $my_string = $my_num.ToString()
PS > $my_string.TypeOf().Name
String
```

## **Creating objects**

To create an object, we use the cmdlet `New-Object`.
```powershell
PS > $person = New-Object -TypeName PSCustomObject
```

### Adding methods
We can also add methods to an object to make it do things. The `-MemberType` in that case is `ScriptMethod`.
```powershell
PS > $person | Add-Member -MemberType ScriptMethod -name "greeting" -Value {Write-Host "Hello, $($person.FirstName)!"}
PS > $person.greeting()
Hello, hobbyrum!
```
---
## **Creating objects using Hashtables**

A newer method to create objects is using *hashtables*, same thing as a dictionary. We do this by encasing multiple key-value pairs in `@{}`.
The `MemberType`s we add this way get set to `NoteProperty`.
```powershell
PS >$person = [PSCustomObject]@{
   Name = "hobbyrum"
   Age = 34
}
```

## **Understanding and creating arrays**
There are multiple ways of creating arrays. Here are some examples.

One-line creation of an array containing an `int` a `string`, an `int` and the boolean `True`.
```powershell
PS > $my_arr = 34, "hobbyrum", 69, $True
PS > $my_arr
34
hobbyrum
69
True
```
We can also create arrays in a similar way that we created an object using a *hashtable*, by wrapping the array items in `@()`. Regular parentheses instead of curly braces.
```powershell
PS > arr_1 = @($True, 5, (Get-Date).DateTime)   # 3 elements
PS > arr_2 = @()                                # Empty array
PS > arr_3 = @(                                 # Multi-line
   "One"
   "Two"
   "Three"
)
```
---
## **Accessing array items**

The easiest way to access array items are from their index, 0-indexed.
```powershell
PS > $colors = "red", "yellow", "black", "blue"
PS > $colors[2]
black
```

Trying to access an index out of bounds will return `$null` instead of throwing an error.
```powershell
PS > $colors[5] # Nothing gets written when $null is returned
PS >
```
When accessing arrays there are several ways of doing so.
```powershell
PS > $colors[0, 2] # Multiple indices, comma separated
red
black
PS > $colors[1..3] # Range operator: returns index 1 through 3
yellow
black
blue
PS > $colors[2..1] # Range operator reverse: returns index 2 through 1
black
yellow
PS > $colors[-1] # Negative indices: items are referenced in the reverse order, and the last item has index -1
blue
```

Every array object has a built-in `ForEach` method that allows us to do various things to the array items.
We can use the variable `$PSItem` or simply `$_`. These variables are the same as `i` in `for i in variableName do x`.
```powershell
PS > $colors.ForEach({ $_ }) # for i in colors print i
red
yellow
black
blue
PS > $colors.ForEach({ $_.Length }) # for i in colors print i.length
3
6
5
4
```
---
## **Operators for arrays**

Some of the operators that work on variables also work on arrays.
```powershell
PS > $fibonacci = 0, 1, 1, 2, 3, 5
PS > $fib_2 = 8, 13, 21, 34
PS > $fibonacci + $fib_2 # Concatenating two arrays
0
1
1
2
3
5
8
13
21
34
PS > $fib_2 * 2 # Multiplying an array copies it a specified number of times. Since we don't use *= the array itself stays the same
8
13
21
34
8  # prints the same array again for the second time
13
21
34
```
### Containment operators
Containment operators also work on arrays. Always returns a boolean.
We can use four operators on arrays:
- `-contains: <array> -contains <item>`
- `-notcontains: <array> -notcontains <item>`
- `-in: <item> -in <array>`
- `-notin: <item> -notin <array>`

`-contains ` and `-in` are effectively the same, the only difference being the order in which they are written.
```powershell
PS > $fibonacci -contains 4
False
PS > 5 -in $fibonacci
True
```
### `-join`

`-join` is similar to `+` but the difference is that `-join` joins the array items by a character or string.
```powershell
PS > $fibonacci -join "foo"
0foo1foo1foo2foo3foo5
```
---

### Strongly typed arrays

Remember that we can force an object to be a certain type like `Int` or `String`?
We can do the same thing with arrays, forcing every item in the array to be true to that type.

Remember to specify that the object should hold an *array* of something, by writing `[String[]]` or `[Int[]]`
```powershell
PS > [String[]]$pets = "cat", "dog", "aardvark"
PS > [Int[]]$numbers = 69, 420
```

### Arrays of objects
Arrays can hold objects as well.
```powershell
PS > $aardvarks = @(
   [PSCustomObject]@{Name = "Chip"; Age = 40, Deez = "old"}
   [PSCustomObject]@{Name = "Uncle Paul"; Age = 57, Deez = "young"}
)
PS > $aardvarks.ForEach({ $_.Name + " is " + $_.Age + " years " + $_.Deez + "."})
Chip is 40 years old.
Uncle Paul is 57 years young.
```

# **Functions**

## Why functions?
To call a function, simply write its name in the cmdline.
```powershell
function Greet {
    Write-Host "Hello"
}
PS > Greet
Hello
```

```powershell
function GetRandomFruit {
    $FruitTypes = @("banana", "apple", "tomato", "pineapple", "kiwi", "passion fruit")
    $FruitType | Get-Random
}
PS > GetRandomFruit
passion fruit # Picks semi-randomly (probably) from the array
```
---

## Components of a function
Functions are built from three components.
- The keyword `Function`
- A function name
- What the function does
---

## Using parameters
```powershell
Function greet1 {
    param($name)
    Write-Host $("Hello, $name")
}
PS > greet1 "hobbyrum"
Hello, hobbyrum
```

```powershell
Function greet2 {
    param($timeOfDay, $name)
    Write-Host $("Good $timeOfDay, $name")
}
PS > greet2 "evening" "hobbyrum"
Good evening, hobbyrum
```
---

## Default parameters
```powershell
function greet2 {
    param($name, timeOfDay = "morning")
    Write-Host $("Good $timeOfDay, $name")
}
PS > greet2 "hobbyrum" # $name = "hobbyrum", $timeOfDay = "morning"
Good morning, hobbyrum
```
In Powershell it's important to declare the default params last. The following example shows why.
```powershell
function greet3 {
    param(timeOfDay = "morning", $name)
    Write-Host $("Good $timeOfDay, $name")
}
PS > greet3 "hobbyrum" # $timeOfDay="hobbyrum", $name = 
Good hobbyrum, # $name is not passed a value, and outputs nothing
```

```powershell
Function UserFeedback{
    Param ($UserName = "Newcomer",$PercentComplete = 0)
    Write-Host "You are doing great, $UserName!"
    Write-Host "You are $PercentComplete% done!"
}
PS > UserFeedback "hobbyrum" 69
You are doing great, hobbyrum!
You are 69% done!
```

# **Control flow**

## Conditional statements - if
The `if` statement works the same way as in other programming languages.
```powershell
$myVar = 2
if ($myVar -eq 2) {
    Write-Host "myVar is 2"
}
Write-Host "hello" # Always displays this since it's part of the script body
```
---

## Conditional statements - else, elseif

Same here.
```powershell
$var = 4
if ($var -gt 10) { 
	Write-Host "Larger than 10"
} elseif ($var -gt 5) {
  Write-Host "good night"
} elseif ($var -gt 0) {
  Write-Host "Good eevening"
} else {
  Write-Host "No match"
}
```

---

## Conditional statements - switch
Same here.
```powershell
$var = 5
switch ($var) {
  {$_ -eq 5} {
    Write-Host $("Yes, $var equals $var")
    break # break not included in the documentation in this step.
  }
  {$_ -lt 0} {
    Write-Host "Not lower than 0"
  }
  {$_ -gt 0} {
    Write-Host "Yes, greater than 0"
  }
  default {
    Write-Host "Nope"
  }
}
```
---

## Loops - for
Same here
```powershell
for ($i = 0; $i -lt 10; $i++) {
    $square = $i * $i
    Write-Host $("The square of $i is $square")
}
```
---
## Loops - foreach
Same here.
```powershell
$recipe = "flour", "sugar", "salt", "oil"
foreach ($ingredient in $recipe) {
    Write-Host $ingredient
}
```
---

## Loops - while
Same here.
```powershell
$count = 0
Write-Host "I can count by 3."
while ($count -le 30) {
  Write-Host $count
  $count+= 3
}
```
---

## Loops - do..while, do..until
Same here.
```powershell
$answer = 4
do {
    $input = Read-Host "Guess my number"
} while ($input -ne $answer)
Write-Host "correct"
```

```powershell
$answer = 4
do {
  $input = Read-Host "Guess my number"
} until ($input -eq $answer)
Write-Host "Correct!"
```
---

## Loops - break, continue
Same here.
```powershell
for ($i = 0; $i -lt 5; $i++) {
  if ($i -eq 2) {
    break
  }
  Write-Host $i
}
```
