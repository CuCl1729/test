# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/quest/generated/quests
# クエスト(スプレッドシートの「クエスト」「クエストの段階」タブ)。asset.quest.<id> = {id, name, main, desc, last, reward?, stages:{s<段階>:{goal, count, desc}}}。進めるのは test:quest/

data modify storage test: asset.quest.herb set value {id:"herb",name:"薬草集め",main:0b,desc:"薬師の頼み。ゴブリンを倒し、薬草を届ける。",last:2,reward:"test:talk/generated/act/a6",stages:{s1:{goal:"kill",count:3,desc:"ゴブリンを倒す"},s2:{goal:"deliver",count:3,desc:"薬師に薬草を届ける"}}}
data modify storage test: asset.quest_ids append value "herb"
data modify storage test: asset.quest.patrol set value {id:"patrol",name:"見回り",main:0b,desc:"村の外れを見て回り、村長に知らせる。",last:2,reward:"test:talk/generated/act/a7",stages:{s1:{goal:"reach",count:1,desc:"村の外れへ行く"},s2:{goal:"talk",count:1,desc:"村長に知らせる"}}}
data modify storage test: asset.quest_ids append value "patrol"
data modify storage test: asset.quest.village set value {id:"village",name:"村の決断",main:1b,desc:"村の行く末を皆で決める。",last:1,reward:"test:talk/generated/act/a8",stages:{s1:{goal:"talk",count:1,desc:"皆で村長と話す"}}}
data modify storage test: asset.quest_ids append value "village"
