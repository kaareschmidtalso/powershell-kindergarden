$Password = "ALSOKursist" -AsSecureString

New-LocalUser "kursist" -Password $Password -FullName "Kursist" -Description "ALSO Kursist"

Add-LocalGroupMember -Group "Administrators" -Member "kursist"