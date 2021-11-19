CXX := g++
LD := g++

CXXFLAGS = -std=c++14 -Iinclude
LDFLAGS =
DBG ?=

ifdef DBG
	CXXFLAGS += -O0 -g
else
	CXXFLAGS += -O2
endif

LIB =

SRC = main.cpp

OBJ = $(patsubst %.cpp, %.o, $(SRC))

TARGET = matrix

all: $(TARGET)

$(OBJ): %.o : %.cpp include/*.h
	$(CXX) -c $(CXXFLAGS) $< -o $@

$(TARGET): $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $(TARGET) $(LIB)

clean:
	rm -f *.o $(TARGET)
