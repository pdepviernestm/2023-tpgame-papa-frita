import wollok.game.*
import personaje.*
import items.*

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

class bloque {
	
	const x = 0
	const y = 0
	var position = game.at(x,y)
	
	method position() = position
	
	method image() = "indestructible.png"
	
	method chocar() {
		return monigote.volver()
	}
	method morir () { }
	method morirPorBomba () { }
	
}

class bloqueRompible inherits bloque {
		
	
	method image() = "roca.jpg"
	
	override method morirPorBomba () {
		if ([1..10].flatten().anyOne() > 6) { 
			[{tablero.agregarAyuda(position)}, {tablero.agregarPuntos(position)}].anyOne().apply()
		}
		game.removeVisual(self)
	}
	
}

object tablero {
	
	const bloques = []
	const items = []
	var columna = 0
	var fila = 0
	
	method agregarAyuda(position) {
		game.schedule(1000, {
			var a = new ayuda(position = position)
			items.add(a)
			game.addVisual(a) 
			}
		)
	}
	
	method agregarPuntos(position) {
		game.schedule(1000, {
			var a = new puntos(position = position)
			items.add(a)
			game.addVisual(a)
			}
		)
	}
	
	
	
	method crearBloque() {
		
		if (columna%2 != 0 and fila%2 != 0) {
			bloques.add(new bloque(x = fila, y = columna))
			coordenadasLibres.removerCoordenada(game.at(fila, columna))
		}
		columna += 1
		
		if (columna == 15) {
			columna = 0
			fila += 1
		}
	}
	
	method crearBloques() {
		coordenadasLibres.agregarCoordenadas()
		225.times({e => self.crearBloque()})
	}
	 
	method agregarBloqueEnCoordenada(a,b) {
		bloques.add(new bloque(x = a, y = b))
	}
	 
	method borde() {
		var b= 0
		var a= 0
		15.times({e => self.agregarBloqueEnCoordenada(-1,b)
			b+=1
		})
		b=0
		15.times({e => self.agregarBloqueEnCoordenada(15,b)
			b+=1
		})
		
		15.times({e => self.agregarBloqueEnCoordenada(a,-1)
			a+=1
		})
		a=0
		15.times({e => self.agregarBloqueEnCoordenada(a,15)
			a+=1
		})
		
		
	}
	
	method crearBloquesRompibles() {
		40.times({ t =>
			var a = coordenadasLibres.coords().anyOne()
			coordenadasLibres.removerCoordenada(a)
			bloques.add(new bloqueRompible(position = a))
		})
	}	
	
	method bloques() = bloques
	
}
