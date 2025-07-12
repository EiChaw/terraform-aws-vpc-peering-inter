### `feature/vpc` branch
```
git checkout -b feature/vpc
```
```
$ git branch -a
* feature/vpc
  main
  remotes/origin/main
```
### Update README.md
```
git add .
git commit -m "initial README.md"
git push --set-upstream origin feature/vpc
```
* Remote branch `remotes/origin/feature/vpc` is available now.
```
$ git branch -a
* feature/vpc
  main
  remotes/origin/feature/vpc
  remotes/origin/main
```