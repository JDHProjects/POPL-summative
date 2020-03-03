#lang racket
(define (a-game number)  ; a-game environment
  (define (errorMessage number)  ; 2 <= number <= 30 error message in own procedure for readability
    (printf "Game Player, you decide to go with number: ~a
. . Wrong, number/amount should be a minimum of 2 pounds
and a maximum of 30 pounds" number))  ; format string ~a replaced  by number

  (define (validMessage number)  ; intro message in own procedure for readability
    (printf "Game Player, you decide to go with number: ~a
GREAT!!!
Remember, in the game, if the player wins, then he scores
1 point [Game Machine will increase player's
account(number) by 1 pound, and deduct 2 pounds from its
account].
If the player loses, then he will lose 2 points [Game
Machine will deduct 2 pounds from player's
account(number), and add 1 pound in its account].
During the game, if the player doesn’t have any credit,
then the game ends. The player can start a new game by
re-register with a deposit.
Generating a random number is now requested. Game Machine
is about to generate a random number and compare it with
the player's number." number))
  
  (define (the-game-number request)  ; the-game-number procedure (params: request)
    (lambda ([input 'null])  ; request parameter (default to 'null if not needed/supplied) 
      (cond  ;  switch statement on request
        [(eqv? request 'randomnum) (randomnum input)]  ; run randomnum with input parameter if request matches it
        [(eqv? request 'increasemoney) (increasemoney)]  ; run increasemoney if request matches it
        [(eqv? request 'decreasemoney) (decreasemoney)]  ; run decreasemoney if request matches it
        [(eqv? request 'topup) (topup input)]  ; run topup with input parameter if request matches it
        [else (printf ". . unknown request ~a" request)])  ; default case if request unknown
      )
    )
  
  (define (randomnum random)  ; randomnum procedure (params: random)
    (set! random (random 2 51))  ; assign random to a random value between 2 and 50 inclusive
    (printf "The random number is: ~a\n" random)  ;
    (printf "Game Player, your number is: ~a\n" number)
    (if (<= number random)  ; if random number is larger or equal to player number, output loss message, otherwise output win message 
        (printf "If your number is less than or equal the random number,
you lose, otherwise you win.
Unfortunately, you have lost, Game Machine will deduct 2
pounds from your account.")
        (printf "If your number is less than or equal the random number,
you lose, otherwise you win.
Great, you have won, Game Machine will add one pound in
your account.")
        ) 
    )

  (define (topup t)  ; topup procedure (params: t)
    (if (or (> t 30) (< t 2))  ; if topup not valid (not 2 <= topup <= 30), output invalid message, otherwise output valid message and topup
        (printf "Game Player, you just topped up: ~a pound(s)
. . Wrong,number/amount should be a minimum of 2 pounds
and a maximum of 30 pounds" t)
        (begin  ; needed as if statement only wants one procedure for else
          (set! number t)  ; set number to topup value
          (printf "Game Player, you just topped up: ~a pound(s)
Great, you can play now" t)
          )
        )
    )
  
  (define (decreasemoney)  ; decreasemoney procedure
    (printf "Game Player, previously you had:~a pound(s)
You have lost, Game Machine is deducting 2 pounds from
your account!\n" number)
    (set! number (- number 2))  ; subtract 2 from number
    (printf "You now have:~a pound(s)\n" number)
    (if (> number 1)  ; if number > 1, output continue to play message, otherwise output out of credit message
        (printf "You still have enough credit to play.")
        (printf ". . Sorry, you are out of credit, which you can't
continue to play. To continue playing, you need to topup.
See you soon!!!")
        )
    )

  (define (increasemoney)  ; increasemoney procedure
    (printf "Game Player, previously you had:~a pound(s)
You have scored 1 point, and been awarded 1 pound by the
Game Machine!\n" number)
    (set! number (+ number 1))  ; add 1 to number
    (printf "You now have:~a pound(s)\n" number)
    )
  
  (if (or (> number 30) (< number 2))  ; if number not valid (not 2 <= topup <= 30), output invalid message, otherwise output valid message and allow player to use requests (randomnum, topup etc) 
      (errorMessage number)
      (begin
        (validMessage number)
        the-game-number  ; allows player to make requests 
        )
      )
 
  )  ; a-game environment ends

(define  game_machine_amount 0)  ; game_machine_amount initialises to 0 

(define (game_machine_decrement)  ; game_machine_decrement procedure
  (printf "Game Machine, before you had: ~a pound(s)\n" game_machine_amount)
  (set! game_machine_amount (- game_machine_amount 2))  ;subtract 2 from game_machine_amount
  (printf "You now have: ~a pound(s)\n" game_machine_amount)
  (if (> game_machine_amount 1)    ; if game_machine_amount > 1, output continue to play message, otherwise output out of credit message
      (printf "Game Machine, there is still enough money in the machine
for a game to be played")
      (printf ". . Game Machine, there isn't any credit in the machine
for a game to be played, needs to top up")
      )
  )

(define (game_machine_increment)  ; game_machine_increment procedure
  (printf "Game Machine, before you had: ~a pound(s)\n" game_machine_amount)
  (set! game_machine_amount (+ game_machine_amount 1))  ; add 1 to game_machine_amount
  (printf "You now have: ~a pound(s)\n" game_machine_amount)
  )




