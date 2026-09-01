# Minecraft 26.3 への追従メモ

26.3 Pre-Release 1 でデータパック側に破壊的変更が入ったため、影響箇所を調査した記録。
**Pre-Release の間はまだ仕様が動く可能性があるため、実際の書き換えは 26.3 正式リリース後に行う。**
このファイルは `data/` の外にあるので Minecraft からは無視され、データパックの動作には影響しない。

調査時点: 2026-09-02 / 動作中のバージョン: 26.2 / `pack.mcmeta` は format 94

出典:

- <https://www.minecraft.net/en-us/article/minecraft-26-3-pre-release-1>
- <https://minecraft.wiki/w/Java_Edition_26.3_Pre-Release_1>
- <https://minecraft.wiki/w/Java_Edition_26.3_Snapshot_10>

---

## 26.3 の何が変わったか(このパックに関係する範囲)

- データパックの pack format が **119.0**(26.2 は 107.1)
- number provider が **`minecraft:context_int_provider`** と **`minecraft:context_float_provider`** の
  2つのレジストリに分割された
  - int 側: `abs` `avg` `binomial` `conditional` `constant` `sub` `from_float` `max` `min` `mod`
    `floor_mod` `environment_attribute` `negate` `number_dispatcher` `pow` `mul` `div` `floor_div`
    **`score`** `storage` `add` `uniform` `weighted_list`
  - float 側: `abs` `avg` `ceil` `conditional` `constant` `cos` `sub` `enchantment_level`
    `environment_attribute` `floor` **`from_int`** `length` `max` `min` `mod` `negate`
    `number_dispatcher` `pow` `mul` `div` `round` `sin` `sqrt` `storage` `add` `truncate`
    `uniform` `weighted_list`
  - **`score` は int 専用**。float が要る場所で使うには `from_int` で持ち上げる
  - 名前変更: `sum`→`add` / `product`→`mul` / `minimum`→`min` / `maximum`→`max` / `average`→`avg`
- **`minecraft:value_check` が削除**され、`minecraft:int_value_check` / `minecraft:float_value_check` に分割
- `minecraft:random_chance` の `chance` は **float provider**
- インライン number provider の **`type` 省略が不可**になった(以前は `minecraft:uniform` が既定)
- ルートテーブルの `rolls` は int provider、`bonus_rolls` は float provider
- 新コマンド `/compute` と、`/data modify … set compute <context> <provider>` が追加された

---

## A. 破壊的変更 — 追従が必須

### A1. `pack.mcmeta`

format 94 → 119.0。`pack_format` は 1.21.9 で `min_format` / `max_format` に置き換わっているので、
この機会に `pack_format` を落とす。

> 未確定: 119.0 を `min_format: 119` と整数で書くのか `[119, 0]` の配列で書くのか(→ 未確定事項 2)

### A2. `data/test/enchantment/move/add_impulse_{x,y,z}.json`

`minecraft:value_check` を **1ファイルあたり68箇所・計204箇所**使っている。すべて
`minecraft:score` provider を整数で比較しているだけなので、`minecraft:int_value_check` へ置換する。

自動生成されたファイル(各1767行)なので、生成元があるならそちらを直して作り直すほうが安全。
無ければ機械的な一括置換で足りる。

> 未確定: 新しい predicate のフィールド名。現行は `value` + `range` だが、
> Wiki の要約では `value` + `test` となっている(→ 未確定事項 1)

### A3. `data/test/predicate/damage/crit.json`

現状:

```json
{
  "condition": "minecraft:random_chance",
  "chance": {
    "type": "minecraft:score",
    "target": { "type": "minecraft:fixed", "name": "#damage" },
    "score": "test.status.crit_rate",
    "scale": 0.0001
  }
}
```

26.3 では2つ問題がある:

1. `chance` は float provider を要求するが、`score` は int 専用になった
2. int モードの `scale` は「掛けてから負方向へ丸める」ため、`0.0001` を掛けると常に 0 になる

`from_int` で float に持ち上げてから `mul` で 0.0001 を掛ける形に書き直す:

```json
{
  "condition": "minecraft:random_chance",
  "chance": {
    "type": "minecraft:mul",
    "values": [
      { "type": "minecraft:from_int",
        "value": { "type": "minecraft:score",
                   "target": { "type": "minecraft:fixed", "name": "#damage" },
                   "score": "test.status.crit_rate" } },
      { "type": "minecraft:constant", "value": 0.0001 }
    ]
  }
}
```

> 未確定: `mul` / `from_int` の引数フィールド名(→ 未確定事項 3)

