#ifndef DARKSOULPACKAGE_H
#define DARKSOULPACKAGE_H

#include "standard.h"
#include "package.h"
#include "card.h"

class Fu: public BasicCard{
    Q_OBJECT

public:
    Q_INVOKABLE Fu(Card::Suit suit, int number);
    virtual QString getSubtype() const;
    virtual bool isAvailable(const Player *player) const;

    virtual bool targetsFeasible(const QList<const Player *> &targets, const Player *Self) const;
    virtual bool targetFilter(const QList<const Player *> &targets, const Player *to_select, const Player *Self) const;
    virtual void onUse(Room *room, const CardUseStruct &card_use) const;

};

class DarksoulPackage : public Package{
    Q_OBJECT

public:
    DarksoulPackage();
};



#endif // DARKSOULPACKAGE_H
