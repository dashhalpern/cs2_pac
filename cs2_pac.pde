final int boardWidth = 30; // number of dots across
final int boardHeight = 30; // number of dots down
final int dotSpacing = 30; // pixels between dot centers
final int dotRadius = 3; // pixels

Dots dots;
Pac pac;
Walls walls;
Ghost ghost;

// It's convenient to refer to two coordinate systems
// Pixel coordinates are the usual Processing coordinates
// Dot coordinates describe the screen as a grid of boxes.
// Each box has an integer x & y coordinate.  At the start of the game,
// there is a dot in the *center* of each box.

// dotToPixel gives the pixel coordinate in the *center* of the corresponding box
float dotToPixel(int x) {
    return (0.5 + x) * dotSpacing;
}

// pixelToDot finds the box in which the pixel is contained
int pixelToDot(float x) {
    if (x > boardWidth * dotSpacing) {
    }
    return floor(x / dotSpacing);
}

void setup() {
    size(900,900);
    dots = new Dots();
    pac = new Pac();
    walls = new Walls();
    ghost = new Ghost(5, 6, 3);
}

float rapt (float i) {
  return (i % (boardWidth * dotSpacing));
}

void draw() {
    clear();
    ghost.render();
    dots.render();
    pac.updatePosition(walls);
    pac.render();
    walls.render();
    PVector y = pac.getPosition();
    ghost.updatePosition(walls,y);
    if (ghost.colide(y)){
      setup();
    }
    int score =  boardWidth*boardHeight-dots.remove(y);
    text(score,10,10);
}

void keyPressed() {
    if (keyCode == UP){
      pac.setDirection(Dir.NORTH);
    }
    if (keyCode == LEFT){
      pac.setDirection(Dir.WEST);
    }    
    if (keyCode == RIGHT){
      pac.setDirection(Dir.EAST);
    }
    if (keyCode == DOWN){
      pac.setDirection(Dir.SOUTH);
    }
    if (keyCode == ' '){
      pac.reverseDirection();
    }
   if (keyCode == 'a'){
      pac.speed();
    }
    if (keyCode == 's'){
      pac.stops();
    } 
}