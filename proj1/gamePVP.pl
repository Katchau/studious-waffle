:-include('board.pl').

verifyPlayerPiece(Pnum, Piece):- Piece == 'x', Pnum == 0; Piece == 'o', Pnum == 1.

checkRightPiece(Board, X, Y, Pnum, Piece):- select_piece(Board, X, Y, Piece),
                                            verifyPlayerPiece(Pnum, Piece).

initGamePVP():- load_lib, final_board(Board),
                playGamePVPinit(Board).

playGamePVPinit(Board):- N is 0,
                         playGamePVP(N, Board).

playGamePVP(N, Board):- N1 is N+1,
                        Num is (N mod 2), Pnum is (Num + 1), nl,
                        write('Player'), write(Pnum), write(' playing:'), nl,
                        display_board(Board), nl,
                        repeat,
                        (
                            repeat,
                            (
                                write('Enter the coordinates of the piece:'), nl,
                                readCoords(X,Y),
                                checkRightPiece(Board, X, Y, Num, Piece)
                            ),
                            write('Enter the coordinates of the destinantion of the piece:'), nl,
                            readCoords(Xf,Yf),
                            (
                                jump(Board, NewBoard, Piece, X, Y, Xf, Yf);
                                (
                                    check_restriction(Board, X, Y, Xf, Yf),
                                    (
										
                                       ( check_center_move(10, X, Y, Xf, Yf); check_mov_adjoining(Board, Xf, Yf) ),
                                        move_piece(Board, NewBoard, X, Y, Xf, Yf, Piece) 
                                    )
                                )
                            )
                        ),
						(game_over(Piece, NewBoard, Pnum) ;
                        playGamePVP(N1, NewBoard) ).
