module main;
import std::io;
import game;
import render;

const int WINDOW_WIDTH  = 600;
const int WINDOW_HEIGHT = 600;
const int CELL_SIZE = 200;

const int GRID_WIDTH  = 3;
const int GRID_HEIGHT = 3;

const int LINE_SIZE = 10;

fn int get_mouse_cell_position() {
    Vector2 mouse = render::get_mouse_position();

    int cellX = (int)((mouse.x + LINE_SIZE / 2) / CELL_SIZE);
    int cellY = (int)((mouse.y + LINE_SIZE / 2) / CELL_SIZE);

    cellX = min(cellX, GRID_WIDTH - 1);
    cellY = min(cellY, GRID_HEIGHT - 1);

    int mouse_pos = cellY * GRID_WIDTH + cellX;

    return mouse_pos;
}


fn void draw_board() {
    // vertical lines
    render::draw_line_ex(
        render::vector2(CELL_SIZE - LINE_SIZE / 2, 0),
        render::vector2(CELL_SIZE - LINE_SIZE / 2, CELL_SIZE * GRID_HEIGHT),
        LINE_SIZE,
        render::WHITE
    );

    render::draw_line_ex(
        render::vector2(CELL_SIZE * 2 - LINE_SIZE / 2, 0),
        render::vector2(CELL_SIZE * 2 - LINE_SIZE / 2, CELL_SIZE * GRID_HEIGHT),
        LINE_SIZE,
        render::WHITE
    );

    // horizontal lines
    render::draw_line_ex(
        render::vector2(0, CELL_SIZE - LINE_SIZE / 2),
        render::vector2(CELL_SIZE * GRID_WIDTH, CELL_SIZE - LINE_SIZE / 2),
        LINE_SIZE,
        render::WHITE
    );

    render::draw_line_ex(
        render::vector2(0, CELL_SIZE * 2 - LINE_SIZE / 2),
        render::vector2(CELL_SIZE * GRID_WIDTH, CELL_SIZE * 2 - LINE_SIZE / 2),
        LINE_SIZE,
        render::WHITE
    );
}


fn void draw() {
   draw_board();
}

fn void update() {
   if (render::is_mouse_button_pressed(render::MOUSE_LEFT_BUTTON)) {
      int mouse = get_mouse_cell_position();
   }
}

fn int main() {
   render::init_window(WINDOW_WIDTH, WINDOW_HEIGHT, "Tic Tac Toe");
   render::set_target_fps(60);
   while (!render::window_should_close()) {
      render::begin_drawing();
      render::clear_background(render::SKYBLUE);
      
      draw();
      update();
            
      render::end_drawing();
   }
   render::close_window();
   return 0;
}