#pragma once

#include <unordered_map>
#include <string>
#include <SFML/Graphics.hpp>


class TextureManager{

    std::unordered_map<std::string, sf::Texture> textures;

public:

    void load(const std::string& id, const std::string& fileName);
    const sf::Texture& get(const std::string& id) const;
};
