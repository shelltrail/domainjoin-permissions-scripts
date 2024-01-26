# Define the distinguished name of the computer object
$computerDN = (Get-ADComputer "PC01").DistinguishedName
#$computerDN = (Get-ADComputer -filter *).DistinguishedName # All computers
$guid = "3f78c3e5-f79a-46bd-a0b8-9d18116ddc79" # msDS-AllowedToActOnBehalfOfOtherIdentity
#$guid = "5b47d60f-6090-40b2-9f37-2a4de88f3063" # msDS-KeyCredentialLink

foreach($computer in $computerDn){
	# Get the current ACL of the computer object
	$acl = Get-ACL "AD:$computer"
	# Remove GUID where AccessControlType equals Deny
	$acl.Access | Where-Object { $_.ObjectType -eq $guid -and $_.AccessControlType -eq "Deny" } | ForEach-Object { $acl.RemoveAccessRule($_) }
	# Set the ACL
	Set-ACL -Path "AD:$computer" -AclObject $acl
}
