# Define the path for the CSV file
$outputFile = "C:\Users\Jovy Trejo\Documents\ReceivedData.csv"

# Check if the file exists; if not, create it and add headers
if (-not (Test-Path $outputFile)) {
    "Timestamp,Data" | Out-File -FilePath $outputFile -Encoding UTF8
}

# Open the port
$port = New-Object System.IO.Ports.SerialPort "COM6", 2400, ([System.IO.Ports.Parity]::None), 7, ([System.IO.Ports.StopBits]::Two)
$port.Handshake = [System.IO.Ports.Handshake]::XOnXOff

try {
    $port.Open()
    Write-Host "Port opened. Listening for data..."

    # Send the interval print command (e.g., every 10 seconds)
    $port.WriteLine("10P")

    # Read data in a loop for a specified duration
    $duration = 600  # Total time to keep the port open (in seconds)
    $interval = 1   # Time to wait between reads (in seconds)
    $startTime = Get-Date

    while (((Get-Date) - $startTime).TotalSeconds -lt $duration) {
        Start-Sleep -Seconds $interval

        # Read available data from the port
        $response = $port.ReadExisting()
        if ($response -ne "") {
            # Get the current timestamp
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            
            # Append the timestamp and data to the CSV file
            "$timestamp,$response" | Out-File -FilePath $outputFile -Append -Encoding UTF8
            
            # Also display it in the console
            Write-Host "Received Data: $response"
        }
    }
}
catch {
    Write-Host "An error occurred: $_"
}
finally {
    # Ensure the port is closed
    if ($port.IsOpen) {
        $port.Close()
        Write-Host "Port closed."
    }
}
