extends Node2D
var malo = 1
var rng = RandomNumberGenerator.new()
var dado 
var ataque = 0

func _ready():
	$t1_presentacion.start()
	$carta0.disabled = true
	$Label.text = "You are a mighty wizard \n Work your magic"
	$AnimatedSprite.hide()
	$carta0.hide()
#	https://www.youtube.com/watch?v=CjmIKYjStDc
#	https://www.youtube.com/watch?v=wItqcSlORRc
	pass # Replace with function body.

func _on_t1_presentacion_timeout():
	$Label.text = "Throw your spell"
	print("termina prsentación")
	$carta0.show()
	activarBoton()
	pass # Replace with function body.

func _on_t2_elegir_timeout():
	$Label.text = "Game Over"
	$malos/AnimationPlayer.play("gameOver")
	$go.play()
	$carta0.disabled = true
	print("muere por no elegir")
	pass # Replace with function body.

func _on_carta0_button_up():
#	$carta0.disabled = true
	$t2_elegir.stop()
	$AnimatedSprite.show()
	$AnimatedSprite.play("default")
	$Magia.play()
	print("ciclo de combate contra el malo", malo)
	rng.randomize()
	dado = rng.randf_range(1, 7)
	ataque = dado
	print("tu ataque ",int(dado))
	if (ataque >= malo +1): # Cuidado justar 
		print("gana tu ataque ", ataque, malo)
		$Label.text = "your attack with "+str(int(ataque))+" points wins \n Next bad: "+str(malo)
#		$t3_cama.start(2)
		$carta0.disabled = true
		if malo == 1 :
			malo =2
			$malos/AnimationPlayer.play("cama2")
			print("reiniciar malo", malo)
		elif malo ==2 :
			malo = 3
			$malos/AnimationPlayer.play("cama3")
		elif malo ==3 :
			$malos/AnimationPlayer.play("cama4")
			malo = 4
		elif malo ==4 :
			$malos/AnimationPlayer.play("ganar")
			$Apla.play()
#			$Label.text = "You WIN\nYou are a machine"+str(malo)
			$Label.text = "You WIN\nYou are a machine"
		
	else:
		$carta0.disabled = true
		$Label.text = "Game Over"
		$malos/AnimationPlayer.play("gameOver")
		$go.play()
		print("pierde  game over ", ataque, malo)
#		print(get_tree().reload_current_scene())
		
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimatedSprite.hide()
	$Magia.stop()
	if anim_name == "gameOver":
		print(get_tree().reload_current_scene())
	elif anim_name == "cama2" :
		activarBoton()
		print(anim_name)
	elif anim_name == "cama3" :
		activarBoton()
		print(anim_name)
	elif anim_name == "cama4" :
		activarBoton()
	elif anim_name == "ganar" :
		print("WINNNNNNNNN anim_name")
		print(get_tree().reload_current_scene())
#		print("reiniciar")
	
func activarBoton():
	$Label.text = "Throw your spell"
	$carta0.disabled = false
	$t2_elegir.start(4)
