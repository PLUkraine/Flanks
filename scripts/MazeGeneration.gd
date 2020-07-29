extends Node2D

const Cell = preload("res://scripts/Cell.gd")

export var width = 5
export var height = 4
var grid: Array

# Called when the node enters the scene tree for the first time.
func _ready():
    grid = []
    for y in range(height):
        var row = []
        row.resize(width)
        for x in range(width):
            row[x] = Cell.new(_get_walls(x, y))
        grid.append(row)
    
    _print_grid()
        
func _print_grid():
    var result = "+"
    for x in width:
        result += "-+"
        
    for y in height:
        result += "\n|"
        for x in width:
            result += " "
            if grid[y][x].has_wall(Cell.Direction.East):
                result += "|"
            else:
                result += " "
        result += "\n+"
        for x in width:
            if grid[y][x].has_wall(Cell.Direction.South):
                result += "-"
            else:
                result += " "
            result += "+"
    print(result)

func _get_walls(x, y):
    var walls = 0
    if x == 0: walls |= Cell.Direction.West
    if y == 0: walls |= Cell.Direction.North
    if x == width-1: walls |= Cell.Direction.East
    if y == height-1: walls |= Cell.Direction.South
    return walls
