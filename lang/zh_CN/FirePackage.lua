-- translation for FirePackage

return {
	["fire"] = "火包",

	["#xunyu"] = "王佐之才",
	["xunyu"] = "荀彧",
	["quhu"] = "驱虎",
	[":quhu"] = "出牌阶段，你可以与一名体力比你多的角色拼点。若你赢，则该角色对其攻击范围内你选择的另一名角色造成1点伤害。若你没赢，则其对你造成1点伤害。每阶段限一次。\
◆你拼点赢后，如果在目标角色的攻击范围内，可以令目标角色对你造成1点伤害。",
	["#QuhuNoWolf"] = "%from 对 %to 拼点赢，但是由于 %to 的攻击范围内没有其他角色，所以结算中止",
	["jieming"] = "节命",
	[":jieming"] = "每当你受到1点伤害后，你可以令一名角色将手牌补至X张（X为该角色的体力上限且至多为5）。",
	["jieming:yes"] = "您可令任意一名角色将手牌补至其体力上限的张数（不能超过5张）",
	["@jieming"] = "是否发动技能【节命】",
	["~jieming"] = "选择一个角色→点击确定按钮",

	["#dianwei"] = "古之恶来",
	["dianwei"] = "典韦",
	["qiangxi"] = "强袭",
	[":qiangxi"] = "出牌阶段，你可以失去1点体力或弃置一张武器牌，对你攻击范围内的一名角色造成1点伤害。每阶段限一次。",

	["#wolong"] = "卧龙",
	["wolong"] = "小诸葛",
	["bazhen"] = "八阵",
	[":bazhen"] = "<b>锁定技</b>，若你的装备区没有防具牌，视为你装备着【八卦阵】。",
	["bazhen:yes"] = "发动自带的【八卦阵】",
	["huoji"] = "火计",
	[":huoji"] = "你可以将一张红色手牌当【火攻】使用。",
	["kanpo"] = "看破",
	[":kanpo"] = "你可以将一张黑色手牌当【无懈可击】使用。",

	["#pangtong"] = "凤雏",
	["pangtong"] = "庞统",
	["lianhuan"] = "连环",
	[":lianhuan"] = "你可以将一张梅花手牌当【铁索连环】使用或重铸。",
	["niepan"] = "涅槃",
	[":niepan"] = "<b>限定技</b>，当你处于濒死状态时，你可以：弃置你区域里所有的牌，然后将你的武将牌翻至正面朝上并重置之，再摸三张牌且体力回复至3点。\
◆弃置你区域里所有的牌是你发动【涅槃】执行的效果而非消耗。",
	["@nirvana"] = "涅槃",
	["niepan:yes"] = "弃置你区域里所有的牌，然后摸三张牌且体力回复至3点（一局游戏仅可使用一次）",

	["#taishici"] = "笃烈之士",
	["taishici"] = "太史慈",
	["tianyi"] = "天义",
	[":tianyi"] = "出牌阶段，你可以与一名其他角色拼点。若你赢，你获得以下技能直到回合结束：你使用【杀】时无距离限制；可以额外使用一张【杀】；使用【杀】时可以额外选择一个目标。若你没赢，你不能使用【杀】，直到回合结束。每阶段限一次。",

	["#yuanshao"] = "高贵的名门",
	["yuanshao"] = "袁绍",
	["luanji"] = "乱击",
	[":luanji"] = "你可以将两张花色相同的手牌当【万箭齐发】使用。",
	["xueyi"] = "血裔",
	[":xueyi"] = "<b>主公技</b>，<b>锁定技</b>，每有一名其他群雄角色存活，你的手牌上限便+2。",

	["#yanliangwenchou"] = "虎狼兄弟",
	["yanliangwenchou"] = "颜良文丑",
	["shuangxiong"] = "双雄",
	[":shuangxiong"] = "摸牌阶段开始时，你可以放弃摸牌，改为进行一次判定，你获得生效后的判定牌，然后你可以将一张与此判定牌颜色不同的手牌当【决斗】使用，直到回合结束。",
	["shuangxiong:yes"] = "选择放弃摸牌并进行一次判定：获得此判定牌并且此回合可以将任意一张与该判定牌不同颜色的手牌当【决斗】使用",

	["#pangde"] = "人马一体",
	["pangde"] = "庞德",
	["mengjin"] = "猛进",
	[":mengjin"] = "当你使用的【杀】被目标角色的【闪】抵消时，你可以弃置其一张牌。",
	["mengjin:yes"] = "你可以弃置对方的一张牌",

	["$bazhen1"] = "你可识得此阵？",
	["$bazhen2"] = "太极生两仪，两仪生四象，四象生八卦。",
	["$huoji1"] = "燃烧吧！",
	["$huoji2"] = "此火可助我军大获全胜。",
	["$jieming1"] = "秉忠贞之志，守谦退之节。",
	["$jieming2"] = "我，永不背弃！",
	["$kanpo1"] = "雕虫小技。",
	["$kanpo2"] = "你的计谋被识破了。",
	["$lianhuan1"] = "伤一敌，可连其百。",
	["$lianhuan2"] = "统统连起来吧。",
	["$luanji1"] = "弓箭手，准备放箭！",
	["$luanji2"] = "全都去死吧！",
	["$niepan"] = "凤雏岂能消亡\
浴火重生！",
	["$niepan1"] = "浴火重生！",
	["$niepan2"] = "凤雏岂能消亡",
	["$NiepanAnimate"] = "anim=skill/niepan",
	["$qiangxi1"] = "吃我一戟！",
	["$qiangxi2"] = "看我三步之内取你小命！",
	["$quhu1"] = "此乃驱虎吞狼之计。",
	["$quhu2"] = "借你之手与他一搏吧。",
	["$tianyi1"] = "我当要替天行道！",
	["$tianyi2"] = "请助我一臂之力！",
	["$mengjin1"] = "你！可敢挡我？",
	["$mengjin2"] = "我要杀你们个片甲不留！",
	["$shuangxiong1"] = "吾乃河北上将颜良（文丑）是也。",
	["$shuangxiong2"] = "快与我等决一死战！",

	["~pangtong"] = "看来，我命中注定将丧命于此。",
	["~wolong"] = "我的计谋竟被……",
	["~dianwei"] = "主公，快走！",
	["~xunyu"] = "主公要臣死，臣不得不死！",
	["~yuanshao"] = "老天不助我袁家呀！",
	["~taishici"] = "大丈夫，当带三尺之剑，立不世之功！",
	["~pangde"] = "四面都是水，我命休矣……",
	["~yanliangwenchou"] = "这红脸长须大将是？",

	
}

