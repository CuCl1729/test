#> test:craft/magic/research/click_arrow
# @s = 研究ステーション本体。@macro dir: -1(前へ)/ 1(次へ)
# 取った矢印がまだカーソルに乗っていれば普通のクリック=1件、それ以外(Shiftクリックで
# Inventoryへ入った/インベントリが満杯でQキーで捨てた等)は全てページ送り=7件として扱う。
# player.cursorはitemsサブコマンド専用のスロット指定で、GUI画面でカーソルに持っている
# アイテムだけを直接見られる(生存モードのみ。クリエイティブモードでは使えない仕様)

scoreboard players set #arrow_step test.buff.work 7
execute if items entity @p[distance=..3] player.cursor arrow[custom_data~{test:{crafter_ui:1b}}] run scoreboard players set #arrow_step test.buff.work 1

$scoreboard players operation #arrow_step test.buff.work *= #$(dir) test.constant

scoreboard players set #page test.buff.work 0
execute store result score #page test.buff.work run data get entity @s data.research_ui.page
scoreboard players operation #page test.buff.work += #arrow_step test.buff.work
execute if score #page test.buff.work matches ..-1 run scoreboard players set #page test.buff.work 0

execute store result entity @s data.research_ui.page int 1 run scoreboard players get #page test.buff.work

function test:craft/magic/research/populate_top
