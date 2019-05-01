# Name: Ping-Machines
Write-Host "Script is running" -ForegroundColor Cyan -BackgroundColor Black

$Hosts = Get-Content 'C:\Temp\MyScript\hosts.txt' # Source list of devices to ping
$Output = 'C:\Temp\MyScript\PingResults.txt'      # Results output file location

function PingMachines { # Function starts
    $totalServers = $(Get-Content C:\Temp\MyScript\hosts.txt).count
    Write-Host "There are $totalServers servers to ping."
    $i = 0

    foreach ($_ in $Hosts) { # foreach loop starts here
        if (Test-Connection -ComputerName "$_" -Count 1 -Quiet) { # if conditional for test-connection
            Write-Host "$_ is reachable" -ForegroundColor Green   # Message to Console
            Write-Output "$_ is reachable"                        # Message to file
        }
        else {                                                    # else conditional statement
            Write-Host "$_ is NOT reachable" -ForegroundColor Red # Message to Console
            Write-Output "$_ is NOT reachable"                    # Message to file
        }

        $percentComplete = ($i / $totalServers) * 100
        $i++
           
        Write-Progress -Activity "Pinging server $i of $totalServers" -Status "$("{0:N2}" -f (($percentComplete),2))% Complete" -PercentComplete $percentComplete
        sleep 1    # to be able to actually see the progress when there are few servers ;)

    }
}

PingMachines | Out-File "$Output" -Append -Force # Function runs and exports results
Write-Host "Done!" -ForegroundColor Cyan -BackgroundColor Black
