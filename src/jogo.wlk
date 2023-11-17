import wollok.game.*
import skin.*
import personaje.*
import tablero.*
import menu.*

class Malo {
		
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
		if (game.getObjectsIn(movimiento).isEmpty() || game.getObjectsIn(movimiento).contains(monigote)) {
			position = movimiento
		} 
	}
	
	method chocar(){
		monigote.morir()
	}
	
	method morirPorBomba() {
		cantidadPuntos.cantidad(cantidadPuntos.cantidad() + 5)
		if (jogo.malos().size() <= 1) {
			var pantallaFinal = new Cartel(image = skin.pantallaFinal())
			var arrancarDeNuevo = new Cartel(image = skin.cartelFinal())
			game.clear()
			game.addVisual(pantallaFinal)
			game.addVisual(arrancarDeNuevo)
			keyboard.r().onPressDo({{game.stop()}})
		} else {
			game.removeVisual(self)
		}
	}
}

class Cartel {
	var property image
	method position() = game.origin()
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
  		15.times({e => malos.add(new Malo()) })
  		malos.forEach({m => game.addVisual(m)})
  		game.addVisualCharacter(monigote)
	}
	
}