#pragma once

#include <SFML/Graphics.hpp>
#include <config.h>
#include <Transform.h>
#include <TextureManager.h>
#include <utility>
#include <InputManager.h>
#include <PhysicsBody.h>
#include <Vector2.h>


class Player {
    Transform transform;
    TextureManager& textureManager;
    sf::Sprite sprite;
    PhysicsBody physics;

public:

    explicit Player(const Transform& transform, TextureManager& textureManager);
    void init();
    void setTexture();
    void update(InputManager& input);
    void control(InputManager& input);
    void draw(sf::RenderWindow& window);
    const sf::Vector2f getPosition() const;
    void setPosition(const sf::Vector2f pos);
    void setVelocityX(double newVelX);
    void setVelocityY(double newVelY);
    float getVelocityX() const;
    float getVelocityY() const;
};
