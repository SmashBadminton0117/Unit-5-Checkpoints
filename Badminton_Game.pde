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

float player1Vy, player2Vy;

//ball (shuttlecock):
float shuttlecockx, shuttlecocky, shuttlecockd;
float shuttlecockvx, shuttlecockvy; // Shuttlecock velocity
float shuttlecockax, shuttlecockay; // Shuttlecock acceleration (gravity)

//hole:
float holex, holey, holed;

//points:
int pointsPlayerA;
int pointsPlayerB;

//sound variables:
SoundFile fail;
SoundFile success;
SoundFile music;

// Key Variables: -------------------------------
boolean aKey, dKey, wKey, sKey;
boolean leftKey, rightKey, upKey, downKey;

//Gravity and Drag constants
float gravity = 0.1; // Gravity strength
float drag = 0.01; // Air drag, adjust for realistic shuttlecock behavior

void setup() {
  size(1200, 600);

  //Load Sounds:
  fail = new SoundFile(this, "FAILURE.wav");
  success = new SoundFile(this, "SUCCESS.wav");
  music = new SoundFile(this, "MUSIC.mp3");

  player1x = width / 2 - 200;
  player1y = height - 65;
  player2x = width / 2 + 200;
  player2y = height - 65;

  player1d = 100;
  player2d = 100;

  player1Vy = 0;
  player2Vy = 0;

  //ball (shuttlecock) setup:
  shuttlecockx = width / 2;
  shuttlecocky = height / 2;
  shuttlecockd = 50;

  shuttlecockvx = random(-3, 3);
  shuttlecockvy = 0;

  shuttlecockax = 0;
  shuttlecockay = gravity;

  //hole setup:
  holex = 300;
  holey = 600;
  holed = 200;

  //points:
  pointsPlayerA = 0;
  pointsPlayerB = 0;

  music.loop();
  music.amp(1);
}

void draw() {
  background(white);
  //Split of both screen:
  //split #1:
  noStroke();
  fill(red(pink + 50), green(pink), blue(pink), 100);
  rect(0, 0, 600, 600);
  
  //split #2:
  fill(red(blue), green(blue), blue(blue), 100);
  rect(width/2, 0, 600, 600);
  
  strokeWeight(5);
  stroke(white);
  fill(pink);
  circle(player1x, player1y, player1d);
  fill(blue);
  circle(player2x, player2y, player1d);

  // Court background:
  fill(green);
  strokeWeight(6);
  rect(150, height - 12, 900, 10);
  
  //Net:
  fill(white);
  strokeWeight(4);
  rect(width/2 - 5, 498, 10, 90);
  

  //Player 1 Movement:
  if (aKey && player1x > 52) player1x = player1x - 5;
  if (dKey && player1x < 600 - 62) player1x = player1x + 5;
  
  //Player 2 Movement:
  if (rightKey && player2x < width - 52) player2x = player2x - 5;
  if (leftKey && player2x > width - 662) player2x = player2x + 5;
  
  //Jump:
  if (wKey && player1y == height - 65) {
    player1Vy = -5;
  }
  player1Vy += 0.2;
  player1y += player1Vy;
  
  if (player1y > height - 65) {
    player1y = height - 65;
    player1Vy = 0;
  }
  
  //Jump:
  if (upKey && player2y == height - 65) {
    player2Vy = -5;
  }
  player2Vy += 0.2;
  player2y += player2Vy;
  
  if (player2y > height - 65) {
    player2y = height - 65;
    player2Vy = 0;
  }

  //shuttlecock:
  strokeWeight(4);
  stroke(white);
  fill(pink);
  circle(shuttlecockx, shuttlecocky, shuttlecockd);

  //gravity + drag
  shuttlecockvx *= (1 - drag);
  shuttlecockvy += shuttlecockay;

  shuttlecockx += shuttlecockvx;
  shuttlecocky += shuttlecockvy;

  // Bounce off the walls:
  if (shuttlecocky - shuttlecockd / 2 <= 0) {
    shuttlecockvy = -shuttlecockvy;
    shuttlecocky = shuttlecockd / 2;
  }

  if (shuttlecocky + shuttlecockd / 2 >= height) {
    shuttlecockvy = -shuttlecockvy;
    shuttlecocky = height - shuttlecockd / 2;
  }

  //Bounce off walls:
  if (shuttlecockx - shuttlecockd / 2 <= 0) {
    shuttlecockvx = -shuttlecockvx;
    shuttlecockx = shuttlecockd / 2;
  }

  if (shuttlecockx + shuttlecockd / 2 >= width) {
    shuttlecockvx = -shuttlecockvx;
    shuttlecockx = width - shuttlecockd / 2;
  }

  //Ball bouncing off of players:
  //Player 1:
  if (dist(player1x, player1y, shuttlecockx, shuttlecocky) <= player1d / 2 + shuttlecockd / 2) {
    shuttlecockvy = (shuttlecocky - player1y) / 5;
    shuttlecockvx = (shuttlecockx - player1x) / 5;
  }

  //Player 2:
  if (dist(player2x, player2y, shuttlecockx, shuttlecocky) <= player2d / 2 + shuttlecockd / 2) {
    shuttlecockvy = (shuttlecocky - player2y) / 5;
    shuttlecockvx = (shuttlecockx - player2x) / 5;
  }
  
  
  

  //points:
  textSize(40);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  text(pointsPlayerA, player1x, player1y);
  text(pointsPlayerB, player2x, player2y);
}

void keyPressed() {
  if (key == 'a' || key == 'A') aKey = true;
  if (key == 'd' || key == 'D') dKey = true;
  if (key == 'w' || key == 'W') wKey = true;
  if (key == 's' || key == 'S') sKey = false;

  if (keyCode == RIGHT) leftKey = true;
  if (keyCode == LEFT) rightKey = true;
  if (keyCode == UP) upKey = true;
  if (keyCode == DOWN) downKey = false;
}

void keyReleased() {
  fail.stop();
  fail.play();

  if (key == 'a') aKey = false;
  if (key == 'd') dKey = false;
  if (key == 'w') wKey = false;
  if (key == 's') sKey = false;

  if (keyCode == RIGHT) leftKey = false;
  if (keyCode == LEFT) rightKey = false;
  if (keyCode == UP) upKey = false;
  if (keyCode == DOWN) downKey = false;
}
