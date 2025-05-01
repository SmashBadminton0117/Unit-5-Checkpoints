color white      = #FFFFFF;
color black      = 0000000;
color darkPurple = #42213D;
color pink       = #F57FEF;
color blue  = #70B3ED;

//target: ----------------------------------------

float player1x, player1y, player1d;

float player2x, player2y, player2d;

//ball:
float ballX, ballY, ballD;

//hole:
float holex, holey, holed;

//points:
int points;

// Key Variables: -------------------------------

boolean aKey, dKey, wKey, sKey;
boolean leftKey, rightKey, upKey, downKey;

//Ball Movements:
float vx, vy;
float ax, ay;

void setup() {
  size(600, 600);
  player1x = width/2;
  player1y = height/2;
  player2x = width/2;
  player2y = width/2;

  player1d = 100;
  player2d = 100;

  //ball setup:
  ballX = width/2;
  ballY = height/2;
  ballD = 50;

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
}

void draw() {
  background(darkPurple);
  strokeWeight(5);
  stroke(white);
  fill(pink);
  circle(player1x, player1y, player1d);
  fill(blue);
  circle(player2x, player2y, player1d);

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

  circle(ballX, ballY, ballD);

  //movement
  ballX += vx;
  ballY += vy;

  //gravity
  //vx = vx + ax;
  //vy = vy + ay;


  //bouncing off walls
  if (ballY - ballD/2 <= 0) {
    vy = -vy;
    ballY = ballD/2;
  }

  if (ballY + ballD/2 >= height) {
    vy = -vy;
    ballY = height - ballD;
  }

  if (ballX - ballD/2 <= 0) {
    vx = -vx;
    ballX = ballD/2;
  }

  if (ballX + ballD/2 >= width) {
    vx = -vx;
    ballX = width - ballD/2;
  }
  
  //drawHole:
  fill(black);
  noStroke();
  circle(holex, holey, holed);

  //Ball bouncing off of player
  //player1:
  if ( dist(player1x, player1y, ballX, ballY) <= player1d/2 + ballD/2) {
    vy = (ballY - player1y)/5;
    vx = (ballX - player1x)/5;
  }
  
  //player2:
  if ( dist(player2x, player2y, ballX, ballY) <= player2d/2 + ballD/2) {
    vy = (ballY - player2y)/5;
    vx = (ballX - player2x)/5;
  }
  
  if ( dist(holex, holey, ballX, ballY) <= holed/2 + ballD/2 ) {
    points = points + 1;
    ballX = width/2;
    ballY = ballD/2;
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
  if ( key == 's') sKey = true;

  if ( keyCode == RIGHT) leftKey = true;
  if ( keyCode == LEFT)  rightKey = true;
  if ( keyCode == UP)    upKey = true;
  if ( keyCode == DOWN)  downKey = true;
}

void keyReleased() {
  if ( key == 'a') aKey = false;
  if ( key == 'd') dKey = false;
  if ( key == 'w') wKey = false;
  if ( key == 's') sKey = false;

  if ( keyCode == RIGHT) leftKey = false;
  if ( keyCode == LEFT)  rightKey = false;
  if ( keyCode == UP)    upKey = false;
  if ( keyCode == DOWN)  downKey = false;
}
