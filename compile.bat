"D:\NewSteamLibrary\steamapps\common\GarrysMod\bin\gmad.exe" create -folder "D:\NewSteamLibrary\steamapps\common\GarrysMod\garrysmod\addons\Zombies" -out "pack.gma"
"D:\NewSteamLibrary\steamapps\common\GarrysMod\bin\gmpublish.exe" update -addon "pack.gma" -id 406760913
del pack.gma
"C:\Program Files (x86)\Git\bin\git" push origin master
pause