#https://devblogs.microsoft.com/scripting/easily-create-a-powershell-hash-table/

$ICMPFirewallRule = $null
$ICMPFirewallRule = @{}
$ICMPv4 = "File and Printer Sharing Echo Request - ICMPv4"
$ICMPv6 = "File and Printer Sharing Echo Request - ICMPv6"
$ICMPv4Status = Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" | Select-Object Name, Enabled
$ICMPv6Status = Get-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" | Select-Object Name, Enabled

[array]$Rules = $ICMPv6Status + $ICMPv4Status

foreach ($Rule in $Rules)
{
    $ICMPFirewallRule.add($Rule.name,$Rule.enabled)
}


if (($ICMPFirewallRule.Values) -contains "False")
{
    set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv4-In)" -Enabled True
    set-NetFirewallRule -DisplayName "File and Printer Sharing (Echo Request - ICMPv6-In)" -Enabled True
}

else
{
    Write-Output "Firewall Rules: "$ICMPv4" and "$ICMPv6" are enabled"
}