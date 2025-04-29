color white      = #FFFFFF;
color black      = 0000000;
color darkPurple = #42213D;
color pink       = #F57FEF;
color blue  = #70B3ED;

//target: ----------------------------------------

float player1x, player1y, player1d;

float player2x, player2y, player2d;

// Key Variables: -------------------------------

boolean aKey, dKey, wKey, sKey;
boolean leftKey, rightKey, upKey, downKey;

void setup() {
  size(600, 600);
  player1x = width/2;
  player1y = height/2;
  player2x = width/2;
  player2y = width/2;
  
  player1d = 100;
  player2d = 100;
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
