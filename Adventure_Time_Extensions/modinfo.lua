name =						"[DST] Adventure Time Extensions"
version = 					"0.0.4"
description =				"Version: "..version
author =					"xTray"

forumthread = 				""

dont_starve_compatible 		= false
reign_of_giants_compatible	= false
dst_compatible 				= true
priority 					= -10000.2578
api_version 				= 10

all_clients_require_mod 	= true
client_only_mod 			= false

configuration_options = {
	{
		name = "DISCORD_URL",
		default = "https://discord.gg/xv7NEy7hTU"
	},
	{
		name = "DISCORD_LABEL",
		default = "Discord Сервер"
	},
	{
		name = "FINDER_ACTIVE",
		label = "Finder active",
		hover = "Do you want to enable or disable highlighting?\nThis way also clients can disable highlighting if they want to.",
		options =	{
						{description = "Disabled", data = false}, -- to allow clients to disable highlighting
                        {description = "Enabled", data = true},
					},
		default = true,
	},
}