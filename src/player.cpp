#include <SFML/Graphics.hpp>
#include <iostream>
#include <player.h>
#include <config.h>
#include <Transform.h>
#include <TextureManager.h>
#include <InputManager.h>
#include <GameTime.h>
#include <cmath>


Player::Player(const Transform& transform, TextureManager& textureManager)
    : transform(transform),
      textureManager(textureManager) {}

void Player::init() {
    setTexture();
}

void Player::setTexture() {
    auto& texture = textureManager.get("player");
    auto size = texture.getSize();
    sprite.emplace(texture);
    sprite->setScale({transform.size.x / size.x, transform.size.y / size.y});
    sprite->setPosition({transform.position.x, transform.position.y});
}

void Player::update(InputManager& input) {
    control(input);

    physics.velocity.x += physics.acceleration.x * GameTime::deltaTimeSeconds;
    physics.velocity.y += physics.acceleration.y * GameTime::deltaTimeSeconds;

    transform.position.x += physics.velocity.x * GameTime::deltaTimeSeconds;
    transform.position.y += physics.velocity.y * GameTime::deltaTimeSeconds;

    sprite->setPosition({transform.position.x, transform.position.y});

}

void Player::control(InputManager& input) {
    if (input.left) {
        physics.acceleration.x = -1000;
    }
    else if (input.right) {
        physics.acceleration.x = 1000;
    } else {
         physics.acceleration.x = 0;
    }
    if (input.jump) {
        physics.acceleration.y = -100;
    } else {
         physics.acceleration.y = 0;
    }
}

void Player::draw(sf::RenderWindow& window) {
    if (sprite) window.draw(*sprite);
}


const sf::Vector2f Player::getPosition() const {
    return sf::Vector2f(transform.position.x, transform.position.y);
}

void Player::setPosition(const sf::Vector2f newPos) {
    transform.position.x = newPos.x;
    transform.position.y = newPos.y;
}

void Player::setVelocityX(double newVelX) {
    physics.velocity.x = newVelX;
}

void Player::setVelocityY(double newVelY) {
    physics.velocity.y = newVelY;
}

float Player::getVelocityX() const {
    return physics.velocity.x;
}

float Player::getVelocityY() const {
    return physics.velocity.y;
}
