from AI import AI
import random
GRID = 15
FRAME = 30
INTERVAL = 50
WIDTH = (GRID-1)*INTERVAL + 2*FRAME
HEIGHT = (GRID-1)*INTERVAL + 2*FRAME
center = WIDTH//2
STONE_DIS = 15
TEXT_DIS = 60


class Gomoku:
    def __init__(self):

        # chessboard
        self.GRID = GRID
        self.itval = (WIDTH - FRAME * 2) // (self.GRID - 1)
        self.stone_list = []
        self.state = True
        self.human_turn = True
        self.AI = AI(self)
        self.FIVE_STONES = 5
        self.occupied_cell = []
        self.user_data = {}
        self.username = ''
        self.filename = '/Users/yezhang/Documents/cs5001/hw12/Game/scores.txt'

    def board(self):
        '''Draws a n*n chess board.'''
        # upper line
        line(FRAME, FRAME, WIDTH-FRAME, FRAME)
        # left line
        line(FRAME, FRAME, FRAME, HEIGHT-FRAME)
        # bottom line
        line(FRAME, HEIGHT-FRAME, WIDTH-FRAME, HEIGHT-FRAME)
        # right line
        line(WIDTH-FRAME, FRAME, WIDTH-FRAME, HEIGHT-FRAME)
        # middle lines
        for i in range(self.GRID):
            line(FRAME, FRAME+self.itval*i, WIDTH-FRAME, FRAME+self.itval*i)
            line(FRAME+self.itval*i, FRAME, FRAME+self.itval*i, HEIGHT-FRAME)

    def save(self):
        '''Saves user scores to a file.'''
        with open(self.filename, 'w') as file:
            sorted_data = sorted(self.user_data.items(),
                                 key=lambda x: x[1], reverse=True)
            for i in sorted_data:
                file.write(i[0] + ' ' + str(i[1]) + '\n')

    def load(self):
        '''Loads user scores from a file.'''
        with open(self.filename, 'r') as file:
            for i in file.read().split('\n'):
                if i:
                    self.user_data[i.split(' ')[0]] = int(i.split(' ')[-1])

    def switch_turn(self):
        '''Switches the turn between human and AI.'''
        self.human_turn = not self.human_turn

    def human_move(self, x, y):
        '''only allow human play'''
        if self.human_turn and self.state:
            if self.stone(x, y):
                self.switch_turn()

    def ai_move(self):
        '''only allow AI play'''
        if not (self.human_turn and self.state):
            if self.get_empty_intersection():
                i, j = self.AI.get_best_move()
                fill(255)  # White color for AI player
                ellipse(i, j, 25, 25)

                self.stone_list.append((i, j, 0))
                self.switch_turn()

    def get_empty_intersection(self):
        '''Retrieves empty intersections on the board.'''
        ept_list = []
        for (i, j, a) in self.stone_list[::-1]:
            if (i + self.itval) <= (WIDTH - FRAME) and \
               (j + self.itval) <= (HEIGHT - FRAME):
                if (i + self.itval, j + self.itval, 0) not in \
                    self.stone_list and \
                   (i + self.itval, j + self.itval, 1) \
                   not in self.stone_list:
                    ept_list.append((i + self.itval, j + self.itval))
            if (j + self.itval) <= (HEIGHT - FRAME):
                if (i, j + self.itval, 0) not in self.stone_list and \
                   (i, j + self.itval, 1) not in self.stone_list:
                    ept_list.append((i, j + self.itval))
            if (i + self.itval) <= (WIDTH - FRAME):
                if (i + self.itval, j, 0) not in self.stone_list and \
                   (i + self.itval, j, 1) not in self.stone_list:
                    ept_list.append((i + self.itval, j))
            if (i - self.itval) >= FRAME and (j - self.itval) >= FRAME:
                if (i - self.itval, j - self.itval, 0) not in \
                   self.stone_list and \
                   (i - self.itval, j - self.itval, 1) not in self.stone_list:
                    ept_list.append((i - self.itval, j - self.itval))
            if (i - self.itval) >= FRAME:
                if (i - self.itval, j, 0) not in self.stone_list and \
                   (i - self.itval, j, 1) not in self.stone_list:
                    ept_list.append((i - self.itval, j))
            if (j - self.itval) >= FRAME:
                if (i, j - self.itval, 0) not in self.stone_list and \
                   (i, j - self.itval, 1) not in self.stone_list:
                    ept_list.append((i, j - self.itval))
            if (i - self.itval) >= FRAME and \
               (j + self.itval) <= (HEIGHT - FRAME):
                if (i - self.itval, j + self.itval, 0) not in \
                 self.stone_list and\
                   (i - self.itval, j + self.itval, 1) not in self.stone_list:
                    ept_list.append((i - self.itval, j + self.itval))
            if (i + self.itval) <= (WIDTH - FRAME) and \
               (j - self.itval) >= FRAME:
                if (i + self.itval, j - self.itval, 0) not \
                    in self.stone_list and \
                   (i + self.itval, j - self.itval, 1) not in self.stone_list:
                    ept_list.append((i + self.itval, j - self.itval))
        return list(set(ept_list))

    def stone(self, i, j):
        '''location of each grid that stone can be placed'''
        for i in range(FRAME, WIDTH, self.itval):
            for j in range(FRAME, WIDTH, self.itval):
                if ((mouseX - i) ** 2 + (mouseY - j) ** 2) ** 0.5 <= STONE_DIS:
                    if (i, j, 1) in self.stone_list or \
                       (i, j, 0) in self.stone_list:
                        return False
                    else:
                        fill(0)
                        ellipse(i, j, 25, 25)
                        self.stone_list.append((i, j, 1))
                        return True

    def game_over(self, side=""):
        '''Checks and displays game-over status.'''
        if side:
            textSize(25)
            fill(0, 250, 0)
            text("Game Over\n" + side + " wins!", center - TEXT_DIS, center)
            print("Game Over")
            self.state = False
        if len(self.stone_list) == (self.GRID ** 2):
            textSize(25)
            fill(0, 250, 0)
            text("Game Over\n It's a draw", center - TEXT_DIS, center)
            print("Game Over")
            self.state = False

    def check_win(self, player, move):
        '''check if the player has achieved the winning situations'''
        win_list = []
        # in all winning situations, when x axis is same
        for i in range(FRAME, WIDTH, self.itval):
            for j in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_x = []
                for k in range(self.FIVE_STONES):
                    tmp_list_x.append((i, j + k * self.itval))

                win_list.append(tmp_list_x)

        # in all winning situations, when y axis is same
        for k in range(FRAME, WIDTH, self.itval):

            for m in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_y = []
                for c in range(self.FIVE_STONES):
                    tmp_list_y.append((m + c * self.itval, k))
                win_list.append(tmp_list_y)

        # for all winning situations, left diagonal situations

        for h in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                       self.itval):
            for c in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_ld = []
                for a in range(self.FIVE_STONES):
                    tmp_list_ld.append((h + a * self.itval,
                                        c + a * self.itval))
                win_list.append(tmp_list_ld)

        # for all winning situations, right diagonal situations

        for g in range(FRAME+(self.FIVE_STONES - 1) * self.itval, WIDTH,
                       self.itval):
            for b in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_rd = []
                for v in range(self.FIVE_STONES):
                    tmp_list_rd.append((g - v * self.itval,
                                        b + v * self.itval))
                win_list.append(tmp_list_rd)

        # To optimize AI chess playing speed and prevent repeated
        # determination of winning combinations
        # as long as human is placing a 3-in-a-row sequence,
        # ai will predict a move,
        # we delete these winning combinations
        # related to that ai predicted move,
        # if not, AI's judgement will be influenced
        # when it is about to win
        if player == 'Black':
            for item in win_list[:]:
                for mv in self.occupied_cell:
                    if mv in item and item in win_list:
                        win_list.remove(item)

        for item in win_list[:]:
            count = 0
            for i in self.stone_list:
                if (i[0], i[1]) in item:
                    if i[2] == (1 if player == 'Black' else 0):
                        count += 1

            if count == 5:
                return True
            if count == 0:
                win_list.remove(item)

        for item in win_list:
            count = 0
            for i in self.stone_list:
                if (i[0], i[1]) in item:
                    if i[2] == (1 if player == 'Black' else 0):
                        count += 1
                elif (i[0], i[1]) in item:
                    if i[2] != (1 if player == 'Black' else 0):
                        count -= 1
            if count == 4:
                if move in item and player == 'Black':
                    self.occupied_cell.append(move)
                    return True
        return False

    def win(self):
        win_list = []
        # in all winning situations, when x axis is same
        for i in range(FRAME, WIDTH, self.itval):
            for j in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_x = []
                for k in range(self.FIVE_STONES):
                    tmp_list_x.append((i, j + k * self.itval))

                win_list.append(tmp_list_x)

        # in all winning situations, when y axis is same
        for k in range(FRAME, WIDTH, self.itval):

            for m in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_y = []
                for c in range(self.FIVE_STONES):
                    tmp_list_y.append((m + c * self.itval, k))
                win_list.append(tmp_list_y)

        # for all winning situations, left diagonal situations

        for h in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                       self.itval):
            for c in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_ld = []
                for a in range(self.FIVE_STONES):
                    tmp_list_ld.append((h + a * self.itval,
                                        c + a * self.itval))
                win_list.append(tmp_list_ld)

        # for all winning situations, right diagonal situations

        for g in range(FRAME+(self.FIVE_STONES - 1) * self.itval, WIDTH,
                       self.itval):
            for b in range(FRAME, WIDTH - (self.FIVE_STONES - 1) * self.itval,
                           self.itval):
                tmp_list_rd = []
                for v in range(self.FIVE_STONES):
                    tmp_list_rd.append((g - v * self.itval,
                                        b + v * self.itval))
                win_list.append(tmp_list_rd)

        # judge who is winning
        for item in win_list:
            count_b = 0
            count_w = 0
            for i in self.stone_list:
                if (i[0], i[1]) in item:
                    if i[2] == 1:
                        count_b += 1
                    if i[2] == 0:
                        count_w += 1
            if count_b == 5:
                self.game_over('Black')
                iscore = int(self.user_data.get(self.username, 0))
                self.user_data[self.username] = iscore + 1
                self.save()

            elif count_w == 5:
                self.game_over('White')
            else:
                self.game_over('')
