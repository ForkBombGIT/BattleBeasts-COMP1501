GUI gui;
CommandPrompt cmd;

ArrayList players;
Player player1;
Player player2;
Player player3;
Player player4;

int turn = 1;
int nextPlayer = 0;

String userInput = "";

Player pp; 
Player c;

ArrayList balls;

void setup(){
  background(127);
  size(1150,800);
  
  players = new ArrayList();
  balls = new ArrayList();
  
  players.add(new Player(1));
  players.add(new Player(2));
  players.add(new Player(3));
  players.add(new Player(4)); 

  pp = (Player) players.get(turn - 1);
  cmd = new CommandPrompt();
  gui = new GUI();
}

void draw(){
  cmd.gameOverText = "Gameover. Player " + (turn) + " has won.";
  checkGameOver();
  if (turn == 5)
    turn = 1;
  
  pp = (Player) players.get(turn - 1);
  background(127);
  gui.drawGUI();
  
  if (pp.moveCount >= 3){
    turn++;
    pp.moveCount = 0;
    cmd.help = false;
    cmd.stats = false;
    cmd.statsText = "";   
    pp.selection = false;
    
    for (int i = 0; i < pp.characters.size(); i++){
      Character c = (Character) pp.characters.get(i);
      
      if (c.selected)
        c.selected = false;
      
    }
  }
  
  for(int i = 0; i < players.size(); i++){
   Player pl = (Player) players.get(i);
  for (int c = 0; c < pl.characters.size(); c++){
   Character ch = (Character) pl.characters.get(c);
     
  if (ch.steps == 0)
    ch.drawCharacter();   
  else
    ch.move();
   }
  }
  
    for (int ww = 0; ww < balls.size(); ww++){
    Ball b = (Ball) balls.get(ww);
    
    b.drawBall();
  }
}

void keyPressed(){
 if (!cmd.canType)
   if (keyCode == ENTER)
     cmd.canType = true;
     
 cmd.handleKeyPress(); 
}

void mousePressed(){
  Player p = (Player) players.get(turn - 1);
  for (int i = 0; i < p.characters.size(); i++){
    Character ch = (Character) p.characters.get(i);
    if (calculateDist(ch.position.x,ch.position.y,mouseX,mouseY) < 15){ 
      if ((mouseButton == LEFT) && (p.selection == false)){
        ch.selected = true;
        p.selection = true;
      }
      if ((mouseButton == RIGHT) && (p.selection == true) && (ch.selected)){
        ch.selected = false;
        p.selection = false;
        ch.effectRadius = 15;
        if (cmd.stats){
          cmd.stats = false;
          cmd.statsText = "";
        }
          
      }
    } 
  }
}

void checkGameOver(){
 int count = 0;
 for (int i = 0; i < players.size(); i++){
  Player p = (Player) players.get(i);
  for (int j = 0; j < p.characters.size(); j++){
    Character c = (Character) p.characters.get(j);
    if (c.name.equals("Tamer"))
      count ++;
  }
 }
 if (count == 1){
   cmd.gameOver = true;
 }
 else
   cmd.gameOver = false;
  
}

float calculateDist(float x1, float y1, float x2, float y2){
 return sqrt(pow(x1 - x2,2) + pow(y1 - y2,2)); 
}