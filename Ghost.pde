class Ghost {
    private PVector position;
    final float speed;
    private Dir travelDirection = Dir.WEST;
    final float countermax;
    private float count;
    //pvector for pac is flipped
    // for testing purposes, don't start in the corner
    Ghost(int x, int y, int z) {
        count = 0;
        speed = 0.1 * dotSpacing;
        countermax = z * dotSpacing/speed; 
        position = new PVector(dotToPixel(x), dotToPixel(y));
    }

    // return a copy of the current position
    PVector getPosition() {
      PVector poscopy = new PVector (position.y ,position.x);
      return poscopy;
    }
    void chase(PVector pac){
      if (abs(pac.y - position.x) - abs(pac.x - position.y) > 0 ) {
        if (pac.y > position.x){
          travelDirection = Dir.EAST;
        }else{
          travelDirection = Dir.WEST;
        }
      }else if (pac.x > position.y){
        travelDirection = Dir.SOUTH;
      }else {
        travelDirection = Dir.NORTH;
      }
      count = 0 ; 
      
    }
    // set a new movement direction
    void setDirection(Dir d) {
      travelDirection = d;
    }
    Boolean colide(PVector pac) {
      PVector pasi = new PVector (position.y, position.x);
      float d = PVector.dist(pac, pasi);
      if (d < dotSpacing){
        return true;
      }else{
        return false;
      }
    }

    // Draw the Pac, as a circle
    void render() {
      fill(200,100,0);
      ellipse(position.x, position.y, (dotSpacing), (dotSpacing));   
    }

    // If the given vector is off the screen, wrap it around to the other side
    // Modify the given vector.
    // If this were public, we probably woudn't modify the vector in place like this.
    private void wrapPosition() {
      if (position.x == dotSpacing/2 && travelDirection == Dir.WEST){
        position.x = (dotSpacing*(boardWidth-.5) ); 
      }
      else if (position.x == (dotSpacing*(boardWidth-.5)) && travelDirection == Dir.EAST){
        position.x = dotSpacing/2; 
      }
      else if (position.y == dotSpacing/2  && travelDirection == Dir.NORTH){
        position.y = (dotSpacing*(boardWidth-.5)); 
      }
      else if (position.y == (dotSpacing*(boardWidth-.5)) && travelDirection == Dir.SOUTH){
        position.y = dotSpacing/2; 
      }
    }

    // reverse the movement direction
    private void changeDir(PVector pacpos) {
      count = 0 ; 
      if (travelDirection == Dir.EAST){
       position.y = dotToPixel (pixelToDot (position.y));
       position.x = dotToPixel (pixelToDot (position.x)-1);
         if (pacpos.x > position.y){
           travelDirection= Dir.SOUTH;
         }else{
           travelDirection= Dir.NORTH;
         }
      }
      else if (travelDirection == Dir.WEST){
        position.y = dotToPixel (pixelToDot (position.y));
        position.x = dotToPixel (pixelToDot (position.x));
         if (pacpos.x > position.y){
           travelDirection= Dir.SOUTH;
         }else{
           travelDirection= Dir.NORTH;
         }
      }
      else if (travelDirection == Dir.NORTH){
       position.y = dotToPixel (pixelToDot (position.y));
       position.x = dotToPixel (pixelToDot (position.x));
         if (pacpos.y < position.x){
           travelDirection= Dir.WEST;
         }else{
           travelDirection= Dir.EAST;
         }
      }
      else if (travelDirection == Dir.SOUTH){
        position.y = dotToPixel (pixelToDot (position.y)-1);
        position.x = dotToPixel (pixelToDot (position.x));
         if (pacpos.y < position.x){
           travelDirection= Dir.WEST;
         }else{
           travelDirection= Dir.EAST;
         }
      }

    }
    

    // Update the position, using the current speed & travel direction
    // If normal movement would hit a wall, find the position after bouncing off the wall.
    // The total distance travelled (before + after hitting the wall) should be the same.
    void updatePosition(Walls walls, PVector pacp) {
     count++;
     PVector a = new PVector (20,20);
     if (count >= countermax){
       this.chase(pacp);
     }
     this.wrapPosition();
     float x = (position.x % dotSpacing);
     float y = (position.y % dotSpacing);
     if (x == 0){
       if (walls.vertical[((pixelToDot (position.y))+1)%30][pixelToDot (position.x)]){
         this.changeDir(pacp);
      }
     }
     if (y== 0 ){
       if (walls.horizontal[pixelToDot (position.y)][((pixelToDot (position.x))+1)%30]){
         this.changeDir(pacp);
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