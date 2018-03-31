# github-delete-reponsities
shell for batch delete reponsities in github
you can delete one or more remote reponsities in github 

## usage

1. first you should put the name of your repositories into a file, one name per line
2. execute deleterep.sh
```
Usage :  deleterep.sh [options] [--]

    Options:
    -h|help         Display this message
    -v|version      Display script version
    -f|file         File stores response name in github to be delete
    -u|user         Name for github
    -c|credentials  Credentials for github "username:password"
```

## example
```
bash deleterep.sh -f ./rep -u "dfyfhqsfly" -p "username:password"
```

rep file:
```
repositorya
repositoryb

```
