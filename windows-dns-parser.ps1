$source = Read-Host "Enter for Source"
$destination = "c:\windows\temp\sample_sanitized.csv"
(Import-CSV $source -Header 1,2,3,4,5,6 | 
    Select "6" | 
    ConvertTo-Csv -NoTypeInformation | 
    Select-Object -Skip 1) -replace '"' | Set-Content $destination
Get-Content c:\windows\temp\sample_sanitized.csv | Where{$_ -notmatch "a"} | Out-File c:\windows\temp\sample_sanitized1.txt
Select-String -Pattern "\w" -Path 'c:\windows\temp\sample_sanitized1.txt' | foreach {$_.line} | Sort-Object -Unique |
Out-File -FilePath c:\users\admin\desktop\dns_logs\dns_ip.txt
$ips = GC C:\Users\Admin\Desktop\DNS_logs\dns_ip.txt
Foreach ($ip in $ips) 
{ 
$name = nslookup $ip 2> $null | select-string -pattern "Name:" 
if ( ! $name ) { $name = "" } 
$name = $name.ToString() 
if ($name.StartsWith("Name:")) 
{ $name = (($name -Split ":")[1]).Trim() } 
 else 
{ $name = "NOT FOUND" } 
Echo "$ip `t $name" 
}
read-host -Prompt "***********Done!, Press Enter to exit***********"
