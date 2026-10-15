local _, ns = ...
local Engine = ns.Engine

function ns.PrintMessage(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff52c7b8MisspelledRetail:|r " .. text)
end

function ns.RegisterCommands()
	SLASH_MISSPELLEDRETAIL1, SLASH_MISSPELLEDRETAIL2 = "/mr", "/misspelledretail"
	SlashCmdList.MISSPELLEDRETAIL = function(message)
		local command, argument = message:match("^%s*(%S*)%s*(.-)%s*$")
		command = command:lower()
		if command == "on" or command == "off" then
			ns.SetOption("enabled", command == "on")
			ns.PrintMessage(command == "on" and "Spelling checks enabled." or "Spelling checks paused.")
		elseif command == "minimap" then
			ns.SetOption("showMinimap", not ns.db.showMinimap)
			ns.PrintMessage(ns.db.showMinimap and "Minimap button shown." or "Minimap button hidden. Use /mr for settings.")
		elseif command == "add" then
			local word = Engine.Normalize(argument)
			local count = 0
			for _ in pairs(ns.db.personalWords) do count = count + 1 end
			if ns.ValidPersonalWord(word) and count < 800 then
				ns.db.personalWords[word] = true; ns.OptionsChanged(); ns.PrintMessage("Learned " .. word .. ".")
			else ns.PrintMessage("Use /mr add <word> (2-28 Latin letters; accents allowed), or edit your personal list in /mr.") end
		elseif command == "help" then
			ns.PrintMessage("/mr settings â€¢ /mr on|off â€¢ /mr minimap â€¢ /mr add <word>. Click an colored word for corrections.")
		elseif command == "debug" then
			ns.Chat:PrintDebug()
		else ns.OpenSettings() end
	end
end
