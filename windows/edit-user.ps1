function edit-user {
    try {
        $choice = get-option -options $([ordered]@{
                "Edit user name"     = "Edit an existing users name."
                "Edit user password" = "Edit an existing users password."
                "Edit user group"    = "Edit an existing users group membership."
            }) -lineAfter

        switch ($choice) {
            0 { $command = "edit user name" }
            1 { $command = "edit user password" }
            2 { $command = "edit user group" }
        }

        write-welcome -command $command

        get-cscommand -command $command
    } catch {
        # Display error message and end the script
        exit-script -type "error" -text "edit-user-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
    }
}

