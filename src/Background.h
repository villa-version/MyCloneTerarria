#pragma once

#include <SFML/Graphics.hpp>
#include <Transform.h>
#include <TextureManager.h>
#include <optional>


class Background {
    Transform transform;
    TextureManager& textureManager;
    std::optional<sf::Sprite> sprite;

public:
    Background(const Transform& transform, TextureManager& textureManager);
    void init();
    void setTexture();
    void draw(sf::RenderWindow& window);
};
