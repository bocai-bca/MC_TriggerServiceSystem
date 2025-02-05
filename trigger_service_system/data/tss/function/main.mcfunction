# 主循环，遍历每个自定义命令

execute as @a unless score @s tssPermission matches ..2147483647 run scoreboard players set @s tssPermission 0
data modify storage tss:main {}.target_list set from storage tss:main {}.cmds
execute if data storage tss:main {}.target_list[0] run function tss:foreach_cmds