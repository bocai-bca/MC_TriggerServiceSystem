# 安装函数，只能执行一次

#已安装检测
execute if score #installed tssGloCtir matches 1 run return run tellraw @s [{"text":"","color":"red"},{"text":"[触发器服务系统] 无法在已安装TSS的存档中再次安装TSS\n  如需重装请先执行卸载函数\n    "},{"text":"/function _tss:uninstall","underlined":true,"clickEvent":{"action":"suggest_command","value":"/function _tss:uninstall"}},{"text":"\n  如需重新载入扩展包请执行\n    "},{"text":"/function _tss:reload","underlined":true,"clickEvent":{"action":"suggest_command","value":"/function _tss:reload"}}]

#主要行为
#创建记分板
scoreboard objectives add tssGloCtir dummy
scoreboard players set #installed tssGloCtir 1
#创建权限表
function tss:permission_create
#构建存储结构
data modify storage tss:main {} merge value {target_list:[],target_cmd:{cmd:"",permission:0,function:""},cmds:[],scoreboards:[]}
#删除所有触发器
function tss:triggers_delete
#清空命令池
data modify storage tss:main {}.cmds set value []
#调用函数标签从所有扩展收集需要注册的自定义命令
function #tss:add_cmd
#创建所有触发器
function tss:triggers_create
#播报消息
tellraw @s ["",{"text":"[触发器服务系统] 已安装TSS"}]