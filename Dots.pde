class Dots {
   private boolean[][] dots;
   private int count;

   // Create an initial board with every dot present
   Dots() {
     count = (boardWidth * boardHeight);
     dots = new boolean[boardWidth] [boardHeight];
     int i = 0;
     int j=0;
     while (i < boardWidth){
        j=0;
        while (j < boardHeight){
          dots[i] [j] = true;
          j++;
        }
     i++;
     }
   }

   // remove any dots between the two positions
   // return the number of dots removed
  // Normally the input vectors will either be in the same row
   // or the same column.  It's fine to only handle these cases.
   // Write a comment explaining what your version does
   // if the inputs are not in the same row or column.
   //PVector fromPosition, 
   int remove(PVector toPosition) {
     float x = (toPosition.x % dotSpacing) - (dotSpacing * 0.5);
     float y = (toPosition.y % dotSpacing) - (dotSpacing * 0.5);
     if (sqrt(x*x + y*y) < dotSpacing/2 + dotRadius/2){  
       if (dots [pixelToDot (toPosition.y)][pixelToDot (toPosition.x)]){
         dots [pixelToDot (toPosition.y)][pixelToDot (toPosition.x)] = false;
         count--;
       }
     }
     return count;
   }

      // return the number of dots remaining
   boolean remaining() {
       return (count > 0);
   }

   // Draw the dots.  Use `dotToPixel`

   void render() {
   int i = 0;
   int j=0;
     while (i < boardWidth){
        j=0;
        while (j < boardHeight){
          if (dots[i] [j] == true){
            fill(255);
            ellipse(((i+0.5)*dotSpacing), ((j+0.5)*dotSpacing), dotRadius, dotRadius);
          }
          j++;
        }
     i++;
     }
   }

}