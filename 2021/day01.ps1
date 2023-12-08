# Placeholder array
[Array]$depthMeasurement = @(199, 200, 208, 210, 200, 207, 240, 269, 260, 259, 260, 263)
$increased = 0

for ($i = 0; $i -lt $depthMeasurement.Count; $i++) {
    if ($depthMeasurement[$i] -gt $depthMeasurement[$i - 1]) {
        $increased++
    }
}

Write-Host "Number of measurements larger than the previous one: $($increased)"
