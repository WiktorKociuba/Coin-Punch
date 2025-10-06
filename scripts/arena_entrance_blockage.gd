extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventController.connect("blockEntrance", blockEntrance)
	EventController.connect("unblockEntrance", unblockEntrance)

func blockEntrance():
	visible = true
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	collision_enabled = true

func unblockEntrance():
	visible = false
	set_process_mode(Node.PROCESS_MODE_DISABLED)
	collision_enabled = false
