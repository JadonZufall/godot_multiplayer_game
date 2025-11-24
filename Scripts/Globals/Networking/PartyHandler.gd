extends Node

signal player_join
signal player_leave
signal player_promoted

signal party_disband


var party_leader: int = -1


func create() -> void:
	pass

func disband() -> void:
	pass

func kick(id: int) -> void:
	pass

func leave() -> void:
	pass
