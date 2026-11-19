#> test:magic/crafter/stage_link_one
# @macro one: つなぎの前に置ける形態のひとつ(ほかのキーも渡ってくるが使わない)
$execute if data storage test: registry_work.stages[-1].status{magic_type:"$(one)"} run scoreboard players set #link_ok test.temporary 1
