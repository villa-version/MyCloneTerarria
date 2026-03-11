BUILD_DIR := build
NPROC     := $(shell nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

ifeq ($(OS),Windows_NT)
    BUILD_CONFIG := Release
    RUN_CMD      := cd $(BUILD_DIR)/Release && MyCloneTerraria.exe
else
    BUILD_CONFIG := Debug
    RUN_CMD      := cd $(BUILD_DIR) && ./MyCloneTerraria
endif

.DEFAULT_GOAL := build

deps:
	chmod +x scripts/build-deps.sh
	./scripts/build-deps.sh

build:
	cmake -B $(BUILD_DIR) -S . -DCMAKE_BUILD_TYPE=$(BUILD_CONFIG)
	cmake --build $(BUILD_DIR) --parallel $(NPROC) --config $(BUILD_CONFIG)

run: build
	$(RUN_CMD)

dev:
	chmod +x scripts/dev.sh
	./scripts/dev.sh

clean:
	rm -rf $(BUILD_DIR)

.PHONY: deps build run dev clean
