#> test:job/station/click_back
# @s = Jobステーション本体。一覧ビューへ戻る

data modify entity @s data.job_ui.view set value "list"
function test:job/station/populate_list
