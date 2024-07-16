extends Node

const card_scene = preload("res://scenes/card.tscn")
const PORT = 4433
var peer = ENetMultiplayerPeer.new()
@onready var line_edit = $LineEdit

func _on_host_pressed():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_card)
	_add_card()

func _add_card(id = 1):
	var card = card_scene.instantiate()
	card.set_meta("Authority", id)
	card.name = str(id)
	call_deferred("add_child", card)

func _on_connect_pressed():
	peer.create_client(line_edit.text, PORT)
	multiplayer.multiplayer_peer = peer
