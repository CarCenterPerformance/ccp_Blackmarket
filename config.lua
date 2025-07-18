Config = {}

Config.RequiredLicense = "rebellen" -- Name der Lizenz

Config.Shop = {
    coords = vec3(4930.2754, -5295.7729, 5.6978),
    npcModel = "g_m_importexport_01",
    blip = {
        enabled = true,
        sprite = 310,
        color = 1,
        label = "Schwarzmarkt"
    }
}

Config.Items = {
    {
        label = "Lunch Box",
        item = "lunchbox",
        price = 150
    },
    {
        label = "Flex",
        item = "flex",
        price = 10000
    }
}

Config.Weapons = {
    {
        label = "50er",
        weapon = "weapon_pistol50",
        price = 45000
    },
    {
        label = "SMG",
        weapon = "weapon_assaultrifle",
        price = 95000
    },
        {
        label = "Precision Sniper",
        weapon = "weapon_precisionrifle",
        price = 195000
    }
}
