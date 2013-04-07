module("extensions.scenemelee", package.seeall)
extension = sgs.Package("scenemelee")

--[[

混战模式： (无主公技, 主公无上限+1福利， 适合4人以及4人以上的身份局)

一：自由对战 ：开局所有人变为内奸，相互残杀，最后一个存活者胜利。

二: 团队混战 ：开局所有人按忠内反平均分为3个阵营，同身份的人为一个阵营， 不同阵营之间相互残杀，最后一个存活的阵营。


]]

function removeWelfare(room, p)	
	for _, askill in sgs.qlist(p:getVisibleSkillList()) do
		if askill:isLordSkill() then room:detachSkillFromPlayer(p, askill:objectName())	end
	end
	if room:hasWelfare(p) then
		room:setPlayerProperty(p, "maxhp", sgs.QVariant(p:getMaxHp() - 1))
		room:setPlayerProperty(p, "hp", sgs.QVariant(p:getMaxHp()))
	end
end

local shuffle=function(arr)
	local count = #arr
	math.randomseed(os.time()+count)
	for i = 1, count do
		local j = math.random( 1, count )
		arr[j], arr[i] = arr[i], arr[j]
	end
	return arr
end

scenemelee = sgs.CreateTriggerSkill{
	name = "#scenemelee",
	events = {sgs.TurnStart, sgs.Death, sgs.GameOverJudge},
	--priority = 1,

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local game_mode = string.lower(room:getMode())
		
		if event == sgs.TurnStart and room:getTag("MeleeGame"):toString() == "" and game_mode:find("[0-9][0-9]p[dz]?$") and game_mode > "03p" and not sgs.GetConfig("EnableHegemony", false) then
			local melee_mode = room:askForChoice(room:getOwner(), "scenemelee", "cancel+freeforall+melee")
			room:setTag("MeleeGame",sgs.QVariant(melee_mode))
			if melee_mode == "cancel" then return false end
			
			room:setTag("SkipNormalDeathProcess", sgs.QVariant(true))
			
			local game_type = melee_mode == "melee" and "#MeleeMode" or "#FreeForAllMode"
			local log= sgs.LogMessage()
			log.type = game_type
			room:sendLog(log)				
			player:speak(sgs.Sanguosha:translate(game_type))
			
			local roles = {}	
			local players = sgs.QList2Table(room:getAllPlayers())

			if melee_mode == "freeforall" then
				for i = 1, #players, 1 do
					table.insert(roles, "renegade")
				end
			end
			
			if melee_mode == "melee" then
				local round = function(num) return math.floor(num + 0.5) end
				local player_count = sgs.Sanguosha:getPlayerCount(room:getMode())
				local loyalist_num =  round(player_count / 2)
				local rebel_num =  round(player_count / 2)
				--local renegade_num = player_count - loyalist_num - rebel_num
				
				for i = 1, loyalist_num, 1 do table.insert(roles, "loyalist") end
				for i = 1, rebel_num, 1 do table.insert(roles, "rebel") end
				--for i = 1, renegade_num, 1 do table.insert(roles, "renegade") end
				roles = shuffle(roles)							
			end

			for i = 1, #players, 1 do
				local p = players[i]
				if p:getRole() == "lord" then removeWelfare(room, p) end				
				p:setRole(roles[i]) 
				room:resetAI(p)
				room:broadcastProperty(p, "role")
			end
			room:updateStateItem()
		end

		if event == sgs.Death or event == sgs.GameOverJudge then
			local melee_mode = room:getTag("MeleeGame"):toString()
			if melee_mode == "cancel" then return false end			

			if event == sgs.Death then
				local death = data:toDeath()
				local victim = death.who
				local killer = death.damage and death.damage.from
				if killer and killer:objectName() == player:objectName() and (melee_mode == "freeforall" or killer:getRole() ~= victim:getRole())  then
					killer:drawCards(3,true)
				end
				if killer and killer:objectName() == player:objectName() and melee_mode == "melee" and killer:getRole() == victim:getRole()  then
					--killer:throwAllHandCardsAndEquips()
				end
			end

			local alives = sgs.QList2Table(room:getAlivePlayers())
			if #alives == 1 then 
				room:gameOver(melee_mode == "melee" and alives[1]:getRole() or alives[1]:objectName()) 
			end
			
			if melee_mode == "melee" then
				local winner_role
				for i = 1, #alives, 1 do
					if not winner_role then winner_role = alives[i]:getRole() end
					if winner_role and winner_role ~= alives[i]:getRole() then return false end
				end
				room:gameOver(winner_role)
			end			
		end

		return false
	end,
}


if not sgs.Sanguosha:getSkill("#scenemelee") then
	local skillList=sgs.SkillList()
	skillList:append(scenemelee)
	sgs.Sanguosha:addSkills(skillList)
end

sgs.LoadTranslationTable {
	["scenemelee"] = "混战场景",
	
	["#FreeForAllMode"] = "自由混战已开启",
	["#MeleeMode"] = "团队混战已开启",
	
	["scenemelee:freeforall"] = "自由混战",
	[":freeforall"] = "开局所有人变为内奸，相互残杀，最后一个存活者胜利, 杀死其他玩家可以摸3牌",
	["scenemelee:melee"] = "团队混战",
	[":melee"] = "开局所有人按忠内反平均分为3个阵营，同身份的人为一个阵营， 不同阵营之间相互残杀，最后存活的阵营获胜，杀死不同阵营的人摸3牌，杀死队友弃光所有牌",
}