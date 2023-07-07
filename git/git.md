# git

## git location
git-scm.com

## git config

- system level: /etc/gitconfig
- user level: ~/.gitconfig
- project level: /project/.git/config

## git three directories:

- commit directory
- staging directory
- working directory

## git diff to see differences between staging directory and working directory

## git show to see the last change

## revert a file before an old commit

- check the commit history: git log
- use ```git checkout <sha> -- file.txt``` 

## revert a commit

- ```git revert <sha>```


##  git diff sha..sha (to compare codes at different point of time)

## delete branch locally
git branch -d awsAsgGslb

## delete branch remotely
git push origin --delete awsAsgGslb

## list branches

```
nic@jumphp:~/aviVmw$ git branch -a
  awsAsgGslb
* master
  remotes/origin/awsAsgGslb
  remotes/origin/master
nic@jumphp:~/aviVmw$
```

## rename a branch

```
git branch -m <new_name>
```

## switch to a branch

```
git checkout <feature_branch>
```

## create a new branch and switch to it

```
$ git checkout -b [name_of_your_new_branch]
```

## Reinitialized files to be sync:
```
git rm -rf --cached .
```

## git merge: I don’t care if there is any other conflict. My branch A will win. Always

```
git checkout A
git merge -s ours master
git checkout master
git merge A
```

## git merge: It is just the File B which should win. All others should be merged as normal

```
git checkout A
cp B ../outsideRepository
git checkout master
git merge --no-commit --no-ff A
cp ../outsideRepsitory/B ./
# Resolve other conflicts...
git commit -m "Your merge message :-)"
```

## git merge: Master branch? A is the new master.


```
git checkout A
git branch -D master #It forces to delete the master branch
git branch master #Creates a new master on current head
git checkout master
git push origin master --force
```

## tacoGitCommit

```
function tacoGitCommit () {
  # $1 = commit comment
  # $2 = master or any branch
  git add .
  git commit -a -m "$1"
  git push -u origin "$2"
  oldTag=`git tag | tail -1`
  newTag=`python3 /home/avi/tacogit.py $oldTag`
  git tag $newTag
  git push -u origin $newTag
  echo "git repo has been updated with tag $newTag"
}
```

## tacoGitInit

```
function tacoGitInit () {
  # $1 = git url
  git init
  git remote add origin $1
}
```


## change git config

```
git config --local -l
git config --local remote.origin.url git@github.com:tacobayle/nestedVsphere8
```

## update ~/.ssh/config

```
Host github.com
  User git
  Hostname github.com
  IdentityFile ~/creds/git/id_rsa_git
```

```
git config --global user.email nicolas.bayle@gmail.com
git config --global user.name tacobayle
```

```
git remote remove origin
git remote add origin git@github.com:tacobayle/aviAws.git
```

## git clone a specific branch

git clone -b dual_attached https://github.com/tacobayle/nestedVsphere8
