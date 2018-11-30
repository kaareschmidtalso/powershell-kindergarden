


Function Set-WallPaper($Value)

{

 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value

 rundll32.exe user32.dll, UpdatePerUserSystemParameters

}


Set-WallPaper -Value C:\Users\SchmiKar\OneDrive\Wallpapers\tumblr_ncepeaVwDY1t0yyxqo1_1280.jpg