function Ssh_academy_git {
    # The first argument is the 'stepping stone',
    # the second is the target to ssh into
    ssh -o proxyCommand="ssh -i /Users/nick/aws/keys/workshop.pem -W %h:%p $1" -i /Users/nick/aws/keys/workshop.pem $2
}