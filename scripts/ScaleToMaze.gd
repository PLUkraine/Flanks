extends Camera2D


func _on_Walls_maze_regenerated(new_size):
    # we should preserve original aspect ratio
    # OR resize dat window
    var screen_size: Vector2 = get_viewport_rect().size
    var aspect = screen_size.x / screen_size.y
    
    var maze_aspect = new_size.x / new_size.y
    var size: Vector2
    if (aspect > maze_aspect):
        # y dominates
        size = Vector2(new_size.y * aspect, new_size.y)
    else:
        # x dominates
        size = Vector2(new_size.x, new_size.x / aspect)
    
    print(size)
    
    self.zoom = size / screen_size
