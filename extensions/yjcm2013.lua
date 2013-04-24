module("extensions.yjcm2013", package.seeall)
extension = sgs.Package("yjcm2013")

sjguohuai = sgs.General(extension, "sjguohuai", "wei")
sjmanchong = sgs.General(extension, "sjmanchong", "wei", 3)
sjcaochong = sgs.General(extension, "sjcaochong", "wei", 3)
sjliufeng = sgs.General(extension, "sjliufeng", "shu")
sjjianyong = sgs.General(extension, "sjjianyong", "shu", 3)
sjguanping = sgs.General(extension, "sjguanping", "shu")
sjpanzmaz = sgs.General(extension, "sjpanzmaz", "wu")
sjyufan = sgs.General(extension, "sjyufan", "wu", 3)
sjzhuran = sgs.General(extension, "sjzhuran", "wu")
sjliru = sgs.General(extension, "sjliru", "qun", 3)
sjfuhuanghou = sgs.General(extension, "sjfuhuanghou", "qun", 3, false)

sjjingce = sgs.CreateTriggerSkill{
	name = "sjjingce",
	events = {sgs.CardUsed, sgs.CardResponded, sgs.EventPhaseStart, sgs.EventPhaseEnd},

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.CardUsed then
			player:addMark("jingcecount")
			return 
		end
		if event == sgs.CardResponded then
			local resp = data:toResponsed()
			if resp:m_isUse() then
				player:addMark("jingcecount")
			end
			return
		end
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_RoundStart then
				room:setPlayerMark(player, "jingcecount", 0)
			end
			return
		end
		if player:getPhase() == sgs.Player_Play then
			if player:getMark("jingcecount") > player:getHp() then
				local choice = "draw"
				if player:isWounded() then
					choice = room:askForChoice(player, self:objectName(), "recover+draw")
				end
				if choice == "recover" then
					local recover = sgs.RecoverStruct()
					recover.who = player
					room:recover(player, recover)
				else
					player:drawCards(1)
				end
			end
		end
	end,
}

sjjunxingcard = sgs.CreateSkillCard{
	name = "sjjunxingcard",
	filter = function(self, targets, to_select, player)
		return #targets == 0 and not to_select:isKongcheng() and to_select:objectName() ~= player:objectName()
	end,
	
	on_use = function(self, room, source, targets)
		local types = {"BasicCard", "EquipCard", "TrickCard"}
		for _, id in sgs.qlist(self:getSubcards()) do
			local t = sgs.Sanguosha:getCard(id):getType()
			if t == "basic" then table.removeOne(types, "BasicCard") end
			if t == "equip" then table.removeOne(types, "EquipCard") end
			if t == "trick" then table.removeOne(types, "TrickCard") end
		end
		local card
		if #types ~= 0 then
			card = room:askForCard(targets[1], table.concat(types, ",").."|.|.|hand", "@Junxing")
		end
		if not card then targets[1]:turnOver() end
	end,
}

sjjunxing = sgs.CreateViewAsSkill{
	name = "sjjunxing",
	n=3,
	
	view_filter = function(self, selected, to_select)
		return true
	end,

	view_as=function(self, cards)
		if #cards == 0 then return end
		local card = sjjunxingcard:clone()
		for _, p in ipairs(cards) do
			card:addSubcard(p)
		end
		return card
	end,

	enabled_at_play=function(self, player)
		return not player:hasUsed("#sjjunxingcard")
	end,
}

sjyuce = sgs.CreateTriggerSkill{
	name = "sjyuce",
	events = {sgs.Damaged},

	on_trigger = function(self, event, player, data)
		if player:isKongcheng() then return end
		if not player:askForSkillInvoke(self:objectName()) then return end
		local room = player:getRoom()
		local card = room:askForCardShow(player, player, "@Yuce")
		if not card then return end
		room:showCard(player, card:getId())
		local pattern = ""
		local t = card:getType()
		if t == "basic" then pattern = "BasicCard"
		elseif t == "equip" then pattern = "EquipCard"
		elseif t == "trick" then pattern = "TrickCard" end
		local damage = data:toDamage()
		if not damage.from then return end
		local res = room:askForCard(damage.from, pattern, "@YuceResp")
		if not res then
			local recover = sgs.RecoverStruct()
			recover.who = player
			room:recover(player, recover)
		end
	end,
}

