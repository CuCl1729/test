#> test:action/cast
# @s = 詠唱者。magic.player が組み立て済みであること(純粋な魔法の test:magic/、または
# magic.player.data.action{kind:"weapon"} を積んだ武器アダプタの両方から呼ばれる共通の発動本体)

# 継続(ビーム・場・自己持続)は押している間ずっと効くので、押し続けを毎 tick 記録しておく。
# ビームはこれが途切れたら止まる(test:magic/beam/tick)
execute if data storage test: magic.player.type_flags{continuous:1b} run function test:magic/cont/hold

# 押し始めだけを受け付ける魔法: つないだ魔法(通し番号 uid がある。押しっぱなしで「置く」と
# 「再使用で起動」が続けて起きないように)と、継続(毎 tick 唱え直されて場が増え続けないように)。
# 右クリックの検知(using_item)は押している間ずっと毎 tick 来るため、どちらもここで止める
scoreboard players set #press_gate test.temporary 0
execute if data storage test: magic.player.uid run scoreboard players set #press_gate test.temporary 1
execute if data storage test: magic.player.type_flags{continuous:1b} run scoreboard players set #press_gate test.temporary 1
# ジョブのビーム選択は離散入力(A->Bの切り替えは即時に起こる)なので、重複入力のためのこの関所は要らない
execute if data storage test: magic.player.data.job_skill run scoreboard players set #press_gate test.temporary 0
execute if score #press_gate test.temporary matches 1 unless function test:magic/chain/press run return fail

# 自分の「再使用で」の設置物があれば、唱える代わりにそれを起動する(MP は払わない)
execute if data storage test: magic.player.uid if function test:magic/place/recast run return 1
# 唱えた回の通し番号。設置物は前の回のものだけを置き換える(複数発射した弾がそれぞれ置いた分は残す)
execute if data storage test: magic.player.uid run scoreboard players add #magic_cast test.time 1
execute if data storage test: magic.player.uid store result storage test: magic.player.cast int 1 run scoreboard players get #magic_cast test.time

# 消費MPを払う(足りなければ唱えない)。ターン制でも同じ処理を使う
# ビーム(維持MPのみ, magic.player.upkeep がある)は前払いが無いので pay を呼ばない(反動の精算もしない)。
# 発生元が武器(magic.player.data.action{kind:"weapon"})なら武器専用の支払いを、純粋な魔法なら従来の pay を使う
execute unless data storage test: magic.player.upkeep if data storage test: magic.player.data.action{kind:"weapon"} unless function test:action/weapon/pay run return fail
execute unless data storage test: magic.player.upkeep unless data storage test: magic.player.data.action{kind:"weapon"} unless function test:magic/pay run return fail

function test:magic/prepare_damage

# 防具のセット効果(magic_cast)。ダメージが決まった後、届け方へ渡す前に詠唱者の属性ダメージをいじれる。
# 武器(攻撃)発生元は命中時の attack_hit を保ったままにするため、ここでは magic_cast にしない
execute unless data storage test: magic.player.data.action{kind:"weapon"} run function test:equip/event {event:"magic_cast"}

# 持続物の数を数える発動ルートを開く(つないだ先に「一定間隔」があるときだけ)
function test:magic/root/open

# 何になるかは組み合わせの表が決める(発生元 player)
function test:magic/dispatch
# 配布で何も持続物を出さなかった(refsが0の)発動ルートの元帳を片付ける
execute if data storage test: magic.player.root run function test:magic/root/prune with storage test: magic.player.root
