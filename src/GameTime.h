#pragma once

#include <SFML/Graphics.hpp>


struct GameTime {

    static float deltaTimeSeconds;
    static float deltaTimeMicroseconds;

    static void update(sf::Time dt);
};



