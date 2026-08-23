local offset_in = 3
local offset_out = 6
local border_radius = 12

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1.0 })
hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "auto", scale = 1.0 })
hl.monitor({ output = "eDP-2", mode = "1920x1080@144", position = "auto", scale = 1.0 })

local terminal = "alacritty"
local file_manager = "thunar"
local shell = "zsh"
local menu = shell .. " -c 'flock -n /tmp/wofi.lock wofi --show drun'"
local exit = shell .. " -c 'command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'"

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.config({
    general = {
        layout = "dwindle",
        gaps_in = offset_in,
        gaps_out = offset_out,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        rounding = border_radius,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
        },
        blur = {
            enabled = true,
            size = 1,
            passes = 5,
            vibrancy = 0.17,
            noise = 0.05,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },

    input = {
        kb_options = "grp:win_space_toggle",
        kb_layout = "us, ru",
        follow_mouse = 1,
        sensitivity = 0,
        repeat_delay = 250,
        repeat_rate = 50,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
        },
    },

    ecosystem = {
        no_update_news = true,
    },
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "wofi" }, blur = true, ignore_alpha = 0.2 })
hl.layer_rule({ match = { namespace = "selection" }, blur = true, ignore_alpha = 0.2 })

hl.curve("ease-in-out", { type = "bezier", points = { { 0.8, 0 }, { 0.2, 1 } } })
hl.curve("ease-in-out-overshoot", { type = "bezier", points = { { 0.8, 0 }, { 0.2, 1.1 } } })
hl.curve("ease-out", { type = "bezier", points = { { 0.6, 0.5 }, { 0.2, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "ease-in-out" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "ease-in-out" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.5, bezier = "ease-out" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "ease-out" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "ease-in-out-overshoot" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "ease-out", style = "popin 95%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "ease-out", style = "popin 95%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "ease-out", style = "slidefade 1%" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "ease-out", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "ease-out", style = "fade" })

local main_mod = "SUPER"

hl.gesture({ fingers = 3, direction = "swipe", mods = "ALT SHIFT", action = "resize" })
hl.gesture({ fingers = 3, direction = "swipe", mods = main_mod .. " SHIFT", action = "move" })
hl.gesture({ fingers = 4, direction = "down", mods = main_mod .. " SHIFT", action = "close" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up", action = function() hl.dispatch(hl.dsp.exec_cmd(menu)) end })

hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd("hyprctl switchxkblayout next"))
hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd(exit))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd(shell .. " -c \"$HOME/.config/hypr/screenshot.sh\""))

hl.bind(main_mod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.window.float({ action = "toggle" }))

for _, direction in ipairs({
    { key = "left", value = "left" },
    { key = "right", value = "right" },
    { key = "up", value = "up" },
    { key = "down", value = "down" },
    { key = "A", value = "left" },
    { key = "D", value = "right" },
    { key = "W", value = "up" },
    { key = "S", value = "down" },
}) do
    hl.bind(main_mod .. " + SHIFT + " .. direction.key, hl.dsp.window.move({ direction = direction.value }), { repeating = true })
    hl.bind(main_mod .. " + " .. direction.key, hl.dsp.focus({ direction = direction.value }), { repeating = true })
end

for _, resize in ipairs({
    { key = "left", x = -30, y = 0 },
    { key = "right", x = 30, y = 0 },
    { key = "up", x = 0, y = -30 },
    { key = "down", x = 0, y = 30 },
    { key = "A", x = -30, y = 0 },
    { key = "D", x = 30, y = 0 },
    { key = "W", x = 0, y = -30 },
    { key = "S", x = 0, y = 30 },
}) do
    hl.bind("ALT + SHIFT + " .. resize.key, hl.dsp.window.resize({ x = resize.x, y = resize.y, relative = true }), { repeating = true })
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "empty-floating-xwayland-no-focus",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "file-chooser-portal",
    match = {
        class = "^(xdg-desktop-portal-gtk|[Xx]dg-desktop-portal-gtk|org\\.freedesktop\\.impl\\.portal\\.desktop\\.gtk|org\\.freedesktop\\.impl\\.portal\\.desktop\\.hyprland)$",
    },
    float = true,
    center = true,
    size = "50% 50%",
    no_initial_focus = true,
})

hl.window_rule({
    name = "file-chooser-firefox",
    match = {
        class = "^(Firefox|firefox)$",
        initial_title = "^(Save|Save As|Open|Open File|Choose a file|Browse)$",
    },
    float = true,
    center = true,
    size = "55% 55%",
    no_initial_focus = true,
})
