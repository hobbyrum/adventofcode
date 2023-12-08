$position = [PSCustomObject]@{
    Depth = 0
    HorizontalPosition = 0
}

function Forward {
    param($times = 0)

    for ($i = 0; $i -lt $times; $i++) {
        $position.HorizontalPosition++
        # Write-Host $position.HorizontalPosition
    }
}

function Down {
    param($times = 0)

    for ($i = 0; $i -lt $times; $i++) {
        $position.Depth++
        # Write-Host $position.Depth
    }
}

function Up {
    param($times = 0)

    for ($i = 0; $i -lt $times; $i++) {
        $position.Depth--
        # Write-Host $position.Depth
    }
}

Write-Host ($position.Depth * $position.HorizontalPosition)
