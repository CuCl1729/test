# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/buff/generated/values
# バフの数値(スプレッドシートの「バフの数値」タブ)。手書きの一覧(init/asset/buff/buffs)に duration・max_stacks・interval・params を足す。
# params は内部の値(×100済み)で、関数の行(buff/on/<event>/<id>)がマクロ引数として受け取る
# stack_lifetime は掛け直したときの時間の持ち方(independent / refresh_all)。
# effects は「バフ効果」タブから作る効果の一覧(順番どおり)。test:buff/runtime が読む

data modify storage test: asset.buff.types[{id:"atk_up"}] merge value {duration:30,max_stacks:3,stack_lifetime:"refresh_all",params:{}}
data modify storage test: asset.buff.types[{id:"poison"}] merge value {duration:30,max_stacks:3,interval:5,stack_lifetime:"refresh_all",params:{}}
data modify storage test: asset.buff.types[{id:"guard"}] merge value {duration:30,max_stacks:1,stack_lifetime:"refresh_all",params:{}}
data modify storage test: asset.buff.types[{id:"speed_up"}] merge value {duration:10,max_stacks:3,stack_lifetime:"refresh_all",params:{per_stack:2000}}
data modify storage test: asset.buff.types[{id:"jump_up"}] merge value {duration:10,max_stacks:3,stack_lifetime:"refresh_all",params:{per_stack:10}}
data modify storage test: asset.buff.types[{id:"atk_up"}] merge value {"effects":[{"kind":"stat","stat":"atk","mode":"add","sign":1,"terms":[],"flat":500,"reference_flat":true}]}
data modify storage test: asset.buff.types[{id:"poison"}] merge value {"effects":[{"kind":"damage","resource":"hp","terms":[],"flat":200,"type":"true","event":"interval"}]}
data modify storage test: asset.buff.types[{id:"speed_up"}] merge value {"effects":[{"kind":"function","path":"test:buff/on/apply/speed_up","tag":false,"event":"apply"},{"kind":"function","path":"test:buff/on/expire/speed_up","tag":false,"event":"expire"}]}
data modify storage test: asset.buff.types[{id:"jump_up"}] merge value {"effects":[{"kind":"function","path":"test:buff/on/apply/jump_up","tag":false,"event":"apply"},{"kind":"function","path":"test:buff/on/expire/jump_up","tag":false,"event":"expire"}]}
data modify storage test: asset.buff.types[{id:"guard"}] merge value {"effects":[{"kind":"stat","stat":"def","mode":"add","sign":1,"terms":[],"flat":1000,"reference_flat":true}]}
