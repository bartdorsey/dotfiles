# Define the path to the text file containing the list of extensions
$extensionListPath = "..\vscode\.config\Code\extensions.txt"

# Check if the file exists
if (Test-Path $extensionListPath) {
    # Read each extension from the file
    $extensions = Get-Content $extensionListPath

    # Loop through each extension and install it using the code CLI
    foreach ($extension in $extensions) {
        if ($extension) {
            Write-Host "Installing extension: $extension"
            # Run the VSCode command to install the extension
            code --install-extension $extension
        }
    }
    Write-Host "All extensions have been installed."
} else {
    Write-Host "The extension list file does not exist. Please check the file path."
}

