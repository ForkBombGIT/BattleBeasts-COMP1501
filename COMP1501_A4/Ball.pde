class Ball{
  Vector position;
  Character target;
  
  Ball(float x, float y,Character c){
   position = new Vector(x,y); 
   target = c;
  }
  
  void drawBall(){
    System.out.println("h");
    float distX = (target.position.x - position.x);
    float distY = (target.position.y - position.y);
    float dist = sqrt(pow(distX,2) + pow(distY,2));
         
    position.x += ((distX)/dist) * 2;
    position.y += ((distY)/dist) * 2;
    
    if (calculateDist(position.x,position.y,target.position.x,target.position.y) < 15){          
      pp.moveCount++;
      target.health -= 4;
      if (target.health <= 0){
        Player p = (Player) players.get(target.team); 
        p.characters.remove(target);
      }
      cmd.battleLog = true;
      cmd.battleLogText = target.name + " [" + target.id.toUpperCase() + "] health is now at " + target.health;
      balls.remove(this);
    }
    
    fill(255,0,0);
    noStroke();
    ellipse(position.x,position.y,15,15);
  }
  
}