### A4. `data/test/loot_table/enemy/dummy.json`

`"rolls": { "min": 1, "max": 3 }` は `type` 省略時の既定 `uniform` に依存している。
`{ "type": "minecraft:uniform", "min": 1, "max": 3 }` と明示する。

---

## B. 影響しないと見込まれるが、更新後に確認する

- `data/math/predicate/0.5.json` — `chance` が素の `0.5`。インライン値は引き続き使えるはず
- `data/minecraft/loot_table/blocks/red_shulker_box.json` — `"rolls": 1` は定数なので問題ないはず
- `data/test/item_modifier/move/add_impulse.json` — `set_enchantments` の値は int provider になったが、
  使っているのは `score`(`scale: 1`)なので条件を満たす
- `enchantment/move/add_impulse_*.json` の `minecraft:apply_impulse` の `magnitude`
  (`minecraft:linear` の `base` / `per_level_above_first`) — エンチャントの値エフェクトが
  provider 分割の対象かどうか記事に記載が無いため、実機で確認する
- 関数側(`.mcfunction`) — `/compute` は未使用。`random value` / `execute store` / `data modify` の
  構文は変わっていないため、現時点で書き換えが必要な行は見つかっていない

---

## C. 新機能の活用

### C1. `#math:tan` を native float provider へ置き換える(本命)

AiMath への依存は `test` 名前空間全体で **`#math:tan` の2箇所だけ**:

- `data/test/function/projectile/shot.mcfunction` — 多重射撃の拡散角
- `data/test/function/scan/aoe/.mcfunction` — 扇状範囲攻撃の左右幅(距離 × tan(半角))

どちらも「`storage math: in` へ角度を書く → `function #math:tan` → `storage math: out` を読む」という
往復をしており、値は100倍整数でやり取りしている。26.3 の float provider には `sin` / `cos` / `div` が
あるので `tan = sin / cos` を1コマンドで書ける:

```
data modify storage test: scan.aoe.tan set compute default {type:"minecraft:div", ...sin/cos...}
```

これで `storage math:` の往復と、100倍整数による丸め誤差が消える。

なお `storage math:` は `projectile/summon.mcfunction` と `projectile/pre_summon.mcfunction` が
**マクロの引数置き場としても**流用しているので、そちらは別途 `storage test:` へ移す必要がある。

### C2. AiMath(`data/math`)の同梱をやめられるか判断する

C1 を終えると `test` 名前空間から `math:` への依存が無くなる。`data/math` は third-party ライブラリ
(MIT, `data/math/LICENSE`)なので、他から使っていないことを確認できればパックから外して軽量化できる。

### C3. 将来候補(今回は着手しない)

- `data/test/function/projectile/move.mcfunction` の座標・速度計算は100倍整数と `execute store` の
  連鎖で組まれている。float provider + `/data modify … set compute` で `Motion[]` へ直接書けるので
  大幅に短くできるが、投射体の挙動全体に影響するため別作業とする
- HP / ATK 等を内部で100倍整数として保持している設計自体は、スコアボードが整数のままなので変更しない

---

## 未確定事項(正式リリース後に実機 / Wiki で確認する)

1. `minecraft:int_value_check` のフィールド名 — 現行 `value_check` は `value` + `range`。
   Wiki の要約では `value` + `test`。204箇所の一括置換内容が変わるので最初に確定させる
2. `pack.mcmeta` に 119.0 をどう書くか — `min_format: 119` の整数か `[119, 0]` の配列か
3. `minecraft:mul` / `minecraft:from_int` の引数フィールド名(`values` / `terms` / `value`)
4. エンチャントの値エフェクト(`minecraft:linear`)が provider 分割の影響を受けるか
5. `/data modify <target> <path> set compute <context> <provider>` の正確な構文と、
   float 結果を `double` タグとして書けるか

---

## 検証方法(書き換えたとき)

1. クライアントを 26.3 へ更新して `/reload` — データパック一覧で「互換性なし」にならないこと
2. `latest.log` に JSON のパースエラー・不明なフィールドの警告が出ていないこと
3. ノックバック系の挙動(`test:motion/player/impulse/`)が従来どおり動くこと
4. クリティカルが機能すること — `test.status.crit_rate` を 0 と 10000 に振って、
   出ない / 必ず出る を確認する
5. `test:enemy/dummy` のドロップが 1〜3 個の範囲で出ること
6. `#math:tan` 置き換え後、多重射撃の拡散角と範囲攻撃剣の扇の広がりが従来と同じであること
   (置き換え前に現行の値を数点メモしておき、前後で比較する)
