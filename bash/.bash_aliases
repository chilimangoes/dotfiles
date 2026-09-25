# Shell command aliases and helpers.

# lsa: equivalent to `ls -al`
# uses is a function so it can correctly forward arguments. For example:
#   lsa /path/to/folder
lsa() {
    ls -al "$@"
}