sjchengxiang = sgs.CreateTriggerSkill{
	name = "sjchengxiang",
	events = {sgs.Damaged},

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		while player:askForSkillInvoke(self:objectName()) do
			if not player:isKongcheng() then
				room:showAllCards(player)
			end
			local sum = 0
			for _, p in sgs.qlist(player:getHandcards()) do
				sum = sum + p:getNumber()
			end
			if sum >= 13 then break end
			player:drawCards(1)
		end
	end,
}

sjbingxin = sgs.CreateTriggerSkill{
	name = "sjbingxin",
	events = {sgs.Dying},

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local dying = data:toDying()
		if dying.who:objectName() ~= player:objectName() then return end
		local invoke = false
		if player:askForSkillInvoke(self:objectName()) then
			while true do
				if not room:askForYiji(player, player:handCards(), false) then break end
				invoke = true
			end
		end
		if invoke then
			player:turnOver()
		end
	end,
}

sjxiansicard = sgs.CreateSkillCard{
	name = "sjxiansicard",
	filter = function(self, targets, to_select, player)
		return #targets < 2 and not to_select:isNude()
	end,
	
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local id = room:askForCardChosen(effect.from, effect.to, "he", self:objectName())
		effect.from:addToPile("xiansipile", id)
	end,
}

sjxiansivsskill = sgs.CreateViewAsSkill{
	name = "sjxiansi",
	n=1,
	
	view_filter = function(self, selected, to_select)
		return not to_select:isEquipped()
	end,

	view_as=function(self, cards)
		if #cards == 0 then return end
		local card = sjxiansicard:clone()
		card:addSubcard(cards[1])
		return card
	end,

	enabled_at_play = function(self, player)
		return false
	end,
	
	enabled_at_response = function(self, player, pattern) 
		return pattern == "@@sjxiansi"
	end,
}

sjxiansi = sgs.CreateTriggerSkill{
	name = "sjxiansi",
	events = {sgs.EventPhaseStart, sgs.GameStart},
	view_as_skill = sjxiansivsskill,

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.GameStart then
			for _, p in sgs.qlist(room:getOtherPlayers(player)) do
				room:attachSkillToPlayer(p, "sjxiansiv")
			end
			return
		end
		if player:getPhase() ~= sgs.Player_Start then return end
		room:askForUseCard(player, "@@sjxiansi", "@Xiansi")
	end,
}

sjxiansivcard = sgs.CreateSkillCard{
	name = "sjxiansivcard",
	filter = function(self, targets, to_select, player)
		return #targets == 0 and not to_select:getPile("xiansipile"):isEmpty() and player:canSlash(to_select)
	end,
	
	on_effect = function(self, effect)
		local room = effect.from:getRoom()
		local cards = effect.to:getPile("xiansipile")
		room:fillAG(cards, effect.from)
		local card_id = room:askForAG(effect.from, cards, true, self:objectName())
		room:broadcastInvoke("clearAG")
		if card_id ~= -1 then
			local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_REMOVE_FROM_PILE, "", self:objectName(), "")
			room:throwCard(sgs.Sanguosha:getCard(card_id), reason, nil)
			local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
			slash:setSkillName(self:objectName())
			local use = sgs.CardUseStruct()
			use.card = slash
			use.from = effect.from
			use.to:append(effect.to)
			room:useCard(use)
		end
	end,
}

sjxiansivs = sgs.CreateViewAsSkill{
	name = "sjxiansiv",
	n=0,

	view_as=function(self, cards)
		return sjxiansivcard:clone()
	end,

	enabled_at_play = function(self, player)
		return sgs.Slash_IsAvailable(player)
	end,
}

sjqiaoshuocard = sgs.CreateSkillCard{
	name = "sjqiaoshuocard",
	will_throw = false,
	filter = function(self, targets, to_select, player)
		return #targets == 0 and not to_select:isKongcheng() and to_select:objectName() ~= player:objectName()
	end,
	
	on_effect = function(self, effect)
		local win = effect.from:pindian(effect.to, "sjqiaoshuo", self)
		local room = effect.from:getRoom()
		if win then
			room:setPlayerFlag(effect.from, "sjqiaoshuo")
		else
			room:setPlayerCardLimitation(effect.from, "use", "TrickCard+^DelayedTrick", true)
		end
	end,
}

