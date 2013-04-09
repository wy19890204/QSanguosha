#include "darksoulpackage.h"
#include "client.h"
#include "engine.h"
#include "general.h"
#include "room.h"
#include "maneuvering.h"

Fu::Fu(Card::Suit suit, int number)
    :BasicCard(suit, number)
{
    setObjectName("fu");

}

QString Fu::getSubtype() const{
    return "buff_card";
}

bool Fu::isAvailable(const Player *player) const{
     Slash *slash = new Slash(Card::NoSuit, 0);
     Peach *peach = new Peach(Card::NoSuit, 0);
     Analeptic *analeptic = new Analeptic(Card::NoSuit, 0);
     slash->deleteLater();
     peach->deleteLater();
     analeptic->deleteLater();
     return slash->isAvailable(player) || peach->isAvailable(player)|| analeptic->isAvailable(player);
}

bool Fu::targetsFeasible(const QList<const Player *> &targets, const Player *) const{
    return !targets.isEmpty();
}

bool Fu::targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const{

    if(targets.length()==1&&targets.at(0)->objectName()==Self->objectName()){
        return false;
    }

    Slash *slash=new Slash(this->getSuit(),this->getNumber());
    int slash_targets = 1 + Sanguosha->correctCardTarget(TargetModSkill::ExtraTarget, Self,slash );
    bool distance_limit = ((1 + Sanguosha->correctCardTarget(TargetModSkill::DistanceLimit, Self, slash)) < 500);
    if (Self->hasFlag("slashNoDistanceLimit"))
        distance_limit = false;

    int rangefix = 0;
    if(Self->getWeapon() && subcards.contains(Self->getWeapon()->getId())){
        const Weapon* weapon = qobject_cast<const Weapon*>(Self->getWeapon()->getRealCard());
        rangefix += weapon->getRange() - 1;
    }

    if(Self->getOffensiveHorse() && subcards.contains(Self->getOffensiveHorse()->getId()))
        rangefix += 1;

    if(Self->hasFlag("slashTargetFix")){
        if(targets.isEmpty())
            return  to_select->hasFlag("SlashAssignee") && Self->canSlash(to_select, slash, distance_limit, rangefix);
        else {
            if (Self->hasFlag("slashDisableExtraTarget")) return false;
            bool canSelect = false;
            foreach(const Player *p, targets){
                if(p->hasFlag("SlashAssignee")){
                    canSelect = true;
                    break;
                }
            }
            if(!canSelect) return false;
        }
    }

    if (targets.length() >= slash_targets) {
        if (Self->hasSkill("duanbing") && targets.length() == slash_targets) {
            bool hasExtraTarget = false;
            foreach (const Player *p, targets)
                if (Self->distanceTo(p) == 1) {
                    hasExtraTarget = true;
                    break;
                }
            if (hasExtraTarget)
                return Self->canSlash(to_select, slash, distance_limit, rangefix);
            else
                return Self->canSlash(to_select, slash) && Self->distanceTo(to_select) == 1;
        } else
            return false;
    }

    Peach *peach = new Peach(Card::NoSuit, 0);
    Analeptic *analeptic = new Analeptic(Card::NoSuit, 0);
    peach->deleteLater();
    analeptic->deleteLater();
    return Self->canSlash(to_select, slash, distance_limit, rangefix)||to_select->objectName()==Self->objectName()&&(peach->isAvailable(Self)||analeptic->isAvailable(Self));
}

void Fu::onUse(Room *room, const CardUseStruct &card_use) const{
    CardUseStruct use = card_use;
    BasicCard::onUse(room, use);
    Card *card=NULL;
    ServerPlayer *source=use.from;
    if(use.to.at(0)->objectName()==source->objectName()){
        Peach *peach = new Peach(Card::NoSuit, 0);
        Analeptic *analeptic = new Analeptic(Card::NoSuit, 0);
        peach->deleteLater();
        analeptic->deleteLater();
        QString choices="";
        QStringList list;
        if(peach->isAvailable(source)){
            list<<"peach";
        }
        if(analeptic->IsAvailable(source)){
            list<<"analeptic";
        }
        choices=list.join("+");
        QString choice=room->askForChoice(source,this->objectName(),choices);
        if(choice=="analeptic"){
            card=new Analeptic(this->getSuit(),this->getNumber());
        }else{
            card=new Peach(this->getSuit(),this->getNumber());
        }
    }else{
        QString choice=room->askForChoice(source,this->objectName(),"slash+fire_slash+thunder_slash");
        if(choice=="slash"){
             card=new Slash(this->getSuit(),this->getNumber());
        }else if(choice=="fire_slash"){
             card=new FireSlash(this->getSuit(),this->getNumber());
        }else if(choice=="thunder_slash"){
             card=new ThunderSlash(this->getSuit(),this->getNumber());
        }
    }
    card->addSubcard(use.card);
    use.card=card;
    room->useCard(use);
}


DarksoulPackage::DarksoulPackage()
    :Package("darksoul")
{
    QList<Card *> cards;

    // spade
     cards << new Fu(Card::Spade,3);

    // club
    cards << new Fu(Card::Club, 3);

    // heart
    cards << new Fu(Card::Heart, 4);

    // diamond
    cards << new Fu(Card::Diamond,4);


    foreach(Card *card, cards)
        card->setParent(this);

    type = CardPack;

}

ADD_PACKAGE(Darksoul)
