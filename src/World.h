#pragma once

#include <player.h>
#include <config.h>
#include <Background.h>
#include <TextureManager.h>
#include <Camera.h>
#include <InputManager.h>
#include <PhysicsSystem.h>
#include <SFML/Graphics.hpp>


class World {

    sf::Clock clock;
    TextureManager& textureManager;
    Player player;
    Background background;
    Camera camera;
    PhysicsSystem physicsSys;

public:
    explicit World(TextureManager& textureManager);
    void init();
    void update(InputManager& input);
    void render(sf::RenderWindow& window);
};
