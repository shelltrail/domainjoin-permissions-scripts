# Domainjoin account permission script

## Disclamer

These scripts is provided 'as is', with no warranties, and users are solely responsible for any risks associated with its use. 
By using the scripts, you acknowledge and agree to use it at your own risk.

### change-owner.ps1

Changes owner for all computer objects

### deny-msdsallowedtoact.ps1

Adds an explicit deny on all computer object which prevents `Write msDS-AllowedToActOnBehalfOfOtherIdentity` for all `Domain Users` (This includes `Domain Admins`)

### remove-deny-msdsallowedtoact.ps1

Removes any explicit deny on `Write msDS-AllowedToActOnBehalfOfOtherIdentity`
