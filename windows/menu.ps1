function menu {
    try {
        # Create a menu with options and descriptions using an ordered hashtable
        $choice = read-option -options $([ordered]@{
                "Toggle administrator"    = "Toggle the Windows built in administrator account."
                "Add user"                = "Add a user to the system."
                "Remove user"             = "Remove a user from the system."
                "Edit user"               = "Edit a users."
                "Edit hostname"           = "Edit this computers name and description."
                "Edit network adapter"    = "Edit a network adapter.(BETA)"
                "Get WiFi credentials"    = "View all saved WiFi credentials on the system."
                "Toggle W11 Context Menu" = "Enable or Disable the Windows 11 context menu."
            })

        # Map user selection to corresponding commands
        if ($choice -eq 0) { $command = "toggle admin" }
        if ($choice -eq 1) { $command = "add user" }
        if ($choice -eq 2) { $command = "remove user" }
        if ($choice -eq 3) { $command = "edit user" }
        if ($choice -eq 4) { $command = "edit hostname" }
        if ($choice -eq 5) { $command = "edit net adapter" }
        if ($choice -eq 6) { $command = "get wifi creds" }
        if ($choice -eq 7) { $command = "toggle context menu" }

        Write-Host
        Write-Host ": "  -ForegroundColor "DarkCyan" -NoNewline
        Write-Host "Running command:" -NoNewline -ForegroundColor "DarkGray"
        Write-Host " $command" -ForegroundColor "Gray"

        read-command -command $command
    } catch {
        # Display error message and exit this script
        write-text -type "error" -text "menu-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)"
    }
}

