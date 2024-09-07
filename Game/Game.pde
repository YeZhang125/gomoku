from AI import AI
from Gomoku import Gomoku

import random
import time

GRID = 15
FRAME = 30
INTERVAL = 50
WIDTH = (GRID-1)*INTERVAL + 2*FRAME
HEIGHT = (GRID-1)*INTERVAL + 2*FRAME


               
gk = Gomoku()
gk.load()

def setup():
    answer = input('enter your name')
    if answer:
        print('hi ' + answer)
        gk.username = answer

    elif answer == '':
        print('[empty string]')
    else:
        print(answer) # Canceled dialog will print None

    size(WIDTH, HEIGHT)
    strokeWeight(3)
    background(155, 130, 10)
    gk.board()
    
    
def draw():
    if gk.state:
        if gk.human_turn == False:
            time.sleep(3)
            gk.ai_move()
            gk.win()

def mouseClicked():
    if gk.state:
        gk.human_move(mouseX, mouseY)
        gk.win()

        
def input(self, message=''):
    from javax.swing import JOptionPane
    return JOptionPane.showInputDialog(frame, message)
