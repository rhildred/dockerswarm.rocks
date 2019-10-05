Set-SmbServerConfiguration -EnableSMB2Protocol $false
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
  $Server = Read-Host -Prompt 'Input your server  name'
Rename-Computer -NewName $Server -Force -PassThru
  curl https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe -o git.exe
  .\git.exe
  $User =  Read-Host -Prompt 'Input your user  name'
  $Password = Read-Host -Prompt 'Input your password'
  New-LocalUser -Name $User -Password (ConvertTo-SecureString -AsPlainText $Password -Force) -PasswordNeverExpires -AccountNeverExpires
  Add-LocalGroupMember -Group "Administrators" -Member $User
  Set-ItemProperty -Path HKLM:\\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters -Name AllowInsecureGuestAuth -Value 1
  Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
  Start-Service sshd
  Set-Service -Name sshd -StartupType 'Automatic'
  New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value 'c:\Program Files\Git\bin\bash'
