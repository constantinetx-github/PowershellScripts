#Script Created by ConstantineJ https://social.technet.microsoft.com/profile/constantinej/
$domain = Read-Host -Prompt 'Input your domain name'
Resolve-DnsName $domain | ForEach-Object { $_.IP4Address } | Out-File $PSScriptRoot\IPs.txt


$ips = GC $PSScriptRoot\IPs.txt

Foreach ($ip in $ips)	{
$name = nslookup $ip 2> $null | select-string -pattern "Name:"
	if ( ! $name ) { $name = "" }
	$name = $name.ToString()
	if ($name.StartsWith("Name:")) {
	$name = (($name -Split ":")[1]).Trim()
	}
	else {
	$name = "NOT FOUND"
	}
Echo "$ip `t $name" | Out-File -Append $PSScriptRoot\NSLookup_Results.txt
}
