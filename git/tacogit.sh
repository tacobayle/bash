# add in the .profile



function tacogit () {
  git add .
  git commit -a -m "$1"
  git push -u origin "$2"
  oldTag=`git tag | tail -1`
  newTag=`python3 /home/avi/tacogit.py $oldTag`
  git tag $newTag
  git push -u origin $newTag
  echo "git repo has been updated with tag $newTag"
}