sjqiaoshuovs = sgs.CreateViewAsSkill{
	name = "sjqiaoshuo",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return not to_select:isEquipped()
	end,

	view_as=function(self, cards)
		if #cards == 0 then return end
		local card = sjqiaoshuocard:clone()
		card:addSubcard(cards[1])
		return card
	end,

	enabled_at_play = function(self, player)
		return not player:hasUsed("#sjqiaoshuocard")
	end,
}

sjqiaoshuo = sgs.CreateTriggerSkill{
	name = "sjqiaoshuo",
	events = {sgs.CardUsed},
	view_as_skill = sjqiaoshuovs,

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local use = data:toCardUse()
		if not use.card:isKindOf("Duel") and not use.card:isKindOf("Snatch") and not use.card:isKindOf("Dismantlement") and not use.card:isKindOf("FireAttack") and not use.card:isKindOf("SavageAssault") and not use.card:isKindOf("ArcheryAttack") and not use.card:isKindOf("AmazingGrace") and not use.card:isKindOf("GodSalvation") and not use.card:isKindOf("IronChain") then return end
		
		if not player:hasFlag("sjqiaoshuo") then return end
		if not player:askForSkillInvoke(self:objectName()) then return end
		
		local getcantarget=function(self,use,room,player)
			local alltargets=room:getOtherPlayers(player)
			if use.card:isKindOf("FireAttack") or use.card:isKindOf("IronChain") then
				alltargets=room:getAlivePlayers()
			end
			local alreadytars=use.to
			local cantarget=alltargets
			for _,p in sgs.qlist(alltargets) do
				if alreadytars:contains(p) or player:isProhibited(p,use.card) then
					cantarget:removeOne(p)
				end
			end
			return cantarget
		end
		
		local getnewtarget=function(self,targets,room,player)
			local newtarget=room:askForPlayerChosen(player,targets,self:objectName())
			return newtarget
		end
		
		local getoldtarget=function(self,use,room,player)
			local alreadytars=use.to
			local oldtarget=room:askForPlayerChosen(player,alreadytars,self:objectName())
			return oldtarget
		end
		local cantarget=getcantarget(self,use,room,player)
		local used
		local target
		local maychoose=cantarget
		if use.card:isKindOf("Duel") or use.card:isKindOf("IronChain") then
			if not maychoose:isEmpty() then 
				if room:askForChoice(player,self:objectName(),"wantadd+wantmove")=="wantadd" then
					used=true
					target=getnewtarget(self,maychoose,room,player)
					use.to:append(target)
				end
			end
		elseif use.card:isKindOf("FireAttack") then
			for _,p in sgs.qlist(cantarget) do
				if p:isKongcheng() then
					maychoose:removeOne(p)
				end
			end
			if not maychoose:isEmpty() then 
				if room:askForChoice(player,self:objectName(),"wantadd+wantmove")=="wantadd" then
					used=true
					target=getnewtarget(self,maychoose,room,player)
					use.to:append(target)
				end
			end
		elseif use.card:isKindOf("Snatch") then
			local snatchs=sgs.SPlayerList()
			for _,p in sgs.qlist(cantarget) do
				if not p:isAllNude() and player:distanceTo(p)<=1 and player:objectName()~=p:objectName() then
					snatchs:append(p)
				end
			end
			if not snatchs:isEmpty() then 
				if room:askForChoice(player,self:objectName(),"wantadd+wantmove")=="wantadd" then
					used=true
					target=getnewtarget(self,snatchs,room,player)
					use.to:append(target)
				end
			end
		elseif use.card:isKindOf("Dismantlement") then
			for _,p in sgs.qlist(cantarget) do
				if p:isAllNude() then
					maychoose:removeOne(p)
				end
			end
			if not maychoose:isEmpty() then 
				if room:askForChoice(player,self:objectName(),"wantadd+wantmove")=="wantadd" then
					used=true
					target=getnewtarget(self,maychoose,room,player)
					use.to:append(target)
				end
			end
		--[[elseif use.card:isKindOf("Collateral") then
			local slasher,slashee={},{}
			slasher[1]=use.to:at(0)
			slashee[1]=use.to:at(1)
			local newslashers=sgs.SPlayerList()
			for _,p in sgs.qlist(room:getOtherPlayers(player)) do
				if p:getWeapon() and not player:isProhibited(p,use.card) and slasher[1]:objectName()~=p:objectName() then
					newslashers:append(p)
				end
			end
			if not newslashers:isEmpty() then
				if room:askForChoice(player,self:objectName(),"wantadd+wantmove")=="wantadd" then
					slasher[2]=room:askForPlayerChosen(player,newslashers,self:objectName())
				end
			end
			if slasher[2] then
				local newslashees=sgs.SPlayerList()
				for _,p in sgs.qlist(room:getOtherPlayers(slasher[2])) do
					if slasher[2]:canSlash(p,true) then
						newslashees:append(p)
					end
				end
				if not newslashees:isEmpty() then
					slashee[2]=room:askForPlayerChosen(player,newslashees,self:objectName())
				end
			end
			if slashee[2] then
				for i=1,2,1 do
					for _,p in sgs.qlist(room:getAlivePlayers()) do
						if slasher[2]:objectName()==p:objectName() then
							use.to=sgs.SPlayerList()
							use.to:append(p)
							slasher[2]=nil
							use.to:append(slashee[2])
							slashee[2]=nil
						elseif slasher[1]:objectName()==p:objectName() then
							use.to=sgs.SPlayerList()
							use.to:append(p)
							slasher[1]=nil
							use.to:append(slashee[1])
							slashee[1]=nil
						end
						use.card:setSkillName(self:objectName())
						room:useCard(use,false)
					end
				end
				return true
			end]] -- I don't know in FAQ, how to deal with Collateral and ExNiholo, so I remove these.
		end
		if not used then
			--[[if use.card:isKindOf("Collateral") then
				return true
			end]]
			target=getoldtarget(self,use,room,player)
			use.to:removeOne(target)
			if use.to:isEmpty() then 
				return true
			end
		end
		data:setValue(use)
	end,
}

