import std::io;

extern fn char get_char() @extern("getchar");

const int MAX_PLAYER = 2;
const int BOARD_SIZE = 9;

alias Board = ushort;

const ushort[] VICTORY_TABLE = {
    0x07,  // row 0,1,2
    0x38,  // row 3,4,5
    0x1C0, // row 6,7,8
    0x49,  // column 0,3,6
    0x92,  // column 1,4,7
    0x124, // column 2,5,8
    0x111, // diagonal 0,4,8
    0x54   // diagonal 2,4,6
};

enum Player {
    PLAYER_ONE,
    PLAYER_TWO
} 

enum Move {
    MOVE_INVALID,
    MOVE_VALID,
}

struct Game {
    Board[2] board;
    Player current_player;
}

fn void Game.next_player(Game* self) {
    self.current_player = (Player) (1 - self.current_player.ordinal);
}

fn void Board.set_bit(Board* self, ushort pos) {
    assert(pos < BOARD_SIZE);
    *self |= (1ull << pos);
}

fn void Board.clear_bit(Board* self, ushort pos) {
    assert(pos < BOARD_SIZE);
    *self &= ~(1ull << pos);
}

fn bool Board.test_bit(Board self, ushort pos) {
    assert(pos < BOARD_SIZE);
    return (bool) ((self >> pos ) & 1);
}

fn Move Game.make_move(Game *self, ushort pos, Player player) {
    int this_player = player.ordinal;
    int other = 1 - self.current_player.ordinal;
    if (
        player == self.current_player
        && !self.board[this_player].test_bit(pos)
        && !self.board[other].test_bit(pos)
        ) {
        self.board[this_player].set_bit(pos);
        self.next_player();
        return Move.MOVE_VALID;
    }
    return Move.MOVE_INVALID;
}

fn void Game.print(Game* self) {
    for (ushort i = 0; i < BOARD_SIZE; i++) {
        if (self.board[0].test_bit(i)) {
            io::printf("X ");
        }
        else if (self.board[1].test_bit(i)) {
             io::printf("O ");
        }
        else {
            io::printf(". ");
        } 

        if ((i + 1) % 3 == 0) {
            io::printf("\n");
        } 
    }
}

fn int Game.check_winner(Game* self) {
    for (int player = 0; player < MAX_PLAYER; player++) {
        for (int i = 0; i < 8; i++) {
            if ((self.board[player] & VICTORY_TABLE[i]) == VICTORY_TABLE[i]) {
                return player;
            }
        }
    }
    return -1;
}

fn void main() {
    Game game;
    int winner;

    for (ushort i = 0; i < BOARD_SIZE; i ++) {
        ushort jogada_pos;
        Move move_status;

        do {
            io::printf("Jogador %d: ", game.current_player.ordinal);
            char c = get_char();
            if (c < '0' || c > '8') continue; // posição válida 0-8
            jogada_pos = (ushort)(c - '0');
            move_status = game.make_move(jogada_pos, game.current_player);
        } while (move_status == Move.MOVE_INVALID);

        game.print();
        winner = game.check_winner();
        if (winner != -1) {
            io::printf("O jogador eh o player %d", winner);
            break;
        }
    }
}

