.num_players = 2
|
.wall |= map(select(IN("1s","2s","3s","4s","5s","6s","7s","8s","9s","10s")))
|
.initial_dead_wall_length = 0
|
.reserved_tiles = []
|
.functions.do_kan_draw = [["set_status", "kan"], ["draw"]]
|
.initial_score = 150000
|
.display_riichi_sticks = false
|
.display_honba = false
|
.score_calculation.riichi_value = 0
|
.score_calculation.honba_value = 0
|
.buttons |= del(.chii) | del(.pon) | del(.daiminkan)
|
.yakuman += [
  {"display_name": "_clear_yaku", "value": 1, "when": [{"name": "others_status", "opts": ["dead_hand"]}]}
]
|
.meta_yakuman += [
  {"display_name": "Chombo", "value": 1, "when": [{"name": "others_status", "opts": ["dead_hand"]}]}
]
|
.after_turn_change.actions = [
  ["ite", [{"name": "others_status", "opts": ["dead_hand"]}], [
    ["uninterruptible_draw", 1, "4x"],
    ["merge_draw"],
    ["uninterruptible_draw", 1, "4x"],
    ["set_tile_alias", ["4x"], ["any"]],
    ["win_by_draw"]
  ], .after_turn_change.actions]
]
|
.yaku_precedence += {
  "_clear_yaku": [1,2,3,4,5,6]
}
|
.default_mods |= map(select(IN("show_waits", "dora", "ura", "aka", "kandora", "suufon_renda", "suucha_riichi") | not))
