local SETTING_SECTION = "Global"

CONVAR_FLAGS = {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY}

TARDIS:AddSetting({
    id="health-enabled",
    type="bool",
    value=true,

    class="global",
    convar = {
        name = "tardis2_damage",
        flags = CONVAR_FLAGS,
        desc = "TARDIS - Damage enabled (1 enables, 0 disables)",
    },

    option = true,
    section=SETTING_SECTION,
    name="EnableHealth",
})

TARDIS:AddSetting({
    id="health-max",
    type="integer",
    value=1000,
    min=1,
    max=10000,
    round_func = function(x)
        if x < 50 then return x end
        if x < 500 then return (x - x % 10) end
        if x < 2000 then return (x - x % 100) end
        return (x - x % 500)
    end,

    class="global",
    convar = {
        name = "tardis2_maxhealth",
        flags = CONVAR_FLAGS,
        desc = "TARDIS - Maximum health",
    },

    option = true,
    section=SETTING_SECTION,
    name="MaxHealth",
})


TARDIS:AddSetting({
    id="boost-speed",
    type="number",
    value=2.5,
    min=1.0,
    max=8.0,
    round_func = function(x)
        return (x - x % 0.5)
    end,

    class="global",
    convar = {
        name = "tardis2_boost_speed",
        flags = CONVAR_FLAGS,
        desc = "TARDIS - Boost Speed",
    },

    option = true,
    section=SETTING_SECTION,
    name="BoostSpeed",
})