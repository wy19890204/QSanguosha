-- translation for SP Package

return {
	["sp"] = "SP",

	["#yangxiu"] = "恃才放旷",
	["yangxiu"] = "杨修",
	
	["jilei"] = "鸡肋",
	["danlao"] = "啖酪",
	[":jilei"] = "每当你受到伤害时，你可以说出一种牌的类别，令伤害来源不能使用、打出或弃置其此类别的手牌，直到回合结束。\
◆你对角色发动【鸡肋】说出一种牌的类别，该角色在执行技能效果或在弃牌阶段弃置手牌时，非该类别的手牌数不足，则该角色须弃置全部非该类别的手牌并展示剩余的该类别的手牌。",
	[":danlao"] = "当一张锦囊牌指定包括你在内的多名目标后，你可以摸一张牌，若如此做，此锦囊牌对你无效。",
	["$jilei1"] = "食之无肉，弃之有味。",
	["$jilei2"] = "曹公之意，我已了然。",
	["$danlao1"] = "我喜欢～",
	["$danlao2"] = "来来，一人一口～",
	["~yangxiu"] = "我故自已死之晚也。",
	
	["cv:yangxiu"] = "官方",
	["#DanlaoAvoid"] = "%from 发动了技能【%arg2】， %arg 对他无效",
	["#Jilei"] = "%from 鸡肋了 %to 的 %arg",
	["#JileiClear"] = "%from 的鸡肋效果消失",

	["#gongsunzan"] = "白马将军",
	["gongsunzan"] = "公孙瓒",
	
	["yicong"] = "义从",
	[":yicong"] = "<b>锁定技</b>，若你当前的体力值大于2，你计算的与其他角色的距离-1；若你当前的体力值小于或等于2，其他角色计算的与你的距离+1。",
	["$yicong1"] = "冲啊！",
	["$yicong2"] = "众将听令，摆好阵势，御敌！",
	["~gongsunzan"] = "我军将败，我已无颜苟活于世",

	["#yuanshu"] = "仲家帝",
	["yuanshu"] = "袁术",
	
	["yongsi"] = "庸肆",
	[":yongsi"] = "<b>锁定技</b>，摸牌阶段，你额外摸等同于现存势力数的牌；弃牌阶段开始时，你须弃置等同于现存势力数的牌。",
	["weidi"] = "伪帝",
	[":weidi"] = "<b>锁定技</b>，你拥有当前主公的主公技",
      ["$yongsi1"] = "玉玺在手，天下我有！",
	["$yongsi2"] = "大汉天下已半入我手！",
      ["$weidi1"] = "我才是皇帝！",
	["$weidi2"] = "你们都得听我的号令！",
	["~yuanshu"] = "可恶，就差一步了……",
	["#YongsiGood"] = "%from 的技能【%arg2】被触发，额外摸了 %arg 张牌",
	["#YongsiBad"] = "%from 的技能【%arg2】被触发，须弃置 %arg 张牌",
	["#YongsiWorst"] = "%from 的技能【%arg2】被触发，弃置了所有的装备和手牌（共 %arg 张）",

	["#sp_guanyu"] = "汉寿亭侯",
	["sp_guanyu"] = "SP关羽",
	
	["danji"] = "单骑",
	[":danji"] = "<b>觉醒技</b>，回合开始阶段，若你的手牌数大于你当前的体力值，且本局主公为曹操时，你须减1点体力上限并永久获得技能“马术”。",
	["#DanjiWake"] = "%from 的手牌数(%arg)多于体力值(%arg2)，且本局主公为曹操，触发【单骑】",
      ["$danji"] = "吾兄待我甚厚，誓以共死，今往投之，望曹公见谅。",
	  ["$DanjiAnimate"] = "anim=skill/danji",
	 
	["sp_diaochan"] = "SP貂蝉",
	["&sp_diaochan"] = "貂蝉",

	["cv_diaochan:convert"] = "你可以替换为SP貂蝉或台版貂蝉或国战貂蝉",
	["cv_diaochan:sp_diaochan"] = "SP",
	["cv_diaochan:tw_diaochan"] = "台湾版",
	["cv_diaochan:heg_diaochan"] = "国战版",

	["#sp_sunshangxiang"] = "梦醉良缘",
	["sp_sunshangxiang"] = "SP孙尚香",
	["&sp_sunshangxiang"] = "孙尚香",
	
	["cv_sunshangxiang:convert"] = "你可以替换为蜀势力SP孙尚香",

	["#sp_pangde"] = "抬榇之悟",
	["sp_pangde"] = "SP庞德",
	["&sp_pangde"] = "庞德",
	
	["cv_pangde:convert"] = "你可以替换为魏势力SP庞德",

	["#sp_caiwenji"] = "金璧之才",
	["sp_caiwenji"] = "SP蔡文姬",
	["&sp_caiwenji"] = "蔡文姬",
	
	["cv_caiwenji:convert"] = "你可以替换为魏势力SP蔡文姬",

	["#sp_machao"] = "西凉的猛狮",
	["sp_machao"] = "SP马超",
	["&sp_machao"] = "马超",

	["cv_machao:convert"] = "你可以替换为群雄势力SP马超或台版马超",
	["cv_machao:sp_machao"] = "SP",
	["cv_machao:tw_machao"] = "台湾版",

	["#sp_jiaxu"] = "算无遗策",
	["sp_jiaxu"] = "SP贾诩",
	["&sp_jiaxu"] = "贾诩",
	
	["cv_jiaxu:convert"] = "你可以替换为魏势力SP贾诩",

	["sp_zhenji"] = "SP甄姬",
	["&sp_zhenji"] = "甄姬",
	
	["cv_zhenji:convert"] = "你可以替换为SP甄姬或台版甄姬或国战甄姬",
	["cv_zhenji:heg_zhenji"] = "国战版",
	["cv_zhenji:tw_zhenji"] = "台湾版",
	["cv_zhenji:sp_zhenji"] = "SP",

	["tw_diaochan"] = "台版貂蝉",
	["&tw_diaochan"] = "貂蝉",
	

	["tw_yuanshu"] = "台版袁术",
	["&tw_yuanshu"] = "袁术", 
	["cv_yuanshu:convert"] = "你可以替换为台版袁术",
	

	["tw_zhaoyun"] = "台版赵云",
	["&tw_zhaoyun"] = "赵云", 
	
	["cv_zhaoyun:convert"] = "你可以替换为台版赵云",

	["tw_daqiao"] = "台版大乔",
	["&tw_daqiao"] = "大乔", 
	
	["cv_daqiao:convert"] = "你可以替换为王战大乔或台版大乔",
	["cv_daqiao:wz_daqiao"] = "王战版",
	["cv_daqiao:tw_daqiao"] = "台湾版",

	["tw_zhenji"] = "台版甄姬",
	["&tw_zhenji"] = "甄姬", 
	

	["tw_machao"] = "台版马超",
	["&tw_machao"] = "马超", 


	["tw_ganning"] = "台版甘宁",
	["&tw_ganning"] = "甘宁", 
	
	["cv_ganning:convert"] = "你可以替换为台版甘宁",

	["tw_lvbu"] = "台版吕布",
	["&tw_lvbu"] = "吕布", 
	
	["cv_lvbu:convert"] = "你可以替换为国战吕布或台版吕布",
	["cv_lvbu:heg_lvbu"] = "国战版",
	["cv_lvbu:tw_lvbu"] = "台湾版",

	["wz_daqiao"] = "王战大乔",
	["&wz_daqiao"] = "大乔", 
	

	["wz_xiaoqiao"] = "王战小乔",
	["&wz_xiaoqiao"] = "小乔", 
	
	["cv_xiaoqiao:convert"] = "你可以替换为王战小乔或国战小乔",
	["cv_xiaoqiao"] = "SP替换",
	["cv_xiaoqiao:wz_xiaoqiao"] = "王战版",
	["cv_xiaoqiao:heg_xiaoqiao"] = "国战版",

	-- Hegemony SP
	["hegemony_sp"] = "国战SP",

	["sp_heg_zhouyu"] = "国战SP周瑜",
	["&sp_heg_zhouyu"] = "周瑜",
	
	["cv_zhouyu:convert"] = "你可以替换为国战周瑜或国战SP周瑜",
	["cv_zhouyu"] = "SP替换",
	["cv_zhouyu:heg_zhouyu"] = "国战版",
	["cv_zhouyu:sp_heg_zhouyu"] = "国战SP版",
	
	["sp_convert"] = "SP替换",
	
      ["#caohong"] = "福将",
	["caohong"] = "曹洪",
	
	["yuanhu"] = "援护",
	[":yuanhu"] = "回合结束阶段开始时，你可以将一张装备牌置于一名角色的装备区里，然后根据此装备牌的种类执行以下效果。\
武器牌：弃置与该角色距离为1的一名角色区域中的一张牌；\
防具牌：该角色摸一张牌；\
坐骑牌：该角色回复一点体力。",
	["@yuanhu-equip"] = "请使用技能【援护】",
	["~yuanhu"] = "选择一张装备牌→选择一名角色→点击确定",
	["$yuanhu1"] = "持吾兵戈，随我杀敌！", --武器
	["$yuanhu2"] = "汝今势微，吾当助汝。", --防具
	["$yuanhu3"] = "公急上马，洪敌贼军！", --坐骑
	["$yuanhu4"] = "天下可无洪，不可无公。", --对曹操
	["$yuanhu5"] = "持戈整兵，列阵御敌！", --对自己
	["~caohong"] = "主公已安，洪纵死亦何惜……", 
	
	["#guanyinping"] = "武姬",
	["guanyinping"] = "关银屏",
	
	["xueji"] = "血祭",
	[":xueji"] = "出牌阶段，你可以弃置一张红色牌，对你攻击范围内的至多X名其他角色各造成1点伤害，然后这些角色各摸一张牌。X为你损失的体力值。每阶段限一次。",
	["huxiao"] = "虎啸",
	[":huxiao"] = "你于出牌阶段每使用一张【杀】被【闪】抵消，此阶段你可以额外使用一张【杀】。",
	["wuji"] = "武继",
	[":wuji"] = "<b>觉醒技</b>，回合结束阶段开始时，若本回合你已造成3点或更多伤害，你须加1点体力上限并回复1点体力，然后失去技能“虎啸”。",
	["$xueji1"] = "踏平南土，以消国恨",
	["$xueji2"] = "陷坚摧锋，以报家仇",
	["$huxiao1"] = "若无后手，何言为将？",
	["$huxiao2"] = "刀行如流水，杀你个措手不及！",
	["$huxiao3"] = "紫髯老贼！还吾父命来！",              -- for sunquan
	["$wuji"] = "武圣虽死，血脉尚存。先父佑我，再现武魂！",
	
       ["$WujiAnimate"] = "anim=skill/wuji",
	["~guanyinping"] = "父亲……",
	
	["#xiahouba"] = "棘途壮志",
	["xiahouba"] = "夏侯霸",
	
	["baobian"] = "豹变",
	[":baobian"] = "<b>锁定技</b>，若你的体力值为3或更少，你视为拥有技能“挑衅”;若你的体力值为2或更少;你视为拥有技能“咆哮”;若你的体力值为1，你视为拥有技能“神速”。",
       ["$baobian1"] = "无胆匪类，可敢一战！",--（挑衅）
	["$baobian2"] = "血染征袍，愈战愈勇！",--（咆哮）
	["$baobian3"] = "残躯搏命，速战速决！",--（神速）
	["~xiahouba"] = "居魏难保魏，投蜀难保蜀~我好恨……",
	
	["#chenlin"] = "破竹之咒",
	["chenlin"] = "陈琳",
	
	["bifa"] = "笔伐",
	[":bifa"] = "回合结束阶段开始时，你可以将一张手牌背面朝下移出游戏并选择一名其他角色。该角色的回合开始时，其观看此牌并选择一项：1、交给你一张与此牌同类别的手牌，然后获得此牌。2、将此牌置入弃牌堆，然后失去1点体力。\
◆在目标角色执行【笔伐】的效果前，你不可以再次对其发动【笔伐】。\
◆目标角色在执行【笔伐】的效果前死亡，在弃置其区域里所有的牌的同时将此牌置入弃牌堆。",
	["@bifa-remove"] = "你可以发动【笔伐】",
	["~bifa"] = "选择一张手牌→选择一名其他角色→点击确定",
	["@bifa-give"] = "请交给目标角色一张类型相同的手牌",
	["songci"] = "颂词",
	[":songci"] = "出牌阶段，你可以选择一项：1、令一名手牌数小于其当前的体力值的角色摸两张牌。2、令一名手牌数大于其当前的体力值的角色弃置两张牌。每名角色每局游戏限一次。",
	["@songci"] = "颂词",
	["$bifa1"] = "文人岂无用，笔墨亦作兵。",
	["$bifa2"] = "将军可否直视此言？",                   --get
	["$bifa3"] = "行文如刀，笔墨诛心，",                 --throw
	["$songci1"] = "广宜恩信，班扬符赏。",               --drawCards
	["$songci2"] = "汝众违旅叛，当有此报！",             --discardCards
	["~chenlin"] = "文未达意，贼不伏诛，吾之过也……",
	
	["#lingju"] = "情随梦逝",
	["lingju"] = "灵雎",
	
	["jieyuan"] = "竭缘",
	[":jieyuan"] = "当你对一名其他角色造成伤害时，若其体力值大于或等于你的体力值，你可弃置一张黑色手牌令此伤害+1；当你受到一名其他角色造成的伤害时，若其体力值大于或等于你的体力值，你可弃置一张红色手牌令此伤害-1",
	["@JieyuanIncrease"] = "你可以弃一张黑色手牌令此伤害+1",
	["@JieyuanDecrease"] = "你可以弃一张红色手牌令此伤害-1",
	["#JieyuanIncrease"] = "%from 发动了技能【竭缘】，伤害点数从 %arg 点增加至 %arg2 点",
	["#JieyuanDecrease"] = "%from 发动了技能【竭缘】，伤害点数从 %arg 点减少至 %arg2 点",
	
	["fenxin"] = "焚心",
	[":fenxin"] = "<b>限定技</b>，当你杀死一名非主公角色时，在其翻开身份牌之前，你可以与该角色交换身份牌。（你的身份为主公时不能发动此技能。）",
	["@burnheart"] = "焚心",
	["$jieyuan1"] = "权谋一世，剑指曹贼！",
	["$jieyuan2"] = "虽有谋，亦有情。",
	["$fenxin"] = "天下与我何干？",
	["$FenxinAnimate"] = "天下与我何干？",
	["~lingju"] = "魏王……",
	["$FenxinAnimate"] = "anim=skill/fenxin",
	
--hulao mode
	["Hulaopass"] = "虎牢关模式",

	["#shenlvbu1"] = "最强神话",
	["shenlvbu1"] = "虎牢关吕布",
	["&shenlvbu1"] = "最强神话",
	["#shenlvbu2"] = "暴怒的战神",
	["shenlvbu2"] = "虎牢关吕布",
	["&shenlvbu2"] = "暴怒的战神",
	["xiuluo"] = "修罗",
	[":xiuluo"] = "回合开始阶段开始时，你可以弃置一张手牌，若如此做，你弃置你判定区里的一张与你弃置手牌同花色的延时类锦囊牌。",
	["@xiuluo"] = "请弃置一张花色相同的手牌",
	["shenwei"] = "神威",
	[":shenwei"] = "<b>锁定技</b>，摸牌阶段，你额外摸两张牌；你的手牌上限+2。",
	["shenji"] = "神戟",
	[":shenji"] = "若你的装备区没有武器牌，当你使用【杀】时，你可以额外选择至多两个目标。",

	["#Reforming"] = "%from 进入重整状态",
	["#ReformingRecover"] = "%from 在重整状态中回复了1点体力",
	["#ReformingDraw"] = "%from 在重整状态中摸了1张牌",
	["#ReformingRevive"] = "%from 从重整状态中复活!",
	["draw_1v3"] = "重整摸牌",
	["weapon_recast"] = "武器重铸",
	["Hulaopass:recover"] = "恢复1点体力",
	["Hulaopass:draw"] = "摸1张牌",
	
	["$xiuluo"] = "哼！鬼蜮伎俩，休想阻我！",
	["$shenwei"] = "飞将之威，上天亦知！",
	["$shenji"] = "神戟在手，何人能及！",
	["~shenlvbu2"] = "什么？我败了？！",

--sp_card
	["sp_cards"] = "SP卡牌包",
	["SPMoonSpear"] = "SP银月枪",
	[":SPMoonSpear"] = "装备牌·武器\
攻击范围：３\
武器特效：你的回合外，每当你使用或打出一张黑色手牌时，你可以令你攻击范围内的一名其他角色打出一张【闪】，否则受到你对其造成的1点伤害",
	["@moon-spear-jink"] = "受到SP银月枪技能的影响，你必须打出一张【闪】",
	}
