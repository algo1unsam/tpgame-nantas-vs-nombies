import wollok.game.*

object papita{
	var position=self.posicionInicial()
	
	method image()="assets/papita1.png"
	method position() = position

	method posicionInicial() = game.at(2.randomUpTo(6), game.height()+1)
	//la papita aparece en un lugar random entre las celdas 3 y 7 
	//un casillero arriba para que no se vea
	
	method aparecer(){
		position = self.posicionInicial()
		game.onTick(250,"moverPapita",{self.mover()})
		//cada 250 milisegundos se mueve la papita
	}
	method desaparecer(){
		game.removeTickEvent("moverPapita")
		position = self.posicionInicial()
	}
	method mover(){
		position = position.down(1) //muevo para abajo un casillero
		if (position.y() == -1)//si se fue del cuadro vuelvo a la pos inicial
			position = self.posicionInicial()
	}
	
}
