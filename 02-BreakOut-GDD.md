## Game Design Document

## 02-BreakOut
https://20_games_challenge.gitlab.io/games/breakout/

# Descripción de la pagina web de 20_games_challenge
Objetivo:
Crear un espacio de juego con paredes y techo.
Añadir una paleta que se pueda mover de izquierda a derecha mediante comandos del jugador.
Añadir una pelota que rebote en la paleta, las paredes y el techo.
Añadir objetos de juego cuadrados (ladrillos) en la parte superior del espacio de juego.

(El juego original tenía ocho filas de 16 ladrillos cada una, aunque se puede cambiar el número de ladrillos según el tamaño del espacio de juego).
Permitir que la pelota rebote en los ladrillos. Cuando la pelota rebote, el ladrillo debe desaparecer.
Romper un ladrillo debe sumar puntos al jugador.
La velocidad de la pelota debe aumentar a medida que se rompen ladrillos.
Mostrar la puntuación y un contador de vidas. El jugador comienza con tres vidas. Si el jugador falla la pelota, se le resta una vida. Cuando se agotan las vidas, el juego termina.

Objetivo adicional:
Guardar la puntuación más alta entre sesiones de juego y mostrarla junto con la puntuación del jugador.
Añadir diferentes colores a los ladrillos de las filas. (El juego original era en blanco y negro, pero tenía una película a color en la pantalla que simulaba filas de ladrillos de colores).
La ​​paleta debería estrecharse una vez que la pelota llegue al techo.

## Objetivo a nivel de aprendizaje.

Asentar y mejorar las bases obtenidas en el juego anterior, utilización de nodos, eventos, trayectorias, impactos, efectos de sonido, gestión de puntuación y vidas, etc.
Añadir la opción de parar el juego y que salga las opciones, reanudar, reset partida, configuración.
Aprender temas de idiomas.
Permitir cambios de configuración de idiomas, guardar las puntuaciones mas altas
Aprender a guardar datos del juego con archivos de configuración.

## Escenas.

arena (Node2D) -> escena y scripts, es la zona de juego, controlara el juego, tendra una instancia de todas las escenas.
marcador (CanvasLayer) -> escena y scripts, es la zona de marcador, controlara y expone el control de las bolas, y de los puntos del jugador.
ladrillos -> escena y scripts con el comportamiento de los ladrillos, tiene que desaparecer cuando la bola los impacte generando un sonido, expone el impacto para poder gestionar el marcador y la velocidad de la bola.
pala -> escena y script que controla el comportamiento de la pala, ubicación tamaño, etc
bola (RigidBody2D) -> escena y scripts con el movimiento y el comportamiento de la bola, tiene que aumentar su velocidad con cada impacto en el ladrillo, tiene que exponer el impacto con la zona de muerte.
zona de muerte (Area2D) -> escena y scripts tiene que detectar cuando la pelota entra en su zona y emitir un aviso para que el resto controle el comportamiento.

## Estados

MENU → PLAYING → PAUSED → {WIN | GAME_OVER} → MENU

## Configuración guardable o información persistente

    - Dificultad: Fácil, Media, Complicada.
    - High Scores: Lista con las mejores puntuaciones conseguidas.
    - Idioma: Incluiremos Español e Ingles.

## Flujo

                   ------> Empezar el juego   -> Arrancar el juego -> Pantalla pausa, deberia ser la misma que la pantalla principal para no duplicar.
                    
Pantalla principal ------> Opciones del juego -> Guardar las opciones elegidas en algun tipo de recurso, creo que se guaran en archivos json, archivo de configuración
                    
                   ------> Salir del juego    -> Salir del juego.

## Comentarios o ideas.

Es posible / rentable hacer los ladrillos por código??
La pantalla de pausa y principal o son las mismas o los botones se hacen como escenas a parte y se hacen dos escenas que instancien los botones, así no se repite todo lo de los botones.

## Adicionales

Añadimos "putadas" entre los ladrillos, por ejemplo ladrillos que tienes que golpear dos veces, ladrillos que rebotan de manera rara en trayectoria y velocidad, ladrillos que caen hacia abajo en vez de desaparecer y así interfiere en la trayectoria de la bola. 
Bufos pelotas mas fuertes que tiran mas de un ladrillo, etc

## Audio.

Efecto de impacto en pala.
Efecto de impacto en ladrillo.
Efecto de impacto en zona de muerte.
Efecto / Música de game over.