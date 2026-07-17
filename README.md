## Azeroth Platform Progression

Playing WoW Classic, TBC, and WotLK should not require multiple servers, migration tools, or a compromised experience.

This repository is a data collection that aims to accurately restore the player experience to its original state during a given patch. It is consumed by [Azeroth Platform](https://github.com/Fero-Fero/Azeroth-Platform) via **Sync with mod-individual-progression**: cloned onto each stack at `{stackRoot}/azeroth-platform-progression/`, used to seed patch folders under `migrations/`, and validated there before patches are applied.

### Repository layout

```
├── classic/                         (also tbc/, wotlk/ — case insensitive)
│   └── 1.0 Start/                   Patch folders use "{index} {Name}" (e.g. 1.1 Molten Core, 2.0 Karazhan)
│       ├── description.md           Patch description (required)
│       ├── config/                  Server and module config overrides applied on patch apply
│       │   ├── worldserver.json     → etc/worldserver.conf
│       │   └── individualProgression.json → etc/modules/individualProgression.conf
│       ├── lua/                     Optional Lua scripts deployed to the worldserver on apply
│       │   └── my_script.lua
│       ├── sql/
│       │   ├── world/*.sql
│       │   ├── auth/*.sql
│       │   └── character/*.sql      On the stack this becomes sql/characters/
│       ├── dbc/**                   CSV, .txt, or .dbc files
│       ├── map/**                   Map files (subfolders allowed)
│       └── mpq/                     Client MPQ content (pre-built archive and/or raw files — see below)
│           ├── mpq.json             Manifest: which archives to add, remove, or build
│           ├── patch-k.mpq          Optional pre-built archive (used as-is if present)
│           └── Interface/…            Optional raw content (built into the name listed in mpq.json "add")
├── mapping.json                     Maps mod-individual-progression SQL into patch folders
└── README.md
```

**Expansion folders** are `classic/`, `tbc/`, and `wotlk/`. Matching is **case insensitive** (`Classic/`, `CLASSIC/`, and `classic/` are equivalent).

**Patch folder names** use the form `{index} {Label}` where `{index}` matches the stack patch index (`1.0`, `1.1`, `2.0`, …). Examples: `1.0 Start`, `1.2 Onyxia`, `2.0 Karazhan, Gruul's Lair, Magtheridon's Lair`.

On the stack, patches are stored under `migrations/` as `patch {index} {SLUG}` (e.g. `patch 1.2 ONYXIA`). The patch **index** is what links a stack folder to its reference folder here.

### Config overrides (`config/`)

Each JSON file in `config/` overrides keys in a server or module `.conf` file when the patch is applied. Keys use AzerothCore's `Key = Value` syntax (the JSON value is written as-is).

| File in patch | Target on stack |
|---------------|-----------------|
| `worldserver.json` | `etc/worldserver.conf` |
| `authserver.json` | `etc/authserver.conf` |
| `individualProgression.json` | `etc/modules/individualProgression.conf` |
| `{moduleName}.json` | `etc/modules/{moduleName}.conf` (matched by base name) |

Example `config/worldserver.json`:

```json
{
    "Rate.XP.Kill": "2",
    "Rate.XP.Quest": "3"
}
```

Example `config/individualProgression.json`:

```json
{
    "IndividualProgression.StartingProgression": "0",
    "IndividualProgression.ProgressionLimit": "2"
}
```

**Placeholders:** an empty `{}`, a comment-only file, or whitespace-only JSON is ignored — useful to reserve the folder before real overrides are ready (same idea as a comment-only `mpq.json`).

**Preview on the stack:** in the Patches tab, open a patch's **Preview changes** button to compare each override against the stack's **live** `.conf` values before apply (current vs new, highlighting keys that will change or be added).

**Module configs:** the target `.conf` must exist on the stack (start or rebuild the server once so configs are seeded from `.conf.dist`). Validation reports missing config files and unknown keys.

### Lua scripts (`lua/`)

Optional `.lua` files for server-side behavior (requires a Lua engine such as `mod-ale` compiled into the worldserver).

- Place scripts under `lua/` in the patch folder (subfolders allowed).
- On **Apply**, Azeroth Platform copies them into the stack's live `lua_scripts/` directory (same destination as the **Lua Scripts** tab).
- Later patches overwrite earlier files with the same relative path when patches are applied or re-applied in order.

Example:

```
Classic/1.0 Start/lua/interrupt_area_trigger.lua
```

### MPQ directory (`mpq/`)

Every patch includes an `mpq/` folder with an **`mpq.json` manifest**. The manifest is always present; when a patch has no client MPQ changes yet, leave the shipped comment template in place — Azeroth Platform treats comment-only files as an empty manifest and ignores them.

Each patch can ship client changes in three ways (combinable):

1. **Pre-built archive** — Place a finished `.mpq` file in `mpq/` (for example `patch-k.mpq`) and describe it in **`description`**. The file is published to players as-is; **`add` is not used** for pre-built archives.
2. **Raw content** — Place the files that should live *inside* an MPQ (for example `Interface/…`, `World/…`) in `mpq/` or in a subfolder. List the output archive name in **`add`** and describe it under **`description`**. On apply, Azeroth Platform builds that `.mpq` from the raw files when no pre-built file with the same name exists yet.
3. **Removal only** — List archive names in **`remove`** to delete them from the client overlay when this patch is applied. **`add` is not required** for removals.

You can mix all three in one patch: drop in a pre-built `patch-k.mpq` with a **`description`**, list a different archive name in **`add`** to build from raw content, and retire an older archive via **`remove`**.

### MPQ manifest (`mpq/mpq.json`)

`mpq.json` is a sidecar manifest — it is **never** packed into a constructed archive.

**Comment template (no MPQ changes yet):**

```json
// example: {
//   "add": ["patch-k.mpq"],
//   "remove": ["patch-w.mpq"],
//   "description": {
//     "patch-k.mpq": "Human-readable description (pre-built .mpq on disk, or built from raw content when listed in add)"
//   }
// }
```

**Pre-built archive with description:**

Place `patch-k.mpq` next to this file in `mpq/`. Only **`description`** is required in the manifest — do not list pre-built files in **`add`**.

```json
{
    "description": {
        "patch-k.mpq": "Onyxia's Lair — client UI and map changes"
    }
}
```

**Remove a previously published archive:**

```json
{
    "remove": [
        "patch-w.mpq"
    ]
}
```

**Build from raw content:**

```json
{
    "add": [
        "patch-k.mpq"
    ],
    "description": {
        "patch-k.mpq": "Built automatically from Interface/… files in this folder"
    }
}
```

Field reference:

- **`add`** — Output archive names to **construct from raw content** in this folder. Not used for pre-built `.mpq` files already on disk.
- **`remove`** — Names of `.mpq` archives to delete from the client when this patch is applied.
- **`description`** — Human-readable notes keyed by archive file name (for example `"patch-k.mpq"`). **Required** for every archive this patch ships — both pre-built `.mpq` files on disk and names listed in **`add`** for construction.

Do not use `patch-D.MPQ` here; that name is reserved for DBC client patches generated on the stack.

### SQL layout note

This repository uses `sql/character/` for character-database scripts. When synced or imported into Azeroth Platform, that folder is mapped to `sql/characters/` on the stack (matching AzerothCore schema names).

### mapping.json

The `mapping.json` file at the repository root defines how SQL from the `mod-individual-progression` module is copied into patch folders. Destinations use `{expansion}/{index} {Name}/…` paths; expansion names are matched case insensitively. For example:

```json
{
    "mappings": [
        {
            "source": "mod-individual-progression/data/sql/world/base/*",
            "destination": "classic/1.0 Start/sql/world/",
            "optional": false
        }
    ]
}
```

Destinations may also target `config/`, `lua/`, `dbc/`, `map/`, and `mpq/` under a patch folder.

### How Azeroth Platform uses this repository

**Sync with mod-individual-progression** and **Validate patches** both use the same checkout of this repository, stored **on the stack** — not beside the platform repo and not on the host outside stack data.

| Flow | What it does |
| --- | --- |
| **Sync with mod-individual-progression** | `git pull` on `mod-individual-progression`, then clone or `git pull` this repo on the stack; create `migrations/` patch folders from this layout; copy patch files (SQL, DBC, map, MPQ, config, lua); apply `mapping.json` to import SQL and other files from the module |
| **Validate patches** | Compare each stack patch folder under `migrations/` to the matching folder in the on-stack checkout; verify every `config/*.json` key exists in the live server `.conf` files |

Nothing is cloned onto the host for sync or validation. The manager never expects a sibling `../Azeroth-Platform-Progression` checkout or a `MIGRATIONS_PROGRESSION_REPO_PATH` bind-mount.

### Stack directory layout

Each stack's data root is `{BuildsPath}/{stackId}` (Docker default: `/app/data/stacks/{stackId}`):

```
{stackRoot}/
├── azeroth-platform-progression/      ← this repository (git clone on first sync, git pull after)
│   ├── Classic/ … Tbc/ … Wotlk/
│   └── mapping.json
├── migrations/                          ← patch content applied by the stack
│   └── patch 1.1 MOLTEN_CORE/
│       ├── progression.json             ← marks Individual Progression managed patches
│       ├── description.md
│       ├── sql/{world,auth,characters}/
│       ├── config/, lua/, dbc/, map/, mpq/
├── lua_scripts/                         ← live scripts (patch lua/ copies here on apply)
├── azerothcore-wotlk/                   ← server build checkout
│   ├── modules/
│   │   └── mod-individual-progression/  ← module sources (mapping.json copies from here)
│   └── env/dist/etc/                    ← live worldserver / module configs
├── server_dbc/                          ← cumulative DBC baseline
├── client/                              ← per-stack launcher client overlay
├── individual_progression_settings.json
└── progression_sync_log.json
```

**`mod-individual-progression`** is cloned into the stack build when the server is built (Grimfeather fork by default). Sync reads mapped files from:

```
{stackRoot}/azerothcore-wotlk/modules/mod-individual-progression/
```

After **Build** (or **Rebuild**), that module directory must exist before sync or validation can use `mapping.json`.

### Sync order (Patches tab)

1. **`git pull`** `mod-individual-progression` in the stack build checkout
2. **`git clone`** this repository into `{stackRoot}/azeroth-platform-progression/` on first sync, then **`git pull`** on later runs
3. Create or update `migrations/` patch folders from the expansion/patch layout in the on-stack checkout
4. Copy SQL, DBC, map, MPQ, **config**, and **lua** files from this repository into those patch folders
5. Apply **`mapping.json`** — copy mapped sources from `mod-individual-progression` into the destinations defined here

Initial sync may overwrite content in managed progression patch folders. Later syncs only update managed progression patches; custom patch folders are left unchanged.

### Validation (Patches tab)

Run **Validate patches** after sync and before applying any patch. Validation:

- When progression patches exist on the stack, compares each managed patch under `migrations/` to the matching reference folder in `{stackRoot}/azeroth-platform-progression/` (run sync first if patches are missing)
- Checks that every key in each patch's `config/*.json` files exists in the corresponding server or module `.conf` on the stack
- Accepts the standard patch categories: `config`, `lua`, `sql`, `dbc`, `map`, and `mpq`

Use **Preview changes** on an individual patch to see current vs new config values before apply.

Re-run validation after every server recompile — a new build invalidates the previous check.

### Apply order (per patch)

When a patch is applied on the stack, Azeroth Platform runs (in order): SQL → DBC → maps → MPQ publish/removal → **config overrides** → **Lua deploy** (then restarts the worldserver when config or Lua changed). Re-apply-all runs the same stages for every already-applied patch in level order.
