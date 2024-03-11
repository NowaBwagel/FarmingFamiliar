extends Node2D

@export var player_warehouse: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	MobileAds.initialize()
	
	#await get_tree().physics_frame
	#_on_load_banner_pressed()

var _banner_ad_view : AdView
func destroy_banner_ad_view():
	if _banner_ad_view:
		_banner_ad_view.destroy()
		_banner_ad_view = null
func _create_banner_adview() -> void:
	if _banner_ad_view:
		destroy_banner_ad_view()
	
	var unit_id : String
	if OS.get_name() == "Android":
		unit_id = "ca-app-pub-3940256099942544/6300978111"
	
	if unit_id:
		var adaptive_size := AdSize.get_current_orientation_anchored_adaptive_banner_ad_size(AdSize.FULL_WIDTH)
		_banner_ad_view = AdView.new(unit_id, adaptive_size, AdPosition.Values.TOP)
	else:
		print_debug("Can't display ad on %s" % [OS.get_name()])

func _on_load_banner_pressed():
	if _banner_ad_view == null:
		_create_banner_adview()
	if _banner_ad_view:
		var ad_request := AdRequest.new()
		_banner_ad_view.load_ad(ad_request)

func register_ad_listener() -> void:
	if _banner_ad_view != null:
		var ad_listener := AdListener.new()

		ad_listener.on_ad_failed_to_load = func(load_ad_error : LoadAdError) -> void:
			print("_on_ad_failed_to_load: " + load_ad_error.message)
		ad_listener.on_ad_clicked = func() -> void:
			print("_on_ad_clicked")
		ad_listener.on_ad_closed = func() -> void:
			print("_on_ad_closed")
		ad_listener.on_ad_impression = func() -> void:
			print("_on_ad_impression")
		ad_listener.on_ad_loaded = func() -> void:
			print("_on_ad_loaded")
		ad_listener.on_ad_opened = func() -> void:
			print("_on_ad_opened")

		_banner_ad_view.ad_listener = ad_listener
