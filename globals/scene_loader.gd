extends Node

signal load_finished

var loading_screen : PackedScene = preload("uid://cqsf10t1k7svg")
var _loaded_scene : PackedScene
var scene_path : String
var status : Array[bool]

var scene_cache : Dictionary[String, Node]
var current_scene : Node
var previous_scene_path : String

func _ready() -> void:
	set_process(false)
	
func _process(_delta: float) -> void:
	var load_status : int = ResourceLoader.load_threaded_get_status(scene_path, status)
	match load_status :
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			_loaded_scene = ResourceLoader.load_threaded_get(scene_path)
			swap_scene_nodes(_loaded_scene.instantiate())
			load_finished.emit()
			set_process(false)
			scene_cache.set(scene_path, current_scene)
			print("scene cached : " + scene_path + "    |   " + str(current_scene))
	
func load_scene(_scene_path : String, hard : bool = false) -> void :
	if hard :
		scene_cache.erase(_scene_path)
	previous_scene_path = scene_path
	scene_path = _scene_path
	print("loading scene: " + scene_path)
	var load_screen : LoadingScreen = loading_screen.instantiate()
	add_child(load_screen)
	load_finished.connect(load_screen.on_load_finished)
	
	await load_screen.loading_screen_ready
	start_load()

func start_load() -> void:
	if scene_cache.has(scene_path) :
		print(scene_path + "  Restored from cache")
		swap_scene_nodes(scene_cache[scene_path])
		load_finished.emit()
		return
		
	var state : int = ResourceLoader.load_threaded_request(scene_path, "", false)
	if state == OK:
		set_process(true)

func swap_scene_nodes(new_scene : Node) -> void:
	if new_scene == current_scene :
		return
	get_tree().root.add_child(new_scene)
	if current_scene :
		get_tree().root.remove_child(current_scene)
	current_scene = new_scene

func load_previous() -> void :
	load_scene(previous_scene_path)
	
func play_animation() -> void :
	var load_screen : LoadingScreen = loading_screen.instantiate()
	add_child(load_screen)
	await load_screen.loading_screen_ready
	load_screen.on_load_finished()