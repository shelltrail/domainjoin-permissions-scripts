$domain="TEST"
#$comps = Get-ADComputer "PC01"
$comps = Get-ADComputer -filter * # All computers

foreach($comp in $comps){
    $comppath = "AD:$($comp.DistinguishedName.ToString())"
    $acl = Get-Acl -Path $comppath
    $objUser = New-Object System.Security.Principal.NTAccount($domain, "Domain Admins")
    $acl.SetOwner($objUser)
    Set-Acl -Path $comppath -AclObject $acl
}
