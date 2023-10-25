extends Resource
class_name tile


@export var title: String

@export var tileScene: PackedScene

@export var filePath: String
@export var fileType: String

@export var upperSiblingPaths: Array[String] = []
@export var lowerSiblingPaths: Array[String] = []
@export var rightSiblingPaths: Array[String] = []
@export var leftSiblingPaths: Array[String] = []


var upperSiblings: Array[tile] = []
var lowerSiblings: Array[tile] = []
var rightSiblings: Array[tile] = []
var leftSiblings: Array[tile] = []


func getAllSiblings():
	getResourceFromPath(upperSiblingPaths, upperSiblings)
	getResourceFromPath(lowerSiblingPaths, lowerSiblings)
	getResourceFromPath(rightSiblingPaths, rightSiblings)
	getResourceFromPath(leftSiblingPaths, leftSiblings)

func getResourceFromPath(_paths, _arrSiblings):
	for path in _paths:
		var imported_resource = load(filePath + path + fileType)
		_arrSiblings.push_back(imported_resource)
	
	

