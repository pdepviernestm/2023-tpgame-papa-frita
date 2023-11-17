import wollok.game.*
import personaje.*
import items.*
import skin.*

class Bloque {
	
	var property position
	
	method image() = skin.bloqueIndestructible()
	
	method chocar() {
		return monigote.volver()
	}
	method morir () { }
	method morirPorBomba () { }
	
}

class BloqueRompible inherits Bloque {
	
	override method image() = skin.bloqueRompible()
	
	override method morirPorBomba () {
		if ((1..10).anyOne() > 6) { 
			const items = [{new Ayuda(position = position)}, {new Puntos(position = position)}]
			var item = items.anyOne().apply()
			item.agregarItem()
		}
		game.removeVisual(self)
	}
	
}

object coordenadasLibres {
	var property coords = []
	var x = 0
	var y = 0
	
	method agregarCoordenadas() {
		15.times({
			e => 15.times({
				t => coords.add(game.at(x,y))
				y +=1
			}) x += 1
			y = 0
		})
		coords.remove(game.at(0,0))
        coords.remove(game.at(1,0))
        coords.remove(game.at(0,1))
	}
	
	method removerCoordenada(coordenada) {
		coords.remove(coordenada)
	}
	
}


object tablero {
	
	const property bloques = []
	var x = 0
	var y = 0
		
	method crearBloque() {
		
		if (x%2 != 0 and y%2 != 0) {
			bloques.add(new Bloque(position = game.at(x,y)))
			coordenadasLibres.removerCoordenada(game.at(x, y))
		}
		x += 1
		
		if (x == 15) {
			x = 0
			y += 1
		}
	}
	
	method crearBloques() {
		coordenadasLibres.agregarCoordenadas()
		225.times({e => self.crearBloque()})
	}
	 
	method agregarBloqueEnCoordenada(a,b) {
		bloques.add(new Bloque(position = game.at(a,b)))
	}
	 
	method borde() {
		15.times({e => self.agregarBloqueEnCoordenada(-1,e-1)})
		15.times({e => self.agregarBloqueEnCoordenada(15,e-1)})
		15.times({e => self.agregarBloqueEnCoordenada(e-1,-1)})
		15.times({e => self.agregarBloqueEnCoordenada(e-1,15)})		
	}
	
	method crearBloquesRompibles() {
		40.times({ t =>
			var a = coordenadasLibres.coords().anyOne()
			coordenadasLibres.removerCoordenada(a)
			bloques.add(new BloqueRompible(position = a))
		})
	}	
	
}
