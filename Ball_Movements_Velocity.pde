color white      = #FFFFFF;
color black      = 0000000;
color darkPurple = #42213D;
color pink       = #F57FEF;
color blue       = #70B3ED;

//target: ----------------------------------------

float ballX, ballY, ballD;
float vx, vy;
float ax, ay;



void setup() {
  size(600, 600);
  ballX = width/2;
  ballY = height/2;
  ballD = 50;

  vx = random(-5, 5);
  vy = random(-5, 5);

  ax = 0;
  ay = 1;
}

void draw() {
  background(darkPurple);

  strokeWeight(4);
  stroke(white);
  fill(pink);

  circle(ballX, ballY, ballD);

  //movement
  ballX += vx;
  ballY += vy;

  //gravity
  vx = vx + ax;
  vy = vy + ay;


  //bouncing off walls
  if (ballY - ballD/2 <= 0) {
    vy = vy * -0.9;
    ballY = ballD/2;
  }

  if (ballY + ballD/2 >= height) {
    vy = vy * -0.9;
    ballY = height - ballD;
  }

  if (ballX - ballD/2 <= 0) {
    vx = vx * -0.9;
    ballX = ballD/2;
  }

  if (ballX + ballD/2 >= width) {
    vx = vx * -0.9;
    ballX = width - ballD/2;
  }
}
