cmake_minimum_required(VERSION 3.11)

if(APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15" CACHE STRING "" FORCE)
endif()

project(MyCloneTerraria LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


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


# Use pre-built SFML if available (run scripts/build-deps.sh first),
# otherwise fall back to building from source via FetchContent.
set(_sfml_install "${CMAKE_SOURCE_DIR}/.deps/sfml-install")
if(EXISTS "${_sfml_install}")
    list(PREPEND CMAKE_PREFIX_PATH "${_sfml_install}")
endif()

set(SFML_STATIC_LIBRARIES ON)
find_package(SFML 3 COMPONENTS Graphics Window System Audio QUIET)

if(SFML_FOUND)
    message(STATUS "SFML: using pre-built installation")
else()
    message(STATUS "SFML: building from source (run scripts/build-deps.sh once to speed this up)")
    set(FETCHCONTENT_BASE_DIR "${CMAKE_SOURCE_DIR}/.deps" CACHE PATH "" FORCE)
    set(SFML_BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
    include(FetchContent)
    FetchContent_Declare(SFML
        GIT_REPOSITORY https://github.com/SFML/SFML.git
        GIT_TAG 3.0.2
        GIT_SHALLOW ON
    )
    FetchContent_MakeAvailable(SFML)
endif()

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

