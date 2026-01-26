#include <App.h>


App::App() : window(sf::VideoMode(Config::SCREEN_WIDTH, Config::SCREEN_HEIGHT), "CloneTerraria"),
    world(textureManager) {}

void App::init() {
    loadAllTextures();
    world.init();
}

void App::loadAllTextures() {
    textureManager.load("background", "../assets/textures/background.jpg");
    textureManager.load("player", "../assets/textures/player.png");
}


int App::run() {
    while (window.isOpen())
    {
        sf::Time dt = clock.restart();
        float deltaTime = dt.asMicroseconds();

        sf::Event event;
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                window.close();
        }

        window.clear(sf::Color::White);
        input.update();
        world.update(input, deltaTime);
        world.render(window);
        window.display();
    }

    return 0;
}

