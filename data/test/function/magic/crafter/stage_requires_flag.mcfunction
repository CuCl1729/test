#> test:magic/crafter/stage_requires_flag
# @macro t: 効果が前提とするタイプid
$execute unless data storage test: magic.loot.status.type_flags{$(t):1b} run scoreboard players set #stage_invalid test.temporary 1
