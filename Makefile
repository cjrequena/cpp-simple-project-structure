# Determine the platform
UNAME_S := $(shell uname -s)

#================================
#
#================================
ifeq ($(UNAME_S),Darwin)
  CXX := clang++ -arch x86_64
else
  CXX := g++
endif
CXXFLAGS := -g
LDFLAGS  :=
BUILD_DIR    := ./build
OBJ_DIR  := $(BUILD_DIR)/objects
APP_DIR  := $(BUILD_DIR)/apps
TARGET   := program
INCLUDE  := -I include/
SRC      := $(shell find src -type f -name *.cpp)
# SRC      :=                      \
#    $(wildcard src/helloworld/*.cpp) \
#    $(wildcard src/datatypes/*.cpp) \
#    $(wildcard src/*.cpp)         \

OBJECTS := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

#================================
#
#================================
$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

#================================
#
#================================
$(APP_DIR)/$(TARGET): $(OBJECTS)
	@echo "Linking ..."
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) $(LDFLAGS) -o $(APP_DIR)/$(TARGET) $(OBJECTS)

#================================
#
#================================
.PHONY: clean

#================================
#
#================================
build:
	@echo "Building ..."
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

#================================
#
#================================
clean:
	@echo "Cleaning ..."
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*

#================================
#
#================================
print:
	@echo " SRC: ${SRC}"
	@echo " OBJECTS: ${OBJECTS}"
	@echo " BUILD_DIR: ${BUILD_DIR}"
	@echo " OBJ_DIR: ${OBJ_DIR}"
	@echo " APP_DIR: ${APP_DIR}"
	@echo " TARGET: ${TARGET}"
	@echo " INCLUDE: ${INCLUDE}"
	@echo " CXXFLAGS: ${CXXFLAGS}"
	@echo " LDFLAGS: ${LDFLAGS}"

#================================
#
#================================
all: print clean build $(APP_DIR)/$(TARGET)