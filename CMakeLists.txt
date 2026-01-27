cmake_minimum_required(VERSION 3.5)

project(MyCloneTerraria LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 REQUIRED COMPONENTS Core Widgets)

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
    headers/App.h
	headers/config.h
	headers/World.h
	headers/player.h
	headers/Vector2.h
	headers/Background.h
	headers/TextureManager.h
	headers/Transform.h
	headers/Camera.h
	headers/InputManager.h
	headers/PhysicsBody.h
	headers/PhysicsSystem.h
	headers/GameTime.h
)

# Создаём исполняемый файл
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# Добавляем include для заголовков
target_include_directories(${PROJECT_NAME} PRIVATE headers)

# Линкуем Qt
target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Widgets)

# Set SFML directory for Windows, Linux will find it automatically
if(WIN32)
    set(SFML_DIR "D:/SFML-2.5.1/lib/cmake/SFML")
endif()

find_package(SFML 2.5 COMPONENTS graphics window system REQUIRED)

target_link_libraries(${PROJECT_NAME}
    sfml-graphics
    sfml-window
    sfml-system
	sfml-audio
)

