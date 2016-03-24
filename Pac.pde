class Pac {
    private PVector position;
    float speed = 0.1 * dotSpacing;
    private Dir travelDirection = Dir.EAST;
    private Dir newDirection = Dir.EAST;
    private int count = 0;

    // for testing purposes, don't start in the corner
    Pac() {
        position = new PVector(dotToPixel(5), dotToPixel(0));
    }

    // return a copy of the current position
    PVector getPosition() {
      PVector poscopy = new PVector (position.y ,position.x);
      return poscopy;
    }

    // set a new movement direction
    void setDirection(Dir d) {
      newDirection = d;
    }

    // Draw the Pac, as a circle
    void render() {
      fill(255);
      ellipse(position.x, position.y, (dotSpacing), (dotSpacing));   
    }

    // If the given vector is off the screen, wrap it around to the other side
    // Modify the given vector.
    // If this were public, we probably woudn't modify the vector in place like this.
    private void wrapPosition() {
      if (position.x == dotSpacing/2  && newDirection == Dir.WEST){
        position.x = (dotSpacing*(boardWidth-.5)); 
      }
      if (position.x == (dotSpacing*(boardWidth-.5)) && newDirection == Dir.EAST){
        position.x = dotSpacing/2; 
      }
      if (position.y == dotSpacing/2  && newDirection == Dir.NORTH){
        position.y = (dotSpacing*(boardWidth-.5)); 
      }
      if (position.y == (dotSpacing*(boardWidth-.5)) && newDirection == Dir.SOUTH){
        position.y = dotSpacing/2; 
      }
    }

    // reverse the movement direction
    private void reverseDirection() {
      if (travelDirection == Dir.EAST){
       travelDirection= Dir.WEST;
       newDirection = Dir.WEST;
       position.y = dotToPixel (pixelToDot (position.y));
       position.x = dotToPixel (pixelToDot (position.x)-1);
       count = 0;
      }
      else if (travelDirection == Dir.WEST){
         travelDirection = Dir.EAST;
         newDirection = Dir.EAST;
         position.y = dotToPixel (pixelToDot (position.y));
         position.x = dotToPixel (pixelToDot (position.x));
         count = 0;
      }
      if (travelDirection == Dir.NORTH){
       travelDirection= Dir.SOUTH;
         newDirection = Dir.SOUTH;
         position.y = dotToPixel (pixelToDot (position.y));
         position.x = dotToPixel (pixelToDot (position.x));
         count = 0;
      }
      else if (travelDirection == Dir.SOUTH){
       travelDirection= Dir.NORTH;
         newDirection = Dir.NORTH;
         position.y = dotToPixel (pixelToDot (position.y)-1);
         position.x = dotToPixel (pixelToDot (position.x));
         count = 0;
      }

    }
    void speed(){
      speed = 0.1 * dotSpacing;
    }
    void stops(){
      speed = 0 ; 
    }
    // Update the position, using the current speed & travel direction
    // If normal movement would hit a wall, find the position after bouncing off the wall.
    // The total distance travelled (before + after hitting the wall) should be the same.
    void updatePosition(Walls walls) {
      count++;
      if(count == dotSpacing / speed){
        travelDirection = newDirection; 
        count = 0;
      }
     float x = (position.x % dotSpacing);
     float y = (position.y % dotSpacing);
     if (x == 0){
       if (walls.vertical[((pixelToDot (position.y))+1)%30][pixelToDot (position.x)]){
         this.reverseDirection();
      }
     }
     if (y== 0 ){
       if (walls.horizontal[pixelToDot (position.y)][((pixelToDot (position.x))+1)%30]){
         this.reverseDirection();
       }
     }
     this.wrapPosition();
      if (travelDirection == Dir.EAST){
        position.x=position.x+speed; 
      }
      if (travelDirection == Dir.NORTH){
        position.y=position.y-speed; 
      }
      if (travelDirection == Dir.SOUTH){
        position.y=position.y+speed; 
      }
      if (travelDirection == Dir.WEST){
        position.x=position.x-speed; 
      }
     
     }



}