sjzongshi = sgs.CreateTriggerSkill{
	name = "sjzongshi",
	events = {sgs.Pindian},
	frequency = sgs.Skill_Frequent,
	
	can_trigger = function()
		return true
	end,

	on_trigger = function(self, event, player, data)
		local pindian = data:toPindian()
		if pindian.from:hasSkill(self:objectName()) and pindian.from:askForSkillInvoke(self:objectName()) then
			if pindian.success then
				pindian.from:obtainCard(pindian.to_card)
			else
				pindian.from:obtainCard(pindian.from_card)
			end
		end
		if pindian.to:hasSkill(self:objectName()) and pindian.to:askForSkillInvoke(self:objectName()) then
			if pindian.success then
				pindian.to:obtainCard(pindian.to_card)
			else
				pindian.to:obtainCard(pindian.from_card)
			end
		end
	end,
}

sjlongyin = sgs.CreateTriggerSkill{
	name = "sjlongyin",
	events = {sgs.CardUsed},
	
	can_trigger = function()
		return true
	end,

	on_trigger = function(self, event, player, data)
		if player:getPhase() ~= sgs.Player_Play then return end
		local room = player:getRoom()
		local use = data:toCardUse()
		if not use.card:isKindOf("Slash") then return end
		local splayer = room:findPlayerBySkillName(self:objectName())
		if not splayer then return end
		local card = room:askForCard(splayer, ".black", "@Longyin", sgs.QVariant(), self:objectName())
		if card then
			use.from:addHistory(use.card:getClassName(), -1)
            use.from:invoke("addHistory", use.card:getClassName()..":-1")
			room:broadcastInvoke("addHistory", "pushPile")
			if use.card:isRed() then splayer:drawCards(1) end
		end
	end,
}

sjduodaocard = sgs.CreateSkillCard{
	name = "sjduodaocard",
	will_throw = false,
	filter = function(self, targets, to_select, player)
		return #targets == 0 and not to_select:isKongcheng() and to_select:getWeapon() and to_select:objectName() ~= player:objectName()
	end,
	
	on_effect = function(self, effect)
		local win = effect.from:pindian(effect.to, "sjduodao", self)
		local room = effect.from:getRoom()
		if win then
			effect.from:obtainCard(effect.to:getWeapon())
		else
			room:setPlayerCardLimitation(effect.from, "use,response", "Slash", true)
		end
	end,
}

