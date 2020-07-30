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
            row[x] = Cell.new(_init_walls(x, y))
        grid.append(row)
    
    _add_wall(0, 3, Cell.Direction.South | Cell.Direction.West | Cell.Direction.North)
    
    _print_grid()
    
    
func _generate():
    pass
    

func _add_wall(x: int, y: int, wall: int):
    grid[y][x].add_wall(wall)
    if (wall & Cell.Direction.West) and x > 0:
        grid[y][x-1].add_wall(Cell.Direction.East)
    if (wall & Cell.Direction.East) and x < width-1:
        grid[y][x+1].add_wall(Cell.Direction.West)
    if (wall & Cell.Direction.North) and y > 0:
        grid[y-1][x].add_wall(Cell.Direction.South)
    if (wall & Cell.Direction.South) and y < height-1:
        grid[y+1][x].add_wall(Cell.Direction.North)

        
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


func _init_walls(x, y):
    var walls = 0
    if x == 0: walls |= Cell.Direction.West
    if y == 0: walls |= Cell.Direction.North
    if x == width-1: walls |= Cell.Direction.East
    if y == height-1: walls |= Cell.Direction.South
    return walls
