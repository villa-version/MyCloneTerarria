cmake_minimum_required(VERSION 3.11)

project(MyCloneTerraria LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Добавляем исходники и заголовки
set(SOURCES
    src/main.cpp
	src/App.cpp
	src/World.cpp
	src/player.cpp
	src/TextureManager.cpp
	src/Background.cpp
	src/Camera.cpp
	src/InputManager.cpp
	src/PhysicsSystem.cpp
	src/GameTime.cpp
)

set(HEADERS
    src/App.h
    src/config.h
    src/World.h
    src/player.h
    src/Vector2.h
    src/Background.h
    src/TextureManager.h
    src/Transform.h
    src/Camera.h
    src/InputManager.h
    src/PhysicsBody.h
    src/PhysicsSystem.h
    src/GameTime.h
)

# Создаём исполняемый файл
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# Добавляем include для заголовков
target_include_directories(${PROJECT_NAME} PRIVATE src)


set(FETCHCONTENT_BASE_DIR "${CMAKE_SOURCE_DIR}/.deps" CACHE PATH "" FORCE)

include(FetchContent)
FetchContent_Declare(SFML
    GIT_REPOSITORY https://github.com/SFML/SFML.git
    GIT_TAG 3.0.2
    GIT_SHALLOW ON
)
FetchContent_MakeAvailable(SFML)

target_link_libraries(${PROJECT_NAME}
    SFML::Graphics
    SFML::Window
    SFML::System
    SFML::Audio
)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/assets $<TARGET_FILE_DIR:${PROJECT_NAME}>/assets
)

