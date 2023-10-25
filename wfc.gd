extends Node2D
class_name wfc

@export var tileSet: Array[tile] = []
@export var dimensions = 20
@export var spacing = 24

var grid = []



# Called when the node enters the scene tree for the first time.
func _ready():
	generateGrid()
	


func entropy():
	
	#Sorted Grid
	#if(fullRows.size() > 1): fullRows.sort_custom(func(a, b): return a[0] > b[0])
	
	
	var index = -1
	for i in grid:
		index += 1
		if(grid[i].collapsed == true):
			continue
		else:
			print(index)
			#if(((num + GridWidth) > grid.size() - 1) || grid[num + GridWidth].isSolid()):
			#goodToMoveDown = false


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
	node.collapseCell(tileSet[0])
	
	return node
	
func generateGrid():
	#generate a cell for every dimension
	for w in dimensions:
		for h in dimensions:
			var x = w * spacing
			var y = h * spacing
			
			var node = createCell(Vector2(x, y))
			grid.push_back(node)
	
