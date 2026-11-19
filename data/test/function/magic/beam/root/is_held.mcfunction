#> test:magic/beam/root/is_held
# @macro id: 発動ルートの元帳(magic_roots)が、このidを「持続中(held)」として今も持っているかだけを返す。
# has_remaining(配布枠)は使わない: 枠を使い切っていても、親のビーム自体は続けてよいため
$execute if data storage test: magic_roots[{id:$(id),held:1b}] run return 1
return 0
