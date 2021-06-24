#Import the required AD module to interact with
Import-module activedirectory

#Users stored captured in a .csv file and the absorbed into a cariable $ADUsers
$ADUsers = Import-csv C:\NEW-ADUserList.csv

#Loop through each user in the file 
foreach ($User in $ADUsers)
{
	#Populate variables from user data captured in the .csv
		
	$Username = $User.username
	$Password = $User.password
	$Firstname = $User.firstname
	$Lastname = $User.lastname
	$OU = $User.ou 
	$Password = $User.Password

	#Checking if there is a clash of accounts in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{
		#Print out warning if username exists
		Write-Warning "A user account with username $Username already exist."
	}
	else
	{
		#User does not exist then create the new user account
		
		New-ADUser `
	-SamAccountName $Username `
	-UserPrincipalName "$Username@l00155877.lyit" `
	-Name "$Firstname $Lastname" `
	-GivenName $Firstname `
	-Surname $Lastname `
	-Enabled $True `
	-DisplayName "$Lastname, $Firstname" `
	-Path $OU ` `
	-Company $company `` `
	-EmailAddress "$Firstname.$Lastname@l00155877.lyit.ie"``
	-AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $True$True
            
	}
}
