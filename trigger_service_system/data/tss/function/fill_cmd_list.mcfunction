# 

data modify storage tss:main {}.cmds set value []
function #tss:add_cmds
data modify storage tss:main {}.cmds append value "tss.help"