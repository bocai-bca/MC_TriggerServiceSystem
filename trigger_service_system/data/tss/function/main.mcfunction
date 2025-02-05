# 主循环，遍历每个自定义命令

data modify storage tss:main {}.target_list set from storage tss:main {}.cmds
execute if data storage tss:main {}.target_list[0] run function tss:foreach_cmds