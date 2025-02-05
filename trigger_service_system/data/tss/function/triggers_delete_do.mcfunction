$scoreboard objectives remove $(trigger)

#迭代控制
data remove storage tss:main {}.target_list[0]
execute if data storage tss:main {}.target_list[0] run function tss:triggers_delete_do with storage tss:main {}.target_list[0]