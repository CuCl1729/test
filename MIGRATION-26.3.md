# Minecraft 26.3 への追従記録

26.2 から 26.3(安定版)への移行で実際に変わった点と、このパックでの対応の記録。
移行は完了済み。このファイルは `data/` の外にあるので Minecraft からは無視される。

- 対応日: 2026-09-24〜28 / 動作中のバージョン: 26.3 / `pack.mcmeta` は format 121
- 事前調査(プレリリース期、2026-09-02)はWeb情報が中心で、外れていた点が多かった。
  以下はすべて、インストール済みクライアント `.minecraft/versions/26.3/26.3.jar` に入っている
  バニラのデータファイルとクラスを直接見て確認したもの

---

## 26.3 で変わったこと(このパックに関係する範囲)

### pack.mcmeta

- データパックの format は **121**(リソースパックは 97.1)
- `min_format` / `max_format` は **素の整数**(`121`)。`[121, 0]` のような配列ではない
  (jar同梱の `data/minecraft/datapacks/*/pack.mcmeta` で確認)

### 述語・ロット関数の書き方

- 述語(predicate / loot condition)の種別キーが **`"condition"` から `"type"`** に変わった。
  述語ファイルのルート、エンチャントの `requirements`、`all_of` の `terms` の中身、
  進捗の `conditions.player` など、述語オブジェクトはすべて `{"type": "minecraft:…", …}` の形
- ロット関数も種別キーが **`"function"` から `"type"`** に変わり、ロットテーブルのエントリで
  関数を並べるフィールドは **`"functions"` から `"modifier"`**(単数形だが中身はリスト)になった
- `item_modifier` の登録ファイルは **単一オブジェクト** でなければならない(配列は不可)
- 進捗の `conditions.player` / `conditions.item` は **単一オブジェクト** で書く
  (要素1つの配列で包む書き方は不可)
- ロットテーブルの `rolls` などインラインの number provider は `type` を省略できない
  (以前は `minecraft:uniform` が既定だった)
- `minecraft:value_check` は `minecraft:int_value_check` / `minecraft:float_value_check` に分割され、
  範囲のフィールドは `range` から `test` になった
- 変わらなかったもの: エンチャントの値エフェクト(`minecraft:linear` の `base` /
  `per_level_above_first`)は素の float のまま。advancement の `rewards.function` や
  `run_function` 効果の `function` も「実行する関数のID」なので名前はそのまま

### number provider と `compute`

- number provider は `context_int_provider` と `context_float_provider` の2つのレジストリに分かれた。
  データパックの `data/<ns>/context_float_provider/` などにJSONを置くとIDで参照できる
- フィールド名(`net/minecraft/world/level/storage/loot/providers/number/` のクラスで確認):
  - `sin` / `cos` / `from_int` / `from_float`: `input`(1つ)
  - `mul` / `add`: `inputs`(リスト)
  - `div`: `left` / `right`
  - `score`(int専用): `target` / `score` / `fallback`。**`scale` は無くなった**
  - 定数は素の数値で書ける。別の登録済みプロバイダはID文字列で参照できる
  - `sin` / `cos` の入力はラジアン
- `compute` コマンドの構文は `compute <context> float <provider> [scale]` /
  `compute <context> integer <provider>`。`<context>` の後に `float` / `integer` が必要。
  float 版は「値 × scale」を切り捨てた整数を返すので、`execute store result` でそのまま受け取れる

---

## このパックでの対応

- `pack.mcmeta`: 94 → 121
- `condition` → `type`: 述語ファイル(`predicate/weather/*`・`predicate/projectile/is_class_manager`)、
  エンチャント(`enchantment/move/add_impulse_{x,y,z}`・`enchantment/trigger/left_click`)、
  進捗(`advancement/trigger/right_click/*`)
- `add_impulse_{x,y,z}.json` の `value_check`(計204箇所)を `int_value_check` + `test` に置換
- `loot_table/enemy/{dummy,goblin}.json`: `functions`→`modifier`・`function`→`type`、
  `rolls` に `type: minecraft:uniform` を明示
- `item_modifier/move/add_impulse.json`: 配列を外して単一オブジェクトに。
  呼び出し元の無かった `item_modifier/loot/{set_lore,set_name}.json` は削除
- 進捗の `conditions.player` を単一オブジェクトに
- クリティカル判定: 当時は float provider のフィールド名を特定できなかったため、
  `predicate/damage/crit.json` をやめて `damage/.mcfunction` 内で `random value 1..10000` と
  `crit_rate` を直接比べる形にした(今ならpredicateでも書けるが、動いているのでそのまま)
- `#math:tan`(AiMath)の2か所を `compute` に置き換え、`data/math` を削除した。
  tanの定義は `data/test/context_float_provider/{projectile,scan}/`

---

## 未着手

- `function/projectile/move.mcfunction` の座標・速度計算は100倍整数と `execute store` の連鎖で
  組まれている。`compute` で書き直せば短くできるが、投射体の挙動全体に影響するため別作業とする

---

## 次のバージョンへ追従するときの教訓

- Web(Wiki・記事)の情報は矛盾していたり省略されていたりした。仕様は
  `.minecraft/versions/<バージョン>/<バージョン>.jar` の中のバニラのJSON(`data/minecraft/…`)と、
  必要ならクラスファイルの文字列(コーデックのフィールド名が読める)で確認するのが確実
- 登録JSONの書き方が間違っているとワールド自体が読み込めなくなる。原因は
  `.minecraft/versions/1.20.5/logs/latest.log` の `Registry loading errors` に、
  どのファイルのどのキーで失敗したかが出る
- `.mcfunction` の構文エラーはワールド読み込みを止めないが、`/reload` 時に
  `Failed to load function` としてログに出る
