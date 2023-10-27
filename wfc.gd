extends Node2D
class_name wfc

@export var tileSet: Array[tile] = []
@export var dimensions = 5
@export var spacing = 24

var grid = []



# Called when the node enters the scene tree for the first time.
func _ready():
	for t in tileSet:
		t.getAllSiblings()
	generateGrid()
	
	entropy()

	
	
func entropy():
	
	#Sorted Grid
	var gridCopy = grid.duplicate()
	gridCopy.sort_custom(func(a, b): return a.options.size() < b.options.size())
	
	var len = gridCopy[0].options.size()
	var stopIndex = -1
	for t in gridCopy:
		stopIndex += 1
		if(t.options.size() > len):
			break
	
	
	if(stopIndex > 0): gridCopy = gridCopy.slice(0, stopIndex)
	
	var randIndex = randi_range(0, gridCopy.size()-1)
	
	var cellToCollapse = gridCopy[randIndex]
	print(cellToCollapse.position)
	collapseIndex(grid.find(cellToCollapse))
	
#	for t in gridCopy:
#		print(t.options.size())
	
	
#	var index = -1
#	for i in grid:
#		index += 1
#		if(grid[index].collapsed == true):
#			continue
#		else:
#			print(index)
#			#if(((num + GridWidth) > grid.size() - 1) || grid[num + GridWidth].isSolid()):
#			#goodToMoveDown = false



func collapseIndex(_index):
	var collapsedCell = grid[_index]
	collapsedCell.collapse()
	var cellTile = collapsedCell.getTile()
	
	
	#Eh this is like simple checks to see where we are on the border to update the surrounding options
	if(_index < dimensions):
		print('top row')
		
	if(_index > (dimensions * dimensions) - dimensions):
		print('bottom row')
	
	if(_index % (dimensions) == 0):
		print('left side?')
		
	if(((_index + 1) % dimensions) == 0):
		print('right side?')
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Create a Square for the grid using un.gd
func createCell(_position):
	var node = cell.new()
	#node.texture = squareTexture
	node.set_script(load("res://cell.gd"))
	add_child(node)
	node.position = _position
	node.options = tileSet
	#node.collapseCell(tileSet[0])
	return node
	
func generateGrid():
	var index = -1
	#generate a cell for every dimension
	for w in dimensions:
		for h in dimensions:
			index += 1
			var x = h * spacing
			var y = w * spacing
			var node = createCell(Vector2(x, y))
			grid.push_back(node)
