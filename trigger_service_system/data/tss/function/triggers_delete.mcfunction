# 遍历记分项列表所有触发器记分项并删除

data modify storage tss:main {}.target_list set from storage tss:main {}.scoreboards
execute if data storage tss:main {}.target_list[0] run function tss:triggers_delete_do with storage tss:main {}.target_list[0]