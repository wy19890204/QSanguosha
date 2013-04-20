if sgs.GetConfig("EnableScene", false) and not table.contains(sgs.Sanguosha:getBanPackages(),"scenemelee") then
	ai_sgs_updateIntention = sgs.updateIntention
	ai_SmartAI_isFriend = SmartAI.isFriend
	ai_SmartAI_isEnemy = SmartAI.isEnemy
	ai_SmartAI_objectiveLevel = SmartAI.objectiveLevel

	sgs.updateIntention = function(player, to, intention)
		local room = global_room or player:getRoom()
		if room and room:getTag("MeleeGame"):toString() == "cancel" then
			ai_sgs_updateIntention(player, to, intention)
		end
	end

	SmartAI.isFriend = function(self, player)
		if self.room:getTag("MeleeGame"):toString() == "cancel" then return ai_SmartAI_isFriend(self, player) end
		return self:objectiveLevel(player) < 0
	end

	SmartAI.isEnemy = function(self, player)
		if self.room:getTag("MeleeGame"):toString() == "cancel" then return ai_SmartAI_isEnemy(self, player) end
		return self:objectiveLevel(player) > 0 
	end
	
		
	SmartAI.objectiveLevel = function(self, player, recursive)
		if not player then return 0 end

		if self.room:getTag("MeleeGame"):toString() == "cancel" then return ai_SmartAI_objectiveLevel(self, player, recursive) end

		if self.room:getTag("MeleeGame"):toString() == "freeforall" then	
			if self.player:objectName() == player:objectName() then return -2 end
			if self.player:aliveCount() == 2 then return 5 end
			local others = sgs.QList2Table(self.room:getOtherPlayers(self.player))
			local getValue = function(player)
				local extra = self:hasSkills("zhiheng|haoshi|yingzi|yinghun|tiaoxin|tuntian|huashen|shelie|longhun|lianpo|jijiu|quanji|biyue|lihun|manjuan|chongzhen|miji|luoshen",player) and 2 or 0
				return (player:getHp())^1.68 + player:getCardCount(true) + extra
			end
			local cmp = function(a, b) return getValue(a) < getValue(b)	end
			table.sort(others, cmp)
			for i = 1, #others, 1 do
				if player:objectName() == others[i]:objectName() then
					if i <= 2 and others[i]:isKongcheng() == 0 and others[i]:getHp() <= 1 then return 5 end
					if (i == 1 and #others ==3) or (i <= 2 and #others >=4) then return getValue(self.player) <= 7 and -2 or 0 end
					return i >= #others * 0.5 and 5 or 0 
				end
			end
		end

		if self.room:getTag("MeleeGame"):toString() == "melee" then			
			if self.player:getRole() == player:getRole() then return -2 end
			if self.player:aliveCount() == 2 then return 5 end
			local players = sgs.QList2Table(self.room:getAllPlayers())
			local getValue = function(player)
				local extra = self:hasSkills("jijiu|longhun", player) and player:getCardCount(true)*0.66 or 0
				return (player:getHp())^1.68 + player:getCardCount(true) + extra
			end
			local role_value = { ["loyalist"] = 0, ["rebel"] = 0, ["renegade"] = 0 }
			local max_role_value, min_role_value, max_role, min_role
			local friendnum = 0

			for i = 1, #players, 1 do
				local p = players[i]
				if role_value[p:getRole()] then
					if p:getRole() ~= self.player:getRole() then
						role_value[p:getRole()] = role_value[p:getRole()] + getValue(p)
						if not max_role_value then max_role_value = role_value[p:getRole()] end
						if not min_role_value then min_role_value = role_value[p:getRole()] end
						if role_value[p:getRole()] > max_role_value then 
							max_role_value = role_value[p:getRole()]
							max_role = p:getRole()
						end
						if role_value[p:getRole()] < min_role_value then 
							min_role_value = role_value[p:getRole()]
							min_role = p:getRole()
						end
					else
						friendnum = friendnum + 1
					end
				end
			end
			if player:getRole() == max_role or max_role == min_role then return 5 end
			if player:getRole() == min_role then return friendnum == 1 and -2 or 0 end
		end

		return 3
	end
	
end

