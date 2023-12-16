# 定义一个名为StateMachine的类，继承自Node节点
class_name StateMachine
extends Node

const KEEP_CURRENT = -1

# 定义一个表示当前状态的变量，初始值为-1
var current_state: int = -1:
	set(v):
		# 当状态改变时，调用owner对象的transition_state方法来处理状态转换
		owner.transition_state(current_state, v)
		# 更新当前状态
		current_state = v
		# 重置状态持续时间
		state_time = 0

# 状态持续时间
var state_time: float

# 当节点准备好时执行
func _ready() -> void:
	# 等待owner对象的ready信号
	await owner.ready
	# 初始化当前状态为0
	current_state = 0

# 每个物理帧调用
func _physics_process(delta: float) -> void:
	while true:
		# 获取下一个状态
		var next := owner.get_next_state(current_state) as int
		# 如果当前状态与下一个状态相同，则退出循环
		if next == KEEP_CURRENT:
			break
		# 更新当前状态为下一个状态
		current_state = next

	# 调用owner对象的tick_physics方法，传入当前状态和时间增量delta
	owner.tick_physics(current_state, delta)
	# 累加状态持续时间
	state_time += delta
