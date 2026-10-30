#> test:machine/by/roll
# @macro key: rng のキー(pre_by / refine_by)。1..100 を引いて #by_roll に入れる

$execute store result score #by_roll test.temporary run function test:rng/roll {key:"$(key)",min:1,max:100}
