# add to .profile

# added in the .profile controller
function aviShellLsc () {
  sudo docker exec -it avicontroller /bin/bash
}

function tacogit () {
  git add .
  git commit -a -m "$1"
  git push -u origin "$2"
}

function tacogittag () {
  git tag "$1"
  git push -u origin "$1"
}
