cd /d "%~dp0"
git init
pause
git add .
git rm "Z GitLoad.bat"
pause
git status
pause
git commit -m "first commit"
pause
git branch -M main
pause
git remote add origin https://github.com/NoNameDev-Git/Auto-tuning-RMS.git
pause
git push -u origin main
pause