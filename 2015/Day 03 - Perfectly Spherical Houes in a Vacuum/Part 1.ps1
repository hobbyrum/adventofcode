<#
--- Day 3: Perfectly Spherical Houses in a Vacuum ---
Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an elf at the North Pole calls him via radio and tells him where to move next. Moves are always exactly one house to the north (^), south (v), east (>), or west (<). After each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his directions are a little off, and Santa ends up visiting some houses more than once. How many houses receive at least one present?

For example:
    - > delivers presents to 2 houses: one at the starting location, and one to the east.
    - ^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.
    - ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.
#>

$InputData = Get-Content -Path "$($PSScriptRoot)\Input.txt"
[array]$SplitHouses = $InputData -split ""

function CountHousesWithPresents($moves) {
    $visitedHouses = @{}
    $x = 0
    $y = 0

    # Mark the starting house as visited
    $visitedHouses["$x,$y"] = $true

    foreach ($move in $moves) {
        switch ($move) {
            '>' { $x++ }
            '<' { $x-- }
            '^' { $y++ }
            'v' { $y-- }
        }

        # Mark the current house as visited
        $visitedHouses["$x,$y"] = $true
    }

    # Count the unique houses with at least one present
    $count = $visitedHouses.Count
    Write-Output "Houses with at least one present: $count"
}

CountHousesWithPresents $SplitHouses
