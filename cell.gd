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


func getTile():
	return cellTile

func getOptions():
	return options;

func updatePossibleOptions(_arrOptions):
	var newOptions = []
	for opt in _arrOptions:
		if(newOptions.has(opt)): continue
		newOptions.push_back(opt)
	
	options = newOptions
