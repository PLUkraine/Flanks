extends Camera2D


func _on_Walls_maze_regenerated(new_size):
    # we should preserve original aspect ratio
    # OR resize dat window
    var screen_size = get_viewport_rect().size
    self.zoom = new_size / screen_size
