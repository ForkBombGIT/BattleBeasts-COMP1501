class Player{
  Vector position;
  ArrayList characters = new ArrayList();
  int playerNum;
  int moveCount = 0;
  
  boolean selection = false;
  
  Player(int pN){
    playerNum = pN;
    if (pN == 1){
      characters.add(new Character(262.5,112.5,"Tengu",pN,"a1"));
      characters.add(new Character(312.5,112.5,"Tengu",pN,"a2"));
      characters.add(new Character(362.5,112.5,"Giant",pN,"a3"));
      characters.add(new Character(387.5,87.5,"Tamer",pN,"a4"));
      characters.add(new Character(412.5,112.5,"Giant",pN,"a5"));
      characters.add(new Character(462.5,112.5,"Dragon",pN,"a6"));
      characters.add(new Character(512.5,112.5,"Dragon",pN,"a7"));
    }
    if (pN == 3){
      characters.add(new Character(262.5,687.5,"Tengu",pN,"b1"));
      characters.add(new Character(312.5,687.5,"Tengu",pN,"b2"));
      characters.add(new Character(362.5,687.5,"Giant",pN,"b3"));
      characters.add(new Character(387.5,712.5,"Tamer",pN,"b4"));
      characters.add(new Character(412.5,687.5,"Giant",pN,"b5"));
      characters.add(new Character(462.5,687.5,"Dragon",pN,"b6"));
      characters.add(new Character(512.5,687.5,"Dragon",pN,"b7"));
    }
    if (pN == 4){
      characters.add(new Character(112.5,262.5,"Tengu",pN,"c1"));
      characters.add(new Character(112.5,312.5,"Tengu",pN,"c2"));
      characters.add(new Character(112.5,362.5,"Giant",pN,"c3"));
      characters.add(new Character(87.5,387.5,"Tamer",pN,"c4"));
      characters.add(new Character(112.5,412.5,"Giant",pN,"c5"));
      characters.add(new Character(112.5,462.5,"Dragon",pN,"c6"));
      characters.add(new Character(112.5,512.5,"Dragon",pN,"c7"));
    }
    if (pN == 2){
      characters.add(new Character(687.5,262.5,"Tengu",pN,"d1"));
      characters.add(new Character(687.5,312.5,"Tengu",pN,"d2"));
      characters.add(new Character(687.5,362.5,"Giant",pN,"d3"));
      characters.add(new Character(712.5,387.5,"Tamer",pN,"d4"));
      characters.add(new Character(687.5,412.5,"Giant",pN,"d5"));
      characters.add(new Character(687.5,462.5,"Dragon",pN,"d6"));
      characters.add(new Character(687.5,512.5,"Dragon",pN,"d7"));
    }
  }
}