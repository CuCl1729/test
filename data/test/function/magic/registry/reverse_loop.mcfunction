#> test:magic/registry/reverse_loop
# registry_work.reverse_src を末尾から取り出して registry_work.reverse_dst へ積み直す(順序反転)
# レジストリの走査は末尾[-1]から削る方が軽いが、それだけだと表示順が逆になるため、
# 先に一度反転しておくことで「末尾から削りつつレジストリの定義順どおりに処理する」を実現する

execute unless data storage test: registry_work.reverse_src[-1] run return 0

data modify storage test: registry_work.reverse_dst append from storage test: registry_work.reverse_src[-1]
data remove storage test: registry_work.reverse_src[-1]

function test:magic/registry/reverse_loop
