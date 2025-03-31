CC = gcc

# If DEBUG=1 is passed, compile with -g -DDEBUG (debugging).
# Otherwise, compile with -O2 (optimization).
ifeq ($(DEBUG),1)
    CFLAGS = -g -DDEBUG -MMD -MP -Iinclude
else
    CFLAGS = -O2 -MMD -MP -Iinclude
endif

# Object files for each target
MATH_OBJS    = src/mathop/main_math.o src/mathop/mathop.o
STRING_OBJS  = src/stringop/main_string.o src/stringop/stringop.o
DATA_OBJS    = src/dataop/main_data.o src/dataop/dataop.o
ALL_OBJS     = src/main.o src/mathop/mathop.o src/stringop/stringop.o src/dataop/dataop.o

# Default target: build all executables
all: math_ops string_ops data_ops all_ops

# Executable targets
math_ops: $(MATH_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

string_ops: $(STRING_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

data_ops: $(DATA_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

all_ops: $(ALL_OBJS)
	$(CC) $(CFLAGS) -o $@ $^

src/mathop/%.o: src/mathop/%.c
	$(CC) $(CFLAGS) -c $< -o $@

src/dataop/%.o: src/dataop/%.c
	$(CC) $(CFLAGS) -c $< -o $@

src/stringop/%.o: src/stringop/%.c
	$(CC) $(CFLAGS) -c $< -o $@

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f math_ops string_ops data_ops all_ops
	find . -name "*.o" -type f -delete
	find . -name "*.d" -type f -delete

run_math: math_ops
	./math_ops

run_string: string_ops
	./string_ops

run_data: data_ops
	./data_ops

run_all_ops: all_ops
	./all_ops

-include $(wildcard src/*.d src/*/*.d)
