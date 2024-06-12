# Git
function gb() { git branch $args }
function gb-d() { git branch -d $args }
function gsi() { git switch $args }
function gs() { git status $args }
function ga() { git add $args }
# 既存のAliasを削除
Remove-Item Alias:gc -Force
function gc() { git commit $args }
# 既存のAliasを削除
Remove-Item Alias:gp -Force
function gp() { git push $args }
function gf() { git fetch $args }
function gpl() { git pull $args }
# 既存のAliasを削除
Remove-Item Alias:gl -Force
function gl() { git log --oneline $args }
function gres() { git restore $args }
function gres-s() { git restore --staged $args }


# Docker
function d() { docker $args }
function dc() { docker-compose $args }
