import random


class AI:
    def __init__(self, gomoku):
        self.gomoku = gomoku

    def get_best_move(self):
        ai_mv = self.check_ai_win()
        if ai_mv:
            return ai_mv
        hm_mv = self.check_human_win()
        if hm_mv:
            return hm_mv

        return self.make_random_move()

    def check_ai_win(self):
        '''Predict the position of the chess intersection that AI will win'''
        for move in self.gomoku.get_empty_intersection():
            self.gomoku.stone_list.append((move[0], move[1], 0))
            if self.gomoku.check_win("White", move):
                self.gomoku.stone_list.remove((move[0], move[1], 0))
                return move
            self.gomoku.stone_list.remove((move[0], move[1], 0))

    def check_human_win(self):
        '''Predict the position of the chess
        intersection that humans will win'''
        for move in self.gomoku.get_empty_intersection():
            self.gomoku.stone_list.append((move[0], move[1], 1))
            if self.gomoku.check_win("Black", move):
                self.gomoku.stone_list.remove((move[0], move[1], 1))
                return move
            self.gomoku.stone_list.remove((move[0], move[1], 1))

    def make_random_move(self):
        '''If no winning moves, make a random move'''
        ept = self.gomoku.get_empty_intersection()
        rdm_mv = random.choice(ept)
        return rdm_mv
