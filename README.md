# 触发器服务系统
## 这是什么？
触发器服务系统(Trigger Service System)，简称TSS，是一个服务于Minecraft Java Edition(后续将简称为MC JE)原版的功能性数据包。基于MC JE的"宏"概念，得以实现自动创建和删除以`trigger`作为准则的记分项(object)。  

主要功能是允许其他数据包通过特定方式向TSS提交记分项(object)注册申请，然后由TSS受理这些注册申请，为它们创建专属的记分项(object)，还提供了卸载功能可以一键删除这些记分项(object)。每个注册申请中需要包含：
1. 名称，待注册的记分项(object)名称
2. 权限，玩家成功触发所需具备的TSS权限等级
3. 函数，触发记分项(object)后执行的函数命名空间ID

同时还提供对玩家使用`/trigger`命令触发这些记分项(object)的侦测，然后以该玩家的身份执行与该记分项(object)所对应的函数。  
综上，本数据包相当于一个用于便利实现原版自定义命令的前置。  
  
TSS设计于面向供几个好友聚会、玩生存的小型原版服务端或不影响原版功能运作的第三方服务端，其开发理念为尽量降低不必要的性能消耗，因而不具备自动纠错功能。例如当发生记分项(object)被人为删除等原因丢失时，TSS不具有主动保护措施。  
虽然已经经过性能优化考量，但刻性能消耗变量仍约为"玩家数量 × 触发器数量"，故不建议在熙攘环境下使用。  

# 如何使用
## 先决条件
再次警告！TSS是面向原版MC服务端设计的，某些第三方服务端可能会对本数据包的运作产生干扰、阻碍甚至引发灾难(比如Paper端会使trigger记分项无法正常运作)。  
请在下载数据包时留意下载说明或文件名是否有表明该文件的版本兼容性是否是只局限在特定版本中的，以免装入了不兼容版本的数据包而导致发生问题。  
## 下载
目前请直接在存储库主页点击"Code">"Download ZIP"，通过下载整个存储库来取得数据包。  
## 导入数据包
怎么把数据包导入MC就不用讲了吧...  
不过需要一提的是，压缩包里具有两个数据包。  
一个叫`trigger_service_system`，这是TSS数据包本体，要使用TSS必须将它导入进存档；  
一个叫`tss_helper`，这是TSS的帮助模块，需要依赖本体运行，它的行为是向TSS本体提交一个注册申请，会往游戏里创建一个`tss.help`触发器，以起到一个用作"显示TSS帮助"的自定义命令的效果。  
`tss_helper`包之所以设计为与本体分离开来，是因为毕竟它注册了一个TSS触发器，只是用于显示帮助信息，这会占用一点性能，而且功能不是很硬性。因此将该包设计一个可选的扩展，让玩家数量较多的服务器能够选择节省掉这一小处性能浪费。  
如果您不需要游戏内帮助信息，则可只导入`trigger_service_system`包。  
  
