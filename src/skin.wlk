import wollok.game.*

object skin {
	
	var property skin
	var property sonidos = (1..10)
	var property enemigos = ["enemigo1.png", "enemigo2.png", "enemigo3.png", "enemigo4.png"]
	var property monigote = "monigote.png"
	var property fondo = "pisoasfalto.png"
	var property mensajeMuerte = "mensajeMuerte.png"
	var property sonidoMuerte = "sonidoMuerte.mp3"
	var property bomba = "bomba.png"	
	var property explosion = "explosion.png"
	var property mensajeMuerteBomba = "troll.png"
	var property item = "item.png"
	var property item2 = "item2.png"
	var property reloj = "reloj.png"
	var property pantallaFinal = "destruido.png"
	var property cartelFinal = "cartelFinal.png"
	var property fondoMenu = "menu.png"
	var property bloqueIndestructible = "indestructible.png"
	var property bloqueRompible = "bloqueRompible.jpg"
	
	method setSkin(nombre) {
		skin = "img/" + nombre + "/"
		sonidos = sonidos.map({e => (skin + "/sonidos/" + e + ".mp3")})
		enemigos = enemigos.map({e => (skin  + e)})
		explosion = skin + explosion
		monigote = skin + monigote
		bomba = skin + bomba
		fondo = skin + fondo
		mensajeMuerte = skin + mensajeMuerte
		mensajeMuerteBomba = skin + mensajeMuerteBomba
		sonidoMuerte = skin + "/sonidos/" + sonidoMuerte
		item = skin + item	
		item2 = skin + item2
		reloj = skin + reloj
		pantallaFinal = skin + pantallaFinal
		cartelFinal = skin + cartelFinal
		fondoMenu = skin + fondoMenu
		bloqueIndestructible = skin + bloqueIndestructible
		bloqueRompible = skin + bloqueRompible
	}
	
}
