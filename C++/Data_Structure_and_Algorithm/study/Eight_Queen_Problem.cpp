const int BOARD_SIZE = 8; 	// squares per row or column
class EightQueens {
public:
	EightQueens();	// Sets all squares to EMPTY.
	void clearBoard();   	// Sets all squares to EMPTY.
	void displayBoard(); 	// Displays the board.
	bool placeQueens(int currColumn);
// Places queens in columns of the board beginning at column specified.
// Precondition: Queens are placed correctly in columns 1 through
//currColumn-1  and no Queens are placed in columns currColumn through
// BOARD_SIZE.
// Postcondition: If a solution is found, each column of  board contains one
// queen and the function returns true otherwise returns false (no solution
// exists for a queen anywhere in column currColumn).

private:
   int board[BOARD_SIZE]; 	// row-position per column, (zero=no queen)
					// NOTE: board is zero-indexed for columns
   void setQueen(int row, int column);
   	// Places a queen in a given row and column. 
	// Postcondition: There is exactly one queen in the given column.
   void removeQueen(int row, int column);
   	// Removes a queen from a given row and column. 
	// Postcondition: There is no queen in the given column.
   bool isUnderAttack(int row, int column);
   	// Determines whether the square on the board at a given row and column is under attack by any queen in any column.
// Precondition: Queens are placed correctly, i.e. 0<=board[i]<=8 for 0<=i<8.   // Postcondition: If under attack, returns true; otherwise, returns false.
}; 			// end class
bool Queens::placeQueens(int currColumn) { 
	// Calls: isUnderAttack, setQueen, removeQueen.
  	if (currColumn > BOARD_SIZE)   return true; 	// base case
   	else
   	{  	bool queenPlaced = false;
		int row = 1; 	// number of square in column
      while ( !queenPlaced && (row <= BOARD_SIZE) ) {  // if square can be attacked
         if (isUnderAttack(row, currColumn))
             ++row; 		// then consider next square in currColumn
         else { // else place queen and consider next column
	        setQueen(row, currColumn);
              queenPlaced = placeQueens(currColumn+1);
  // if no queen is possible in next column,  backtrack: remove queen placed earlier and try next square in column
            if (!queenPlaced) {
                removeQueen(row, currColumn);
                ++row;
            } } }  // end of while   
      return queenPlaced;
   } } // end placeQueens
