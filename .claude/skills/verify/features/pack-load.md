# Pack loads

After an edit, `/reload` reloads every function, advancement, loot table and registry file of the pack.
The world keeps running and no function is reported as broken.

## Sub-features

- `load-functions` reloads all `.mcfunction` files without parse errors.
- `load-registries` keeps the world loadable, so no registry JSON is rejected.
- `load-generated` reloads the generator's output after `generate.cmd -Offline`.

## How to get to it (user POV)

- Type `/reload` in chat.
- Reopen the world. This is the only path that loads the dimension and worldgen JSON.

## Driving it with mc.ps1

Preconditions:

- The baseline from the README is met.

- **Reload.** Run `N=$(MC -Mark | tr -d '\r'); MC -Cmd "/reload"; sleep 4`. The chat shows 再読み込み中….
- **Check errors.** Run `MC -Doctor`. It prints `last load/reload` at a line ≥ `N` and `errors since last reload: 0`.
- **Proof.** Run `MC -Since $N -Save "$TEMP/mc-verify/<run>/pack-load.txt"`. The file contains 再読み込み中… and
  no error line.

## Gotchas

- A `.mcfunction` parse error doesn't stop `/reload`. It shows up only as a `Failed to load function` log line,
  which Doctor counts.
- Editing a dimension, worldgen or registry JSON needs a world reopen, which the user does. A broken registry
  file stops the world from opening, and `latest.log` names the file under `Registry loading errors`.
- A function that parses can still fail at run time without any log line, such as a macro called without
  `with`. Drive the feature too, not only the reload.
