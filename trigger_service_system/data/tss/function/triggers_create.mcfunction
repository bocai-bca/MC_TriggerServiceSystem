# 遍历命令池所有自定义命令并为它们进行触发器创建，同时将记分项名添加到记分项列表

data modify storage tss:main {}.target_list set from storage tss:main {}.cmds
execute if data storage tss:main {}.target_list[0] run function tss:triggers_create_do with storage tss:main {}.target_list[0]