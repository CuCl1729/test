# Shop and bank

Looking at a shopkeeper or banker puts a chest minecart at the player's head, so a right click opens that
NPC's screen. The shop sells samples for coins first and the bank second, and buys whole lots placed in the
sell slots. The bank takes coins and pays them out. Looking away or sneaking removes the cart.

## Sub-features

- `cart-gaze` the cart appears while looking at the counter NPC and disappears 10 ticks after looking away.
- `cart-sneak` sneaking removes the cart, and sneak + right click talks to the NPC.
- `shop-buy` taking a sample pays its price (coins first, then the bank, change in coins) and gives the
  real item. When the money is short, `お金が足りない` shows and the sample returns.
- `shop-sell` items in slots 14–17 plus `[売る]` sell whole `個数` lots into the bank. The remainder and
  unwanted items return.
- `bank-withdraw` slots 22–26 pay out 1 / 10 / 100 / 1000 / all as coins.
- `bank-deposit` coins put in slots 0–17 go into the bank. Anything else returns.

## How to get to it (user POV)

- Stand in front of the shopkeeper (x=-3) or the banker (x=-6), look at them, and right click.

## Driving it with mc.ps1

Preconditions:

- The baseline is met. Note the starting money from `MC -Cmd "/trigger test.quest"`.

- **Gaze.** Run `MC -Cmd "/tp @s -2.5 0.2 -12.5 180 0"` and `MC -Cmd "/execute if entity @e[tag=npc_cart]"`.
  The log shows `テストに成功しました`. Then run `MC -Cmd "/tp @s -2.5 0.2 -12.5 0 0"` and the same check.
  The log shows `テストに失敗しました`.
- **Open.** Face the NPC again and run `MC -Click <center> -Right`, then `MC -Shot`. The 27-slot screen shows
  samples in 0–4, a gold ingot in 18 and an emerald `[売る]` in 19.
- **Buy, short.** With less than 30 G in total, `MC -Click` slot 0 (the healing potion). The log shows
  `お金が足りない`.
- **Buy.** Run `MC -Cmd "/function test:debug/money_add"` and click slot 0 again. The log shows `買った -30G`.
  `/trigger test.quest` shows coins used first and the bank only for the rest.
- **Sell.** Give `test:item/material/give {id:"bone",count:7}`. Click the bone in the inventory, click slot 14,
  then click slot 19. The log shows `×6 を 10G で売った`, and one bone is back in the inventory.
- **Bank.** Face the banker (x=-5.5) and open the screen. Click slot 23 to withdraw 10 G as one silver coin.
  Then put that coin into slot 0. `/trigger test.quest` shows the bank back at its old value and the coins
  back too.
- **Sneak.** Stand on a block (see Gotchas). Run `MC -Sneak 2200` in the background, then
  `MC -Click <center> -Right` within 1 s. The log shows `[道具屋] いらっしゃい。品物は、こっちを見ると出るよ。`.
- **Proof.** Run `MC -Since $N -Save "$TEMP/mc-verify/<run>/shop-bank.txt"`.

## Gotchas

- The shop buys the material bone (`test.material.kind:"bone"`), not vanilla `minecraft:bone`. A vanilla
  bone correctly comes back with `売れるものが無い`.
- Sneaking while flying descends instead of crouching. For the sneak test, place a temporary
  `setblock -3 -1 -13 minecraft:barrier`, stop flying on it, and restore `minecraft:water` afterwards.
- Never open the chat while Shift is held. The command is then sent as a public chat message.
- The light gray panes in empty slots are almost invisible in shots. Check them with
  `/data get entity @e[tag=npc_cart,limit=1] Items` when it matters.
- While the cart is at your head, the camera is inside it and the scene is hidden. This is expected.
