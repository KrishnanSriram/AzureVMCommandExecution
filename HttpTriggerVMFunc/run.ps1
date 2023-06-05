#// code/vmPowerFunction.ps1

using namespace System.Net

# Input bindings are passed in via param block.
param($request, $TriggerMetadata)

#Set default value
$status = 200

Try{
    # Write to the Azure Functions log stream.
    Write-Output "PowerShell HTTP trigger function processed a request."

    # Interact with query parameters or the body of the request.
    Write-Output ($request | ConvertTo-Json -depth 99)
    $ResourceGroupName = $request.Body.ResourceGroupName
    $VMName = $request.Body.VMName
    $Context = $request.Body.Context
    $Action = $request.Body.Action
    $Command = $request.Body.Command


    Write-Output("Resource Group - " + $ResourceGroupName)
    Write-Output("VM Name - " + $VMName)
    Write-Output("Context - " + $Context)
    Write-Output("Action - " + $Action)
    Write-Output("Command - " + $Command)

    $null = Connect-AzAccount -Identity
    $null = Set-AzContext $Context

    $vmStatus = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Status
    Write-output $vmStatus
    If(-not ($vmStatus)){
        $status = 404
        Throw "ERROR! VM [$VMName] not found. Please check if the 'Subscription ID', 'Resource Group Name' or 'VM name' is correct and exists."
    }
    [string]$Message = "Virtual machine [$VMName] status: " + $vmStatus.statuses[-1].displayStatus
    Switch($Action){
        'script' {
            $ret_value = Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId 'RunPowerShellScript' -ScriptPath 'simple.ps1'
            [string]$message += $ret_value
        }
        'command' {
            $ret_value = Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId 'RunPowerShellScript' -ScriptString $Command
            Write-Output "Completed execution of command with return value"
            Write-Output $ret_value.Value.Message
            [string]$message = $ret_value.Value.Message
        }
        default{
            [string]$message += ". $($request.query.action) is outside of the allowed actions. Only allowed actions are: 'script', 'command'"
            $status = 400
        }
    }
}
Catch{
    [string]$message += $_
    $status = 500
}

Write-output $message

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value (
    [HttpResponseContext]@{
        StatusCode = $status
        body = [string]$message
        headers = @{ "content-type" = "text/plain" }
    }
)
return $message