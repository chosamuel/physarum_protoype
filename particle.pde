class particle{

  PVector pos;
  PVector dir;
  float heading; 
  float maxSpeed;

  float depositAmt;
  float senseDist;

  particle(float x, float y ){
    pos = new PVector(x,y);
    dir = new PVector(0,0);
    //produce 1 from 8 directions
    //later multiply by 45
    heading = floor(random(16));



    depositAmt = 170;
    maxSpeed = 5.8;
    senseDist = 7.2;
  }

  void show(){
    pushStyle();
    stroke(255);
    point(pos.x,pos.y);
    popStyle();
  }

  void deposit(trailmap tm){
    int x = floor(pos.x);
    int y = floor(pos.y);


    tm.grid[x][y] += depositAmt;
  }

  void sense(trailmap tm){
    //
    float nextIntensity = 0;
    float maxIntensity = 0;
    float maxHeading = 0;
    for(int i = -1; i<2; i++){
      //look in directions relative to heading
      float look = heading + i;
      //get radians angle from heading direction
      float angle = radians(look*22.5);

      PVector offset = PVector.fromAngle(angle).mult(senseDist);
 

      int currentX, currentY;
      currentX = int(pos.x + offset.x);
      currentY = int(pos.y + offset.y);

      if(currentX > width-1){
        currentX = 0;
      } else if(currentX < 0){
        currentX = width-1;
      }

      if(currentY > height-1){
        currentY = 0;
      } else if(currentY < 0){
        currentY = height-1;
      }

      nextIntensity = tm.grid[currentX][currentY];
      if(maxIntensity < nextIntensity){
        maxIntensity = nextIntensity;
        dir.x = offset.x;
        dir.y = offset.y;
        dir.setMag(maxSpeed);
        maxHeading = i;
      }
   }
   //turn particle
    heading+=maxHeading;
  }

  void move(){
    pos.add(dir);
    wrap();
    //resetPos();
  }

  void wrap(){
    if(pos.x > width-1){
      pos.x = 0;
    } else if (pos.x < 0){
      pos.x = width-1;
    }

    if(pos.y > height-1){
      pos.y = 0;
    } else if (pos.y < 0){
      pos.y = height-1;
    }
  }

  void resetPos(){
    if(pos.x > width-1 || pos.x < 0 ||
      pos.y > height-1 || pos.y < 0){
      pos.x = floor(random(width));
      pos.y = floor(random(height));
      dir = PVector.random2D();
    }
  }

  void reset(){
    pos = new PVector(random(width),random(height));
  }


}
