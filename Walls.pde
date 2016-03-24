class Walls {
    // vertical walls.
    // This array is true for a given square if there is a wall to the right of that square
    private boolean[][] vertical;
    // horizontal - true if there is a wall below that square.
    private boolean[][] horizontal;

    // A new set of walls, for testing purposes
    // eventually, we'll want some particular levels
    Walls() {
        this.vertical = new boolean[boardHeight][boardWidth];
        this.horizontal = new boolean[boardHeight][boardWidth];
        for(int i=0; i<boardHeight; i++) {
            for (int j=0; j<boardWidth; j++) {
                if (i == j) {
                    vertical[i][j] = true;
                    horizontal[i][j] = true;
                } else {
                    vertical[i][j] = false;
                    horizontal[i][j] = false;
                }
            }
        }
    }


    // Make a new Walls object from two arrays:
    // Horizontal & Vertical walls.
    // WISH check that dimensions are correct.
    Walls(boolean[][] h, boolean[][] v) {
        this.horizontal = h;
        this.vertical = v;
    }

    // If there is a wall between the two given positions, return the point of collision.
    // Otherwise, return some value that can never be a collision.
    // Input & Output are in pixel coordinates
    PVector collision(PVector fromPosition, PVector toPosition) {
      PVector x = new PVector (0,0);
      return x;
    }

    void render() { 
      fill(255);
      for(int i=0; i<boardHeight; i++) {
            for (int j=0; j<boardWidth; j++) {
              if (vertical[i][j] == true){
                rect((dotSpacing * (j+1)) - 2 ,(dotSpacing * (i)),2 ,dotSpacing);
              }
              if ( horizontal[i][j] == true){
                rect(dotSpacing * j ,(dotSpacing * (i+1)) - 2, dotSpacing, 2);
              }   
            
            }
      }
    }

}