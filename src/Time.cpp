#include <Time.h>
#include <SFML/Graphics.hpp>


void GameTime::Time::update(sf::Time time) {
    deltaTimeSeconds = time.asSeconds();
    deltaTimeMicroseconds = time.asMilliseconds();
}
