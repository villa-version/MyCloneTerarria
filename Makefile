CXX = g++
CXXFLAGS = -std=c++17 -g -fdiagnostics-color=always
LDFLAGS =

# Detect OS
ifeq ($(OS),Windows_NT)
    CXXFLAGS += -ID:/SFML-2.5.1/include -Iheaders -DSFML_STATIC
    LDFLAGS += -LD:/SFML-2.5.1/lib -lsfml-graphics-s -lsfml-window-s -lsfml-system-s -lsfml-main -lopengl32 -lgdi32 -lwinmm
    EXECUTABLE = build/main.exe
else
    CXXFLAGS += -Iheaders
    LDFLAGS += -lsfml-graphics -lsfml-window -lsfml-system
    EXECUTABLE = build/main
endif

SOURCES = $(wildcard src/*.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	@mkdir -p build
	$(CXX) $(OBJECTS) -o $@ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

.PHONY: all clean