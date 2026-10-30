#> test:machine/smelt/roll
# @macro max: 重みの合計。1..合計を引いて #main_roll に入れる(rng のキー refine_main)

$execute store result score #main_roll test.temporary run function test:rng/roll {key:"refine_main",min:1,max:$(max)}
