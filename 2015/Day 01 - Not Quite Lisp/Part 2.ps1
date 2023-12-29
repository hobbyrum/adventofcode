<#
--- Part Two ---
Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.

For example:

) causes him to enter the basement at character position 1.
()()) causes him to enter the basement at character position 5.
What is the position of the character that causes Santa to first enter the basement?
#>

$InputData = Get-Content -Path "$($PSScriptRoot)\Input.txt"
[Array]$ParenthesesArray = $InputData -Split "" -Match "[()]"
$Floor = 0
$FirstTimeNegative = $null

for ($i = 0; $i -lt $ParenthesesArray.Length; $i++) {
    if ($ParenthesesArray[$i] -eq "(") {
        $Floor++
    } elseif ($ParenthesesArray[$i] -eq ")") {
        $Floor--

        if ($Floor -eq -1 -and $null -eq $FirstTimeNegative) {
            # We don't want the index, we want the position.
            $FirstTimeNegative = $i +1
            break
        }
    }
}
$FirstTimeNegative