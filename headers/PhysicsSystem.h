#pragma once

#include <player.h>


class PhysicsSystem {

    const double gravity = 98*2;
    const double friction = 0.99;

public:
    void update(Player& player);
};
