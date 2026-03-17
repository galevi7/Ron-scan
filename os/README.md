# Neural OS Layer - Ron's Expression Control System

> **Agent 2 - Your Mission: Find the buffer overflow in Ron's neural pathway
> code that disables his silly face lock.**

## Background

The CerebralGit scan extracted the low-level C code that controls Ron's
facial expressions. The program maintains a `neural_state_t` struct that
holds Ron's current expression and a "silly face lock" flag. The code has
a classic buffer overflow vulnerability - if you can craft the right input,
you can overflow from one struct field into adjacent fields and disable
the silly face lock.

There's also an assembly routine (`face_trigger.asm`) that contains a
hidden subroutine - see if you can find it.

## Prerequisites

- GCC (`sudo apt install gcc` or `sudo dnf install gcc`)
- GDB (`sudo apt install gdb` or `sudo dnf install gdb`)
- NASM (for the assembly file: `sudo apt install nasm` or `sudo dnf install nasm`)
- Make

## Step 1: Build the Program

```bash
make all
```

This compiles both the C program and the assembly module.

## Step 2: Run It Normally

```bash
./ron_neural_pathways
```

You'll see Ron's neural state. The expression is "serious_face" and the
silly face lock is ENGAGED. Try typing normal inputs - nothing breaks it.

## Step 3: Find the Vulnerability

Open the source code. Look at:
- The `neural_state_t` struct layout - what fields are adjacent in memory?
- The `process_neural_input()` function - how does it read input?
- What happens if your input is longer than the buffer?

## Debugging Guide

```bash
# Run in GDB
gdb ./ron_neural_pathways

# Set a breakpoint after input
(gdb) break process_neural_input
(gdb) run

# Examine the struct in memory
(gdb) print state
(gdb) x/80xb state    # examine 80 bytes of the struct

# After entering a long input, check what changed
(gdb) x/80xb state
```

## Hints (read only if stuck)

<details>
<summary>Hint 1 - The struct layout</summary>
The struct fields are laid out sequentially in memory:

```
[input_buffer: 16 bytes][current_expression: 32 bytes][resistance_level: 4 bytes][silly_face_locked: 4 bytes]
```

If you overflow `input_buffer`, you write into `current_expression` and beyond.
</details>

<details>
<summary>Hint 2 - The dangerous function</summary>
The code uses `gets()` which performs NO bounds checking. Any input longer
than 16 bytes overflows into adjacent struct fields.
</details>

<details>
<summary>Hint 3 - Crafting the exploit</summary>
You need to write exactly 52 bytes to reach `silly_face_locked` (16 + 32 + 4).
The last 4 bytes must be all zeros to set `silly_face_locked = 0`.

```bash
python3 -c "import sys; sys.stdout.buffer.write(b'A'*52 + b'\x00\x00\x00\x00')" | ./ron_neural_pathways
```
</details>

<details>
<summary>Hint 4 - The assembly secret</summary>
Look at `face_trigger.asm`. There's a function called `_secret_message` that
is never called from main. Disassemble it or read the `.data` section to
find the hidden string.
</details>

## What You're Looking For

1. Use GDB to visualize the struct memory layout
2. Demonstrate the buffer overflow happening in real-time
3. Show the silly face lock being disabled
4. Bonus: find the hidden message in the assembly file

Film your GDB session. The audience wants to see bytes being overwritten.

---

*"His neural pathways are strong, but his buffers are weak." - CerebralGit Report*
