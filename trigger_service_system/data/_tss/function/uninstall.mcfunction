# 卸载函数，只能在已安装的情况下执行

#已安装检测
scoreboard objectives add tssInstalledCheck dummy
execute store success score #uninstall tssInstalledCheck run scoreboard players reset #null tssGloCtir
execute if score #uninstall tssInstalledCheck matches 0 run return run function tss:install_check_failed

#主要行为
#删除所有触发器
function tss:triggers_delete
#删除权限表
scoreboard objectives remove tssPermission
#删除全局容器
scoreboard objectives remove tssGloCtir
#删除存储
data remove storage tss:main {}.target_list
data remove storage tss:main {}.cmds
data remove storage tss:main {}.scoreboards
data remove storage tss:main {}.target_cmd
#播报消息
tellraw @s [{"text":"[触发器服务系统] 已卸载TSS并删除相关数据\n  (由扩展包产生的数据不受TSS核心管理，因此它们不会被删除)"}]