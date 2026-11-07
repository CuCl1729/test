#> test:magic/crafter/process_clicks
# 取り出した枠は描画前に記録済み。削除は後ろから行い、同時に取った要素の位置をずらさない。
execute if data storage test: registry_work.magic_clicks.s17 run function test:magic/crafter/click_build {index:8}
execute if data storage test: registry_work.magic_clicks.s16 run function test:magic/crafter/click_build {index:7}
execute if data storage test: registry_work.magic_clicks.s15 run function test:magic/crafter/click_build {index:6}
execute if data storage test: registry_work.magic_clicks.s14 run function test:magic/crafter/click_build {index:5}
execute if data storage test: registry_work.magic_clicks.s13 run function test:magic/crafter/click_build {index:4}
execute if data storage test: registry_work.magic_clicks.s12 run function test:magic/crafter/click_build {index:3}
execute if data storage test: registry_work.magic_clicks.s11 run function test:magic/crafter/click_build {index:2}
execute if data storage test: registry_work.magic_clicks.s10 run function test:magic/crafter/click_build {index:1}
execute if data storage test: registry_work.magic_clicks.s9 run function test:magic/crafter/click_build {index:0}
execute if data storage test: registry_work.magic_clicks.s19 run function test:magic/crafter/click_bpage {dir:-1}
execute if data storage test: registry_work.magic_clicks.s21 run function test:magic/crafter/click_bpage {dir:1}
execute if data storage test: registry_work.magic_clicks.s1 run function test:magic/crafter/click_top {index:0}
execute if data storage test: registry_work.magic_clicks.s2 run function test:magic/crafter/click_top {index:1}
execute if data storage test: registry_work.magic_clicks.s3 run function test:magic/crafter/click_top {index:2}
execute if data storage test: registry_work.magic_clicks.s4 run function test:magic/crafter/click_top {index:3}
execute if data storage test: registry_work.magic_clicks.s5 run function test:magic/crafter/click_top {index:4}
execute if data storage test: registry_work.magic_clicks.s6 run function test:magic/crafter/click_top {index:5}
execute if data storage test: registry_work.magic_clicks.s7 run function test:magic/crafter/click_top {index:6}
execute if data storage test: registry_work.magic_clicks.s0 run function test:magic/crafter/click_arrow {dir:-1}
execute if data storage test: registry_work.magic_clicks.s8 run function test:magic/crafter/click_arrow {dir:1}
execute if data storage test: registry_work.magic_clicks.s18 run function test:magic/crafter/click_clear
execute if data storage test: registry_work.magic_clicks.s26 run function test:magic/crafter/click_craft

function test:magic/crafter/populate_top
function test:magic/crafter/rebuild
