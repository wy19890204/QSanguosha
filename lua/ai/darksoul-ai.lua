--[[
table
concat
insert
remove
ipairs

clearAG
Sanguosha
format
sgs.Card_Parse
sgs.QList2Table(cards)

QList列表
SPlayerList
PlayerList
CardList
IntList
SkillList
ItemList
DelayedTrickList
CardsMoveList
PlaceList
PhaseList


名称：Phase（阶段）
来源：player.h
sgs.Player_RoundStart
sgs.Player_Start
sgs.Player_Judge
sgs.Player_Draw
sgs.Player_Play
sgs.Player_Discard
sgs.Player_Finish
sgs.Player_NotActive
sgs.Player_PhaseNone
名称：Place（分区）
来源：player.h
sgs.Player_PlaceHand
sgs.Player_PlaceEquip
sgs.Player_PlaceDelayedTrick
sgs.Player_PlaceJudge
sgs.Player_PlaceSpecial
sgs.Player_DiscardPile
sgs.Player_DrawPile
sgs.Player_PlaceTable
sgs.Player_PlaceUnknown
sgs.Player_PlaceWuGu
名称：Role（身份）
来源：player.h
lord
loyalist
rebel
renegade
名称：Suit（花色）
来源：card.h
sgs.Card_Spade
sgs.Card_Club
sgs.Card_Heart
sgs.Card_Diamond
sgs.Card_NoSuit
名称：Color（颜色）
来源：card.h
sgs.Card_Red
sgs.Card_Black
sgs.Card_Colorless
名称：CardType（卡牌类型）
来源：card.h
sgs.Card_Skill
sgs.Card_Basic
sgs.Card_Trick
sgs.Card_Equip
名称：Frequency（发动频率）
来源：skill.h
sgs.Skill_Frequent
sgs.Skill_NotFrequent
sgs.Skill_Compulsory
sgs.Skill_Limited
sgs.Skill_Wake
名称：Location（位置）
来源：skill.h
sgs.Skill_Left
sgs.Skill_Right
名称：Nature（属性）
来源：structs.h
sgs.DamageStruct_Normal
sgs.DamageStruct_Fire
sgs.DamageStruct_Thunder
名称：TriggerEvent（触发事件）
来源：structs.h
	NonTrigger,

    GameStart,
    TurnStart,
    EventPhaseStart,
    EventPhaseProceeding,
    EventPhaseEnd,
    EventPhaseChanging,

    DrawNCards,
    AfterDrawNCards,

    PreHpRecover,
    HpRecover,
    PreHpLost,
    HpChanged,
    MaxHpChanged,
    PostHpReduced,

    EventLoseSkill,
    EventAcquireSkill,

    StartJudge,
    AskForRetrial,
    FinishRetrial,
    FinishJudge,

    PindianVerifying,
    Pindian,

    TurnedOver,
    ChainStateChanged,

    ConfirmDamage,    // confirm the damage's count and damage's nature
    Predamage,        // trigger the certain skill -- jueqing
    DamageForseen,    // the first event in a damage -- kuangfeng dawu
    DamageCaused,     // the moment for -- qianxi..
    DamageInflicted,  // the moment for -- tianxiang..
    PreHpReduced,     // the moment before Hpreduce
    DamageDone,       // it's time to do the damage
    Damage,           // the moment for -- lieren..
    Damaged,          // the moment for -- yiji..
    DamageComplete,   // the moment for trigger iron chain

    Dying,
    AskForPeaches,
    AskForPeachesDone,
    Death,
    BuryVictim,
    BeforeGameOverJudge,
    GameOverJudge,
    GameFinished,

    SlashEffect,
    SlashEffected,
    SlashProceed,
    SlashHit,
    SlashMissed,

    CardAsked,
    CardResponded,
    BeforeCardsMove, // sometimes we need to record cards before the move
    CardsMoving,
    CardsMoveOneTime,
    CardDrawing,

    PreCardUsed, // for AI to filter events only.
    CardUsed,
    TargetConfirming,
    TargetConfirmed,
    CardEffect,
    CardEffected,
    CardFinished,

    ChoiceMade,

    StageChange, // For hulao pass only
    FetchDrawPileCard, // For miniscenarios only

    NumOfEvents

objectName
setObjectName
inherits
setParent
getMaxHp
getKingdom
isMale
isFemale
isNeuter
isLord
isHidden
isTotallyHidden
getGender
setGender
addSkill
hasSkill
getSkillList
getVisibleSkillList
getVisibleSkills
getTriggerSkills
getPackage
getSkillDescription
lastWord
Player
setScreenName
screenName
getHp
setHp
getMaxHp
setMaxHp
getLostHp
isWounded
getGender
setGender
isSexLess
isMale
isFemale
isNeuter
getMaxCards
getKingdom
setKingdom
setRole
getRole
getRoleEnum
setGeneral
setGeneralName
getGeneralName
setGeneral2Name
getGeneral2Name
getGeneral2
setState
getState
getSeat
setSeat
getPhaseString
setPhaseString
getPhase
setPhase
getAttackRange
inMyAttackRange
isAlive
isDead
setAlive
getFlags
getFlagList
setFlags
hasFlag
clearFlags
faceUp
setFaceUp
aliveCount
distanceTo
setFixedDistance
getAvatarGeneral
getGeneral
isLord
acquireSkill
detachSkill
detachAllSkills
addSkill
loseSkill
hasSkill
hasSkills
hasLordSkill
hasInnateSkill
setEquip
removeEquip
hasEquip
hasEquip
getJudgingArea
addDelayedTrick
removeDelayedTrick
containsTrick
getHandcardNum
removeCard
addCard
getWeapon
getArmor
getDefensiveHorse
getOffensiveHorse
getEquips
getEquip
hasWeapon
hasArmorEffect
isKongcheng
isNude
isAllNude
addMark
removeMark
setMark
getMark
setChained
isChained
canSlash
canSlash
getCardCount
getPile
getPileName
addHistory
clearHistory
hasUsed
usedTimes
getSlashCount
getTriggerSkills
getVisibleSkills
getVisibleSkillList
getAcquiredSkills
getSkillDescription
isProhibited
canSlashWithoutCrossbow
isLastHandCard
jilei
isJilei
setCardLocked
isLocked
setCardLimitation
removeCardLimitation
clearCardLimitation
isCardLimited
isCaoCao
copyFrom
getSiblings
setTag
getTag
removeTag
tag.remove
ServerPlayer
setSocket
invoke
reportHeader
drawCard
getRoom
broadcastSkillInvoke
broadcastSkillInvoke
getRandomHandCardId
getRandomHandCard
obtainCard
throwAllEquips
throwAllHandCards
throwAllHandCardsAndEquips
throwAllCards
bury
throwAllMarks
clearPrivatePiles
removePileByName
drawCards
askForSkillInvoke
QVariant
forceToDiscard
handCards
getHandcards
getCards
wholeHandCards
hasNullification
kick
pindian
turnOver
play
QList
&getPhases
skip
insertPhase
isSkipped
gainMark
loseMark
loseAllMarks
setAI
getAI
getSmartAI
aliveCount
getHandcardNum
removeCard
addCard
isLastHandCard
addVictim
getVictims
startRecord
saveRecord
setNext
getNext
getNextAlive
addToSelected
getSelected
findReasonable
clearSelected
getGeneralMaxHp
getGameMode
getIp
introduceTo
marshal
addToPile
addToPile
addToPile
exchangeFreelyFromPrivatePile
gainAnExtraTurn
speak
QByteArray
.toBase64
getRoom
speakCommand
ClientPlayer
aliveCount
getHandcardNum
removeCard
addCard
addKnownHandCard
isLastHandCard
CardMoveReason
CardMoveReason
CardMoveReason
CardMoveReason
gamerule
only
DamageStruct
CardEffectStruct
SlashEffectStruct
CardUseStruct
isValid
parse
tryParse
CardsMoveStruct
DyingStruct
DeathStruct
RecoverStruct
JudgeStruct
isGood
isEffected
isBad
PindianStruct
PhaseChangeStruct
ResponsedStruct
Card
getSuitString
isRed
isBlack
getId
setId
getEffectiveId
getEffectIdString
getNumber
setNumber
getNumberString
getSuit
setSuit
sameColorWith
isEquipped
getPackage
getFullName
getLogName
getName
getSkillName
setSkillName
getDescription
isVirtualCard
match
addSubcard
addSubcard
getSubcards
clearSubcards
subcardString
addSubcards
subcardsLength
getType
getSubtype
getTypeId
toString
isNDTrick
targetFixed
targetsFeasible
targetFilter
isAvailable
validate
validateInResponse
isMute
willThrow
canRecast
hasPreAction
getHandlingMethod
setFlags
hasFlag
clearFlags
onUse
use
onEffect
isCancelable
isKindOf
getFlags
isModified
getClassName
getRealCard
CompareByColor
CompareBySuitNumber
CompareByType
Parse
Clone
Suit2String
Number2String
IdsToStrings
StringsToIds
toEquipCard
qobject_cast
toWeapon
qobject_cast
toWrapped
qobject_cast
toTrick
qobject_cast
takeOver
copyEverythingFrom
setModified
SkillCard
setUserString
getSubtype
getType
getTypeId
toString
DummyCard
Package
addTranslationEntry
translate
addPackage
addBanPackage
getBanPackages
cloneCard
cloneCard
cloneCard
cloneSkillCard
getVersion
getVersionName
getExtensions
getKingdoms
getKingdomColor
getSetupString
getAvailableModes
getModeName
getPlayerCount
getRoles
getRoleList
getRoleIndex
getPattern
getCardHandlingMethod
getRelatedSkills
getModScenarioNames
addScenario
getScenario
getGeneral
getGeneralCount
getSkill
getTriggerSkill
getViewAsSkill
getDistanceSkills
getMaxCardsSkills
getTargetModSkills
addSkills
getCardCount
getEngineCard
getCard
getWrappedCard
getLords
getRandomLords
getRandomGenerals
QSet
getRandomCards
getRandomGeneralName
getLimitedGeneralNames
playSystemAudioEffect
playAudioEffect
playSkillAudioEffect
isProhibited
correctDistance
correctMaxCards
correctCardTarget
currentRoom
getCurrentCardUsePattern
getCurrentCardUseReason
Skill
isLordSkill
isAttachedLordSkill
getDescription
isVisible
getDefaultChoice
getEffectIndex
getDialog
getLocation
initMediaSource
playAudioEffect
setFlag
unsetFlag
getFrequency
getSources
TriggerSkill
getViewAsSkill
getTriggerEvents
getPriority
triggerable
trigger
LogMessage
toString
RoomThread
resetRoomState
constructTriggerTable
trigger
trigger
addPlayerSkills
addTriggerSkill
delay
run3v3
action3v3
Room
addSocket
isFull
isFinished
getLack
getMode
getScenario
getThread
getCurrent
setCurrent
alivePlayerCount
getOtherPlayers
getPlayers
getAllPlayers
getAlivePlayers
enterDying
killPlayer
revivePlayer
aliveRoles
gameOver
slashEffect
slashResult
attachSkillToPlayer
detachSkillFromPlayer
setPlayerFlag
setPlayerProperty
setPlayerMark
addPlayerMark
removePlayerMark
setPlayerCardLimitation
removePlayerCardLimitation
clearPlayerCardLimitation
setPlayerCardLock
setPlayerJilei
setCardFlag
setCardFlag
clearCardFlag
clearCardFlag
useCard
damage
sendDamageLog
loseHp
loseMaxHp
applyDamage
recover
cardEffect
cardEffect
judge
sendJudgeResult
getNCards
getLord
askForGuanxing
doGongxin
drawCard
peek
fillAG
takeAG
provide
getLieges
sendLog
showCard
showAllCards
retrial
broadcastSkillInvoke
broadcastSkillInvoke
broadcastSkillInvoke
broadcastSkillInvoke
notifyUpdateCard
broadcastUpdateCard
notifyResetCard
broadcastResetCard
changePlayerGeneral
changePlayerGeneral2
filterCards
acquireSkill
acquireSkill
adjustSeats
swapPile
getDiscardPile
getDrawPile
getCardFromPile
findPlayer
findPlayerBySkillName
findPlayersBySkillName
installEquip
resetAI
changeHero
swapSeat
getLuaState
setFixedDistance
reverseFor3v3
hasWelfare
getFront
signup
getOwner
reconnect
marshal
isVirtual
setVirtual
copyFrom
duplicate
isProhibited
setTag
getTag
removeTag
setEmotion
getCardPlace
getCardOwner
setCardMapping
drawCards
obtainCard
throwCard
moveCardTo
moveCardsAtomic
moveCardsAtomic
moveCards
moveCards
activate
askForSuit
askForKingdom
askForSkillInvoke
QVariant
askForChoice
QVariant
askForDiscard
askForExchange
askForNullification
isCanceled
askForCardChosen
askForCard
askForCard
QVariant
askForUseCard
askForUseSlashTo
askForAG
askForCardShow
askForYiji
askForPindian
askForPlayerChosen
askForGeneral
askForSinglePeach
broadcastInvoke
updateStateItem
notifyProperty
QString
broadcastProperty
QString
nextPlayer
getCurrent
getNextAlive
if
QRegExp
exactMatch
toInt
toString
toStringList
toBool
toDamage
toCardEffect
toSlashEffect
toCardUse
toCard
toPlayer
toDying
toDeath
toDamageStar
toRecover
toJudge
toPindian
toPhaseChange
toMoveOneTime
toResponsed
length
append
prepend
isEmpty
first
last
removeAt
at
]]
sgs.ai_use_value.Fu =6.3
sgs.ai_keep_value.Fu =8

--符
function SmartAI:useCardFu(card, use)
    if self.player:isWounded() then
		use.card=card
		if use.to then use.to:append(self.player) end
		return
	end
end

sgs.ai_skill_choice["fu"]=function(self, choices, data)
	local choice_table = choices:split("+")
	for _,v in ipairs(choice_table) do
		if v=="peach" then
			return "peach"
		elseif v=="fire_slash" then
			return "fire_slash"
		end
	end
end

sgs.ai_view_as.fu_view = function(card, player, card_place)
	local suit = card:getSuitString()
	local number = card:getNumberString()
	local card_id = card:getEffectiveId()
	if card_place ~= sgs.Player_PlaceEquip then
		if card:isKindOf("Fu") then
			return (sgs.fu_view_Pattern[1]..":fu[%s:%s]=%d"):format(suit, number, card_id)
		end
	end
end

