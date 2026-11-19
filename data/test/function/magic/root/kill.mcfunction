#> test:magic/root/kill
# @s = 消える持続物。先にルート参照を1つ返し(居なければ何もしない)、そのうえで必ず消える
function test:magic/root/release
return run kill @s
