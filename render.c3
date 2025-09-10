module render;

struct Vector2 {
    float x;
    float y;
} 

struct Rect {
    float x;
    float y;
    float width;
    float height;
}

struct Color {
    char r;
    char g;
    char b;
    char a;
}

/* Mouse buttons */
const int MOUSE_LEFT_BUTTON   = 0;
const int MOUSE_RIGHT_BUTTON  = 1;
const int MOUSE_MIDDLE_BUTTON = 2;

/* Colors */
const Color GRAY     = (Color){130, 130, 130, 255};
const Color YELLOW   = (Color){253, 249,   0, 255};
const Color GOLD     = (Color){255, 203,   0, 255};
const Color BROWN    = (Color){127, 106,  79, 255};
const Color WHITE    = (Color){255, 255, 255, 255};
const Color BLACK    = (Color){  0,   0,   0, 255};
const Color BLANK    = (Color){  0,   0,   0,   0};
const Color SKYBLUE  = (Color){102, 191, 255, 255};

extern fn void init_window(int width, int height, char *title) @extern("InitWindow");
extern fn void close_window() @extern("CloseWindow");
extern fn void set_target_fps(int fps) @extern("SetTargetFPS");
extern fn bool window_should_close() @extern("WindowShouldClose");
extern fn void begin_drawing() @extern("BeginDrawing");
extern fn void clear_background(Color color) @extern("ClearBackground");
extern fn void end_drawing() @extern("EndDrawing");
extern fn void draw_rect(Rect rect, Color color) @extern("DrawRectangleRec");
extern fn void draw_line(int startPosX, int startPosY, int endPosX, int endPosY, Color color) @extern("DrawLine");
extern fn void draw_lineV(Vector2 startPos, Vector2 endPos, Color color) @extern("DrawLineV");
extern fn void draw_line_ex(Vector2 startPos, Vector2 endPos, float thick, Color color) @extern("DrawLineEx");
extern fn float get_frame_time() @extern("GetFrameTime");
extern fn int get_screen_width() @extern("GetScreenWidth");
extern fn int get_screen_height() @extern("GetScreenHeight");
extern fn Color color_from_hsv(float hue, float saturation, float value) @extern("ColorFromHSV");
extern fn bool is_mouse_button_pressed(int button) @extern("IsMouseButtonPressed");
extern fn Vector2 get_mouse_position() @extern("GetMousePosition");
  
/* Useful macros */
macro rect(x, y, width, height) {
    return (Rect){.x = x, .y = y, .width = width, .height = height};
}

macro vector2(x, y) {
    return (Vector2){.x = x, .y = y};
}