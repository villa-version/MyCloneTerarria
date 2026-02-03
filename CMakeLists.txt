cmake_minimum_required(VERSION 3.10)
project(MyCloneTerarria)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find SFML
set(SFML_STATIC_LIBRARIES TRUE)
find_package(SFML 2.5 COMPONENTS graphics window system)

if(SFML_FOUND)
    # Use system SFML
    include_directories(${SFML_INCLUDE_DIR})
else()
    # Fallback for Windows with custom SFML path
    if(WIN32)
        set(SFML_INCLUDE_DIR "D:/SFML-2.5.1/include")
        set(SFML_LIBRARIES sfml-graphics-s sfml-window-s sfml-system-s sfml-main opengl32 gdi32 winmm)
        set(SFML_LIBRARY_DIR "D:/SFML-2.5.1/lib")
        include_directories(${SFML_INCLUDE_DIR})
        link_directories(${SFML_LIBRARY_DIR})
        add_definitions(-DSFML_STATIC)
    else()
        message(FATAL_ERROR "SFML not found. Please install SFML.")
    endif()
endif()

# Include directories
include_directories(headers)

# Source files
file(GLOB SOURCES "src/*.cpp")

# Executable
add_executable(${PROJECT_NAME} WIN32 ${SOURCES})

# Link SFML
if(SFML_FOUND)
    target_link_libraries(${PROJECT_NAME} sfml-graphics sfml-window sfml-system)
else()
    target_link_libraries(${PROJECT_NAME} ${SFML_LIBRARIES})
endif()

# Copy assets to build directory
file(COPY assets DESTINATION ${CMAKE_BINARY_DIR})