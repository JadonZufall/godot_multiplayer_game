extends AudioStreamPlayer3D


func _ready() -> void:
	VOIP.register_stream(Network.local_pid, get_stream_playback())
