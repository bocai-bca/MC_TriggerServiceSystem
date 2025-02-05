$data modify storage tss:main {}.scoreboards append value {trigger:"$(cmd)"}
$scoreboard objectives add $(cmd) trigger

#迭代控制
data remove storage tss:main {}.target_list[0]
execute if data storage tss:main {}.target_list[0] run function tss:triggers_create_do with storage tss:main {}.target_list[0]