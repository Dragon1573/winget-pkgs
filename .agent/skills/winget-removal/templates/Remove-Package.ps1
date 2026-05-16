[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $PackageIdentifier,
    [Parameter()]
    [string[]]
    $Versions,
    [Parameter(Mandatory = $true)]
    [int]
    $IssueId,
    [Parameter()]
    [string]
    $AssistantFooter
)

foreach ($v in $Versions) {
    $branchName = "issues/$IssueId/$($v -creplace " ", "-")/drop"
    $title = "Remove version: $PackageIdentifier version $v"
    $body = @"
## ✅ Checklist

- [x] Signed the [Contributor License Agreement](https://cla.opensource.microsoft.com)
- [x] Linked to an issue (if applicable)
  - Resolves #$IssueId

## 📦 Manifest Checklist

- [x] Checked that there aren't other open [pull requests](https://github.com/microsoft/winget-pkgs/pulls) for the same manifest update/change
- [x] This PR only modifies one (1) manifest
- [x] It's about manifest removal

"@

    # 完成 Git Commit 提交与推送
    git.exe switch --create $branchName --no-track "upstream/master"
    git.exe rm -r --sparse "manifests/$($PackageIdentifier[0].ToString().ToLower())/$($PackageIdentifier -creplace "\.", "/")/$v"
    if ($AssistantFooter -ne "") {
        $messages = $title + "`n`n" + $AssistantFooter
    }
    else {
        $messages = $title
    }
    git.exe commit -vsS -m $messages
    git.exe push --progress --set-upstream origin $branchName
    gh.exe pr create --no-maintainer-edit --title $title --body $body
    git.exe switch master
    git.exe branch -d $branchName
    Write-Host "----- Above Task Done -----"
}
