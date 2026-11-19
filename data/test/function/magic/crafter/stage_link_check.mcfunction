#> test:magic/crafter/stage_link_check
# registry_work.link_after.list = つなぎの前に置ける形態の一覧(レジストリの after)。
# 閉じたばかりの段(stages[-1])の形態がどれでもなければ不正。
# 「一定間隔」のように複数の形態の後ろに置けるつなぎがあるため、after は常に一覧で持つ
scoreboard players set #link_ok test.temporary 0
function test:magic/crafter/stage_link_loop
execute if score #link_ok test.temporary matches 0 run scoreboard players set #stage_invalid test.temporary 1
execute if score #link_ok test.temporary matches 0 run data modify storage test: registry_work.invalid_reason set value "このつなぎは前の段に付かない"
