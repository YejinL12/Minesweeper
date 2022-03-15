import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 25;
private int NUM_COLS = 25;
private int NUM_MINES = 50;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < buttons.length; r ++) {
    for (int c = 0; c <buttons[r].length; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }

  setMines();
}
public void setMines()
{
  while (mines.size() < NUM_MINES) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(r) || !mines.contains(c)) {
      mines.add(buttons[r][c]);
      System.out.println(r + "," + c);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(!mines.contains(buttons[r][c]) && !buttons[r][c].clicked){
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
    buttons[0][0].setLabel("Y");
    buttons[0][1].setLabel("o");
    buttons[0][2].setLabel("u");
    buttons[0][3].setLabel(" ");
    buttons[0][4].setLabel("L");
    buttons[0][5].setLabel("o");
    buttons[0][6].setLabel("s");
    buttons[0][7].setLabel("e");
    buttons[0][8].setLabel(" ");
    buttons[0][9].setLabel(":");
    buttons[0][10].setLabel("C");
}

public void displayWinningMessage()
{
    buttons[0][0].setLabel("Y");
    buttons[0][1].setLabel("o");
    buttons[0][2].setLabel("u");
    buttons[0][3].setLabel(" ");
    buttons[0][4].setLabel("w");
    buttons[0][5].setLabel("i");
    buttons[0][6].setLabel("n");
    buttons[0][7].setLabel(" ");
    buttons[0][8].setLabel(":");
    buttons[0][9].setLabel(">");
}
public boolean isValid(int r, int c)
{
  if (r >= NUM_ROWS|| c>= NUM_COLS) {
    return false;
  } else if ( r < 0 || c < 0) {
    return false;
  } else {
    return true;
  }
}
public int countMines(int row, int col)
{
  int numMines = 0;
        if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
            numMines++;
        if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
            numMines++;
        if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
            numMines++;  
        if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
            numMines++;   
        if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
            numMines++;   
        if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
            numMines++;   
        if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
            numMines++;   
        if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
            numMines++;   
        return numMines;
}

public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if(keyPressed == true){
      flagged = !flagged;
      if(flagged == false){
        clicked = false;
      }
    }
    else if(mines.contains(this)){
      displayLosingMessage();
    }else if(countMines(myRow,myCol)>0){
      setLabel("" + countMines(myRow, myCol));
    }
    
     else {
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false)
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false)
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false)
                buttons[myRow-1][myCol].mousePressed();  
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false)
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked == false)
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false)
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked == false)
                buttons[myRow-1][myCol-1].mousePressed();    
            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
                buttons[myRow-1][myCol+1].mousePressed();        
        }
        
            }
   
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
  public boolean isClicked()
{
 return clicked; 
}
public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255,0,0);
    else if (clicked)
      fill( 189,153,189 );
    else 
    fill(100);

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
}
