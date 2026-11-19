#> test:init/asset/buff/buffs
# バフ/デバフのレジストリ(見た目と分類だけ)。種類を増やすときはここに1行足し、
# スプレッドシートの「バフの数値」タブ(時間・最大段数・間隔・時間更新)と「バフ効果」タブ(効果の行)に書く
# (init/asset/buff/generated/values が merge する)。効果の中身は test:buff/runtime が段ごとに動かす
#
# id:         識別子(ストレージのキーに使う)
# label:      チャット通知に出す表示名
# color:      チャット通知に出す色
# icon:       敵のHPバーの横に並べるテキストコンポーネント(そのまま連結するので先頭に空白を入れておく)
# kind:       buff=有利な効果 / debuff=不利な効果。範囲魔法の敵味方振り分けに使う
# 生成で足されるもの:
# duration:   継続時間(秒)。内部は常に「秒」で持ち、リアルタイムでは毎秒1、ターン制では
#             保持者の手番終了ごとに10進める。つまりターン制では実質 ceil(duration/10) ターン
# max_stacks: 段数の上限(1なら重ねない)。超えたら古い段から押し出す
# stack_lifetime: independent = 段ごとに時間を持つ / refresh_all = 新しい段が付くと全段の残り時間を戻す
# interval:   一定間隔(interval)の効果がある場合の間隔(秒)
# effects:    効果の行(stat / function / heal / damage)

data remove storage test: asset.buff.types

data modify storage test: asset.buff.types append value {id:"atk_up",label:"攻撃力上昇",color:"gold",icon:{text:" ▲",color:"gold"},kind:"buff"}
data modify storage test: asset.buff.types append value {id:"poison",label:"毒",color:"dark_green",icon:{text:" ☠",color:"dark_green"},kind:"debuff"}

# 移動速度・ジャンプ強度を上げるバフ。ステータスではなく自分の名前付き属性修飾子(test:speed_up/test:jump_up)を
# 使う(test:buff/native/reconcile が段の合計に合わせて入れ直し、他の移動速度・ジャンプ効果には触れない)
data modify storage test: asset.buff.types append value {id:"speed_up",label:"加速",color:"aqua",icon:{text:" ►",color:"aqua"},kind:"buff"}
data modify storage test: asset.buff.types append value {id:"jump_up",label:"跳躍",color:"green",icon:{text:" ↑",color:"green"},kind:"buff"}

# 「防御」行動を選んだときに自分へ付与する
data modify storage test: asset.buff.types append value {id:"guard",label:"防御",color:"aqua",icon:{text:" 防",color:"aqua"},kind:"buff"}
