import wollok.game.*
import papita.*
import juego.*

class Zombie{
	var numero=1
	var property position=self.posicionInicial()
	
	method image()="assets/zombie" + numero.toString() + ".png"

	method posicionInicial() = game.at(game.width()+1 , 1.randomUpTo(6))
	//al principio estan en un lugar random entre las celdas 1 y 6
	//un casillero la derecha para que no se vea
	
	method aparecer(){
		position = self.posicionInicial()
		game.onTick(1000,"moverZombie",{self.mover()})
	}
	
	method mover(){
		position = position.left(1) //muevo para izq un casillero
		if (position.x() == 0){
			juego.gameOver() //perdes cuando un zombie recorrio todo el tablero sin morir
		}
		
		numero=3.min(numero+1) //para el movimiento
		if (numero==3) numero=1 //loop
	}
	
	method chocar(){
		self.desaparecer()
		puntaje.subirPuntaje(30)} //ganas puntos
		
	method chocar(contraOtroZombie){} //no hace nada
	
	method estaVivo()= position != self.posicionInicial() //esta vivo si está al principio
	
	method desaparecer(){
		game.removeTickEvent("moverZombie") //deja de moverse
		position = self.posicionInicial()} //desaparece
}