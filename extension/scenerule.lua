dofile "lua/sgs_ex.lua"
module("extensions.scenerule", package.seeall)
extension = sgs.Package("scenerule")

scene={}

scene.turncount = 0
scene.effectIdList = {}
scene.effectFunc  = {}
scene.effectClear = {}

-- 双杀: 你的杀可额外指定一个目标
shuangshakedi = sgs.CreateTargetModSkill{
	name = "shuangshakedi",
	pattern = "Slash",
	extra_target_func = function(self, player)
		if player:hasSkill(self:objectName()) then
			return 1
		end
	end,
}

--  强击: 你的杀无距离限制
qiangjiliwei = sgs.CreateTargetModSkill{
	name = "qiangjiliwei",
	pattern = "Slash",
	distance_limit_func = function(self, player)
		if player:hasSkill(self:objectName()) then
			return 1000
		end
	end,
}

-- 普渡众生: 所有已受伤的角色回复1血， 没受伤的角色摸2牌
puduzhongsheng = sgs.CreateTriggerSkill{
	name = "#puduzhongsheng",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do
			if p:isWounded() then
				local recover = sgs.RecoverStruct()
				recover.who = p
				room:recover(p, recover, true)
			else
				p:drawCards(2,true)
			end
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 厄运当头:  所有人流失1点体力
eyundangtou = sgs.CreateTriggerSkill{
	name = "#eyundangtou",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		for _, p in sgs.qlist(room:getAlivePlayers()) do
			room:loseHp(p)
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 阳光普照： 所有人摸1牌
yangguangpuzhao = sgs.CreateTriggerSkill{
	name = "#yangguangpuzhao",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			p:drawCards(1,true)
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 多多益善:  所有人随机摸 2~5 牌
duoduoyishan = sgs.CreateTriggerSkill{
	name = "#duoduoyishan",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			p:drawCards(math.random(2, 5),true)
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 有难同当:  所有人都用铁锁连起来
younantongdang = sgs.CreateTriggerSkill{
	name = "#younantongdang",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			room:setPlayerProperty(p, "chained", sgs.QVariant(true))
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 年年有余:  手牌上限 +2
niannianyouyu=sgs.CreateMaxCardsSkill{
	name="#niannianyouyu",
	extra_func=function(self, player)
		if not player:hasSkill(self:objectName()) then return 0 end
		return 2
	end
}

-- 缴械归公:  所有人弃置装备区的所有装备牌
jiaoxieguigong = sgs.CreateTriggerSkill{
	name = "#jiaoxieguigong",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			p:throwAllEquips()
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 养精蓄锐:  所有手牌数不小于体力数且正面朝上的角色，摸1牌并翻面
yangjingxurui = sgs.CreateTriggerSkill{
	name = "#yangjingxurui",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			if p:getHandcardNum() >= p:getHp() and p:faceUp() then
				p:turnOver() 
				p:drawCards(1,true)
				room:getThread():delay(333)
			end			
		end
		return false
	end,
}

-- 瞬息万变:  所有人弃置所有手牌，并摸取等量的牌
shunxiwanbian = sgs.CreateTriggerSkill{
	name = "#shunxiwanbian",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do
			local n = p:getHandcardNum()
			p:throwAllHandCards()			
			p:drawCards(n,true)
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 顺手牵羊: 所有人须获取下家一张牌
xunshouqianyang = sgs.CreateTriggerSkill{
	name = "#xunshouqianyang",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do
			local target = p:getNextAlive()
			if not target:isAllNude() then
				local card_id = room:askForCardChosen(p, target, "hej", "scenerule")				
				room:obtainCard(p, card_id, room:getCardPlace(card_id) ~= sgs.Player_Hand)
				room:getThread():delay(333)
			end			
		end
		return false
	end,
}

-- 饮酒并醉: 所有人出牌阶段开始时，视为他对自己使用了一张酒
yinjiubingzui = sgs.CreateTriggerSkill{
	name = "#yinjiubingzui",
	events = {sgs.EventPhaseStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase()==sgs.Player_Play then
			local analeptic=sgs.Sanguosha:cloneCard("analeptic", sgs.Card_NoSuit, 0)
			local use = sgs.CardUseStruct()
			use.from = player
			use.to:append(player)
			use.card = analeptic
			room:useCard(use, true)
		end
		return false
	end,
}

-- 弹尽粮绝:  所有人回合结算阶段结束后， 须弃置两手牌，不足就弃装备
danjinliangjue = sgs.CreateTriggerSkill{
	name = "#danjinliangjue",
	events = {sgs.EventPhaseEnd},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Finish and not player:isNude() then
			if player:getHandcardNum() >=2 then
				room:askForDiscard(player, "scenerule", 2, 2, false, false)
			else
				room:askForDiscard(player, "scenerule", 2, 2, false, true)
			end
		end
		return false
	end,
}

-- 蓄势待发:  所有人跳过出牌和弃牌阶段
xushidaifa = sgs.CreateTriggerSkill{
	name = "#xushidaifa",
	events = {sgs.EventPhaseChanging},
	priority = -1,
	on_trigger = function(self, event, player, data)		
		local change = data:toPhaseChange()
		local room = player:getRoom()
		if change.to == sgs.Player_Play    and not player:isSkipped(sgs.Player_Play)    then  player:skip(sgs.Player_Play) end
		if change.to == sgs.Player_Discard and not player:isSkipped(sgs.Player_Discard) then  player:skip(sgs.Player_Discard) end
		room:getThread():delay(800)
		return false
	end,
}

-- 颜色考试: 摸牌阶段结束后，可猜1个颜色并进行判定，猜对就获得判定牌，可猜5次
yansekaoshi = sgs.CreateTriggerSkill{
	name = "#yansekaoshi",
	events = {sgs.EventPhaseEnd, sgs.AskForRetrial, sgs.FinishJudge},
	priority = 3,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseEnd and player:getPhase() == sgs.Player_Draw then
			for i = 1, 5, 1 do				
				local color = room:askForChoice(player, "scenerule", "red+black")
				local log= sgs.LogMessage()
				log.type = "#ChooseColor"
				log.from = player
				log.arg = color
				room:sendLog(log)

				local judge = sgs.JudgeStruct()
				local regexp = color == "red" and "(.*):(heart|diamond):(.*)" or "(.*):(spade|club):(.*)"
				judge.pattern = sgs.QRegExp(regexp)
				judge.good = true
				judge.reason = self:objectName()
				judge.who = player
				judge.time_consuming = true
				room:judge(judge)				
			end
		end
		if event == sgs.FinishJudge then
			local judge = data:toJudge()
			if judge.reason == self:objectName() and judge:isGood() then 
				player:obtainCard(judge.card)
			end
		end
		--禁止任何人(包括自己)，更改此次的判定牌
		if event == sgs.AskForRetrial then			
			return true
		end
		return false
	end,
}

-- 智商捉鸡： 所有人须展示一张锦囊牌，否则流失1体力
zhishangzhuoji = sgs.CreateTriggerSkill{
	name = "#zhishangzhuoji",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end
		for _, p in sgs.qlist(room:getAlivePlayers()) do
			local card = room:askForCard(p, "TrickCard", "@trickcard", sgs.QVariant(), sgs.Card_MethodNone)
			if card then	
				room:showCard(p, card:getId())
			else
				room:loseHp(p)	
			end			
			room:getThread():delay(700)
		end
		return false
	end,
}

-- 见者有份: 当前回合角色摸取和场上存活人数等量的牌，然后其他人各抽取其1牌
jianzheyoufen = sgs.CreateTriggerSkill{
	name = "#jianzheyoufen",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		player:drawCards(player:aliveCount(), true)
		for _, p in sgs.qlist(room:getOtherPlayers(player)) do
			local card_id = room:askForCardChosen(p, player, "h", "scenerule")				
			room:obtainCard(p, card_id, false)
			room:setEmotion(p, "draw-card")
			room:getThread():delay(333)
		end
		return false
	end,
}

-- 落井下石：任何人受到伤害后需要弃置1手牌，没手牌就弃装备
luojingxiashi = sgs.CreateTriggerSkill{
	name = "#luojingxiashi",
	events = {sgs.Damaged},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:isNude() then return false end
		room:getThread():delay(500)
		if player:getHandcardNum() >= 1 then
			room:askForDiscard(player, "scenerule", 1, 1, false, false)
		else
			room:askForDiscard(player, "scenerule", 1, 1, false, true)
		end	
		return false
	end,
}


-- 大赦天下:  清空所有角色判定区,解除所有角色铁锁,翻面等异常状况
dashetianxia = sgs.CreateTriggerSkill{
	name = "#dashetianxia",
	events = {sgs.TurnStart},
	priority = -1,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner() 
		if player:objectName() ~= starter:objectName() then return false end

		for _, p in sgs.qlist(room:getAlivePlayers()) do			
			if not p:getJudgingArea():isEmpty() then
				local reason=sgs.CardMoveReason()
				reason.m_reason   = sgs.CardMoveReason_S_REASON_NATURAL_ENTER
				reason.m_playerId = p:objectName()
				reason.m_targetId = p:objectName()
				for _, card in sgs.qlist(p:getJudgingArea()) do
					room:throwCard(card, reason, nil) 
				end	
			end
			if not p:faceUp() then p:turnOver() end
			if p:isChained() then room:setPlayerProperty(p, "chained", sgs.QVariant(false)) end			
			room:getThread():delay(333)
		end
		return false
	end,
}

local skillList=sgs.SkillList()
if not sgs.Sanguosha:getSkill("shuangshakedi") then skillList:append(shuangshakedi) end
if not sgs.Sanguosha:getSkill("qiangjiliwei") then skillList:append(qiangjiliwei) end
if not sgs.Sanguosha:getSkill("#yangguangpuzhao") then skillList:append(yangguangpuzhao) end
if not sgs.Sanguosha:getSkill("#eyundangtou") then skillList:append(eyundangtou) end
if not sgs.Sanguosha:getSkill("#puduzhongsheng") then skillList:append(puduzhongsheng) end
if not sgs.Sanguosha:getSkill("#younantongdang") then skillList:append(younantongdang) end
if not sgs.Sanguosha:getSkill("#duoduoyishan") then skillList:append(duoduoyishan) end
if not sgs.Sanguosha:getSkill("#niannianyouyu") then skillList:append(niannianyouyu) end
if not sgs.Sanguosha:getSkill("#jiaoxieguigong") then skillList:append(jiaoxieguigong) end
if not sgs.Sanguosha:getSkill("#yangjingxurui") then skillList:append(yangjingxurui) end
if not sgs.Sanguosha:getSkill("#shunxiwanbian") then skillList:append(shunxiwanbian) end
if not sgs.Sanguosha:getSkill("#xunshouqianyang") then skillList:append(xunshouqianyang) end
if not sgs.Sanguosha:getSkill("#yinjiubingzui") then skillList:append(yinjiubingzui) end
if not sgs.Sanguosha:getSkill("#danjinliangjue") then skillList:append(danjinliangjue) end
if not sgs.Sanguosha:getSkill("#xushidaifa") then skillList:append(xushidaifa) end
if not sgs.Sanguosha:getSkill("#yansekaoshi") then skillList:append(yansekaoshi) end
if not sgs.Sanguosha:getSkill("#zhishangzhuoji") then skillList:append(zhishangzhuoji) end
if not sgs.Sanguosha:getSkill("#jianzheyoufen") then skillList:append(jianzheyoufen) end
if not sgs.Sanguosha:getSkill("#luojingxiashi") then skillList:append(luojingxiashi) end
if not sgs.Sanguosha:getSkill("#dashetianxia") then skillList:append(dashetianxia) end
sgs.Sanguosha:addSkills(skillList)

function attachSkillsToPlayers(room, skill_list)
	local skills = skill_list:split("|")
	for _,skill in ipairs(skills) do
		if sgs.Sanguosha:getSkill(skill) then
			for _, p in sgs.qlist(room:getPlayers()) do
				if p:hasSkill(skill) then
					room:setPlayerMark(p, "has_" .. skill, 1)
				else
					room:acquireSkill(p, skill)
				end
			end
		end
	end
end

function detachSkillsFromPlayers(room, skill_list)
	local skills = skill_list:split("|")
	for _,skill in ipairs(skills) do
		if sgs.Sanguosha:getSkill(skill) then
			for _, p in sgs.qlist(room:getPlayers()) do
				if p:getMark("has_" .. skill) > 0 then
					room:setPlayerMark(p, "has_" .. skill, 0)
				else
					room:detachSkillFromPlayer(p, skill)
				end
			end
		end
	end
end

local index = 0
function getIndex()
	index = index + 1
	return index
end

local sceneData = {}

sceneData[getIndex()] = {"墨守陈规", "", "本轮场景无效果"}
sceneData[getIndex()] = {"不动如山", "weimu|yizhong", '所有角色获得技能 "帷幕, 毅重"'}
sceneData[getIndex()] = {"崩坏无谋", "benghuai|wumou", '所有角色获得技能 "崩坏, 无谋"'}
sceneData[getIndex()] = {"英姿飒爽", "yingzi", '所有角色获得技能 "英姿"'}
sceneData[getIndex()] = {"闭月羞花", "biyue", '所有角色获得技能 "闭月"'}
sceneData[getIndex()] = {"近在咫尺", "mashu", '所有角色获得技能 "马术"'}
sceneData[getIndex()] = {"遥不可及", "feiying", '所有角色获得技能 "飞影"'}
sceneData[getIndex()] = {"安恤人言", "anxu", '所有角色获得技能 "安恤"'}
sceneData[getIndex()] = {"无情之谷", "jueqing", '所有角色获得技能 "绝情"'}
sceneData[getIndex()] = {"烽火连天", "zonghuo", '所有角色获得技能 "纵火"'}
sceneData[getIndex()] = {"百发百中", "liegong", '所有角色获得技能 "烈弓"'}
sceneData[getIndex()] = {"明哲保身", "mingzhe", '所有角色获得技能 "明哲"'}
sceneData[getIndex()] = {"谁能挡我", "wushuang", '所有角色获得技能 "无双"'}
sceneData[getIndex()] = {"阵前挑衅", "tiaoxin", '所有角色获得技能 "挑衅"'}
sceneData[getIndex()] = {"以逸待劳", "wuyan", '所有角色获得技能 "无言"'}
sceneData[getIndex()] = {"咆哮之怒", "paoxiao", '所有角色获得技能 "咆哮"'}
sceneData[getIndex()] = {"无计可施", "noswuyan", '所有角色获得技能 "旧无言"'}
sceneData[getIndex()] = {"知己知彼", "dongcha", '所有角色获得技能 "洞察"'}
sceneData[getIndex()] = {"双杀克敌", "shuangshakedi", "所有角色的【杀】可额外指定一个目标"}
sceneData[getIndex()] = {"强击立威", "qiangjiliwei", "所有角色的【杀】无视距离"}
sceneData[getIndex()] = {"普渡众生", "#puduzhongsheng", "所有受伤角色回复1点体力，没受伤的角色摸两牌"}
sceneData[getIndex()] = {"厄运当头", "#eyundangtou", "所有角色流失1点体力"}
sceneData[getIndex()] = {"阳光普照", "#yangguangpuzhao", "所有角色摸一张牌"}
sceneData[getIndex()] = {"多多益善", "#duoduoyishan", "所有角色随机摸2~5张牌"}
sceneData[getIndex()] = {"有难同当", "#younantongdang", "所有角色横置武将牌"}
sceneData[getIndex()] = {"年年有余", "#niannianyouyu", "所有角色手牌上限+2"}
sceneData[getIndex()] = {"缴械归公", "#jiaoxieguigong", "所有角色须弃置装备区的所有装备牌"}
sceneData[getIndex()] = {"养精蓄锐", "#yangjingxurui", "所有手牌数不小于体力值且武将牌正面朝上的角色将武将牌翻面并摸一牌"}
sceneData[getIndex()] = {"瞬息万变", "#shunxiwanbian", "所有角色弃置所有手牌，然后摸取等量的牌"}
sceneData[getIndex()] = {"顺手牵羊", "#xunshouqianyang", "所有角色可获得下家一张牌"}
sceneData[getIndex()] = {"饮酒并醉", "#yinjiubingzui", "所有角色出牌阶段开始时，视其对自己使用一张酒"}
sceneData[getIndex()] = {"弹尽粮绝", "#danjinliangjue", "当所有角色回合结束阶段结束后，须弃置两张牌"}
sceneData[getIndex()] = {"蓄势待发", "#xushidaifa", "所有角色跳过其出牌阶段和弃牌阶段"}
sceneData[getIndex()] = {"颜色考试", "#yansekaoshi", "所有角色摸牌阶段结束后猜测1种颜色并进行1次判定，若猜对则将判定牌收为手牌，可猜测5次"}
sceneData[getIndex()] = {"智商拙计", "#zhishangzhuoji", "所有角色须依次展示一张锦囊牌，否则流失一点体力"}
sceneData[getIndex()] = {"见者有份", "#jianzheyoufen", "当前角色摸取和当前存活角色数量等量的牌，其他角色依次抽取其一张手牌"}
sceneData[getIndex()] = {"落井下石", "#luojingxiashi", "任何角色受到伤害后须弃置1牌"}
sceneData[getIndex()] = {"大赦天下", "#dashetianxia", "清空所有角色判定区,解除所有角色铁锁,翻面等异常状况"}



for i = 1, #sceneData, 1 do
	scene.effectFunc[i] = function(room, id)
		local skills = sceneData[i][2]
		if skills ~= "" then
			attachSkillsToPlayers(room, skills)
			scene.effectClear[id] = function(room)
				detachSkillsFromPlayers(room, skills)
			end
		end
	end
	sgs.LoadTranslationTable {["scene_" .. i] = sceneData[i][1], ["scene_" .. i .. "_effect"] = sceneData[i][3]}
end

for i = 1, 999, 1 do
	scene.effectIdList[i] = math.random(1, #sceneData)   --随机
	--scene.effectIdList[i] = (i % #sceneData) + 1       --顺序
end

scenerule = sgs.CreateTriggerSkill{
	name = "#scenerule",
	events = {sgs.TurnStart, sgs.Death},
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local starter = room:getLord() or room:getOwner()    --国战模式可能会没有lord

		if #sceneData == 0 or player:objectName() ~= starter:objectName() then return false end

		local clearEffect = function()
			local effectid = scene.effectIdList[scene.turncount]
			local clear_func = scene.effectClear[effectid]
			if effectid then
				local log= sgs.LogMessage()
				log.type = "#SceneFinished"
				log.arg = "scene_" .. effectid
				room:sendLog(log)
			end
			if type(clear_func) == "function" then clear_func(room, effectid) end			
		end	

		if event == sgs.TurnStart then
			clearEffect()
			scene.turncount = scene.turncount + 1
			
			effectid = scene.effectIdList[scene.turncount]
			local effect_func = scene.effectFunc[effectid]
			if type(effect_func) == "function" then
				local effect_text = "scene_" .. effectid .. "_effect"
				local log= sgs.LogMessage()
				log.type = "#SceneChanged"
				log.arg = "scene_" .. effectid
				log.arg2 = effect_text
				room:sendLog(log)				
				room:broadcastInvoke("animate", string.format("lightbox:%s:2222", effect_text))
				room:getThread():delay(1000)	
				effect_func(room, effectid)
				player:speak(sgs.Sanguosha:translate(effect_text))
			end
		end
		
		if event == sgs.Death then 
			local death = data:toDeath()
			if death.who:objectName() == player:objectName() then clearEffect() end
		end

		return false
	end,
}


if not sgs.Sanguosha:getSkill("#scenerule") then
	local skillList=sgs.SkillList()
	skillList:append(scenerule)
	sgs.Sanguosha:addSkills(skillList)
end

sgs.LoadTranslationTable {
	["scenerule"] = "随机场景",
	["#SceneFinished"] = "场景 %arg 失效。",
	["#SceneChanged"] = "场景 %arg 生效, %arg2。",

	["shuangshakedi"] ="双杀",
	[":shuangshakedi"] ="你的杀可额外指定一个目标",

	["qiangjiliwei"] ="强击",
	[":qiangjiliwei"] ="你的杀无距离限制",
	
	["yansekaoshi"] = "颜色考试",	
	["#yansekaoshi"] = "颜色考试",	
	["#ChooseColor"] = "%from 选择了颜色 %arg",
	["red"] = "红色",
	["black"] = "黑色",

	["@trickcard"] = "请展示一张锦囊牌",	
}