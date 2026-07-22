# Breakout

*[English version](README.en.md)*

Mi versión del clásico Breakout, hecha en Godot 4.6 como **juego 2** del [20 Games Challenge](https://20_games_challenge.gitlab.io/).

![Captura del juego](captura_breakout.png)

## Breakout original

Breakout es uno de los clásicos de la era dorada del arcade. Creado por Atari en 1976, nació de una idea de Nolan Bushnell y Steve Bristow, y fue diseñado —en cuatro noches— por Steve Wozniak y Steve Jobs, antes de que Apple fuera Apple. El concepto es simple: una pala, una pelota y un muro de ladrillos que destruir. Pero esa simplicidad esconde una profundidad táctica real: el ángulo de rebote, la gestión de las vidas y la presión de ir rompiendo el muro ladrillo a ladrillo lo convierten en uno de los juegos más adictivos de su época.

## Por qué he hecho este juego

Este proyecto es la segunda entrega del [20 Games Challenge](https://20_games_challenge.gitlab.io/). Breakout es el salto natural desde Pong: comparte la mecánica de rebote de pelota con pala, pero añade gestión de niveles, distintos tipos de ladrillos, sistema de vidas con corazones y una arquitectura de juego más compleja. El objetivo era asentar lo aprendido con Pong y dar un paso más en la organización de proyectos en Godot.

## Qué he aprendido con este juego

A nivel de conceptos:

- Arquitectura de escena única: una raíz permanente con paneles show/hide en lugar de cambiar de escena con `change_scene_to_file`.
- Generación procedural de niveles por código a partir de datos en JSON.
- Control de física manual en `RigidBody2D` mediante `_integrate_forces`: cálculo del ángulo de rebote según la posición de impacto en la pala y su inercia.
- Sistema de buses de audio (Master → Música / SFX) para controlar el volumen de música y efectos de forma independiente.
- Fuentes bitmap en Godot 4: creación y uso de `BitmapFont` con archivo `.fnt` generado a partir de un PNG.
- `CanvasLayer` como HUD: no hereda la visibilidad del nodo padre, hay que gestionarla explícitamente.
- `TextureRect` con `expand_mode` e `stretch_mode` para mostrar imágenes ajustadas dentro de contenedores UI.
- Guardado de configuración entre sesiones con `ConfigFile`.
- Cambio de modo pantalla completa / ventana mediante `DisplayServer`.

Nodos utilizados:

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

## Controles

| Acción | Tecla |
| --- | --- |
| Mover pala a la izquierda | `←` |
| Mover pala a la derecha | `→` |
| Pausar / Menú | `Escape` |

## Créditos

Los efectos de sonido y assets gráficos usados en este proyecto no son propios. Gracias a sus autores:

**Efecto de rebote** (pala y paredes)
- Archivo: `Bleep_04.wav`
- Pack: *Interface Bleeps Wav*
- Autor: [bleeoop](https://bleeoop.itch.io/interface-bleeps)

**Efectos de impacto y rotura de ladrillo**
- Archivos: `8bit-explode17.wav`, `8bit-explode5.wav`
- Autor: [Juhani Junkala](https://juhanijunkala.com/) vía [OpenGameArt](https://opengameart.org/content/512-sound-effects-8-bit-style)

**Efecto de vida perdida**
- Archivo: `JDSherbert - Pixel Game Essentials SFX Pack - Die 1.wav`
- Pack: *Pixel Game Essentials SFX Pack*
- Autor: JDSherbert

**Efecto de nivel completado / partida ganada**
- Archivo: `JDSherbert - Pixel Game Essentials SFX Pack - Level Complete 1.wav`
- Pack: *Pixel Game Essentials SFX Pack*
- Autor: JDSherbert

**Fuente bitmap**
- Archivo: `anuvverbubbla_8x8.png`
- Autor: Zingot Games
- Fuente: [OpenGameArt](https://opengameart.org/content/8x8-font-chomps-anuvverbubbla)

**Sprites de ladrillos y pala**
- Archivo: `Breakout_Tile_Free.png`
- Autor: [Kenney](https://kenney.nl)

**Sprite de pelota**
- Archivo: `58-Breakout-Tiles.png`
- Autor: [Cuz](https://opengameart.org/users/cuz) vía [OpenGameArt](https://opengameart.org/content/breakout-brick-breaker-tile-set-free)

## Posibles evoluciones

- **Sistema de extras/bufos**: ladrillos especiales que al romperse sueltan power-ups (pala grande, bola múltiple, disparo...) o debufos (pala pequeña, bola acelerada).
- **High scores**: tabla de puntuaciones máximas guardada entre sesiones.
- **Velocidad progresiva de la pelota**: que aumente con cada ladrillo roto, como en el original.
- **Más niveles** con patrones de ladrillo más elaborados.
- **Soporte para mando**.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE.md](LICENSE.md) para más detalles.
