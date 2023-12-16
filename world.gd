# 扩展自Node2D，表示这是一个基于Node2D节点的自定义类
extends Node2D

# 使用@onready关键字延迟加载TileMap和Camera2D节点，当场景树准备好时会初始化这些变量
@onready var tile_map: TileMap = $TileMap
@onready var camera_2d: Camera2D = $Player/Camera2D

# _ready函数在节点加入场景树并准备好时被调用
func _ready() -> void:
	# 获取瓦片地图已使用的矩形区域
	var used := tile_map.get_used_rect().grow(-1)
	# 获取瓦片地图中单个瓦片的尺寸
	var tile_size := tile_map.tile_set.tile_size
	
	# 设置摄像机的移动限制，根据瓦片地图的使用范围来设置
	camera_2d.limit_top = used.position.y * tile_size.y
	camera_2d.limit_right = used.end.x * tile_size.x
	camera_2d.limit_bottom = used.end.y * tile_size.y
	camera_2d.limit_left = used.position.x * tile_size.x

	# 重置摄像机的平滑移动设置
	camera_2d.reset_smoothing()
