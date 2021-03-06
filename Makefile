# Makefile template for shared library
 
CXX = g++ # C++ compiler
CXXFLAGS = -fPIC -O3 -g -DNDEBUG # C flags
LDFLAGS = -shared  # linking flags
RM = rm -f  # rm command
TARGET_LIB = rp.so # target lib
DEPENDENCES = src/FelzenSegment
CONSTANTS = 

#SRCS = $(wildcard src/*.cpp ) # source files
SRCS = src/RP_python.cpp $(wildcard src/stopwatch/*.cpp)
OBJS = $(SRCS:.cpp=.o)
 
.PHONY: all
all: ${TARGET_LIB} dependences

dependences:
	$(MAKE) -C $(DEPENDENCES)

$(TARGET_LIB): $(OBJS)
	$(CXX) ${LDFLAGS} -o $@ $^
 
$(SRCS:.cpp=.d):%.d:%.cpp
	$(CXX) $(CXXFLAGS) -MM $< >$@
 
include $(SRCS:.cpp=.d)
 
.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.cpp=.d)
	$(MAKE) -C $(DEPENDENCES) clean
