const Cell = preload("res://scripts/Cell.gd")

var width = 5
var height = 4
var grid: Array


# Called when the node enters the scene tree for the first time.
func _init(width: int, height: int):
    self.width = width
    self.height = height
    self.grid = []
    for y in range(height):
        var row = []
        row.resize(width)
        for x in range(width):
            row[x] = Cell.new(_init_walls(x, y))
        self.grid.append(row)
    
    
func generate():
    pass
    

func add_wall(x: int, y: int, wall: int):
    self.grid[y][x].add_wall(wall)
    if (wall & Cell.Direction.West) and x > 0:
        self.grid[y][x-1].add_wall(Cell.Direction.East)
    if (wall & Cell.Direction.East) and x < width-1:
        self.grid[y][x+1].add_wall(Cell.Direction.West)
    if (wall & Cell.Direction.North) and y > 0:
        self.grid[y-1][x].add_wall(Cell.Direction.South)
    if (wall & Cell.Direction.South) and y < height-1:
        self.grid[y+1][x].add_wall(Cell.Direction.North)

        
func print_grid():
    var result = "+"
    for x in width:
        result += "-+"
        
    for y in height:
        result += "\n|"
        for x in width:
            result += " "
            if self.grid[y][x].has_wall(Cell.Direction.East):
                result += "|"
            else:
                result += " "
        result += "\n+"
        for x in width:
            if self.grid[y][x].has_wall(Cell.Direction.South):
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
