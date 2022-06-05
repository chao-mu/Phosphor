extends Node

const _FADE_RATE = 1.05
const _INITIAL_FADEIN_CUTOFF = 250.0
const _TARGET_FADEIN_CUTOFF = 20000.0

func fade_in_scene():
	var scene_bus_idx = AudioServer.get_bus_index("Scene")
	var lpf = AudioServer.get_bus_effect(scene_bus_idx, 0) as AudioEffectFilter
	
	var cutoff = _INITIAL_FADEIN_CUTOFF
	lpf.set_cutoff(cutoff)
	
	$Ambience.play()
	
	while cutoff < _TARGET_FADEIN_CUTOFF:
		cutoff = min(_TARGET_FADEIN_CUTOFF, cutoff * _FADE_RATE)
		lpf.set_cutoff(cutoff)
		yield(get_tree().create_timer(0.05), "timeout")
