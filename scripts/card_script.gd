extends Node2D

var is_selected = false
var allowed_player : int

func _enter_tree():
	print(str(name))
	print("Authority: " + str(get_meta("Authority")))
	print(str(multiplayer.get_unique_id()))
	print()
	#set_multiplayer_authority(get_meta("Authority"))
	set_multiplayer_authority(name.to_int())

func _process(delta):
	if not is_selected: return

	var mouse_position = get_global_mouse_position()
	position = mouse_position
	DisplayServer.window_get_size()
	var viewport_size = get_viewport().get_visible_rect().size	
	position.x = float_clamp(position.x, -viewport_size[0]/2, viewport_size[0]/2)
	position.y = float_clamp(position.y, -viewport_size[1], viewport_size[1])

func float_clamp(value, minimum, maximum):
	if value < minimum: return minimum
	return min(value, maximum)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if not is_multiplayer_authority(): return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_selected = true if event.pressed else false
