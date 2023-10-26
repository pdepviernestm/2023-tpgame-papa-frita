import wollok.game.*
import skin.*
import personaje.*
import tablero.*

class malo {
		
	var position = self.asignarPosicion()
	const imagen = skin.enemigos().anyOne()
	const movimientos = [{position.up(1)}, {position.down(1)}, {position.right(1)}, {position.left(1)}]
	var movimiento = movimientos.anyOne()
	
	method image() = imagen
	
	method position() = position
	
	method asignarPosicion() {
		
		position = coordenadasLibres.coords().anyOne()
		coordenadasLibres.removerCoordenada(position)
		
		return position
	}
	
	method mover() {
		movimiento = movimientos.anyOne().apply()
		
		// Solo se mueve en una direccion en caso de que en esa direccion no haya nada o
		// este el personaje
		if (game.getObjectsIn(movimiento).isEmpty() || game.getObjectsIn(movimiento) == [monigote]) {
			position = movimiento
		} 
	}
	
	method chocar(){
		monigote.morir()
	}
	
	method morirPorBomba() {
		game.removeVisual(self)
	}
}

object nuevoFondo {
	
	method image() = "menu.png"
	method position() = game.origin()
	method chocar(){}
}

object jogo {
  	var property malos = []
  	var property bombas = []
	
	method generarLayout() {
  		tablero.crearBloques()
  		tablero.borde()
  		tablero.crearBloquesRompibles()
  		tablero.bloques().forEach({b => game.addVisual(b)})		
	}
	
	method iniciarNivel() {
  		15.times({e => malos.add(new malo()) })
  		malos.forEach({b => game.addVisual(b)})
  		game.addVisualCharacter(monigote)
	}
	
}