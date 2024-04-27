extends Node

class_name Enums

enum ZIndex {
    EntityAir = 20,
    EntityGround = 10,
    Props = 0,
    Terrain = -10,
}

enum MonsterType {
    None = 0, # I hate this but in GDScript enums can't be nulls and there aren't any sum types like in rust so this is all we can do
    Sheep,
    Imp,
    Chupacapra,
    Watcher,
    Chtulu,
}
