@echo off
setlocal enabledelayedexpansion

:: Salut toi ! On démarre l'initialisation de Tarantula Operator ! 
:: Ça va être rapide et efficace, promesse de la maison. 😎

:: Couleurs cool pour que ça claque un peu dans la console
color 0A
echo ======================================
echo BIENVENUE DANS TARANTULA OPERATOR !
echo ======================================

:: Check si t'as bien installé Node.js (parce qu'on va en avoir besoin)
echo On vérifie si Node.js est là, attends une seconde...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Oups... Pas de Node.js détecté ! 😬
    echo Va vite le télécharger ici : https://nodejs.org/
    pause
    exit /b
)
echo Nickel, Node.js est installé ! Version trouvée : 
node -v

:: On check si Internet est là, parce que bon, sans ça c'est un peu mort...
echo Vérification de la connexion Internet, bouge pas.
ping -n 1 8.8.8.8 >nul 2>&1
if %errorlevel% neq 0 (
    echo Euh... Pas de réseau ? 🤔 Vérifie ta connexion, je t'attends.
    pause
    exit /b
)
echo Super, Internet est bien là. On continue ! 🌐

:: On va jeter un œil à la version locale du selfbot
echo OK, maintenant on regarde la version locale de ton selfbot...
for /f "tokens=2 delims=:," %%A in ('findstr /i "version" package.json') do set "local_version=%%A"
set "local_version=!local_version: =!"
set "local_version=!local_version:~1,-1!"
echo Ta version locale : !local_version!

:: Maintenant, on va sur GitHub checker s'il y a une version plus récente (on est sérieux ici 😏)
echo On check la version sur GitHub, histoire de pas passer à côté d’une nouveauté !
curl -s https://raw.githubusercontent.com/ton-utilisateur/ton-repo/main/package.json -o temp_package.json
if exist temp_package.json (
    for /f "tokens=2 delims=:," %%A in ('findstr /i "version" temp_package.json') do set "remote_version=%%A"
    s
