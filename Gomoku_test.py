
from AI import AI
from Gomoku import Gomoku

gk = Gomoku()
ai = AI(gk)


def test_load():
    gk.load()
    assert gk.user_data != []


def test_switch_turn():
    gk.human_turn = True
    gk.switch_turn()
    assert not gk.human_turn


def test_get_empty_intersection():
    gk.stone_list = [(120, 150, 1), (120, 180, 1), (120, 210, 1),
                     (120, 240, 1), (120, 270, 1)]
    test_data = sorted([(120, 120), (120, 300), (90, 120), (90, 150),
                        (90, 180), (90, 210), (90, 240), (90, 270),
                        (90, 300), (150, 120), (150, 150), (150, 180),
                        (150, 210), (150, 240), (150, 270), (150, 300)])
    assert sorted(gk.get_empty_intersection()) == test_data


def test_check_win():
    gk.stone_list = [(210, 150, 1), (210, 180, 1),
                     (210, 210, 1), (210, 240, 1)]
    assert gk.check_win('Black', (210, 120))

    gk.stone_list = [(90, 150, 0), (210, 240, 1)]
    assert not gk.check_win('Black', (30, 30))