sjduodao = sgs.CreateViewAsSkill{
	name = "sjduodao",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return not to_select:isEquipped()
	end,

	view_as=function(self, cards)
		if #cards == 0 then return end
		local card = sjduodaocard:clone()
		card:addSubcard(cards[1])
		return card
	end,

	enabled_at_play = function(self, player)
		return not player:hasUsed("#sjduodaocard")
	end,
}

sjanjian = sgs.CreateTriggerSkill{
	name = "sjanjian",
	events = {sgs.DamageCaused},
	frequency = sgs.Skill_Compulsory,

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()
		if not damage.card:isKindOf("Slash") then return end
		if damage.chain or damage.transfer then return end
		if not damage.to:inMyAttackRange(player) then
			local log = sgs.LogMessage()
			log.type = "#TriggerSkill"
			log.from = player
			log.arg = self:objectName()
			room:sendLog(log)
			damage.damage = damage.damage + 1
			data:setValue(damage)
		end
	end,
}

sjzongxuan = sgs.CreateTriggerSkill{
	name = "sjzongxuan",
	events = {sgs.CardsMoveOneTime},

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local move = data:toMoveOneTime()
		if move.from == nil or move.from:objectName() ~= player:objectName() then return end
		local reason = move.reason.m_reason
		local invoke= reason==sgs.CardMoveReason_S_REASON_DISCARD or reason==sgs.CardMoveReason_S_REASON_RULEDISCARD or reason==sgs.CardMoveReason_S_REASON_THROW or reason==sgs.CardMoveReason_S_REASON_CHANGE_EQUIP or reason==sgs.CardMoveReason_S_REASON_DISMANTLE
		local card_id
		if invoke then
			local ids = sgs.IntList()
            for i=0,(move.card_ids:length()-1),1 do
                card_id = (move.card_ids):at(i)
				if (move.from_places):at(i) == sgs.Player_PlaceHand or (move.from_places):at(i) == sgs.Player_PlaceEquip then
					ids:append(card_id)
				end
			end
			while not ids:isEmpty() do
				if player:askForSkillInvoke(self:objectName()) then
					room:fillAG(ids, player)
					local card_id = room:askForAG(player, ids, true, self:objectName())
					room:broadcastInvoke("clearAG")
					if card_id ~= -1 then
						local reason = sgs.CardMoveReason(sgs.CardMoveReason_S_REASON_PUT, player:objectName(), "", self:objectName(), "")
						room:moveCardTo(sgs.Sanguosha:getCard(card_id), nil, sgs.Player_DrawPile, reason, true)
						ids:removeOne(card_id)
					end
				else break end
			end
		end
	end,
}

sjzhiyan = sgs.CreateTriggerSkill{
	name = "sjzhiyan",
	events = {sgs.EventPhaseStart},

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if player:getPhase() == sgs.Player_Finish then
			if player:askForSkillInvoke(self:objectName()) then
				local target = room:askForPlayerChosen(player, room:getAllPlayers(), self:objectName())
				local card = room:peek()
				target:drawCards(1)
				room:showCard(target, card:getId())
				if card:isKindOf("EquipCard") then
					local recover = sgs.RecoverStruct()
					recover.who = player
					room:recover(target, recover)
					local use = sgs.CardUseStruct()
					use.card = card
					use.from = target
					room:useCard(use)
				end
			end
		end
	end,
}

sjdanshou = sgs.CreateTriggerSkill{
	name = "sjdanshou",
	events = {sgs.Damage, sgs.Damaged, sgs.EventPhaseStart},
	
	can_trigger = function()
		return true
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.EventPhaseStart then
			if player:getPhase() == sgs.Player_RoundStart then
				for _, p in sgs.qlist(room:getPlayers()) do
					if p:getMark(self:objectName()) > 0 and p:getHp() > 0 then
						p:setAlive(true)
						room:broadcastProperty(p, "alive")
					end
				end
			end
			return
		end
		if event == sgs.Damaged then
			if damage.from:getMark(self:objectName()) > 0 then
				return true
			end
		end
		local target = room:getCurrent()
		if target:isAlive() and player:hasSkill(self:objectName()) and player:askForSkillInvoke(self:objectName()) then
			target:drawCards(1)
			target:addMark(self:objectName())
			target:setAlive(false)
			room:broadcastProperty(target, "alive")
		end
	end,
}	

