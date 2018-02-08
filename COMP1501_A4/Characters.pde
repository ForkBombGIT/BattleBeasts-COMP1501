class Character{
 Vector position;
 String name;
 int team;
 
 int moves;
 int damage;
 int health;
 String id;
 String[] specials = new String[1];
 
 boolean isMoving = false;
 boolean moveLeft = true,
         moveRight = true,
         moveDown = true,
         moveUp = true;
 boolean mooved = false;
 
 String dir = "";
 int steps = 0;
 int count = 0;
 
 int dSpeed = 1,
     uSpeed = 1,
     lSpeed = 1,
     rSpeed = 1;
 int reduction = 0;
 int cTeam = 1;
 
 String tID = "";
 
 int effectRadius = 15;
 int effectMax;
 float shrink = 1.5;
 boolean applyEffect = false;
 
 boolean selected = false;
 
 Character(float x, float y, String n, int t, String ID){
  position = new Vector(x,y);
  name = n;
  team = t;
  id = ID;
  
  if (name.equals("Tengu")){
   moves = 8;
   damage = 2;
   health = 8;
   effectMax = 55;
   specials = new String[] {"\n- Defend\n   - Reduces damage taken during\n     the next turn\n"};
  }
  if (name.equals("Giant")){
   moves = 4;
   damage = 6;
   health = 15;
   effectMax = 130;
   specials = new String[] {""};
  }
  if (name.equals("Dragon")){
   moves = 6;
   damage = 5;
   health = 12;
   effectMax = 180;
   specials = new String[] {"\n- Fire Ball\n   - Shoots a projectile at an enemy\n" + 
                            "To use: /special/ [ENEMY ID]-"};
  }
  if (name.equals("Tamer")){
   moves = 10;
   damage = 2;
   health = 10;
   effectMax = 105;
   specials = new String[] {"\n- Heal\n   - Heals a selected beast\n"};
  }
 }
   
 void drawCharacter(){
   if (health <= 0){
     Player pla = (Player) players.get(team - 1);
     Player cPla = (Player) players.get(cTeam);
     
     if (name.equals("Tamer")){
       int iterate = 0;
       for (int i = 0; i < pla.characters.size(); i++){
         Character c = (Character) pla.characters.get(i);
         c.team = cPla.playerNum;}
         
         while (iterate != 7){
           Character ch = (Character) pla.characters.get(0);
           if (ch.team == cPla.playerNum){
             cPla.characters.add(ch);
             pla.characters.remove(ch);
           }
         iterate ++;
         }
       pla.characters.remove(this);
   }
 }
   if (selected){
      applyEffect(244,250,0);
   }
   
   fill(255);
   
   textSize(12);
   text(id.toUpperCase(),position.x - 7,position.y + 22);
   strokeWeight(2);
   if (team == 1)
     stroke(211,0,0);
   if (team == 2)
     stroke(0,211,0);
   if (team == 3)
     stroke(0,0,211);
   if (team == 4)
     stroke(211,211,0);
     
   if (name.equals("Tengu"))
     ellipse(position.x, position.y, 20,20);  
   
   if (name.equals("Giant"))
     ellipse(position.x, position.y, 20,20);
   
   if (name.equals("Dragon"))
     ellipse(position.x, position.y, 20,20);
   
   if (name.equals("Tamer"))
     ellipse(position.x, position.y, 20,20);
   
 
 }
 
 void move(){
   if ((count != steps)){
     isMoving = true;
     if (position.x <= 60)
       lSpeed = 0;
     else
       lSpeed = 1;
     if (position.y <= 63)
       uSpeed = 0;
     else
       uSpeed = 1;
     if (position.y > 737)
       dSpeed = 0;
     else
       dSpeed = 1;
     if (position.x > 737)
       rSpeed = 0;
     else
       rSpeed = 1;
         
     if (dir.equals("left")){
       for (int w = 0; w < players.size(); w++){
         Player playy = (Player) players.get(w);
         for (int p = 0; p < playy.characters.size(); p++){
            Character charr = (Character) playy.characters.get(p);
            
            if ((((position.x - 25) == charr.position.x)) && (position.y == charr.position.y)){
              moveLeft = false;
              break;
            } 
            else moveLeft = true;
         }
         if (moveLeft == false)
           break;
       }
       if (moveLeft){
         position.x -= lSpeed;
         count++;
         mooved = true;      
         cmd.moveLog = true;
         cmd.moveLogText = "Successful movement of " + name + " [" + id.toUpperCase() + "] " + steps/25 + "\nspace(s) " + dir;
       }
       if (!moveLeft){
         count = steps;
         cmd.moveLog = true;
         cmd.moveLogText = name + " [" + id.toUpperCase() + "] cant move " + steps/25 + " space(s) " + dir;
       }
     }
     
     else if (dir.equals("right")){
       for (int w = 0; w < players.size(); w++){
         Player playy = (Player) players.get(w);
         for (int p = 0; p < playy.characters.size(); p++){
            Character charr = (Character) playy.characters.get(p);
            
            if (((position.x + 25) == charr.position.x) && (position.y == charr.position.y)){
              moveRight = false;
              break;
            } 
            else moveRight = true;
         }
         if (moveRight == false)
           break;
       }
       if (moveRight){
         position.x += rSpeed;
         count++;
         mooved = true;      
         cmd.moveLog = true;
         cmd.moveLogText = "Successful movement of " + name + " [" + id.toUpperCase() + "] " + steps/25 + "\nspace(s) " + dir;
       }
       if (!moveRight){
         cmd.moveLog = true;
         cmd.moveLogText = name + " [" + id.toUpperCase() + "] cant move " + steps/25 + " space(s) " + dir;
         count = steps;
       }
     }
     
     else if (dir.equals("up")){
       for (int w = 0; w < players.size(); w++){
         Player playy = (Player) players.get(w);
         for (int p = 0; p < playy.characters.size(); p++){
            Character charr = (Character) playy.characters.get(p);
            
            if (((position.y - 25) == charr.position.y) && (position.x == charr.position.x)){
              moveUp = false;
              break;
            } 
            else moveUp = true;
         }
         if (moveUp == false)
           break;
       }
       if (moveUp){
         position.y -= uSpeed;
         count++;
         mooved = true;      
         cmd.moveLog = true;
         cmd.moveLogText = "Successful movement of " + name + " [" + id.toUpperCase() + "] " + steps/25 + "\nspace(s) " + dir;
       }
       if (!moveUp){
         count = steps;
         cmd.moveLog = true;
         cmd.moveLogText = name + " [" + id.toUpperCase() + "] cant move " + steps/25 + " space(s) " + dir;
       }
     }
     else if (dir.equals("down")){
       for (int w = 0; w < players.size(); w++){
         Player playy = (Player) players.get(w);
         for (int p = 0; p < playy.characters.size(); p++){
            Character charr = (Character) playy.characters.get(p);
            
            if (((position.y + 25) == charr.position.y) && (position.x == charr.position.x)){
              moveDown = false;
              break;
            } 
            else moveDown = true;
         }
         if (moveDown == false)
           break;
       }
       if (moveDown){
         position.y += uSpeed;
         count++;      
         cmd.moveLog = true;
         cmd.moveLogText = "Successful movement of " + name + " [" + id.toUpperCase() + "] " + steps/25 + "\nspace(s) " + dir;
         mooved = true;
       }
       if (!moveDown){
         count = steps;
         cmd.moveLog = true;
         cmd.moveLogText = name + " [" + id.toUpperCase() + "] cant move " + steps/25 + " space(s) " + dir;
       }
     }
     drawCharacter();
   }
   else{
     count = 0;
     isMoving = false;
          
     if (mooved){
       pp.moveCount += 1;
     }
     else{
       cmd.moveLog = true;
       cmd.moveLogText = name + " [" + id.toUpperCase() + "] cant move " + steps/25 + " space(s) " + dir;
     }
     
     dir = "";
     steps = 0;
     if (pp.moveCount == 3){
        pp.selection = false;
        pp.moveCount = 0;
        for (int i = 0; i < pp.characters.size(); i++){
         Character c = (Character) pp.characters.get(i);
         
         c.selected = false;
        }
        
        turn ++;
        }
   }
 }
 
 void specialAttack(){
  if (name.equals("Tengu")){
      reduction += 2;
      cmd.battleLog = true;
      cmd.battleLogText = name + " [" + id.toUpperCase() + "] defense has been buffed by 2";
      pp.moveCount ++;
  }
  
  if (name.equals("Dragon")){
    for (int i = 0; i < players.size(); i++){
      Player play = (Player) players.get(i);
      for (int q = 0; q < play.characters.size(); q++){
        Character c = (Character) play.characters.get(q);
        
        if (c.id.equals(tID)){
         if (calculateDist(position.x,position.y,c.position.x, c.position.y) < 90){
           balls.add(new Ball(position.x,position.y,c)); 
           cmd.battleLog = true;
           cmd.battleLogText = "Sucessful special attack on " + c.name + " [" + c.id.toUpperCase() + "]"; 
         }
         else{
           cmd.battleLog = true;
           cmd.battleLogText = c.name + " [" + c.id.toUpperCase() + "] is not in range"; 
         }
        }
      }
    } 
  }
  
  if (name.equals("Tamer")){
    boolean found = false;
    for (int i = 0; i < players.size(); i++){
      Player play = (Player) players.get(i);
      for (int q = 0; q < play.characters.size(); q++){
        Character c = (Character) play.characters.get(q);
        if (c.id.equals(tID)){ 
          found = true;
          System.out.println(calculateDist(position.x,position.y,c.position.x,c.position.y));
          if (calculateDist(position.x,position.y,c.position.x,c.position.y) < 60){
            c.health += 4;
            cmd.battleLog = true;
            cmd.battleLogText = name + " [" + id.toUpperCase() + "] has healed " + c.name + " [" + c.id.toUpperCase() + "] by 4";
            pp.moveCount ++;
          }
          else{
            cmd.battleLog = true;
            cmd.battleLogText = c.name + "[" + c.id.toUpperCase() + "] is not in range"; 
          }
        }
      }
    }
    if (!found){
      cmd.battleLog = true;
      cmd.battleLogText = "ID not found";
    }
  }
  
 if (pp.moveCount == 3){
   pp.selection = false;
   pp.moveCount = 0;
   for (int i = 0; i < pp.characters.size(); i++){
     Character c = (Character) pp.characters.get(i);
         
   c.selected = false;
   }
        
   turn ++;
   }
 }
 
 void applyEffect(int r, int g, int b){
    applyEffect = true;
    strokeWeight(2);
    stroke(r,g,b,85);
    noFill();
    
    if (effectRadius > effectMax)
      shrink = -1;
    if (effectRadius < 0)
      shrink = 1.5;
    
    if (applyEffect == true)
      effectRadius += shrink;
      
    ellipse(position.x,position.y,effectRadius,effectRadius); 
 }
}