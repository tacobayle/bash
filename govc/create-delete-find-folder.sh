govc folder.create /dc1/vm/folder-foo
govc object.destroy /dc1/vm/folder-foo
govc find -json . -type f