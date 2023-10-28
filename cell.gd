extends Node
class_name cell

var totalOptions = []
var options = []
var optionsItCantBe = []

var collapsed = false

var child = null
var cellTile = null

var position = null


func collapse():
	collapsed = true
	if(options.size() == 0): 
		collapseCell(totalOptions[0])
		return
	collapseCell(options[randi_range(0,options.size()-1)])


func collapseCell(_tile):
	cellTile = _tile
	var newScene = cellTile.tileScene.instantiate()
	newScene.position = position
	add_child(newScene)


func getTile():
	return cellTile

func getOptions():
	return options;

func eliminateOptions(_arrOptions):
	var newOptions = []
	#loop through total options
	for opt in totalOptions:
		#if our new list of options have this current option then add it.
		if(!_arrOptions.has(opt)):
			if(!optionsItCantBe.has(opt)):				
				optionsItCantBe.push_back(opt)
		
	#All This probably doesn't need to be here
	#Could probably clean this up further
	#TODO: Clean Up Further		
	var optionsToDelete = []
	for opt in options:
		if(optionsItCantBe.has(opt)):
			optionsToDelete.push_back(opt)

	for opt in optionsToDelete:
			options.erase(opt)
	
func printOptions():
	var currentOptionsStr =''
	for opt in options:
		currentOptionsStr += opt.title
		
	print(currentOptionsStr)
	pass
