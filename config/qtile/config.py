from libqtile import bar, layout, qtile
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration


mod = "mod4"
terminal = "kitty"


keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),

    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+")),
    Key([], "XF86AudioMute", lazy.spawn(
        "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Tab",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(
        "kitty nvim ."), desc="Launch file manager"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("dmenu_run"),
        desc="Spawn a command using a prompt widget"),
    KeyChord([mod], "d", [
        Key([], "p", lazy.spawn("/home/novus/nixos-dotfiles/config/dmenu/scripts/project-select.sh"),
            desc="Launch project-select"),
        Key([], "t", lazy.spawn("/home/novus/nixos-dotfiles/config/dmenu/scripts/tax-year.sh"),
            desc="Launch tax sheet selector"),
    ]),
]


for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(
                func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )


layouts = [
    layout.Columns(
        border_focus="#89b4fa",
        border_normal="#1e1e2e",
        border_width=2,
        margin=8,
        margin_on_single=8,
    ),
    layout.Max(
        margin=8,
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


widget_defaults = dict(
    font="DepartureMono Nerd Font Mono",
    foreground="#cdd6f4",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

powerlineSlashF = {
    "decorations": [
        PowerLineDecoration(
            path='forward_slash',
        )
    ]
}

powerlineRoundR = {
    "decorations": [
        PowerLineDecoration(
            path='rounded_right',
        )
    ]
}

powerlineRoundL = {
    "decorations": [
        PowerLineDecoration(
            path='rounded_left',
        )
    ]
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method='block',
                    active="#cdd6f4",
                    inactive="#7f849c",
                    this_current_screen_border="#45475a",
                    rounded=False,
                    background="#1e1e2e",
                    ** powerlineRoundL
                ),
                widget.WindowName(
                    padding=8,
                    **powerlineRoundR
                ),
                widget.StatusNotifier(
                    icon_theme=None,
                ),
                widget.Memory(
                    format='RAM {MemPercent}%',
                    background="#1e1e2e",
                    **powerlineSlashF
                ),
                widget.CPU(
                    format='CPU {load_percent}%',
                    background="#313244",
                    **powerlineSlashF
                ),
                widget.PulseVolume(
                    background="#45475a",
                    fmt="Vol: {}",
                    mute_format="X",
                    step=5,
                    **powerlineSlashF
                ),
                widget.Clock(
                    format="%a %H:%M",
                    padding=8,
                    background="#585b70",
                ),
            ],
            margin=8,
            size=28,
            background="#181825",
        ),
        background="#181825",
        wallpaper="~/Pictures/Wallpapers/Wallpaper-Static_002.png",
        wallpaper_mode="center",
    ),
]


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = True
reconfigure_screens = True


auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
