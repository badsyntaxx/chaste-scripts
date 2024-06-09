function add-user {
    try {
        write-welcome -command "add user" -description "Create a local or domain user account."

        $choice = get-option -options $([ordered]@{
                "Add local user"  = "Add a local user to the system."
                "Add domain user" = "Add a domain user to the system."
            })

        if ($choice -eq 0) { $command = "add local user" }
        if ($choice -eq 1) { $command = "add ad user" }

        write-welcome -command $command

        get-cscommand -command $command
    } catch {
        exit-script -type "error" -text "add-user-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
    }
}

