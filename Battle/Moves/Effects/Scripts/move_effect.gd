class_name MoveEffect
extends Resource

func apply(_pokemon_target: BattlePokemon, _pokemon_user: BattlePokemon, _move: MoveResource, _battle_system: BattleSystem) -> void:
	push_error("Trying to call from base class")
