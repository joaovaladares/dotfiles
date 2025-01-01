-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

------------------------
--        Font        --
------------------------
config.font = wezterm.font_with_fallback{
    'IosevkaTerm Nerd Font',
}
config.font_size = 14

-----------------------
-- 	Style        --
-----------------------
config.color_scheme = 'Django'
config.enable_scroll_bar = true

-----------------------
-- 	Tab Bar      --
-----------------------
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false 
config.tab_bar_at_bottom = true
config.colors = {
    tab_bar = {
        background = '00000000',
        active_tab = { bg_color = '00000000', fg_color = 'ccc' },
        inactive_tab = { bg_color = '00000000', fg_color = '666' },
        new_tab = { bg_color = '00000000', fg_color = 'fff' },
    },
}

-------------------------------
--        Keybindings        --
-------------------------------
config.keys = {
    --------------------------------
    --        Tabs & Panes        --
    --------------------------------
    { key = '-', mods = 'CTRL',       action = act.DisableDefaultAssignment },
    { key = '<', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(-1) },
    { key = '>', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(1) },
    {
        mods = 'CTRL',
        key = 'Enter',
        action = act.SplitPane {
            direction = 'Right',
            size = { Cells = 90 }
        },
    },
    {
        mods = 'CTRL|ALT',
        key = 'Enter',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    { mods = 'CTRL|SHIFT', key = 'h', action = act.ActivatePaneDirection 'Left' },
    { mods = 'CTRL|SHIFT', key = 'l', action = act.ActivatePaneDirection 'Right' },
    { mods = 'CTRL|SHIFT', key = 'k', action = act.ActivatePaneDirection 'Up' },
    { mods = 'CTRL|SHIFT', key = 'j', action = act.ActivatePaneDirection 'Down' },
    { mods = 'LEADER', key = 'n', action = act.PaneSelect { alphabet = 'neioarst' } },
    {
        mods = 'CTRL',
        key = '\\',
        action =
            act.Multiple {
                act.ActivatePaneDirection 'Left',
                act.TogglePaneZoomState,
                act.ActivatePaneDirection 'Right',
            }
    },
    { mods = 'CTRL|SHIFT', key = '|',    action = act.TogglePaneZoomState },
    { mods = 'CTRL|SHIFT', key = 'q',    action = act.CloseCurrentPane { confirm = true }},
}

max_fps = 120

for i = 1, 8 do
    -- ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'ALT',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- and finally, return the configuration to wezterm
return config

