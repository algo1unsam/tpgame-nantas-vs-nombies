import wollok.game.*
import papita.*
import juego.*

class Zombie{
	var numero=1
	var position=self.posicionInicial()
	
	method image()="assets/zombie" + numero.toString() + ".png"
	method position() = position

	method posicionInicial() = game.at(game.width()+1 , 1.randomUpTo(6))
	//aparecen en un lugar random entre las celdas 1 y 6
	//un casillero la derecha para que no se vea
	
	method aparecer(){
		position = self.posicionInicial()
		game.onTick(1000,"moverZombie",{self.mover()})
	}
	
	method mover(){
		position = position.left(1) //muevo para izq un casillero
		numero=3.min(numero+1) 
		if (numero==3) numero=1
		if (position.x() == 0){
			juego.gameOver()
		}
	}
	method morir(){
		game.removeTickEvent("moverZombie")
		position = self.posicionInicial()
		puntaje.subirPuntaje(30)
	}
	
	}
