extends Node

# var playback : AudioStreamGeneratorPlayback

var _streams: Dictionary[int, AudioStreamGeneratorPlayback] = {}
const BUFFER_SIZE: int = 512

func register_stream(pid: int, stream: AudioStreamGeneratorPlayback) -> void:
	_streams[pid] = stream


@rpc("any_peer", "call_remote", "reliable")
func transmit_data(pid: int, data: PackedVector2Array) -> void:
	for i in range(0, BUFFER_SIZE):
		# playback.push_frame(data[i])
		pass
