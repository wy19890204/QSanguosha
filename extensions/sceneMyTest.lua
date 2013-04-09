

dofile("./lua/MyAI/MyAI.lua")

module("extensions.sceneMyTest", package.seeall)
extension = sgs.Package("sceneMyTest")

test1 = sgs.General(extension, "test1", "shu")

--新建场景用于测试
sceneMyTest = sgs.CreateTriggerSkill {
	name = "#sceneMyTest",
	events = {sgs.GameStart},
	on_trigger = function(self, event, player, data)
		--把登陆的玩家信息记录到数据库
		if event==sgs.GameStart then
			if player:getAI() then return end
			db:exec(("delete from userLoin where username = '%s'"):format(player:screenName()))
			local sql=("insert into userLoin values('%s','%s')"):format(player:screenName(),player:getGeneralName())
			db:exec(sql)
			local sql2=("select * from userLoin where username = '%s'"):format(player:screenName())
			local query=db:first_row(sql2)
			player:speak("用户:"..query.username.."--->"..query.general)
		end
	end
	}

--测试play的作用
skill_test1 = sgs.CreateTriggerSkill {
	name = "skill_test1",
	events = {sgs.EventPhaseStart,sgs.TurnStart,sgs.ChoiceMade},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()	

		if event==sgs.ChoiceMade then
			player:speak(data:toString())
		end
		
		--room:setPlayerCardLimitation(player,"response,use","TrickCard|EquipCard",true)
		--武将选择
		--room:askForGeneral(player,"pangtong+zhugeliang")
		--变更英雄                        满血  标记      日志   
		--room:changeHero(player,"pangtong",true,true,false,true)
		
		--要求玩家弃牌
		-- local b=room:askForDiscard(player,self:objectName(),4,,false,false,self:objectName())
		-- if b then 
			 -- player:speak("ccccccc")
		-- end
		
		--要求打出一张卡片                                   %src   %dest  %arg
		-- local c=room:askForCard(player,"BasicCard|.|.|.|red","@ddd:param1:param2:param3:333",data)
		-- if c then 
			 -- player:speak(c:getSuitString())
		-- end		
		-- room:askForCard(player,"TrickCard|.|.|.|black","",data) 

		if event==sgs.TurnStart then 
			for  _,pl in sgs.qlist(room:getAllPlayers()) do
				if pl:getMark("num")==1 and pl:getHp()>0 then
					pl:setMark("num",0)
					pl:setAlive(true)
					--立刻公布角色当前属性
					room:broadcastProperty(pl, "alive")
				end
			end
			return false
		end

		if not player:hasSkill(self:objectName()) then return end
		
		if not (player:getPhase() == sgs.Player_NotActive) then
			if player:getMark("num")>0 then
				player:setMark("num",player:getMark("num")-1)
			end
		end
		
		--player:speak(player:getPhaseString().."---"..player:getMark("num"))
			
		if player:getPhase()==sgs.Player_RoundStart then
			local p=sgs.PhaseList()
			p:append(sgs.Player_Draw)--立刻跳过当前回合并执行以下阶段
			p:append(sgs.Player_Draw)
			p:append(sgs.Player_Play)
			p:append(sgs.Player_Discard)
			player:setMark("num",p:length()+1)
			player:play(p)
		end

		if player:getPhase()==sgs.Player_NotActive and  player:getMark("num")==1 then 
			player:setAlive(false)
			room:broadcastProperty(player, "alive")
		end
		
		return false
	end,

	can_trigger=function(self, player)
		return true
	end,
}


test1:addSkill(skill_test1)

if not sgs.Sanguosha:getSkill("#sceneMyTest") then
	local skillList=sgs.SkillList()
	skillList:append(sceneMyTest)
	sgs.Sanguosha:addSkills(skillList)
end

sgs.LoadTranslationTable{
	["sceneMyTest"] = "My测试包",

	["#test1"] = "测试武将",
	["test1"] = "测试武将",
	
	["skill_test1"] = "技能测试",
	[":skill_test1"] = "技能测试",
	
	["@ddd"]="测试技能%src对%dest对 %arg 对 %arg2"

}


