extends Resource

@export var base_health_points: int:
    set(value):
        base_health_points = value if value >= 0 else 0
@export var base_power_points: int:
    set(value):
        base_power_points = value if value >= 0 else 0
@export var base_attack: int:
    set(value):
        base_attack = value if value >= 0 else 0
@export var base_defense: int:
    set(value):
        base_defense = value if value >= 0 else 0
@export var base_special_attack: int:
    set(value):
        base_special_attack = value if value >= 0 else 0
@export var base_special_defense: int:
    set(value):
        base_special_defense = value if value >= 0 else 0
@export var base_speed: int:
    set(value):
        base_speed = value if value >= 0 else 0
