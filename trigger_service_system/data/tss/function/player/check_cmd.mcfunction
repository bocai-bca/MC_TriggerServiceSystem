$execute if score @s[scores={$(cmd)=..2147483647}] tssPermission >= #permission_require tssGloCtir unless score @s $(cmd) matches 0 at @s run function $(function)
$execute if score @s[scores={$(cmd)=..2147483647}] tssPermission < #permission_require tssGloCtir unless score @s $(cmd) matches 0 run tellraw @s [{"text":"[触发器服务系统] 不能执行\"$(cmd)\"，因为权限不足","color":"red"}]
$scoreboard players reset @s $(cmd)
$scoreboard players enable @s $(cmd)