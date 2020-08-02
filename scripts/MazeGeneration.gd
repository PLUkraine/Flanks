const Cell = preload("res://scripts/Cell.gd")
const Grid = preload("res://scripts/Grid.gd")

    
func gen_maze(grid: Grid, rng_seed: int = 42):
    var rng = RandomNumberGenerator.new()
    rng.seed = rng_seed
    print("Seed = " + str(rng.seed))

    var used = Array()
    for y in grid.height:
        var row = []
        row.resize(grid.width)
        used.append(row)
    var start_x = rng.randi_range(0, grid.width-1)
    var start_y = rng.randi_range(0, grid.height-1)
    _gen_rec(rng, used, grid, start_y, start_x, start_y, start_x)
    

func _gen_rec(
        rng: RandomNumberGenerator,
        used: Array,
        grid: Grid,
        y: int, x: int,
        py: int, px: int):
    used[y][x] = true
    var directions = [Cell.Direction.West, Cell.Direction.East, Cell.Direction.North, Cell.Direction.South]
    var choises = [[-1,0], [1, 0], [0, -1], [0, 1]]
    while choises:
        var ind = rng.randi_range(0, len(choises)-1)
        var nx = choises[ind][0] + x
        var ny = choises[ind][1] + y
        if _in_b(ny, nx, grid.height, grid.width):
            if not used[ny][nx]:
                _gen_rec(rng, used, grid, ny, nx, y, x)
            elif not (px == nx and py == ny):
                grid.add_wall(x, y, directions[ind])
        directions.remove((ind))
        choises.remove(ind)

  
func _in_b(y, x, height, width):
    return 0<=y and y<height and 0<=x and x<width
