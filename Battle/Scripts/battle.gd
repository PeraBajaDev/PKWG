class_name BattleSystem
extends Node

@export var move_buttons: MoveButtons
@export var pokemon_foe_resource: PokemonResource
@export var pokemon_user_resource: PokemonResource
@onready var pokemon_foe: BattlePokemon = BattlePokemon.new(pokemon_foe_resource)
@onready var pokemon_user: BattlePokemon = BattlePokemon.new(pokemon_user_resource)


func _ready() -> void:
	move_buttons.player_move_selected.connect(resolve_turn)
	await get_tree().create_timer(0.2).timeout
	move_buttons.set_buttons_texts(pokemon_user.moves)


func resolve_turn(move_name: String) -> void:
	var by_name := func(move: MoveResource) -> bool: return move.name == move_name
	var user_move: MoveResource = pokemon_user.moves.filter(by_name).front()
	var foe_move: MoveResource = pokemon_foe.moves.pick_random()

	var turn_order: Array[Turn] = []
	turn_order.assign(
		[
			Turn.new(pokemon_user, pokemon_foe, user_move),
			Turn.new(pokemon_foe, pokemon_user, foe_move),
		],
	)
	var by_priority_then_speed := func(a: Turn, b: Turn) -> bool:
		if a.move.priority == b.move.priority and a.attacker.speed == b.attacker.speed:
			return [true, false].pick_random()
		if a.move.priority == b.move.priority:
			return a.attacker.speed < b.attacker.speed

		return a.move.priority < b.move.priority

	turn_order.sort_custom(by_priority_then_speed)
	for turn: Turn in turn_order:
		var move: MoveResource = turn.move
		var attacker: BattlePokemon = turn.attacker
		var target: BattlePokemon = turn.target
		move.effect.apply(target, attacker, move, self)
	print_info()


class Turn:
	var target: BattlePokemon
	var attacker: BattlePokemon
	var move: MoveResource


	func _init(_target: BattlePokemon, _attacker: BattlePokemon, _move: MoveResource) -> void:
		self.target = _target
		self.attacker = _attacker
		self.move = _move


func print_info() -> void:
	print(
		"health user: ",
		pokemon_user.current_health_points,
		" health foe: ",
		pokemon_foe.current_health_points,
	)
	print(
		"power points user: ",
		pokemon_user.current_power_points,
		"power  points foe: ",
		pokemon_foe.current_power_points,
	)
