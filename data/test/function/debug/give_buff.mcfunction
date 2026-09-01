#> test:debug/give_buff
# @s = 対象(プレイヤーでも敵でもよい)。バフ基盤の動作確認用に2種類まとめて付与する

function test:buff/apply {id:"atk_up",stacks:1}
function test:buff/apply {id:"poison",stacks:1}
