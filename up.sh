git submodule foreach git pull origin master
git add .
git commit -m "update"
git push
git submodule update
