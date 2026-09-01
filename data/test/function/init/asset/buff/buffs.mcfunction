#> test:init/asset/buff/buffs
# バフ/デバフのレジストリ。付与・経過・終了の処理はすべてこの一覧を走査して行うため、
# 種類を増やすときはここに1行足し、宣言したイベントぶん test:buff/on/<event>/<id>.mcfunction を作れば済む
#
# id:         識別子(関数名・ストレージのキーに使う)
# label:      チャット通知に出す表示名
# color:      チャット通知に出す色
# icon:       敵のHPバーの横に並べるテキストコンポーネント(そのまま連結するので先頭に空白を入れておく)
# kind:       buff=有利な効果 / debuff=不利な効果。範囲魔法の敵味方振り分けに使う
# duration:   継続時間(秒)。内部は常に「秒」で持ち、リアルタイムでは毎秒1、ターン制では
#             保持者の手番終了ごとに10減らす。つまりターン制では実質 ceil(duration/10) ターン
# max_stacks: 重ねがけの上限(1なら重ねない)
# refresh:    既に掛かっている状態で再付与されたときの挙動
#             stack  = スタックを足して時間リセット
#             refresh= 時間だけリセット。段数は足さないが、より多い段数で掛け直したときは下げない
#             ignore = 何もしない
# interval:   n秒ごとに test:buff/on/interval/<id> を呼ぶ。使わないならキーごと書かないこと
#             (0を書くと「宣言あり」と判定されてしまう)
# timers:     [10,20] のように、付与からその秒数を過ぎた時点で一度だけ test:buff/on/timer/<id> を呼ぶ。
#             昇順に並べておくこと。使わないならキーごと書かない
# events:     実際にディスパッチするイベント(apply / interval / timer / expire)。
#             宣言していないイベントは関数が無くても呼ばれない(projectileのprojectile_eventsと同じ流儀)

data remove storage test: asset.buff.types

data modify storage test: asset.buff.types append value {id:"atk_up",label:"攻撃力上昇",color:"gold",icon:{text:" ▲",color:"gold"},kind:"buff",duration:30,max_stacks:3,refresh:"stack",events:{apply:1b,expire:1b}}
data modify storage test: asset.buff.types append value {id:"poison",label:"毒",color:"dark_green",icon:{text:" ☠",color:"dark_green"},kind:"debuff",duration:30,max_stacks:3,refresh:"stack",interval:5,events:{interval:1b}}
