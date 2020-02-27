// Neo Chen
//
// 2 Types of fun: Challenge and Submission. 
//
// - Challenge: Player have to click certain amount of time inside a short time frame which is 3 sec. 
// They need to click more or equal to their target in order to advance to next level. 
// There is pleasure if they achieve higher level that their friends or opponents can't. 
// This is a (Archiver) game that Not every one can click to higher level in my game, 
// so people will be challenged to click more and get to higher level, if they don't meet the target click numbers,
// they will lose the game, if they pass the target number, they can move on to next level. 
//
// - Submission: It's a very simple game that people can just use it to kill time,
// whenever they feel bored on train/subway and they can just enjoy the moment they spent on this game.
// I personally like to do simple task game to kill time or to clear my head after work, 
// clicking game is a great way to release stress and empty mind when playing the game,
// only left enjoyment while gaming. 
//
PImage[] img = new PImage[4]; // Declare a variable of type PImage
int score = 0;
int time;
int wait = 1000;
int t;
int t1;
int level = 1;
int finalScore = 0;
int click = 0;
int toggleCount = 0;
int startCount = 0;
img[1] = loadImage("blue-dot.jpeg");
img[2] = loadImage("blue-dot.jpeg");
img[3] = loadImage("10.jpg");
img[4] = loadImage("levelUp.jpeg");
int[] cNum = new int[8];
int[] bNum = new int[8];

void setup() {
	size(500, 500);
  time = millis();//store the current time
	smooth();
  randomNum();
	starter();
	noLoop();
}

void draw() {
	// Draw the image to the screen at coordinate (0,0)
	background(255);
	game();
}

void starter() {
	if(click == 0){
		background(255, 204, 0);
		fill(50);
		text("Click to Start!", 150,150);
	}
}

void mouseClicked() {
		click++;
		if(click%2== 1){
			background(255, 204, 0);
			fill(50);
			text("Click again to go back!~", 150,150);
			text("Press V to reset the screen.", 150, 170);
		} else { 
			background(255);
			displayText();
			fill(50);
			text("Score: ", 0, 10);
			fill(50);
			text(score, 40, 10);
			fill(50);
			text("Timer:", 0, 30);
			fill(50)
			text("Ready!", 40, 30);
			fill(50);
			text("Level: ", 90, 10);
			fill(50);
			text(level, 140, 10);
			fill(50);
			text("Target: ", 90, 30);
			fill(50);
			text(level+2, 140, 30);
			image(img[1], 0, 70);
			reset();
		}
		
}

void timer() {
		if(millis() - time >= wait){
			if(t < 3){
				t++;
			} else {
				timerReached();
			}
			time = millis();//also update the stored time
		}
}

void keyPressed(){
  if( key == 'v'  || key == 'V'){
    reset();
  }
	
	if(key == 'g' || key == 'G'){
		if(t <=3 && t > 0){
			frameRate(30)
			score += 1;
			if(score == 0 || score%2 == 1) {
				noTint();
			} else {
				tint(115, 196, 227);
			}
		}
	}
	
	if(key == 's' || key == 'S'){
		if(startCount == 0){
			clear();
			loop();
			image(img[1], 0, 70);
			startCount ++;
		}
	}
	
	if(key == 'q' || key == 'Q') {
		clear()
		text("Program ended!", 150,150);
		text("Refresh page to reload the game.", 150,170);
		exit();
	} 
	
	if(key == 'd' || key == 'D') {
		toggleCount++;
		if(toggleCount%2==0 && toggleCount > 0){
			background(255);
			fill(50);
			text("black-curve-on-white draws a spline curve", 100,100);
			text("Click twice to exit", 100,120);
			text("Press V to reset the screen.", 100, 140);
			noFill();
			stroke(1);
			curve(cNum[1], cNum[2], cNum[3], cNum[4], cNum[5], cNum[6], cNum[7], cNum[8]);
			ellipse(cNum[1], cNum[2], 5, 5);
			fill(238, 255, 0);
			ellipse(cNum[3], cNum[4], 5, 5);
			fill(66, 245, 114);
			ellipse(cNum[5], cNum[6], 5, 5);
			fill(66, 135, 245);
			ellipse(cNum[7], cNum[8], 5, 5); 
		} else {
			background(0);
			fill(255);
			text("white-curve-on-black draws a B ́ezier curve", 100,100);
			text("Click twice to exit", 100,120);
			text("Press V to reset the screen.", 100, 140);
			fill(0, 255, 38);
			ellipse(cNum[1], cNum[2], 5, 5);
			fill(238, 255, 0);
			ellipse(cNum[3], cNum[4], 5, 5);
			fill(66, 245, 114);
			ellipse(cNum[5], cNum[6], 5, 5);
			fill(66, 135, 245);
			ellipse(cNum[7], cNum[8], 5, 5); 
			noFill();
			stroke(255);
			beginShape();
			bezier(cNum[5], cNum[6], cNum[1], cNum[2], cNum[7], cNum[8], cNum[3], cNum[4]);
			endShape();
		}
	}
}

