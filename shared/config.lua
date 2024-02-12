Config = {}

Config.Ped = {
    model = 'a_m_y_genstreet_01', -- The ped model for selling (https://docs.fivem.net/docs/game-references/ped-models/)
    coords = vec4(412.0504, 315.1076, 102.1343, 207.2065), -- The location at which the ped will spawn
}

Config.Blip = {
    ['Pawnshop'] = {
        Coords = vector3(412.0504, 315.1076, 102.1343),
        Sprite = 207,
        Color = 5,
        Size = 1.0,
    },
}

Config.sellableitems = {
    goldbar = { -- The item name itself
        label = 'Gold Bar',
        sellable = true,
        price = 50
    },
}
