#> test:equip/effect/self_buff
# event: 主に damaged。@s = 装備している人。@macro buff_id/stacks/chance: chance%で自分にバフを付与する

execute store result score #equip_roll test.temporary run function test:rng/roll {key:"equip_effect",min:1,max:100}
$execute if score #equip_roll test.temporary matches ..$(chance) run function test:buff/apply {id:"$(buff_id)",stacks:$(stacks)}
