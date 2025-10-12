class_name MoveResource
extends Resource

enum Category { PHYSIC, SPECIAL, STATUS }

@export var name: String
@export var power: int
@export var power_points_cost: int
@export var description: String
@export var type: TypeResource
@export var category: Category
