#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define INPUT_BUFFER_LEN  16
#define EXPRESSION_LEN    32

/*
 * Ron's Neural State Structure
 *
 * MEMORY LAYOUT (total: 56 bytes):
 * +-------------------+  offset 0
 * | input_buffer [16] |
 * +-------------------+  offset 16
 * | current_expr [32] |
 * +-------------------+  offset 48
 * | resistance_level  |  (4 bytes)
 * +-------------------+  offset 52
 * | silly_face_locked |  (4 bytes)
 * +-------------------+  offset 56
 */
typedef struct {
    char input_buffer[INPUT_BUFFER_LEN];
    char current_expression[EXPRESSION_LEN];
    int resistance_level;
    int silly_face_locked;
} neural_state_t;

void init_neural_state(neural_state_t *state) {
    memset(state, 0, sizeof(neural_state_t));
    strncpy(state->current_expression, "serious_face", EXPRESSION_LEN - 1);
    state->resistance_level = 9999;
    state->silly_face_locked = 1;
}

void display_state(neural_state_t *state) {
    printf("\n");
    printf("+============================+\n");
    printf("|   RON'S NEURAL STATE       |\n");
    printf("+============================+\n");
    printf("| Expression : %-13s |\n", state->current_expression);
    printf("| Resistance : %-13d |\n", state->resistance_level);
    printf("| Silly Lock : %-13s |\n",
           state->silly_face_locked ? "ENGAGED" : ">> DISENGAGED <<");
    printf("+============================+\n");
    printf("\n");
}

void process_neural_input(neural_state_t *state) {
    printf("[neural-input] Enter stimulus: ");
    fflush(stdout);

    /*
     * VULNERABILITY: gets() does not check the length of input.
     * input_buffer is only 16 bytes, but gets() will happily write
     * past it into current_expression, resistance_level, and
     * silly_face_locked.
     *
     * To disable the silly face lock, overflow 52 bytes
     * (16 + 32 + 4) into input_buffer, then write 4 zero bytes
     * to overwrite silly_face_locked with 0.
     */
    gets(state->input_buffer);

    printf("[neural-input] Processing: %s\n", state->input_buffer);
}

void check_silly_face(neural_state_t *state) {
    if (!state->silly_face_locked) {
        printf("\n");
        printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        printf("!!                                      !!\n");
        printf("!!   SILLY FACE LOCK: DISENGAGED        !!\n");
        printf("!!   EXPRESSION OVERRIDE DETECTED       !!\n");
        printf("!!                                      !!\n");
        printf("!!   Ron is now making: %-15s !!\n", state->current_expression);
        printf("!!                                      !!\n");
        printf("!!   OPERATION SILLY FACE: SUCCESS      !!\n");
        printf("!!                                      !!\n");
        printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
        printf("\n");
        printf("Quick! Take the photo for the t-shirt!\n\n");
    }
}

void print_banner(void) {
    printf("\n");
    printf("  ____             _       ____            _       \n");
    printf(" |  _ \\ ___  _ __ ( )___  | __ ) _ __ __ _(_)_ __  \n");
    printf(" | |_) / _ \\| '_ \\|// __| |  _ \\| '__/ _` | | '_ \\ \n");
    printf(" |  _ < (_) | | | | \\__ \\ | |_) | | | (_| | | | | |\n");
    printf(" |_| \\_\\___/|_| |_| |___/ |____/|_|  \\__,_|_|_| |_|\n");
    printf("\n");
    printf("  Neural Pathway Simulator v1.0\n");
    printf("  CerebralGit Scan Export\n");
    printf("  Subject: Ron\n");
    printf("\n");
}

int main(void) {
    neural_state_t ron_brain;
    init_neural_state(&ron_brain);

    print_banner();
    display_state(&ron_brain);

    printf("Type neural stimuli to interact with Ron's brain.\n");
    printf("(His silly face lock is ENGAGED. Can you break it?)\n\n");

    while (1) {
        process_neural_input(&ron_brain);
        display_state(&ron_brain);
        check_silly_face(&ron_brain);

        if (!ron_brain.silly_face_locked) {
            break;
        }
    }

    return 0;
}
