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
#	grid[5].eliminateOptions([tileSet[2], tileSet[0]])
	
	
func entropy():
	
	
	#Sorted Grid
	var gridCopy = grid.duplicate()
	
	var cellsToDelete = []
	for g in gridCopy:
		if(g.collapsed || g.cellTile != null):
			print('found a collapsed?')
			cellsToDelete.push_back(g)
			
	gridCopy.sort_custom(func(a, b): return a.options.size() < b.options.size())
	

	
	for g in cellsToDelete:
		gridCopy.erase(g)
	
	var len = gridCopy[0].options.size()
	var stopIndex = -1
	for t in gridCopy:
		stopIndex += 1
		if(t.options.size() > len):
			break
	

	
	if(stopIndex > 0): gridCopy = gridCopy.slice(0, stopIndex)
	
	var randIndex = randi_range(0, gridCopy.size()-1)
	
	var cellToCollapse = gridCopy[randIndex]
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
			#if(((num + GridWidth) > grid.size() - 1) || grid[num + GridWidth].isSolid()):
			#goodToMoveDown = false



func collapseIndex(_index):
	var collapsedCell = grid[_index]
	collapsedCell.collapse()
	var cellTile = collapsedCell.getTile()

	var topIndex = _index - dimensions;
	var bottomIndex = _index + dimensions;
	var rightIndex = _index + 1;
	var leftIndex = _index - 1;
	
	print('current index ' + str(_index))
	print('top index ' + str(topIndex))
	print('bottom index ' + str(bottomIndex))
	print('left index ' + str(leftIndex))
	print('right index ' + str(rightIndex))
	
	
	if(topIndex > 0):
		grid[topIndex].eliminateOptions(collapsedCell.getTile().upperSiblings)
	
	if(bottomIndex < grid.size()):
		grid[bottomIndex].eliminateOptions(collapsedCell.getTile().lowerSiblings)
		
	if((rightIndex % dimensions) != 0):
		grid[rightIndex].eliminateOptions(collapsedCell.getTile().rightSiblings)
		grid[rightIndex].printOptions()
	
	if((leftIndex % dimensions + 1) != 0):
		grid[leftIndex].eliminateOptions(collapsedCell.getTile().leftSiblings)


#	for g in grid:
#		print(str(g.options.size()))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_down")):
		entropy()
		


#Create a Square for the grid using un.gd
func createCell(_position):
	var node = cell.new()
	#node.texture = squareTexture
	node.set_script(load("res://cell.gd"))
	add_child(node)
	node.position = _position
	node.options = tileSet.duplicate()
	node.totalOptions = tileSet.duplicate()
	node.collapsed = false
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
