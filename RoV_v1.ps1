Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class KeyboardInput {
        [DllImport("user32.dll", SetLastError=true)]
        public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
    }
"@

# Constants for key codes
$VK_V = 0x56
$VK_Q = 0x51  # Q key code
$KEYEVENTF_KEYUP = 0x0002

# Function to write colored text
function Write-ColoredMessage {
    param (
        [string]$Message,
        [ConsoleColor]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}


Write-ColoredMessage "
______               _       _____      _   _ _____ ___________ 
| ___ \             | |     |  _  |    | | | |  _  |_   _| ___ \
| |_/ /___  __ _  __| |_   _| | | |_ __| | | | | | | | | | |_/ /
|    // _ \/ _` |/ _` | | | | | | | '__| | | | | | | | | |  __/ 
| |\ \  __/ (_| | (_| | |_| \ \_/ / |  \ \_/ | \_/ /_| |_| |    
\_| \_\___|\__,_|\__,_|\__, |\___/|_|   \___/ \___/ \___/\_|    
                        __/ |                                   
                       |___/                                    
A script to virtually hold down your VOIP key to enable local communication without input
By: Keystone
" -Color Cyan
Write-ColoredMessage "BE CAREFUL WHEN USING OTHER APPLICATIONS WITH TEXTS. WILL SPAM 'V'" -Color Red

Write-ColoredMessage "---------------------" -Color Cyan
Write-ColoredMessage "RoV is running!" -Color Green


# Infinite loop to hold down the 'V' key
Write-ColoredMessage "Press 'Q' to stop the script." -Color Red
while ($true) {
    [KeyboardInput]::keybd_event($VK_V, 0, 0, [UIntPtr]::Zero)  # 'V' key, key down
    Start-Sleep -Milliseconds 100  # Adjust sleep duration as needed

    # Check if 'Q' key is pressed, and exit the loop if true
    if ([Console]::KeyAvailable) {
        $key = [Console]::ReadKey($true)
        if ($key.Key -eq "Q") {
            Write-ColoredMessage "Script stopped by user." -Color Red
            break
        }
    }
}

# Release the 'V' key
[KeyboardInput]::keybd_event($VK_V, 0, $KEYEVENTF_KEYUP, [UIntPtr]::Zero)




