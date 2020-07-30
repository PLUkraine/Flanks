extends Node2D

const Cell = preload("res://scripts/Cell.gd")
const Grid = preload("res://scripts/Grid.gd")

export var width = 5
export var height = 4
var grid: Grid

func _ready():
    grid = Grid.new(width, height)
    grid.add_wall(3, 0, Cell.Direction.North | Cell.Direction.East)
    grid.print_grid()

