$User =  Read-Host -Prompt 'Input your user  name'
$Password = Read-Host -Prompt 'Input your password'
New-LocalUser -Name $User -Password (ConvertTo-SecureString -AsPlainText $Password -Force) -PasswordNeverExpires -AccountNeverExpires
Add-LocalGroupMember -Group "Administrators" -Member $User
