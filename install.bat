@echo off
setlocal enabledelayedexpansion

color 0A
echo ======================================
echo Initialisation de Tarantula Operator
echo ======================================

echo Vérification de Node.js...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js n'est pas installé. Veuillez l'installer depuis https://nodejs.org/
    pause
    exit /b
)
echo Node.js est installé. Version: 
node -v

echo Vérification de la connexion Internet...
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% neq 0 (
    echo Pas de connexion Internet détectée. Vérifiez votre connexion.
    pause
    exit /b
)
echo Connexion Internet détectée.

echo Vérification de la version locale...
for /f "tokens=2 delims=:," %%A in ('findstr /i "version" package.json') do set "local_version=%%A"
set "local_version=!local_version: =!"
set "local_version=!local_version:~1,-1!"
echo Version locale : !local_version!

echo Vérification de la version distante sur GitHub...
curl -s https://raw.githubusercontent.com/ton-utilisateur/ton-repo/main/package.json -o temp_package.json
if exist temp_package.json (
    for /f "tokens=2 delims=:," %%A in ('findstr /i "version" temp_package.json') do set "remote_version=%%A"
    set "remote_version=!remote_version: =!"
    set "remote_version=!remote_version:~1,-1!"
    echo Version distante : !remote_version!
    del temp_package.json

    if "!local_version!" neq "!remote_version!" (
        echo Une nouvelle version du selfbot est disponible : !remote_version!
        echo Veuillez mettre à jour en téléchargeant la dernière version depuis GitHub.
        pause
        exit /b
    ) else (
        echo Le selfbot est à jour.
    )
) else (
    echo Impossible de récupérer la version distante. Vérifiez l'URL ou votre connexion.
    pause
    exit /b
)

:: Démarrage du selfbot
echo Lancement de Tarantula Operator...
node index.js
pause
