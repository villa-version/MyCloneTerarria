#include <InputManager.h>
#include <SFML/Graphics.hpp>


void InputManager::update() {
    left = sf::Keyboard::isKeyPressed(sf::Keyboard::A);
    right = sf::Keyboard::isKeyPressed(sf::Keyboard::D);
    jump = sf::Keyboard::isKeyPressed(sf::Keyboard::W);
}
