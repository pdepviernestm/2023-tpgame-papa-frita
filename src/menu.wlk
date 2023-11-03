import wollok.game.*
import jogo.*
import skin.*
import personaje.*
import items.*


object hud {	
	method iniciarHud() {
		const ayuda = new Ayuda(position = game.at(16,13))
		const puntos = new Puntos(position = game.at(16,12))
		tiempo.correrTiempo()
		game.addVisual(ayuda)
		game.addVisual(puntos)
		game.addVisual(reloj)
		game.addVisual(tiempo)
		game.addVisual(cantidadAyudas)
		game.addVisual(cantidadPuntos)
	}
}

object fondoMenu {
	
	method image() = skin.fondoMenu()
	method position() = game.origin()
}

object reloj {
    var property position = game.at(16, 14)
    method image() = skin.reloj()
}

object tiempo {
    var tiempo = 0
    var property position = game.at(17, 14)
    
    method correrTiempo() {
    	game.onTick(1000, "incrementarTiempo", {=> if (monigote.vivo()) tiempo += 1})
    }
        
	method text() = tiempo.toString()	
	
	method textColor() = "FFFFFFFF"
}

object cantidadAyudas {
	var property cantidad = 0
    var property position = game.at(17, 13)

	method text() = cantidad.toString()
	method textColor() = "FFFFFFFF"

}

object cantidadPuntos {
	var property cantidad = 0
    var property position = game.at(17, 12)
    
	method text() = cantidad.toString()
	method textColor() = "FFFFFFFF"
}

object menu {
	
	var ready = false
	
	method menucito() {
  		skin.setSkin("milei")
		const fondoMenu = new Cartel(image = skin.fondoMenu())
		
		game.clear()
		game.title("milei en el banco central simulator")
		game.width(18)
  		game.height(15)
  		game.cellSize(60)
  		game.addVisual(fondoMenu)
  		//game.addVisual(fondoMenu)
  		game.boardGround(skin.fondo())
  		keyboard.f().onPressDo({
  			if (not ready) {
				game.removeVisual(fondoMenu)
  				self.arrancar()
  				ready = true
  			}
  		})	
	}
	
	method arrancar(){
		jogo.generarLayout()
		jogo.iniciarNivel()
		hud.iniciarHud()
		keyboard.w().onPressDo({if (monigote.vivo()) monigote.arriba()})
		keyboard.s().onPressDo({if (monigote.vivo())  monigote.abajo()})
		keyboard.a().onPressDo({if (monigote.vivo())  monigote.izquierda()})
		keyboard.d().onPressDo({if (monigote.vivo())  monigote.derecha()})
		keyboard.space().onPressDo({if (monigote.vivo()) monigote.ponerBomba()})
		keyboard.r().onPressDo({if (!monigote.vivo()) {game.stop()}})
		game.whenCollideDo(monigote, {e => e.chocar()})
		game.onTick(300, "mover malos", { jogo.malos().forEach({e => e.mover()}) })
	}
}
