#> test:craft/custom/consume
# 実行位置 = 樽。結果が取られ、材料が足りていた。材料の各枠を、索引の need(craft_work.match)の数だけ減らす

function test:craft/custom/consume_one {slot:3,i:0}
function test:craft/custom/consume_one {slot:4,i:1}
function test:craft/custom/consume_one {slot:5,i:2}
function test:craft/custom/consume_one {slot:12,i:3}
function test:craft/custom/consume_one {slot:13,i:4}
function test:craft/custom/consume_one {slot:14,i:5}
function test:craft/custom/consume_one {slot:21,i:6}
function test:craft/custom/consume_one {slot:22,i:7}
function test:craft/custom/consume_one {slot:23,i:8}
function test:craft/custom/log_craft with storage test: craft_work.rec
