extends Resource
class_name tile


@export var title: String #Helpful for debugging purposes

@export var tileScene: PackedScene #Your tile scene goes here.

@export var filePath: String #Your filepath to your tile resources goes here.
@export var fileType: String #Your file type of the tile resources goes here.

#To Make this 3rd Dimensional we will need to include 2 more sibling/neighbors arrays from above/below
#The upper/lower & right/left could be renamed to north/east/south/west
#TODO: Rename variables & Include 3rd Dimension
@export var upperSiblingPaths: Array[String] = []
@export var lowerSiblingPaths: Array[String] = []
@export var rightSiblingPaths: Array[String] = []
@export var leftSiblingPaths: Array[String] = []

var upperSiblings: Array[tile] = []
var lowerSiblings: Array[tile] = []
var rightSiblings: Array[tile] = []
var leftSiblings: Array[tile] = []

#Grabs Siblings From Resources
#Can't directly set the sibling resource as an @export as it will cause a circular reference expection/infinite loop 
func getAllSiblings():
	getResourceFromPath(upperSiblingPaths, upperSiblings)
	getResourceFromPath(lowerSiblingPaths, lowerSiblings)
	getResourceFromPath(rightSiblingPaths, rightSiblings)
	getResourceFromPath(leftSiblingPaths, leftSiblings)

#Grabs Siblings From Resources
func getResourceFromPath(_paths, _arrSiblings):
	for path in _paths:
		var imported_resource = load(filePath + path + fileType)
		_arrSiblings.push_back(imported_resource)
	
	

