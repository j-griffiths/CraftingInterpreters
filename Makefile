CC := gcc

JAVAC := javac
JAR := jar

SRC := src
BUILD := build
BIN := bin

JAVA_SOURCES := $(shell find $(SRC)/java -name "*.java")
C_SOURCES := $(wildcard $(SRC)/c/*.c)
C_OBJECTS := $(C_SOURCES:$(SRC)/c/%.c=$(BUILD)/c/%.o)

.PHONY: all clean jlox clox

all: jlox clox

jlox: | $(BIN)
	@mkdir -p $(BUILD)
	$(JAVAC) -d $(BUILD) $(JAVA_SOURCES)
	$(JAR) cfe $(BIN)/jlox.jar com.craftinginterpreters.lox.Lox -C $(BUILD) .

clox: $(C_OBJECTS) | $(BIN)
	$(CC) -o $(BIN)/clox $(C_OBJECTS)

$(BUILD)/c/%.o: $(SRC)/c/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN):
	mkdir -p $(BIN)

clean:
	rm -rf $(BUILD) $(BIN)

