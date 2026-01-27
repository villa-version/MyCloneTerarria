#pragma once

#include <SFML/Graphics.hpp>


class Camera {
    sf::View view;

public:
    Camera(sf::Vector2f pos, sf::Vector2f size);
    void update(const sf::Vector2f pos);
    const sf::View& getView() const;
};
