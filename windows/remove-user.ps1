function remove-user {
    try {
        $user = select-user

        $choice = get-option -Options $([ordered]@{
                "Delete" = "Also delete the users data."
                "Keep"   = "Do not delete the users data."
            })

        if ($choice -eq 0) { $deleteData = $true }
        if ($choice -eq 1) { $deleteData = $false }

        if ($deleteData) { write-text -type "label" -text "Delete this account and its data?" -lineBefore -lineAfter } 
        else { write-text -type "label" -text "Delete this account?" -lineBefore -lineAfter }
        
        get-closing -Script "remove-user"

        if ($deleteData) {
            $dir = (Get-CimInstance Win32_UserProfile -Filter "SID = '$((Get-LocalUser $user["Name"]).Sid)'").LocalPath
            if ($null -ne $dir -And (Test-Path -Path $dir)) { Remove-Item -Path $dir -Recurse -Force }
        }

        if ($null -eq $dir) { write-text -type 'success' -Text "User data deleted." }

        Remove-LocalUser -Name $user["Name"] | Out-Null

        if (Get-LocalUser -Name $user["Name"] -ErrorAction SilentlyContinue | Out-Null) {
            write-text -Type "error" -Text "Could not remove user."
        } else {
            write-text -type 'success' -Text "User removed."
        }

        exit-script
    } catch {
        # Display error message and end the script
        exit-script -Type "error" -Text "remove-user-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
    }
}

