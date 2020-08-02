extends Node2D

const Wall = preload("res://scenes/Wall.tscn")
const Grid = preload("res://scripts/Grid.gd")
const MazeGen = preload("res://scripts/MazeGeneration.gd")

export var wall_half_step = 30
export var wall_thickness = 0.8
export var wall_size = 6.7
var maze_width: int = 12
var maze_height: int = 4


signal maze_regenerated(new_size)


func _ready():
    regenerate()
    

func recenter_walls():
    """
    center maze in (0, 0)
    """
    var msize = maze_pixel_size()
    self.position = -msize / 2.0 + Vector2(wall_thickness, wall_thickness)


func maze_pixel_size() -> Vector2:
    var width = _pos_on_walls(maze_width) + wall_thickness * 2
    var height = _pos_on_walls(maze_height) + wall_thickness * 2
    return Vector2(width, height)


func regenerate():
    """
    Generate new maze
    """
    _remove_walls()
    maze_width += 1
    maze_height += 1
    var grid = Grid.new(maze_width, maze_height)
    MazeGen.new().gen_maze(grid)
    grid.print_grid()
    self._generate_walls(grid)
    emit_signal("maze_regenerated", maze_pixel_size()) 
    recenter_walls()
    

func _remove_walls():
    for node in self.get_children():
        remove_child(node)
        node.queue_free()
    

func _input(event):
    if event is InputEventMouseButton:
        var mouse_event := event as InputEventMouseButton
        if mouse_event.pressed:
            regenerate()


func _generate_walls(grid: Grid):
    for x in range(grid.width):
        var wall = Wall.instance()
        wall.position = Vector2(_pos_between_walls(x), 0)
        wall.scale = Vector2(wall_size, wall_thickness)
        self.add_child(wall)
    
    for y in range(grid.height):
        var left_wall = Wall.instance()
        left_wall.position = Vector2(0, _pos_between_walls(y))
        left_wall.scale = Vector2(wall_thickness, wall_size)
        self.add_child(left_wall)

        for x in range(grid.width):
            if grid.has_wall(x, y, Grid.Cell.Direction.East):
                var wall = Wall.instance()
                wall.position = Vector2(_pos_on_walls(x+1), _pos_between_walls(y))
                wall.scale = Vector2(wall_thickness, wall_size)
                self.add_child(wall)
            if grid.has_wall(x, y, Grid.Cell.Direction.South):
                var wall = Wall.instance()
                wall.position = Vector2(_pos_between_walls(x), _pos_on_walls(y+1))
                wall.scale = Vector2(wall_size, wall_thickness)
                self.add_child(wall)


func _pos_between_walls(x):
    return wall_half_step + wall_half_step * 2 * x


func _pos_on_walls(x):
    return wall_half_step * 2 * (x)
