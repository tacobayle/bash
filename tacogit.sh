# add in the .profile


function tacogit () {
  git add .
  git commit -a -m "$1"
  git push -u origin "$2"
}
