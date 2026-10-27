#> test:battle/ui/clear_items_type
# @macro id: 手元から消すタイプアイコンのid

$clear @s *[custom_data~{test:{skill_choice:"$(id)"}}]
