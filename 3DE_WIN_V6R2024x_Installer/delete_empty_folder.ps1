

$folderPath = "D:\InstallData\InstallData" # 替换为你要遍历的文件夹路径

Get-ChildItem -Path $folderPath -Recurse -Directory | ForEach-Object {
    if ((Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object).Count -eq 0) {
        Remove-Item -Path $_.FullName -Recurse -Force
    }
}