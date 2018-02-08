class GUI{
  void drawPlayingGround(){
    fill(6,100,1);
    stroke(95);
    strokeWeight(10);
    rect(50,50,700,700);
    
    int xx = 50, yy = 50;
    strokeWeight(4);
    stroke(255,255,255,25);
    for (int x = 0; x < 27; x++){
     xx += 25;
     line(xx,56,xx,744); 
    }
    
    for (int x = 0; x < 27; x++){
     yy += 25;
     line(56,yy,744,yy); 
    }
  }
  
  void drawSideBar(){
    textSize(24);
    
    //Top Bar
    fill(95);
    rect(800,50,310,700);
    
    fill(72);
    noStroke();
    rect(808,56,295,55);
    
    fill(255);
    text("MOVES: " + pp.moveCount,985,92);
   
    fill(72);
    rect(808,125,295,615);
    
    
    //Command Field
    fill(0);
    rect(815,690,280,40);
    
    strokeWeight(2);
    
    if (turn == 1)
      stroke(255);
    else
      noStroke();
    fill(211,0,0);
    ellipse(830,83,25,25);
    if (turn == 2)
      stroke(255);
    else
      noStroke();
    fill(0,211,0);
    ellipse(870,83,25,25);
    if (turn == 3)
      stroke(255);
    else
      noStroke();
    fill(0,0,211);
    ellipse(910,83,25,25);
    if (turn == 4)
      stroke(255);
    else
      noStroke();
    fill(211,211,0);
    ellipse(950,83,25,25);
    
    fill(255);
    textSize(16);
    text("1",825,89);
    text("2",865,89);
    text("3",905,89);
    text("4",945,89);
    noStroke();
    
    textSize(24);
    
    fill(255);
    if (cmd.canType){
      if (userInput.length() == 0)
        text("|",820,719);
      else 
        text(userInput,817,719);
    }
    
    fill(0);
    rect(815,140,280,535);
    
    //CMD TEXT
    fill(255);
    textSize(18);
    text("Command Output",822,160);
    
    textSize(14);
    if (cmd.help)
      text(cmd.helpText,820,185);
      
    else if (cmd.moveLog)
      text(cmd.moveLogText,820,185);
      
    else if (cmd.controls)
      text(cmd.controlsText,820,185);
    
    else if (cmd.stats)
      text(cmd.statsText,820,185);
      
    else if (cmd.battleLog)
      text(cmd.battleLogText,820,185);
      
    else if (cmd.unknown)
      text(cmd.unknownText,820,185);
      
    else if(cmd.gameOver)
      text(cmd.gameOverText,820,185);
    
    else
      text(cmd.startUp,820,185);
    
  }
  void drawGUI(){
    drawPlayingGround();
    drawSideBar();
  }
}