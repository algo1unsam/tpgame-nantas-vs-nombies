import wollok.game.*

object juegoMenu{
	
	method configurar(){
		game.width(64)
		game.height(36)
		game.cellSize(20)
		game.title("Niantas vs niombies")
		game.boardGround("assets/menu.png")
		game.addVisual(flecha)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
	}
	
}

object flecha{
	const posicionesY= [8,4,1]
 	var numero=0
 	//var property position= game.at(14, posicionesY.get(numero) )
 	
 	method image()="assets/flecha.png"
	
	method subir(){
		numero=0.max(numero-1)
		//position= game.at(14, posicionesY.get(numero))
	}
	
	method bajar(){
		numero=2.min(numero+1)
		//position= game.at(14, posicionesY.get(numero))
	}	
	method position(){
		return game.at(14, posicionesY.get(numero))
	}
	
}