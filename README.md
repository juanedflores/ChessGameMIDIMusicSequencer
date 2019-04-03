# ChessGameMIDIMusicSequencer
A chess game that you can play while also making music collaboratively with your opponent/friend. 

I thought of this idea as an interesting challenge while playing chess with a friend. I then researched online and found this project dating from 2012 on the hackaday website made by Jarl Einar Ottestad (tinkartank) after I already started coding.
https://hackaday.com/2012/04/18/chess-board-step-sequencer/
It seems he had the same idea of utilizing the letters used to define positions on the 8x8 board as notes on a scale.
He even states that "H to denote the key of B is not uncommon in some parts of Europe. In this system, the key of Bb is notates as B and B is H."

I would like to explore more possibilities one can do with this chessboard format, while also applying the rules of the game, and making collaborative music.
I am thinking H can represent a percussive element. 

This is the 8x8 Matrix:
[A1][B1][C1][D1][E1][F1][G1][H1]  
[A2][B2][C2][D2][E2][F2][G2][H2]  
[A3][B3][C3][D3][E3][F3][G3][H3]  
[A4][B4][C4][D4][E4][F4][G4][H4]  
[A5][B5][C5][D5][E5][F5][G5][H5]  
[A6][B6][C6][D6][E6][F6][G6][H6]  
[A7][B7][C7][D7][E7][F7][G7][H7]  
[A8][B8][C8][D8][E8][F8][G8][H8]  

This project serves as a proof of concept and uses Processing as a visual interface and sends position information to Cycling '74's Max visual coding software to handle the portion that behaves like a step sequencer. In the future I would also like to turn it into a physical interface using a similar system involving reed switches and magnets.

