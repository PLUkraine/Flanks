extends Node2D

const Wall = preload("res://scenes/Wall.tscn")
const Grid = preload("res://scripts/Grid.gd")
const MazeGen = preload("res://scripts/MazeGeneration.gd")

var wall_half_step = 60
var wall_size = 13


func _ready():
    var grid = Grid.new(10, 6)
    MazeGen.new().gen_maze(grid)
    grid.print_grid()
    self.generate_walls(grid)


func generate_walls(grid: Grid):
    for x in range(grid.width):
        var wall = Wall.instance()
        wall.position = Vector2(_pos_between_walls(x), 0)
        wall.scale = Vector2(wall_size, 1)
        self.add_child(wall)
    
    for y in range(grid.height):
        var left_wall = Wall.instance()
        left_wall.position = Vector2(0, _pos_between_walls(y))
        left_wall.scale = Vector2(1, wall_size)
        self.add_child(left_wall)

        for x in range(grid.width):
            if grid.has_wall(x, y, Grid.Cell.Direction.East):
                var wall = Wall.instance()
                wall.position = Vector2(_pos_on_walls(x+1), _pos_between_walls(y))
                wall.scale = Vector2(1, wall_size)
                self.add_child(wall)
            if grid.has_wall(x, y, Grid.Cell.Direction.South):
                var wall = Wall.instance()
                wall.position = Vector2(_pos_between_walls(x), _pos_on_walls(y+1))
                wall.scale = Vector2(wall_size, 1)
                self.add_child(wall)


func _pos_between_walls(x):
    return wall_half_step + wall_half_step * 2 * x


func _pos_on_walls(x):
    return wall_half_step * 2 * (x)
