local DISCORD_URL = GetModConfigData("DISCORD_URL")
local DISCORD_LABEL = GetModConfigData("DISCORD_LABEL")

Assets = {
	Asset("ATLAS", "images/btns.xml"),
	Asset("IMAGE", "images/btns.tex"),
}

local menv = env
GLOBAL.setfenv(1, GLOBAL)

if not TheNet:IsDedicated() then
	local ImageButton = require("widgets/imagebutton")
	menv.AddClassPostConstruct("widgets/controls", function(self)
		if not self.inv then
			return
		end
		
		self.discord = self.topleft_root:AddChild(ImageButton("images/btns.xml", "discord.tex"))
		self.discord:SetPosition(35, -35)
		self.discord.scale_on_focus = false
		
		self.discord:SetOnClick(function()
			VisitURL(DISCORD_URL)
		end)
		
		self.discord:SetTooltip(DISCORD_LABEL)
		self.discord:SetTooltipPos(0, -40, 0)
	end)
end