sjjuece = sgs.CreateTriggerSkill{
	name = "sjjuece",
	events = {sgs.BeforeCardsMove, sgs.CardsMoveOneTime},
	frequency = sgs.Skill_Compulsory,

	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local move = data:toMoveOneTime()
		if player:getPhase() == sgs.Player_NotActive then return end
		if not move.from then return end
		local from = room:findPlayer(move.from:getGeneralName())
		if not from then return end
		if move.from_places:contains(sgs.Player_PlaceHand) then
			if event == sgs.BeforeCardsMove then
				for _, id in sgs.qlist(from:handCards()) do
					if not move.card_ids:contains(id) then return end
				end
				from:addMark(self:objectName())
			else
				if from:getMark(self:objectName()) == 0 then return end
				from:removeMark(self:objectName())
				local log = sgs.LogMessage()
				log.type = "#TriggerSkill"
				log.from = from
				log.arg = self:objectName()
				room:sendLog(log)
				local damage = sgs.DamageStruct()
				damage.from = player
				damage.to = from
				room:damage(damage)
			end
		end
	end,
}

sjmieji = sgs.CreateTargetModSkill{
	name = "sjmieji",
	pattern = "SingleTargetTrick+^Collateral|.|.|.|black",
	extra_target_func = function(self, player)
		if player:hasSkill(self:objectName()) then
			return 1
		else
			return 0
		end
	end,
}

sjfenchengcard = sgs.CreateSkillCard{
	name = "sjfenchengcard",
	target_fixed = true,
	
	on_use = function(self, room, source, targets)
		source:loseMark("@fencheng")
		for _, p in sgs.qlist(room:getOtherPlayers(source)) do
			local num = p:getEquips():length()
			if num ~= 0 and not room:askForDiscard(p, "sjfencheng", num, num, true, false) then
				local damage = sgs.DamageStruct()
				damage.from = source
				damage.to = p
				damage.nature = sgs.DamageStruct_Fire
				room:damage(damage)
			end
		end
	end,
}

sjfenchengvs = sgs.CreateViewAsSkill{
	name = "sjfencheng",
	n = 0,

	view_as=function(self, cards)
		return sjfenchengcard:clone()
	end,

	enabled_at_play = function(self, player)
		return player:getMark("@fencheng") > 0
	end,
}

sjfencheng = sgs.CreateTriggerSkill{
	name = "sjfencheng",
	events = {sgs.GameStart},
	view_as_skill = sjfenchengvs,
	frequency = sgs.Skill_Limited,

	on_trigger = function(self, event, player, data)
		player:gainMark("@fencheng")
	end,
}

sjzhuikong = sgs.CreateTriggerSkill{
	name = "sjzhuikong",
	events = {sgs.EventPhaseStart},
	
	can_trigger = function()
		return true
	end,
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local splayer = room:findPlayerBySkillName(self:objectName())
		if not splayer then return end
		if player:getPhase() == sgs.Player_NotActive then
			if player:getMark(self:objectName()) > 0 then
				player:removeMark(self:objectName())
				room:setFixedDistance(player, splayer, -1)
			end
			return
		end
		if player:getPhase() ~= sgs.Player_RoundStart then return end
		if player:objectName() == splayer:objectName() or not splayer:isWounded() or splayer:isKongcheng() or player:isKongcheng() then return end
		if not splayer:askForSkillInvoke(self:objectName()) then return end
		local win = splayer:pindian(player, self:objectName())
		if win then
			player:skip(sgs.Player_Play)
		else
			room:setFixedDistance(player, splayer, 1)
			player:addMark(self:objectName())
		end
	end,
}

sjqiuyuan = sgs.CreateTriggerSkill{
	name = "sjqiuyuan",
	events = {sgs.TargetConfirming},
	
	on_trigger = function(self, event, player, data)
		local use = data:toCardUse()
		local room = player:getRoom()
		if use.card and use.card:isKindOf("Slash") and use.to:contains(player) then
			local victims = sgs.SPlayerList()
			for _, p in sgs.qlist(room:getOtherPlayers(player)) do
				if not p:isKongcheng() then
					victims:append(p)
				end
			end
			if not victims:isEmpty() then
				if not player:askForSkillInvoke(self:objectName()) then return end
				local victim = room:askForPlayerChosen(player, victims, self:objectName())
				local card = room:askForCardShow(victim, player, "@Qiuyuan")
				player:obtainCard(card)
				if not card:isKindOf("Jink") then
					use.to:append(victim)
					data:setValue(use)
				end
			end
		end
	end,
}

