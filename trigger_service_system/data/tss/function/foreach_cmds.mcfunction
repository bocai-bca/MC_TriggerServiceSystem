execute store result score #permission_require tssGloCtir run data get storage tss:main {}.target_list[0].permission
execute as @a run function tss:player/check_cmd with storage tss:main {}.target_list[0]

#迭代控制
data remove storage tss:main {}.target_list[0]
execute if data storage tss:main {}.target_list[0] run function tss:foreach_cmds