# tetris-processing

El código consta 4 clases y el programa principal Tetris que es el que le da la secuencia al juego, veremos cual es la función de cada clase:

pieza: Esta clase es la que contiene la forma que tendrá cada figura y sus rotaciones posibles, contiene los métodos para girar la pieza y moverla dentro del tablero.

tablero: Es una matriz que contiene los espacios utilizados por las piezas, sus métodos permiten saber cuando las lineas están completas y nos dice cuantas son, ademas de que nos da el valor de cada uno de los espacios si esta lleno o vacío, para determinar si una pieza puede ocupar esa posición.

marcador: Contiene los datos de puntuación, nivel y las lineas que llevamos, sus métodos son muy sencillos ya que solo incrementan los contadores.

juego: Esta es la clase que determina las acciones que se pueden realizar, restringe los movimientos de las piezas en el tablero, actualiza los valores del tablero y los valores del marcador; esta clase lleva como parámetros las 3 clases anteriores ya que interactua directamente con sus propiedades y métodos.

Todas las clases cuentan con el método draw() que dibuja en pantalla y restart() para reiniciar los valores cuando inicia un juego nuevo.

Visita http://make-a-tronik.com
