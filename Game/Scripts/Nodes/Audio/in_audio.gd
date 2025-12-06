extends AudioStreamPlayer

var effect: AudioEffectCapture
var playback: AudioStreamGeneratorPlayback


func _ready() -> void:
	effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	playback = get_stream_playback()


func _process(delta: float) -> void:
	if (effect.can_get_buffer(512) && playback.can_push_buffer(512)):
		VOIP.transmit_data.rpc(Network.local_pid, effect.get_buffer(512))
	effect.clear_buffer()
	
