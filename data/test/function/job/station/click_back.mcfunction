#> test:job/station/click_back
# @s = Jobステーション本体。一覧ビューへ戻る

data modify entity @s data.job_ui.view set value "list"
data modify entity @s data.job_ui.page set value 0
function test:job/station/populate_list
