# 装備・武器のスプレッドシート

Googleスプレッドシートに書いた武器・防具・アクセサリー・シリーズ・レシピから、`.mcfunction` を自動で作ります。
生成されたファイルは1行目に「自動生成」と書いてあります。直接は編集せず、スプレッドシートを直して作り直してください。

## 最初の準備(1回だけ)

1. Googleスプレッドシートを新しく作り、`data/` にある6つのCSVを取り込む
   (「ファイル → インポート → アップロード」で1つずつ選び、「新しいシートを挿入する」)。
   タブ名は何でもかまいません(下の表の名前にしておくと分かりやすいです)
2. 「共有」から「リンクを知っている全員」を「閲覧者」にする(スクリプトがログインなしで読めるようにするため)
3. `config.json` を書く
   - `sheet_id`: スプレッドシートのURLの `/d/` と `/edit` の間の文字列
   - `tabs` の各値: そのタブを開いたときのURLの末尾 `#gid=` の数字

| config.jsonのキー | 内容 | CSV |
|---|---|---|
| `weapons` | 武器 | `data/weapons.csv` |
| `forge_recipes` | 鍛冶場レシピ | `data/forge_recipes.csv` |
| `equipment` | 防具・アクセサリー | `data/equipment.csv` |
| `sets` | シリーズ | `data/sets.csv` |
| `set_effects` | 4部位効果 | `data/set_effects.csv` |
| `workshop_recipes` | 防具工房レシピ | `data/workshop_recipes.csv` |

## 使い方

1. スプレッドシートを編集する
2. `generate.cmd` をダブルクリックする(取得 → 検証 → 生成)
3. ゲーム内で `/reload` する

`generate.cmd -Offline` で実行すると、取得せずに `data/*.csv` から作ります。取得したCSVは `data/` に保存されるので、
コミットすればデータの変更がgitの差分で見られます。

書き方に誤りがあると、どのタブの何行目かを表示して、ファイルを1つも書き換えずに終わります。

## 列の書き方

見出し(1行目)の文字で列を探すので、列の順番は自由です。空欄は「無し」の意味です。

- **ステータスの種類**(基礎ステ・ボーナス・メイン・2部位ボーナス)は `atk_add` / `def_m` / `hp_max_m` / `fire_resist_add` などです。
  使えるのは `data/test/function/init/set_table.mcfunction` の成長の表(`loot.table.grow`)にある種類です。
  `_add` は実数、`_m` は%です
- **武器の属性の列**(物理・火・水・木・金・土): ダメージ式を `atk=200, base=200` の形で書きます。
  `atk`/`hp_max`/`def` は攻撃力・HP・防御力の何%か、`base` は固定値です
- **鍛冶場レシピの触媒**: 触媒なしは `none`。他は `iron_catalyst` / `diamond_catalyst` などの素材の種類です
- **防具の部位**: `head` / `chest` / `legs` / `feet` / `accessory`。アクセサリーはインベントリに入れておくだけで効きます
- **防具の色**: `#RRGGBB`(革防具の染め色)
- **シリーズの2部位ボーナス**: `def_m=5; hp_max_add=30` のように `;` で区切ります
- **4部位効果**(1つのシリーズに何行でも書けます)
  - `event`: いつ動くか(`magic_cast` 魔法を唱えたとき / `attack_hit` 攻撃が当たったとき / `damaged` ダメージを受けたとき)
  - `kind`: 何をするか。`data/test/function/equip/effect/<kind>.mcfunction` があるもの
    (`apply_buff` 相手にバフ付与 / `self_buff` 自分にバフ付与 / `magic_damage_up` 魔法ダメージ上昇)
  - `params`: その効果に渡す値。`id=poison; stacks=1; chance=20` のように書きます。
    数字は数値として、それ以外は文字列として渡されます。必要な値が足りなければ検証で知らせます
  - `説明`: 装備の説明文に出す文
- **新しい効果を作るとき**は、`equip/effect/<kind>.mcfunction` を1つ書いてから、`kind` にその名前を書きます
