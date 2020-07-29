enum Direction{
    North=1,
    South=2,
    West =4,
    East =8,
}

var walls = 0

func _init(wall: int):
    self.walls = wall

func set_wall(wall: int):
    self.walls |= wall

func has_wall(wall: int):
    return self.walls & wall
