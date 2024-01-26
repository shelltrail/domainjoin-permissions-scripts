#$computerDN = (Get-ADComputer "PC01").DistinguishedName
$computerDN = (Get-ADComputer -filter *).DistinguishedName # All computers
$entity = "TEST\Domain Users"
$guid = "3f78c3e5-f79a-46bd-a0b8-9d18116ddc79" # msDS-AllowedToActOnBehalfOfOtherIdentity

# Define the ACE properties
$adRights = [System.DirectoryServices.ActiveDirectoryRights]::WriteProperty
$objectType = New-Object Guid $guid # GUID for the specific property
$inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance]::None
$accessControlType = [System.Security.AccessControl.AccessControlType]::Deny
$identityReference = New-Object System.Security.Principal.NTAccount($entity)

# Create the ACE
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($identityReference, $adRights, $accessControlType, $objectType, $inheritanceType)

foreach($computer in $computerDn){
	# Get the current ACL of the computer object
	$acl = Get-ACL "AD:$computer"
	# Add the new ACE to the ACL
	$acl.AddAccessRule($ace)
	# Set the modified ACL back to the computer object
	Set-ACL -Path "AD:$computer" -AclObject $acl
