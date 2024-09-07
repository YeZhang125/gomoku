
from AI import AI
from Gomoku import Gomoku

gk = Gomoku()
ai = AI(gk)


def test_check_ai_win():
    gk.stone_list = [(120, 150, 1), (120, 180, 1), (120, 210, 1),
                     (120, 240, 0), (150, 120, 0), (150, 150, 0)]
    assert ai.check_ai_win() is None

    gk.stone_list = [(120, 150, 0), (120, 180, 0),
                     (120, 210, 0), (120, 240, 0)]
    assert ai.check_ai_win() == (120, 270)


def test_check_human_win():
    gk.stone_list = [(210, 150, 1), (210, 180, 1),
                     (210, 210, 1), (210, 240, 1)]
    assert ai.check_human_win() == (210, 120)

    gk.stone_list = [(300, 150, 1), (300, 180, 1), (300, 210, 1)]
    assert ai.check_human_win() == (300, 240)

    gk.stone_list = [(30, 150, 1), (300, 180, 1)]
    assert ai.check_human_win() is None


def test_get_best_move():
    gk.stone_list = [(210, 150, 1), (210, 180, 1),
                     (210, 210, 1), (210, 240, 1)]
    assert ai.get_best_move() == (210, 120)

    gk.stone_list = [(120, 150, 0), (120, 180, 0),
                     (120, 210, 0), (120, 240, 0)]
    assert ai.get_best_move() == (120, 270)

    gk.stone_list = [(300, 150, 1), (300, 180, 1)]
    assert ai.get_best_move() is not None


def test_make_random_move():
    gk.stone_list = [(120, 150, 0), (120, 180, 0),
                     (120, 210, 0), (120, 240, 0)]
    assert ai.make_random_move() is not None
