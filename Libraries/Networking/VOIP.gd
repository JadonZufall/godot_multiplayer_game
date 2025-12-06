extends Node

# var playback : AudioStreamGeneratorPlayback

const BUFFER_SIZE: int = 512

@rpc("any_peer", "call_remote", "reliable")
func transmit_audio(pid: int, data: PackedVector2Array) -> void:
	for i in range(0, BUFFER_SIZE):
		# playback.push_frame(data[i])
		pass
