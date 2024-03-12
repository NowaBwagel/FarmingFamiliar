@tool
extends Area2D

@export var item_protoset:ItemProtoset
@export var item_id: String:
	set(value):
		if item_protoset and item_protoset.has_prototype(value):
			item_id = value
			var texture: Texture = load(item_protoset.get_prototype_property(item_id, "image"))
			if sprite:
				remove_child(sprite)
				sprite.queue_free()
			sprite = Sprite2D.new()
			sprite.texture = texture
			add_child(sprite)
			item = InventoryItem.new()
			item.protoset = item_protoset
			item.prototype_id = item_id
			item.set_property("stack_size", randi_range(2,5))

var sprite:Sprite2D
var item: InventoryItem

func _take_item() ->InventoryItem:
	return item
