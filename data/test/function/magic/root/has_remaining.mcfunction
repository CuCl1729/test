#> test:magic/root/has_remaining
# @macro id: magic_rootsのidの元帳が有り、remainingが残っているかだけを返す(消費はしない)
$execute unless data storage test: magic_roots[{id:$(id)}] run return 0

scoreboard players set #root_remaining test.temporary 0
$execute store result score #root_remaining test.temporary run data get storage test: magic_roots[{id:$(id)}].remaining
execute if score #root_remaining test.temporary matches 1.. run return 1
return 0
