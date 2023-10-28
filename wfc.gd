extends Node2D
class_name wfc

@export var tileSet: Array[tile] = []
@export var dimensions = 5
@export var spacing = 24

var grid = []

@export var generationSpeed: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	for t in tileSet:
		t.getAllSiblings()
	generateGrid()
	entropy()
	
func entropy():
	#Sorted Grid
	var gridCopy = grid.duplicate()
	
	var cellsToDelete = []
	for g in gridCopy:
		if(g.collapsed || g.cellTile != null):
			cellsToDelete.push_back(g)
			
	gridCopy.sort_custom(func(a, b): return a.options.size() < b.options.size())
	
	for g in cellsToDelete:
		gridCopy.erase(g)
	
	if(gridCopy.size() == 0):
		print('Wave Function Collapse Completed')
		return
	
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
	
	if(generationSpeed > 0): await get_tree().create_timer(generationSpeed).timeout
	entropy()

func collapseIndex(_index):
	var collapsedCell = grid[_index]
	collapsedCell.collapse()
	var cellTile = collapsedCell.getTile()



	#Eliminate Options of siblings based off of our position of siblings.
	#To Make this 3rd Dimensional we will need to include 2 more sibling arrays from above/below
	var topIndex = _index - dimensions;
	var bottomIndex = _index + dimensions;
	var rightIndex = _index + 1;
	var leftIndex = _index - 1;
	
#	#Debugger	
#	print('current index ' + str(_index))
#	print('top index ' + str(topIndex))
#	print('bottom index ' + str(bottomIndex))
#	print('left index ' + str(leftIndex))
#	print('right index ' + str(rightIndex))
	
	if(topIndex >= 0):
		grid[topIndex].eliminateOptions(collapsedCell.getTile().upperSiblings)
		#grid[topIndex].printOptions()
	
	if(bottomIndex < grid.size()):
		grid[bottomIndex].eliminateOptions(collapsedCell.getTile().lowerSiblings)
		#grid[bottomIndex].printOptions()
		
	if((rightIndex % dimensions) != 0):
		grid[rightIndex].eliminateOptions(collapsedCell.getTile().rightSiblings)
		#grid[rightIndex].printOptions()
	
	if((leftIndex % dimensions + 1) != 0):
		grid[leftIndex].eliminateOptions(collapsedCell.getTile().leftSiblings)
		#grid[leftIndex].printOptions()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	#Debugger
#	if(Input.is_action_just_pressed("ui_down")):
#		entropy()
	pass

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
