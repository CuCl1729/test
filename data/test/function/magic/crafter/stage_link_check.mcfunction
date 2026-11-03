#> test:magic/crafter/stage_link_check
# @macro after: つなぎの前に要る形態。閉じたばかりの段(stages[-1])の形態が違えば不正にする
$execute unless data storage test: registry_work.stages[-1].status{magic_type:"$(after)"} run scoreboard players set #stage_invalid test.temporary 1
