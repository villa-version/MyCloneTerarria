#pragma once

#include <SFML/Graphics.hpp>
#include <config.h>
#include <TextureManager.h>
#include <World.h>
#include <InputManager.h>

class App {
    sf::RenderWindow window;
    TextureManager textureManager;
    World world;
    InputManager input;

public:
    App();
    void init();
    int run();
    void loadAllTextures();
};
