class CommandPrompt{
  boolean canType = false;
  boolean help = false;
  boolean stats = false;
  boolean controls = false;
  boolean battleLog = false;
  boolean invalid = false;
  boolean moveLog = false;
  boolean gameOver = false;
  boolean unknown = false;
  
  String command = "";
  String keyWord = "";
  String startUp = "Press [ENTER] to type into the\ncommand prompt\nType /help/ for a list of commands\nType /controls/ for a list of controls\n\nYour objective is to capture opponents\n'Tamers' using your army of beasts.\n\nEach turn, you are limited to 3 moves,\nwhich is displayed at the top right of\nthe screen.\nThis includes, attacks, movement, and\nspecials";
  String helpText = "/controls/\n   - Displays game controls\n\n/move/ [DIRECTION] [SPACES]-\n   - Moves Selected Character\nEX: /move/ down 1-\n\n/attack/ [ENEMY ID]-\n   - Attacks selected enemy if in range\n EX: /attack/ a3-\n\n/special/ [ADD. PARAM.]-\n   - Uses the selected characters Special\n"+
                    "\n/stats/\n   - Displays stats for the selected\n      character\n\n/end/\n   - Ends current players turn";
  String statsText = "";
  String controlsText = "[ENTER]\n   - Executes whatever is typed into the\n      prompt\n[LEFT CLICK] on a character\n   - This will select a character that\n      commands can be applied upon\n[RIGHT CLICK] on a character\n   This will deselect a character";
  String invalidText = "That doesn't seem to be valid";
  String battleLogText = "";
  String moveLogText = "";
  String gameOverText = "Gameover.";
  String unknownText = "";
  
  String dir = "";
  String moves = "";
  String targetID = "";
  
  void handleKeyPress(){
    Player p = (Player) players.get(turn - 1);
    if (canType){  
      if (keyCode == BACKSPACE){
        if (userInput.length() > 0){userInput = userInput.substring(0,userInput.length() - 1);}
      }
      
      if (userInput.length() > 0)
        if (keyCode == ENTER){
          command = userInput.toLowerCase();
          userInput = ""; 
          help = false;
          stats = false;
          controls = false;
          battleLog = false;
          moveLog = false;
          unknown = false;
          
          decodeCommand();
        }
      
      if ((keyCode != ENTER) && (keyCode != BACKSPACE) && (userInput.length() < 17)){userInput = userInput += key;}
    }
  }
    
  void decodeCommand(){
    if (command.substring(0,1).equals("/")){
      for (int l = 1; l < command.length();l++){
        if (command.substring(l, l+1).equals("/")){
          keyWord = command.substring(1,l);
          break;
        }
      }
    }
          
      //LIST OF COMMANDS
      if (keyWord.equals("help")){
        help = true;
      }
      
      //LIST OF CONTROLS
      else if (keyWord.equals("controls")){
        controls = true;
      }
      
      //NEXT TURN COMMAND
      else if (keyWord.equals("end")){
       pp.selection = false;
        
       for (int i = 0; i < pp.characters.size(); i++){
         Character c = (Character) pp.characters.get(i);
         
         c.selected = false;
       }
        
       turn++;
       
         
       pp.moveCount = 0;
       help = false;
       cmd.stats = false;
       cmd.statsText = "";
      }
      
      //STATS COMMAND
      else if (keyWord.equals("stats")){
        stats = true;
        statsText = "";
        
        for (int i = 0; i < pp.characters.size(); i++){
          Character c = (Character) pp.characters.get(i);
          
          if (c.selected)
            statsText += ("Name: " + c.name + "\nCurrent Health: " + c.health + "\nMoves: " + c.moves + "\nAttack: " + c.damage + "\nSpecial:" + c.specials[0]);
          }
        
      }
      
      
      //MOVEMENT COMMAND
      else if (keyWord.equals("move")){
        dir = "";
        for (int k = keyWord.length() + 3; k < command.length(); k++){
          if (command.substring(k,k+1).equals(" ")){
            dir = command.substring(keyWord.length() + 3,k);
          }
        }
        
        for (int k = dir.length() + 3; k < command.length(); k++){
          if (command.substring(k,k+1).equals("-")){
            moves = command.substring(keyWord.length()+dir.length() + 4,k);
          }
        }
        
        for(int i = 0; i < pp.characters.size(); i++){
          Character c = (Character) pp.characters.get(i);   
          if (!c.selected){moveLog = true; moveLogText = "That isn't possible";}
          if (pp.moveCount != 3){
            if (c.selected){
              if (!c.isMoving){
                if (((!moves.equals("")) && (!moves.equals("-")) && (Integer.parseInt(moves) <= (c.moves)))){
                  c.dir = dir;
                  c.steps = Integer.parseInt(moves) * 25;
                  moveLog = true;
                  c.mooved = false;
                  moveLogText = "";
                }
                break;
              }
            
            }
          }
          else{
           command = "end";
          }
        }
      }
      
      else if (keyWord.equals("attack")){
        for (int k = keyWord.length() + 4; k < command.length(); k++){
          if (command.substring(k,k+1).equals("-")){
            String letter = command.substring(keyWord.length() + 3,k - 1).toLowerCase();
            targetID = letter + command.substring(keyWord.length() + 4,k);
          }
        }
          for (int w = 0; w < players.size(); w++){
            Player play = (Player) players.get(w);
          
            if (pp.moveCount != 3){
              for(int i = 0; i < pp.characters.size(); i++){
              Character c = (Character) pp.characters.get(i);
                if ((c.selected) && (!c.isMoving)){
                for (int e = 0;  e < play.characters.size(); e++){
                  Character enemy = (Character) play.characters.get(e);
                  enemy.cTeam = c.team - 1;
                  
                  if (enemy.id.equals(targetID)){
                    if (calculateDist(c.position.x,c.position.y,enemy.position.x,enemy.position.y) < 30){
                      enemy.health -= (c.damage - enemy.reduction);
                      enemy.reduction = 0;
                      pp.moveCount ++;
                      
                      battleLog = true;
                      battleLogText = "Attack from " + c.name + " [" + c.id.toUpperCase() + "] succesfully hit\n"  + enemy.name + "[" + enemy.id.toUpperCase() + "]\n" + 
                                      enemy.name + " [" + enemy.id.toUpperCase() + "] is now at " + enemy.health + " health.\n";
                      if (enemy.health <= 0){
                        battleLogText += enemy.name + " [" + enemy.id.toUpperCase() + "] has perished\n";
                      
                      if (enemy.name.equals("Tamer"))
                        battleLogText += "A player's Tamer has perished, and their\narmy has joined Player " + pp.playerNum + "'s army.";
                      }
                      
                      
                      break;
                    }
                    else{
                     battleLog = true;
                     battleLogText = "Enemy is not in attacking range!"; 
                    }
                  }
                }
              break;
             
          }  
          else{
            command = "end";
          }
              }
            }
          }
      }
      
      else if (keyWord.equals("special")){
        for (int k = keyWord.length() + 5; k < command.length(); k++){
          if (command.substring(k,k+1).equals("-")){
            String letter = command.substring(keyWord.length() + 3,k - 1).toLowerCase();
            targetID = letter + command.substring(keyWord.length() + 4,k);
          }
        }
       
       for(int i = 0; i < pp.characters.size(); i++){
         Character c = (Character) pp.characters.get(i);
         if (c.selected){
           c.tID = targetID; 
           c.specialAttack();
           break;
           }
         }
      }
      
     else{
      unknown = true;
      unknownText = "That is not a valid command";
     }
  }
}