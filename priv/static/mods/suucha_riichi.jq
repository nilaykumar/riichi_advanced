.before_turn_change.actions = [
  ["when", [{"name": "num_players", "opts": [4]}, {"name": "everyone_status", "opts": ["riichi"]}], [
    ["subtract_score", "riichi_value"],
    ["put_down_riichi_stick"],
    ["unset_status", "just_reached"],
    ["pause", 1000],
    ["abortive_draw", "Suucha Riichi"]
  ]]
] + .before_turn_change.actions