void reset(){
	background(255);
  t = 0;
  score = 0;
	level = 1;
	finalScore = 0;
	clear();
	UIDisplay();
	displayText();
	noTint();
  image(img[1], 0, 70);
	timer();
	toggleCount = 0;
	startCount = 0;
}

void timerReached() {
	noLoop();
	check();
}

void check() {
	if (score < (level + 2)) {
		clear();
		fill(50)
		EndGameDisplay()
		text("GG!", 0 ,200 );	
		text("Press V to restart the game", 0 , 420);
		randomNum();
		drawCurve();
		bCurve()
	} else {
		clear();
		UIDisplay();
		frameRate(1);
		fill(50)
		text("Congratz! You clear this level!", 0 ,400 );
		text("Moving next level!", 0 , 410);
		levelUp();
		nextLevel();
	}
}

void levelUp(){
	level++;
}

void nextLevel(){
	t = 0;
  score = 0;
	finalScore += level;
	noTint();
	img[4].resize(200,200);
	image(img[4], 0, 70);
	loop();
}

void displayText() {
	fill(50);
	text("No cap sensitive, just press lol.", 0, 390);
	fill(50);
	text("Press S to start the game", 0, 400);
	fill(50);
	text("Press G or Click to gain scores", 0 , 410);
	fill(50);
	text("Press V to reset the game", 0 , 420);
	fill(50);
	text("Press D to draw black-curve-on-white draws a spline curve", 0,430);
	fill(50);					
	text("Press D again, redraw white-curve-on-black draws a B ́ezier curve", 0, 440);
	fill(50);
	text("Press Q to Quit the game and stop the program!", 0, 450);
	fill(50);

}

void UIDisplay() {
	fill(50);
	text("Score: ", 0, 10);
	fill(50);
	text(score, 40, 10);
	fill(50);
	text("Timer:", 0, 30);
	fill(50)
	timeCount();
	fill(50);
	text("Level: ", 90, 10);
	fill(50);
	text(level, 140, 10);
	fill(50);
	text("Target: ", 90, 30);
	fill(50);
	text(level+2, 140, 30);
}

void timeCount() {
	if(t == 0){
		//Say Ready before number count down
		text("Ready!", 40, 30);
	} else {
		text((4 - t ), 40, 30);
	}
}

void EndGameDisplay() {
	background(1000);
	fill(50);
	text("Final Score: ", 0, 10);
	fill(50);
	text(finalScore, 80, 10);
	fill(50);
	text("Highest Level: ", 180, 10);
	fill(50);
	text(level, 260, 10);
	noTint();
	img[3].resize(300,100);
	image(img[3], 0, 70);
}

void game() {
	background(255);
	clear();
	UIDisplay();
	displayText();
	image(img[1], 0, 70);
	timer();
}

void randomNum(){
	for(int i = 1; i <=8; i++){
		int x = int(random(150,300));
		cNum[i] = x;
		// print(cNum[i]);
	}
	for(int i = 1; i <=8; i++){
		int x = int(random(300,400));
		bNum[i] = x;
		// print(bNum[i]);
	}	
	
}

void drawCurve() {
	noFill();
	curve(cNum[1], cNum[2], cNum[3], cNum[4], cNum[5], cNum[6], cNum[7], cNum[8]);
	noStroke();
  fill(255, 0, 157);
  ellipse(cNum[1], cNum[2], 5, 5);
	fill(238, 255, 0);
  ellipse(cNum[3], cNum[4], 5, 5);
	fill(66, 245, 114);
  ellipse(cNum[5], cNum[6], 5, 5);
  fill(66, 135, 245);
  ellipse(cNum[7], cNum[8], 5, 5); 
}

void bCurve() {
	fill(0, 255, 38);
	ellipse(bNum[1], bNum[2], 5, 5);
	fill(238, 255, 0);
  ellipse(bNum[3], bNum[4], 5, 5);
  fill(66, 245, 114);
	ellipse(bNum[5], bNum[6], 5, 5);
  fill(66, 135, 245);
  ellipse(bNum[7], bNum[8], 5, 5); 
	noFill();
	stroke(1);
	bezier(bNum[1], bNum[2], bNum[3], bNum[4], bNum[5], bNum[6], bNum[7], bNum[8]);

}