local skills = sgs.SkillList()
if not sgs.Sanguosha:getSkill("sjxiansiv") then skills:append(sjxiansivs) end
sgs.Sanguosha:addSkills(skills)

sjguohuai:addSkill(sjjingce)
sjmanchong:addSkill(sjjunxing)
sjmanchong:addSkill(sjyuce)
sjcaochong:addSkill(sjchengxiang)
sjcaochong:addSkill(sjbingxin)
sjliufeng:addSkill(sjxiansi)
sjjianyong:addSkill(sjqiaoshuo)
sjjianyong:addSkill(sjzongshi)
sjguanping:addSkill(sjlongyin)
sjpanzmaz:addSkill(sjduodao)
sjpanzmaz:addSkill(sjanjian)
sjyufan:addSkill(sjzongxuan)
sjyufan:addSkill(sjzhiyan)
sjzhuran:addSkill(sjdanshou)
sjliru:addSkill(sjjuece)
sjliru:addSkill(sjmieji)
sjliru:addSkill(sjfencheng)
sjfuhuanghou:addSkill(sjzhuikong)
sjfuhuanghou:addSkill(sjqiuyuan)

sgs.LoadTranslationTable{
	["yjcm2013"] = "一将成名2013",

	["#sjguohuai"] = "就一白板",
	["sjguohuai"] = "郭淮",
	
	["sjjingce"] = "精策",
	[":sjjingce"] = "出牌阶段结束时，若你本回合使用的牌的数量大于你当前的体力值，你可以回复1点体力或摸一张牌。",
	["sjjingce:recover"] = "回复1点体力",
	["sjjingce:draw"] = "摸一张牌",

	["#sjmanchong"] = "大概不逗",
	["sjmanchong"] = "满宠",
	
	["sjjunxing"] = "峻刑",
	[":sjjunxing"] = "出牌阶段，你可以弃置一至三张牌，然后令一名有手牌的其他角色选择一项：弃置一张与你的弃牌均不同类别的手牌，或将其武将牌翻面。每阶段限一次。",
	["sjjunxingcard"] = "峻刑",
	["@Junxing"] = "请弃置一张与弃牌不同类别的手牌",
	
	["sjyuce"] = "御策",
	[":sjyuce"] = "每当你受到一次伤害后，你可以展示一张手牌，令伤害来源弃置一张相同类别的手牌，否则，你回复1点体力。",
	["@Yuce"] = "请展示一张手牌",
	["@YuceResp"] = "请弃置一张同类别的牌",

	["#sjcaochong"] = "说好的早夭呢",
	["sjcaochong"] = "曹冲",
	
	["sjchengxiang"] = "称象",
	[":sjchengxiang"] = "每当你受到一次伤害后，你可以展示所有手牌，若点数之和小于13，你摸一张牌。你可以重复此流程，直至你的所有手牌点数之和等于或大于13为止。",
	
	["sjbingxin"] = "冰心",
	[":sjbingxin"] = "每当你进入濒死状态时，你可以将所有牌以任意方式交给任意数量的其他角色，若如此做，你将武将牌翻面。",
	
	["#sjliufeng"] = "大浪比",
	["sjliufeng"] = "刘封",
	
	["sjxiansi"] = "陷嗣",
	[":sjxiansi"] = "回合开始阶段开始时，你可以弃置一张手牌，将至多两名角色的各一张牌移动至你的武将牌上，称为“逆”。每当其他角色需要对你使用一张【杀】时，该角色可以弃置你的一张“逆”，视为对你使用一张【杀】。",
	["sjxiansicard"] = "陷嗣",
	["sjxiansiv"] = "陷嗣",
	[":sjxiansiv"] = "回合开始阶段开始时，你可以弃置一张手牌，将至多两名角色的各一张牌移动至你的武将牌上，称为“逆”。每当其他角色需要对你使用一张【杀】时，该角色可以弃置你的一张“逆”，视为对你使用一张【杀】。",
	["sjxiansivcard"] = "陷嗣",
	["xiansipile"] = "逆",
	["@Xiansi"] = "你可以发动技能“陷嗣”",
	["~sjxiansi"] = "选中一张牌→选择1~2名角色→点确定",
	
	["#sjjianyong"] = "一堆FAQ",
	["sjjianyong"] = "简雍",
	
	["sjqiaoshuo"] = "巧说",
	[":sjqiaoshuo"] = "出牌阶段，你可以与一名其他角色拼点，若你赢，你获得以下技能直到回合结束：你使用的下一张非延时类锦囊可以额外指定一个目标或减少指定一个目标。若你没赢，你不能使用非延时类锦囊直到回合结束。每阶段限一次。（无中生有和借刀杀人扔不明确，故这两张卡不能发动巧说拼点赢后获得的技能）",
	["sjqiaoshuocard"] = "巧说",
	["sjqiaoshuo:wantadd"] = "增加一个目标",
	["sjqiaoshuo:wantmove"] = "减少一个目标",
	
	["sjzongshi"] = "纵适",
	[":sjzongshi"] = "若你向其他角色发起拼点且拼点赢时，或其他角色向你发起拼点且该角色没赢时，你可以获得该角色的拼点牌，否则，你可以收回你自己的拼点牌。",
	
	["#sjguanping"] = "不是终版",
	["sjguanping"] = "关平",
	
	["sjlongyin"] = "龙吟",
	[":sjlongyin"] = "任意角色于其出牌阶段使用【杀】时，你可弃置一张黑色手牌令此杀不计入每阶段使用次数，若此杀为红色，你摸一张牌。",
	["@Longyin"] = "你可以弃置一张黑色手牌发动“龙吟”",
	
	["#sjpanzmaz"] = "兄贵",
	["sjpanzmaz"] = "潘璋＆马忠",
	
	["sjduodao"] = "夺刀",
	[":sjduodao"] = "出牌阶段，你可以和一名装备区有武器牌的其他角色拼点，若你赢，你获得其装备区中的武器牌：若你没赢，则你不可以使用或打出【杀】直到回合结束。",
	["sjduodaocard"] = "夺刀",
	
	["sjanjian"] = "暗箭",
	[":sjanjian"] = "<b>锁定技</b>，每当你使用【杀】对目标角色造成伤害时，若你不在其攻击范围内，则此伤害+1。",
	
	["#sjyufan"] = "节操何在",
	["sjyufan"] = "虞翻",
	
	["sjzongxuan"] = "纵玄",
	[":sjzongxuan"] = "每当你将要因弃置而失去一张牌时，你可以将该牌置于牌堆顶。",
	
	["sjzhiyan"] = "直言",
	[":sjzhiyan"] = "回合结束阶段开始时，你可以令一名角色摸一张牌并展示之，然后若其为装备牌，该角色回复1点体力并使用该牌。",
	
	["#sjzhuran"] = "结算不明",
	["sjzhuran"] = "朱然",
	
	["sjdanshou"] = "胆守",
	[":sjdanshou"] = "每当你造成一次伤害后，你可以摸一张牌。若如此做，此回合结束。（卖血流技能无法发动）",
	
	["#sjliru"] = "贾诩二代",
	["sjliru"] = "李儒",
	
	["sjjuece"] = "绝策",
	[":sjjuece"] = "<b>锁定技</b>，在你的回合内，一名角色失去最后一张手牌后，你对其造成1点伤害。",
	
	["sjmieji"] = "灭计",
	[":sjmieji"] = "你使用黑色非延时类锦囊牌仅指定一个目标后，可以额外指定另一名角色为目标。（依然不包括借刀）",
	
	["sjfencheng"] = "焚城",
	[":sjfencheng"] = "<b>限定技</b>，出牌阶段，你可令所有其他角色选择：1、弃置X张手牌；2、受到1点火焰伤害。（X为该角色装备区牌的数量）",
	["sjfenchengcard"] = "焚城",
	["@fencheng"] = "焚城",
	
	["#sjfuhuanghou"] = "结算BUG帝",
	["sjfuhuanghou"] = "伏皇后",
	
	["sjzhuikong"] = "惴恐",
	[":sjzhuikong"] = "其他角色的回合开始时，若你已受伤，你可以与该角色拼点。若你赢，该角色跳过出牌阶段；若你没赢，该角色与你距离为1直到回合结束。",
	
	["sjqiuyuan"] = "求援",
	[":sjqiuyuan"] = "当你成为杀的目标时，你可以令一名其他角色交给你一张手牌。若此牌不为闪，该角色也成为此杀的目标。",
	["@Qiuyuan"] = "请交给其一张手牌",
}