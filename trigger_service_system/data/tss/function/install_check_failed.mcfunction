# 安装检测失败时被上层函数调用的函数，用于清除检测安装用的临时记分项，并向执行者报告错误消息

execute if score #uninstall tssInstalledCheck matches 0 run tellraw @s [{"text":"","color":"red"},{"text":"[触发器服务系统] 无法在未安装TSS的情况下卸载TSS"}]

execute if score #reload tssInstalledCheck matches 0 run tellraw @s [{"text":"","color":"red"},{"text":"[触发器服务系统] 重新载入适用于已在正常运行中的TSS，当前TSS尚未安装"}]

scoreboard objectives remove tssInstalledCheck