CC = gcc
CFLAGS = -g -fno-stack-protector -z execstack -no-pie -Wall
NASM = nasm
NASM_FLAGS = -f elf64 -g

all: ron_neural_pathways face_trigger.o

ron_neural_pathways: ron_neural_pathways.c
	$(CC) $(CFLAGS) -o $@ $<
	@echo ""
	@echo "=== BUILD COMPLETE ==="
	@echo "Binary: ron_neural_pathways"
	@echo "NOTE: Compiled with -fno-stack-protector for... reasons."
	@echo "Run with: ./ron_neural_pathways"
	@echo ""

face_trigger.o: face_trigger.asm
	$(NASM) $(NASM_FLAGS) -o $@ $<
	@echo "Assembly module compiled."
	@echo "Inspect with: objdump -d face_trigger.o"
	@echo "Find the hidden function with: objdump -t face_trigger.o"

clean:
	rm -f ron_neural_pathways face_trigger.o

.PHONY: all clean
