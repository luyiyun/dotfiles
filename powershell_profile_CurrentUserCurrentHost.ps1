remove-item alias:ls
remove-item alias:rm


# Starship
Invoke-Expression (&starship init powershell)

# PSReadline
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
 # Set-PSReadlineKeyHandler -Key Tab -Function ForwardChar
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+k -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Ctrl+j -Function HistorySearchForward
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History

# micromamba alias
Set-Alias -Name mamba -Value micromamba
Set-Alias -Name mb -Value micromamba

# use scoop-search insteal of builtin scoop search
Invoke-Expression (&scoop-search --hook)


# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}
