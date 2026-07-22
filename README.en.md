# Breakout

*[Versión en español](README.md)*

My take on classic Breakout, built in Godot 4.6 as **game 2** of the [20 Games Challenge](https://20_games_challenge.gitlab.io/).

![Game screenshot](captura_breakout.png)

## Original Breakout

Breakout is one of the classics from the golden age of arcades. Created by Atari in 1976, it was born from an idea by Nolan Bushnell and Steve Bristow, and designed — in four nights — by Steve Wozniak and Steve Jobs, before Apple was Apple. The concept is simple: a paddle, a ball and a wall of bricks to destroy. But behind that simplicity lies real tactical depth: the angle of the bounce, managing lives and the pressure of chipping away at the wall brick by brick make it one of the most addictive games of its era.

## Why I made this game

This project is the second entry of the [20 Games Challenge](https://20_games_challenge.gitlab.io/). Breakout is the natural step up from Pong: it shares the ball-and-paddle bounce mechanic, but adds level management, different brick types, a heart-based lives system and a more complex game architecture. The goal was to consolidate what I learned with Pong and take a step further in organising Godot projects.

## What I learned with this game

On the concepts side:

- Single-scene architecture: a permanent root scene with show/hide panels instead of switching scenes with `change_scene_to_file`.
- Procedural level generation from JSON data.
- Manual physics control in `RigidBody2D` via `_integrate_forces`: calculating the bounce angle based on impact position on the paddle and its momentum.
- Audio bus system (Master → Music / SFX) to control music and sound effect volume independently.
- Bitmap fonts in Godot 4: creating and using a `BitmapFont` with a `.fnt` file generated from a PNG.
- `CanvasLayer` as a HUD: it does not inherit visibility from its parent node — it must be managed explicitly.
- `TextureRect` with `expand_mode` and `stretch_mode` to display images scaled inside UI containers.
- Saving settings between sessions with `ConfigFile`.
- Toggling fullscreen / windowed mode via `DisplayServer`.

Nodes used:

- `Node2D`
- `Control`
- `ColorRect`
- `CanvasLayer`
- `CharacterBody2D`
- `RigidBody2D`
- `Sprite2D`
- `TextureRect`
- `StaticBody2D`
- `Area2D`
- `CollisionShape2D`
- `AudioStreamPlayer`
- `Label`
- `Button`
- `HSlider`
- `CheckButton`
- `HBoxContainer` / `VBoxContainer` / `CenterContainer`

## Controls

| Action | Key |
| --- | --- |
| Move paddle left | `←` |
| Move paddle right | `→` |
| Pause / Menu | `Escape` |

## Credits

The sound effects and graphical assets used in this project are not my own. Thanks to their authors:

**Bounce sound** (paddle and walls)
- File: `Bleep_04.wav`
- Pack: *Interface Bleeps Wav*
- Author: [bleeoop](https://bleeoop.itch.io/interface-bleeps)

**Brick hit and break sounds**
- Files: `8bit-explode17.wav`, `8bit-explode5.wav`
- Author: [Juhani Junkala](https://juhanijunkala.com/) via [OpenGameArt](https://opengameart.org/content/512-sound-effects-8-bit-style)

**Life lost sound**
- File: `JDSherbert - Pixel Game Essentials SFX Pack - Die 1.wav`
- Pack: *Pixel Game Essentials SFX Pack*
- Author: JDSherbert

**Level complete / game won sound**
- File: `JDSherbert - Pixel Game Essentials SFX Pack - Level Complete 1.wav`
- Pack: *Pixel Game Essentials SFX Pack*
- Author: JDSherbert

**Bitmap font**
- File: `anuvverbubbla_8x8.png`
- Author: Zingot Games
- Source: [OpenGameArt](https://opengameart.org/content/8x8-font-chomps-anuvverbubbla)

**Brick and paddle sprites**
- File: `Breakout_Tile_Free.png`
- Author: [Kenney](https://kenney.nl)

**Ball sprite**
- File: `58-Breakout-Tiles.png`
- Author: [Cuz](https://opengameart.org/users/cuz) via [OpenGameArt](https://opengameart.org/content/breakout-brick-breaker-tile-set-free)

## Possible future improvements

- **Power-up / power-down system**: special bricks that drop power-ups (big paddle, multi-ball, laser...) or debuffs (small paddle, faster ball) when broken.
- **High scores**: leaderboard saved between sessions.
- **Progressive ball speed**: increasing with each brick broken, as in the original.
- **More levels** with more elaborate brick patterns.
- **Gamepad support**.

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.
