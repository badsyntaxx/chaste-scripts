function edit-user-name {
    try {
        $user = select-user -lineBefore

        if ($user["Source"] -eq "Local") { Edit-LocalUserName -User $user } else { Edit-ADUserName }
    } catch {
        # Display error message and exit this script
        write-text -type "error" -text "edit-user-name-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
        read-command
    }
}

function Edit-LocalUserName {
    param (
        [Parameter(Mandatory)]
        [System.Collections.Specialized.OrderedDictionary]$user
    )

    try {
        $newName = read-input -prompt "Enter username:" -Validate "^(\s*|[a-zA-Z0-9 _\-]{1,64})$" -CheckExistingUser -lineBefore

        read-closing -Script "edit-user-name"
    
        Rename-LocalUser -Name $user["Name"] -NewName $newName

        $newUser = Get-LocalUser -Name $newName

        if ($null -ne $newUser) { 
            # $newData = get-userdata -Username $newUser
            write-compare -oldData "$($user['name'])" -newData $newUser
            write-text -type "success" -text "Account name successfully changed." -lineBefore -lineAfter
            read-command
        } else {
            write-text -type "error" -text "There was an unknown error when trying to rename this user." -lineBefore -lineAfter
            read-command
        }
    } catch {
        # Display error message and exit this script
        write-text -type "error" -text "Edit-LocalUserName-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
        read-command
    }
}

function Edit-ADUserName {
    write-text -type "fail" -text "Editing domain users doesn't work yet."
    write-text
}
