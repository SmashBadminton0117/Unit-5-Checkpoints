import processing.sound.*;



color white      = #FFFFFF;
color black      = 0000000;
color darkPurple = #42213D;
color pink       = #F57FEF;
color blue       = #70B3ED;
color green      = #7E8C1F;

//target: ----------------------------------------
//player
float player1x, player1y, player1d;

float player2x, player2y, player2d;

//ball:
float shuttlecockx, shuttlecocky, shuttlecockd;

//hole:
float holex, holey, holed;

//points:
int points;

//sound variables:
SoundFile fail;
SoundFile success;
SoundFile music;

// Key Variables: -------------------------------

boolean aKey, dKey, wKey, sKey;
boolean leftKey, rightKey, upKey, downKey;

//Ball Movements:
float vx, vy;
float ax, ay;

void setup() {
  size(1200, 600);

  //Load Sounds:
  fail = new SoundFile(this, "FAILURE.wav");
  success = new SoundFile(this, "SUCCESS.wav");
  music = new SoundFile(this, "MUSIC.mp3");

  player1x = width/2;
  player1y = height - 65;
  player2x = width/2;
  player2y = height - 65;

  player1d = 100;
  player2d = 100;

  //ball setup:
  shuttlecockx = width/2;
  shuttlecocky = height/2;
  shuttlecockd = 50;

  vx = random(-5, 5);
  vy = random(-5, 5);

  ax = 0;
  ay = 1;

  //hole setup:
  holex = 300;
  holey = 600;
  holed = 200;

  //points:
  points = 0;

  music.loop();

  music.amp(1);
}

void draw() {
  background(darkPurple);
  strokeWeight(5);
  stroke(white);
  fill(pink);
  circle(player1x, player1y, player1d);
  fill(blue);
  circle(player2x, player2y, player1d);

  //background: Court
  fill(green);
  strokeWeight(6);
  rect(150, 590, 900, 10);

  //First Player:
  if (aKey) player1x = player1x - 5;
  if (dKey) player1x = player1x + 5;
  if (wKey) player1y = player1y - 5;
  if (sKey) player1y = player1y + 5;

  //2nd Player:
  if (rightKey) player2x = player2x - 5;
  if (leftKey)  player2x = player2x + 5;
  if (upKey)    player2y = player2y - 5;
  if (downKey)  player2y = player2y + 5;


  //drawBall:
  strokeWeight(4);
  stroke(white);
  fill(pink);

  circle(shuttlecockx, shuttlecocky, shuttlecockd);

  //movement
  shuttlecockx += vx;
  shuttlecocky += vy;

  //gravity
  vx = vx + ax;
  vy = vy + ay;
  
  if ( wKey == true) {
    player1y = player1y + ay;
  }

  //player1x = player1x + ax;
  //player1y = player1y + ay;


  //bouncing off walls
  if (shuttlecocky - shuttlecockd/2 <= 0) {
    vy = -vy;
    shuttlecocky = shuttlecockd/2;
  }

  if (shuttlecocky + shuttlecockd/2 >= height) {
    vy = -vy;
    shuttlecocky = height - shuttlecockd;
  }

  if (shuttlecockx - shuttlecockd/2 <= 0) {
    vx = -vx;
    shuttlecockx = shuttlecockd/2;
  }

  if (shuttlecockx + shuttlecockd/2 >= width) {
    vx = -vx;
    shuttlecockx = width - shuttlecockd/2;
  }

  ////drawHole:
  //fill(black);
  //noStroke();
  //circle(holex, holey, holed);

  //if ( dist(holex, holey, shuttlecockx, shuttlecocky) <= holed/2 + shuttlecockd/2 ) {
  //  points = points + 1;
  //  shuttlecockx = width/2;
  //  shuttlecocky = shuttlecockd/2;
  //}


  //Ball bouncing off of player
  //player1:
  if ( dist(player1x, player1y, shuttlecockx, shuttlecocky) <= player1d/2 + shuttlecockd/2) {
    vy = (shuttlecocky - player1y)/5;
    vx = (shuttlecockx - player1x)/5;
  }

  //player2:
  if ( dist(player2x, player2y, shuttlecockx, shuttlecocky) <= player2d/2 + shuttlecockd/2) {
    vy = (shuttlecocky - player2y)/5;
    vx = (shuttlecockx - player2x)/5;
  }

  textSize(40);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text(points, player1x, player1y);
}

void keyPressed() {
  if ( key == 'a') aKey = true;
  if ( key == 'd') dKey = true;
  if ( key == 'w') wKey = true;
  if ( key == 's') sKey = false;


  if ( keyCode == RIGHT) leftKey = true;
  if ( keyCode == LEFT)  rightKey = true;
  if ( keyCode == UP)    upKey = true;
  if ( keyCode == DOWN)  downKey = false;
}

void keyReleased() {
  fail.stop();
  fail.play();

  if ( key == 'a') aKey = false;
  if ( key == 'd') dKey = false;
  if ( key == 'w') wKey = false;
  if ( key == 's') sKey = false;

  if ( keyCode == RIGHT) leftKey = false;
  if ( keyCode == LEFT)  rightKey = false;
  if ( keyCode == UP)    upKey = false;
  if ( keyCode == DOWN)  downKey = false;
}
