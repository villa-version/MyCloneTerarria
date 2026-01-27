#include <PhysicsSystem.h>
#include <player.h>
#include <Vector2.h>
#include <iostream>
#include <GameTime.h>


void PhysicsSystem::update(Player& player) {

    float velX = player.getVelocityX();
    float imparedVelX = velX * friction;
    player.setVelocityX(imparedVelX);

}
