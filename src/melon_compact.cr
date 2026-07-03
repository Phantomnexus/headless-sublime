require "rosegold"

# Harvests a melon farm in two sides (west/east of a 4-wide center row), going
# south→north, breaking with an axe and switching tools as durability runs out.
# Periodically deposits melon in a chest and lights a stick-fired furnace.
# Adapted from arthirob's MelonCompact.js (v1.4).

SERVER_HOST   = ENV.fetch "SERVER_HOST", "play.civmc.net"
SPECTATE_HOST = ENV.fetch "SPECTATE_HOST", "0.0.0.0"
SPECTATE_PORT = ENV.fetch("SPECTATE_PORT", "25566").to_i

INITIAL_RETRY_DELAY = 5.seconds
MAX_RETRY_DELAY     = 5.minutes

X_EAST           =  8508
X_WEST           =  8249
Z_NORTH          = -2736
Z_SOUTH          = -2557
CENTER_ROW       =  8377
CENTER_ROW_WIDTH =     4
PLOT_HEIGHT      =     4 # Each plot covers 4 z-rows; cursor advances by this each iteration.

X_FRONT_COMPACTOR   =  8377
Z_FRONT_COMPACTOR   = -2644
X_CHEST_COMPACTOR   =  8379
Z_CHEST_COMPACTOR   = -2647
X_FURNACE_COMPACTOR =  8379
Z_FURNACE_COMPACTOR = -2645
Y_COMPACTOR         =   143

COMPACT_EVERY_PLOT = 6
LAG_TICKS          = 6
MAX_STUCK_RETRIES  = 20 # consecutive move_to stalls before abandoning a row

DISCORD_GROUP = "mtafarm"
FARM_NAME     = "Melon farm near Maius(gs melon farm)"
REGROW_HOURS  = 27

PITCH_VALUE       = 10.0_f32  # nominal harvesting pitch
PITCH_STUCK       = 28.0_f32  # steeper pitch to chew through a blocking melon
BREAK_TIME        =        2  # ticks per melon break (with haste II)
SPEED_REDRINK_GAP = 5.seconds # min time between speed-pot attempts