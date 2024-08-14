function remove-file {
    try {
        do {
            Write-text -type 'header' -text 'Enter or paste the path and file'  -lineAfter
            $filepath = read-input -lineAfter

            $file = Get-Item $filepath -ErrorAction SilentlyContinue

            if ($file) {
                $file | Remove-Item -Force 
            } else {
                write-text -type "error" -text "Could not find the file. Check that the path for typos."
            }
        } while (!$file)

        $file = Get-Item $filepath -ErrorAction SilentlyContinue
        if (!$file) { 
            write-text -type "success" -text "File successfully deleted." -lineAfter 
            read-command
        }
    } catch {
        # Display error message and exit this script
        write-text -type "error" -text "remove-file-$($_.InvocationInfo.ScriptLineNumber) | $($_.Exception.Message)" -lineAfter
        read-command
    }
}

