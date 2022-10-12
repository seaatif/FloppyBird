@echo off

set fileName=%~1

set outDir=export
del /Q %outDir%
del /Q %outDir%\game.zip
del /Q %outDir%\game.love

mkdir %outDir%
powershell -command " Compress-Archive src\* %outDir%\game.zip "
rename %outDir%\game.zip game.love

copy /b "C:\Program Files\LOVE\love.exe"+"%outDir%\game.love" ".\%outDir%\%fileName%.exe"
copy /b "C:\Program Files\LOVE\SDL2.dll" ".\%outDir%\"
copy /b "C:\Program Files\LOVE\OpenAL32.dll" .\%outDir%\
copy /b "C:\Program Files\LOVE\love.dll" .\%outDir%\
copy /b "C:\Program Files\LOVE\lua51.dll" .\%outDir%\
copy /b "C:\Program Files\LOVE\mpg123.dll" .\%outDir%\
copy /b "C:\Program Files\LOVE\msvcp120.dll" .\%outDir%\
copy /b "C:\Program Files\LOVE\msvcr120.dll" .\%outDir%\
copy /b "config.ini" .\%outDir%\

echo Done

del /Q %outDir%\game.love
del %fileName%.zip
powershell -command " Compress-Archive %outDir%\* %fileName%.zip -Update"

:END