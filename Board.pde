  



class Board{
  final private int gridHeight, gridWidth, block;
  public int[][] grid;

  
  int currentFile = 0;

  Board(int h, int w, int b, color[] col){
    color[] colors=col;
    gridHeight=h;
    gridWidth=w;
    block=b;
    grid =new int[gridHeight][gridWidth];

    for (int x=0;x<=gridWidth-1;x++){
      for (int y=0;y<=gridHeight-1;y++){
        grid[y][x]=7;
      } 
    }
  }

  public void draw(){
    for (int x=0;x<=gridWidth-1;x++){
      for (int y=0;y<=gridHeight-1;y++){
        if(grid[y][x]<=6){
          stroke(colors[grid[y][x]]);
          fill(colors[grid[y][x]]);
          rect(block*x,block*y,block,block);
        }
        //else{
        //  stroke(0);
        //  fill(colors[7]);
        //  rect(block*x,block*y,block,block);
        //}
      }
    }
  }

  int sizeX(){
    return gridWidth;
  }

  int sizeY(){
    return gridHeight;
  }

  boolean saveBlock(int x, int y, int c){
    if( y < 0 || x < 0 || y > gridHeight || x > gridWidth){
      return false;
    }else{
      grid[y][x]=c;
      return true;
    }
  }

  boolean checkBlock(int x, int y){
    try{
      if(grid[y][x]!=7){
        return false;
      }
      else{
        return true;
      }
    }
    catch(Exception e){
      return false;
    }
  }

  private void eraseLine(int Line){
    for (int y=Line;y>=1;y--){
      for (int x=0;x<=gridWidth-1;x++){
        grid[y][x]=grid[y-1][x];
      }
    }    
  }

  int checkLines(){
    int z=0,l=0;
    
    for (int y=0;y<=gridHeight-1;y++){
      z=0;
      for (int x=0;x<=gridWidth-1;x++){
        if(grid[y][x]<=6) z++;
      }
      if(z==gridWidth) {
        eraseLine(y); 
        l++;
      }
    }
    return l;
  }

  void restart(){
    for (int x=0;x<=gridWidth-1;x++){
      for (int y=0;y<=gridHeight-1;y++){
        grid[y][x]=7;
      } 
    }
  }

};