import java.util.*;
import java.net.*;
import java.io.*;

public int[][] lastPoints = new int[1][2];
public int rounds = 1;
public int timeLimit = 30; // seconds
public int currentPlayer;
public String[] wordList = {"cat","dog","bee","bat","rat","light","desk","pizza","dress","school","butterfly"};
public String secretWord;
Scanner myObj = new Scanner(System.in);
Level myVar;
HashMap<Integer,Player> currentTurns;
String guess = "";

enum Level {
    DRAWING,
    GUESSING,
    NONE,
    END
}

public void setup() {
  
  
  size(800,800);
  Player p1 = new Player(1);
  Player p2 = new Player(2);
  background(255);

  
  currentTurns = new HashMap<Integer,Player>();
  
  currentTurns.put(1,p1);
  currentTurns.put(2,p2);

  currentPlayer = 1;
  
  thread("game");
  myVar = Level.NONE;
  
  
  
   
}


public void game(){
  
  
  for(int i = 0; i < rounds; i++){
    for(int j = 0; j < 2 ; j++){
      System.out.println();
      secretWord = wordList[(int)(Math.random()*wordList.length)];
      
      System.out.println("your word is "+ secretWord);
      System.out.println("current turn is player "+ currentTurns.get(currentPlayer).turn);
      System.out.println("You have 10 seconds to draw your word!");
      System.out.println();
      int currentSeconds = second()+ minute()*60+ hour()*3600;
      while(currentSeconds+10 >= (second()+ minute()*60+ hour()*3600)){
        myVar = Level.DRAWING;
      }
      
      System.out.println("timer is over");
      //guessing
      System.out.println("Now its time to guess(you have 5 seconds): ");
      
      currentSeconds = second()+ minute()*60+ hour()*3600;  
      
      while(currentSeconds+5 >= (second()+ minute()*60+ hour()*3600)){
        myVar = Level.GUESSING;
        //wait
      }
      System.out.println("guessing is over"); 
      if(guess.equals(secretWord)){
        System.out.println("player "+currentTurns.get(currentPlayer).turn+" got their word guessed correctly!");
        currentTurns.get(currentPlayer).increaseScore();
      }
      else{
        System.out.println("you got it wrong lol, no points for you");
      }
      
      myVar = Level.NONE;
      currentSeconds = second()+ minute()*60+ hour()*3600;
      while(currentSeconds+0.1 >= (second()+ minute()*60+ hour()*3600)){
        myVar = Level.NONE;
      }
            
      
      
      currentPlayer++;
      if(currentPlayer >= 3){
        currentPlayer = 1;
      }
    }
    
  }
  System.out.println("Game Over!");
  
  int thing = checkWin();
  if(thing == 0){
    System.out.println("Tie! End of Game :D");
  }
  else{
    System.out.println("player "+ thing+ "won! play again ig?");
  }
  myVar = Level.END;
  
}

public int checkWin(){
  if(currentTurns.get(1).score > currentTurns.get(2).score){
    return(1);
  }
  else if(currentTurns.get(1).score < currentTurns.get(2).score){
    return(2);
  }
  else{
    return(0);
  }
    
  
}

public void draw() {
  
  switch(myVar){
    
    case DRAWING:

      if (mousePressed){
        
        if(lastPoints[0] != null){
           line(mouseX,mouseY, lastPoints[0][0], lastPoints[0][1]);
        }
        stroke(0);
        strokeWeight(5);
        point(mouseX, mouseY);
        int[] a = {mouseX, mouseY};
        lastPoints[0] = a;    
      }
      else{
        lastPoints[0] = null;
      }
      break;
  case GUESSING:
    //keyboard input
    fill(255);
    
    rect(0, 800-100, 800, 50);
    
    fill(0);
    textSize(50);

    text(guess, 400, 750);

    break;
    
  case NONE:
    guess = "";
    background(255);
    break;

  case END:
    background(255);
    fill(0);
    textSize(100);

    text("END OF GAME LOL", 25, 400);

    
  default:
    "".isEmpty();
    break;
  }
    
}

class Player{
  
  int turn;
  int score = 0; 
  Player(int turn){
    this.turn = turn;
  }

  public void increaseScore(){
    this.score++;
  }
  
  
}
void keyPressed()
{
         if (keyAnalyzer(key).compareTo("LETTER") == 0 || keyAnalyzer(key).compareTo("NUMBER") == 0)
        {
           guess = guess + key;
        }
        if (keyCode == BACKSPACE)
        {
           guess = guess.substring(guess.length()-1);
        }
}

String keyAnalyzer(char c)
{
    if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9')
    {
        return "NUMBER";
    }
    else if (c == 'A' || c == 'a' || c == 'B' || c == 'b' || c == 'C' || c == 'c' || c == 'D' || c == 'd' || c == 'E' || c == 'e' ||
             c == 'F' || c == 'f' || c == 'G' || c == 'g' || c == 'H' || c == 'h' || c == 'I' || c == 'i' || c == 'J' || c == 'j' ||
             c == 'K' || c == 'k' || c == 'L' || c == 'l' || c == 'M' || c == 'm' || c == 'N' || c == 'n' || c == 'O' || c == 'o' ||
             c == 'P' || c == 'p' || c == 'Q' || c == 'q' || c == 'R' || c == 'r' || c == 'S' || c == 's' || c == 'T' || c == 't' ||
             c == 'U' || c == 'u' || c == 'V' || c == 'v' || c == 'W' || c == 'w' || c == 'X' || c == 'x' || c == 'Y' || c == 'y' ||
             c == 'Z' || c == 'z')
    {
        return "LETTER";
    }
    else
    {
        return "OTHER";
    }
}
