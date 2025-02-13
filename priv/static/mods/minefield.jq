.default_mods |= map(select(IN("kandora", "aka", "yaku/renhou_yakuman", "kyuushu_kyuuhai", "pao", "suufon_renda", "suucha_riichi", "suukaikan", "show_waits") | not))
|
.available_mods |= map(select(type != "object" or (.id | IN("drawless_riichi") | not)))
|
.starting_tiles = 34
|
.num_players = 2
|
.after_turn_change.actions |= map(
  if .[0] == "ite" and .[1] == ["no_tiles_remaining"] then
    .[1] = [{"name": "aside_tile_count", "opts": [4]}]
    |
    .[3] = []
  else . end
)
|
.functions.discard_passed += [
  ["when_everyone", [{"name": "status", "opts": ["match_start"]}, "not_has_aside"], [["pause", 1000], ["ryuukyoku"]]]
]
|
.play_restrictions = [
  [["any"], ["not_is_drawn_tile"]]
]
|
.yaku |= map(select(.display_name != "Round Wind"))
|
# remove all calls except for ron
.buttons |= del(.chii, .pon, .daiminkan, .kakan, .ankan, .riichi, .chankan, .tsumo)
|
.after_start.actions += [["set_status_all", "building"]]
|
.buttons += {
  "build": {
    "display_name": "Select 13 tiles to form a tenpai hand",
    "show_when": [{"name": "status", "opts": ["building"]}],
    "actions": [
      ["unset_status", "building"],
      ["mark", [["hand", 13, ["self"]]]],
      ["set_aside_marked_hand"],
      ["swap_hand_and_aside"],
      ["put_down_riichi_stick"],
      ["set_status", "match_start", "just_reached", "riichi", "ippatsu"]
    ],
    "unskippable": true,
    "cancellable": false
  },
  "discard": {
    "display_name": "Select a tile to discard",
    "show_when": ["our_turn", {"name": "status", "opts": ["match_start"]}, "not_has_draw", "not_just_discarded"],
    "actions": [
      ["mark", [["aside", 1, ["self"]]]],
      ["draw_marked_aside"],
      ["discard_draw"]
    ],
    "unskippable": true,
    "cancellable": false
  }
}
|
.buttons.ron.show_when |= map(if . == [{"name": "has_yaku_with_discard", "opts": [1]}, {"name": "has_yaku2_with_discard", "opts": [1]}] then
  [{"name": "has_yaku_with_discard", "opts": [3, 60]}, {"name": "has_yaku_with_discard", "opts": [4, 30]}, {"name": "has_yaku_with_discard", "opts": [5]}, {"name": "has_yaku2_with_discard", "opts": [1]}]
else . end)
|
.buttons.ron.show_when |= [{"name": "status", "opts": ["match_start"]}] + .
|
.auto_buttons["2_auto_ron"].enabled_at_start = true
|
.auto_buttons |= del(.["3_auto_no_call"])
|
.auto_buttons["4_auto_discard"].actions = [
  ["when", [{"name": "buttons_include", "opts": ["discard"]}], [["press_button", "discard"]]]
]
|
.auto_buttons["4_auto_discard"].enabled_at_start = true
|
.display_riichi_sticks = false
|
.display_round_marker = false
|
.display_wall = false
|
# this is just to make aside clickable
.four_rows_discards = true
|
# dora counts towards mangan
.score_calculation.extra_yaku_lists = []
