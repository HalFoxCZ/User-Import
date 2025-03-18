param (
    [string]$FilePath
)

# Function to check if module is available
function Ensure-Module {
    param ($ModuleName)
    if (-not (Get-Module -Name $ModuleName -ListAvailable)) {
        Install-Module -Name $ModuleName -Force -Confirm:$false
    }
    Import-Module $ModuleName
}

# Ensure Active Directory module is loaded
Ensure-Module -ModuleName ActiveDirectory

# Validate file existence
if (-Not (Test-Path $FilePath)) {
    Write-Host "Error: File not found!" -ForegroundColor Red
    exit
}

# Import CSV
$users = Import-Csv -Path $FilePath
$allImported = true;
# Loop through each user
foreach ($user in $users) {
    $FullName = "$($user.first_name) $($user.last_name)"
    $SamAccountName = ($user.last_name + $user.first_name.Substring(0,1) + $user.id).ToLower()
    
    ### EDIT DOAMIN ###
    $UserPrincipalName = "$SamAccountName@EDIT_DOAMIN.com"
    $OU = "OU=Users,DC=EDIT_DOMAIN,DC=com"
    ### EDIT DOAMIN ###


    ### PASSWORD ###
    $Password = ConvertTo-SecureString "Abcdef01" -AsPlainText -Force
    ### PASSWORD ###

    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $SamAccountName}) {
        Write-Host "User $FullName ($SamAccountName) already exists. Skipping." -ForegroundColor Yellow
    } else {
        # Create the new AD user
        try {
            New-ADUser -GivenName $user.first_name `
                       -Surname $user.last_name `
                       -Name $FullName `
                       -UserPrincipalName $UserPrincipalName `
                       -SamAccountName $SamAccountName `
                       -EmailAddress $user.email `
                       -Path $OU `
                       -AccountPassword $Password `
                       -Enabled $true `
                       -PassThru | Set-ADUser -ChangePasswordAtLogon $true

            Write-Host "User $FullName ($SamAccountName) created successfully." -ForegroundColor Green
        } catch {
            $allImported = false;
            Write-Host "Failed to create user $FullName ($SamAccountName): $_" -ForegroundColor Red
        }
    }
}
if ($allImported) {
    Write-Host "All users imported successfully." -ForegroundColor Cyan
} else {
    Write-Host "Some users failed to import." -ForegroundColor Red
}
