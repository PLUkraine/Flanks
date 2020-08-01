extends Node2D

const Cell = preload("res://scripts/Cell.gd")
const Grid = preload("res://scripts/Grid.gd")

export var width = 5
export var height = 4
var grid: Grid

func _ready():
    grid = Grid.new(width, height)
    _gen_maze()
    grid.print_grid()
    
func _gen_maze():
    var rng = RandomNumberGenerator.new()
    rng.seed = 42

    var used = Array()
    for y in height:
        var row = []
        row.resize(width)
        used.append(row)
    var start_x = rng.randi_range(0, width-1)
    var start_y = rng.randi_range(0, height-1)
    _gen_rec(rng, used, start_y, start_x, start_y, start_x)
    

func _gen_rec(rng: RandomNumberGenerator, used, y, x, py, px):
    used[y][x] = true
    var directions = [Cell.Direction.West, Cell.Direction.East, Cell.Direction.North, Cell.Direction.South]
    var choises = [[-1,0], [1, 0], [0, -1], [0, 1]]
    while choises:
        var ind = rng.randi_range(0, len(choises)-1)
        var nx = choises[ind][0] + x
        var ny = choises[ind][1] + y
        if _in_b(ny, nx):
            if not used[ny][nx]:
                _gen_rec(rng, used, ny, nx, y, x)
            elif not (px == nx and py == ny):
                grid.add_wall(x, y, directions[ind])
        directions.remove((ind))
        choises.remove(ind)

  
func _in_b(y, x):
    return 0<=y and y<height and 0<=x and x<width
