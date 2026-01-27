#include <GameTime.h>
#include <SFML/Graphics.hpp>
#include <iostream>
#include <config.h>


float GameTime::deltaTimeSeconds = 0;
float GameTime::deltaTimeMicroseconds = 0;

void GameTime::update(sf::Time time) {
    // deltaTimeSeconds = time.asSeconds();
    deltaTimeSeconds = time.asSeconds(); //std::min(time.asMicroseconds() / 10000.f, 1.f / (float)Config::FPS);

}