> TSS本体在`#minecraft:load`时会向`@a` `tellraw`一则消息。
## TSS的使用(面向管理员)
TSS通过放置文件导入进地图之后，需要进行初始化以在该地图中起效，此步骤需要具有管理员权限的玩家或服务器后台控制台进行。通过调用TSS的手动函数(这些函数以`_tss`作为命名空间)，可以要求TSS完成如安装、卸载、重新载入的操作。
> [!NOTE]
> 使用服务器后台控制台执行TSS的手动函数时，您将收不到TSS通过`tellraw @s`发出的成功或报错信息。因此建议您尽量以玩家肉身进入游戏中执行函数。
### TSS安装
是安装，也是初始化步骤。TSS本体数据包和所有要安装的扩展包均已载入地图后(如果您对此有疑问请上网查询Java版数据包的使用方法)，请执行命令`function _tss:install`，随后TSS会在存档中释放TSS的全部组件，并进行一次"TSS载入"。在同一存档中，TSS不可重复安装。通常您不需要重新安装，如果您需要改动扩展包，请见下文"TSS载入"。如果您确定自己一定要重新安装TSS，请在安装之前先进行卸载行为，请见下文"TSS卸载"。
### TSS卸载
卸载TSS也相当于解除安装TSS，该操作适用于您想要将其从存档中移除并将数据抹尽，和重新安装TSS的情况。在载入了TSS本体数据包且TSS处于已安装状态的存档中，执行命令`function _tss:uninstall`，随后TSS会删除所有其登记的触发器记分项(object)，并移除TSS在安装时会释放的全部组件。卸载完成后，您就可以将TSS数据包移出存档了。真是干净又卫生。
### TSS载入
> 懒人概括：就跟用`reload`命令一样用`_tss:reload`函数，只不过后者需要在前者之后。  
**载入是什么以及如何触发**  
TSS载入TSS数据包本体的一个概念，是一部分相关行为的抽象，进行TSS载入时会重新获取注册申请并重新创建触发器记分项(object)。详细描述：TSS本体会从MC存档中已载入所有扩展包中收集注册申请，然后为每则申请创建专属的触发器记分项(object)，同时还会删除旧记分项(object)。  
TSS不会自动进行载入，每次都需要由管理员手动执行，除非您编写个东西使其自动调用`_tss:reload`函数，不过一般不建议，因为应该没有这种需要，而且载入可能具有一定性能耗费(随注册申请数量线性提升)。  
TSS载入可通过手动执行函数`_tss:install`或`_tss:reload`触发(两者载入流程不同，后者更好，但一般不需要关注它们的区别)。  
  
**什么时候该执行TSS载入以及怎样操作**  
情况一 安装TSS时  
在您执行TSS安装函数`_tss:install`时会自动进行一次载入，因此建议您在执行TSS安装之前，先将扩展包也在MC中载入到位，以便TSS在安装完毕时能立即接到工作。  
  
情况二 装入新扩展包时  
当TSS已被安装完成并处于运作状态下，您想要在存档中装入新的扩展包游玩时，需要进行TSS载入。  
先确保扩展包已导入进存档并已被MC载入(如果您是在运行存档的状态下进行的别忘了使用MC的命令`reload`)，然后通过执行函数`_tss:reload`以触发一次TSS载入。  
届时TSS会刷新登记的注册申请表，并为新扩展包创建好它的触发器记分项(object)。  
  
情况三 删改扩展包时(与情况二类似)  
当TSS已被安装完成并处于运作状态下，您想要从存档中移除旧扩展包甚至同时装入新扩展包时，需要进行TSS载入。  
先确保在存档文件夹中已经完成数据包文件的删改，然后在MC里加载存档或游戏内重新载入(`reload`命令)，然后通过执行函数`_tss:reload`以触发一次TSS载入。  
届时TSS会刷新登记的注册申请表，删除已不存在的扩展包的触发器记分项(object)，如果有新扩展包的话会像情况二一样为它创建触发器记分项(object)。  

## TSS的使用(面向玩家)
TSS的使用围绕MC的`trigger`命令，其语法为:  
`trigger <触发器>`  
`trigger <触发器> set <整数>`  
### 使用例
**无参自定义命令**  
假如服务器实现了一个基于TSS的、用来自杀的无参自定义命令叫`kill`，以便让不具备管理员权限的玩家可以进行执行MC的`kill`命令相同的效果。  
该自定义命令不需要接受参数，我们可以进行无参触发，操作如下:  
1. 打开聊天框，输入`/`以进入命令输入状态
2. 输入`trigger kill`
3. 按下回车
然后您就应该"掉出了这个世界"了。  
**有参自定义命令**  
有些基于TSS的自定义命令需要实现高端功能，也可能不高端只不过还是需要玩家输入一个参数，这类自定义命令就是有参自定义命令。  
假如服务器实现了一个基于TSS的、用来获取