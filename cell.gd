extends Node
class_name cell

var options = []
var collapsed = false


var child = null
var cellTile = null

var position = null

func collapse():
	collapseCell(options[randi_range(0,options.size()-1)])


func collapseCell(_tile):
	cellTile = _tile
	collapsed = true
	var newScene = cellTile.tileScene.instantiate()
	newScene.position = position
	add_child(newScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
