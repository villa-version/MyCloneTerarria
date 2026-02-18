#include <SFML/Graphics.hpp>
#include <Camera.h>

Camera::Camera(sf::Vector2f pos, sf::Vector2f size) : view(pos, size) {}

void Camera::update(const sf::Vector2f pos) {
    view.setCenter({pos.x + 25, pos.y + 32.5f});
}

const sf::View& Camera::getView() const {
    return view;
}
