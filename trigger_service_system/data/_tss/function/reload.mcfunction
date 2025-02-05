# 重新载入函数，也会在安装时被执行，用于重新读入并创建自定义命令实例

#已安装检测
scoreboard objectives add tssInstalledCheck dummy
execute store success score #reload tssInstalledCheck run scoreboard players reset #null tssGloCtir
execute if score #reload tssInstalledCheck matches 0 run return run function tss:install_check_failed

#主要行为
#删除所有触发器
function tss:triggers_delete
#清空命令池
data modify storage tss:main {}.cmds set value []
#调用函数标签从所有扩展收集需要注册的自定义命令
function #tss:add_cmd
#创建所有触发器
function tss:triggers_create
#播报消息
tellraw @s [{"text":"[触发器服务系统] 已重新载入"}]