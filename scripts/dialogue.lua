if not Dialogue then
	Dialogue=class({})

	--DebugPrint('** Alustetaan Dialogue ***')
	CustomGameEventManager:RegisterListener("dialog_closed", Dynamic_Wrap(Dialogue, "Close"))
end

queue = {}
in_use = 0

-- Muuta palauttamaan array
function Dialogue:GetConversationPartner(hero)
	-- Ei tue kuin yhtä keskustelukumppania
	local partner = Entities:FindInSphere(nil, hero:GetAbsOrigin(), 1000)
	
	while partner do
	
		if partner:HasAttribute("partner") then
			return partner
		end

		partner = Entities:FindInSphere(partner, hero:GetAbsOrigin(), 1000)
	end

	if not partner then
		Warning("Oh no. No conversation partner found.")
	end
end

function Dialogue:Start(hero, arg)

	if in_use > 0 then
		return
	end

	in_use = 1
	queue = arg
		
	--hero:Stop()

	--local suunta = partner:GetAbsOrigin():__sub(hero:GetAbsOrigin())
	--suunta = suunta:Normalized()
	--hero:Interrupt()

	-- Ainakin kääntyy oikeaan suuntaan -_-
	--hero:SetForwardVector(suunta)

	hero:MoveToPosition(queue[1].speaker:GetAbsOrigin())

	Timers:CreateTimer(.03, function()
			hero:Stop()
		
	end)

	Dialogue:SendBox(queue)

end

function Dialogue:SendBox(queue)

	--local player = hero:GetPlayerOwner()

	local dialoginfo = {
		heroname = queue[1].speaker:GetUnitName()
	}

	queue[1].speaker = queue[1].speaker:GetEntityIndex()
	
	CustomUI:DynamicHud_Create(-1, "dialog", "file://{resources}/layout/custom_game/dialogue.xml", dialoginfo)
	CustomGameEventManager:Send_ServerToAllClients( "dialog_pass_info", queue[1] )
end


function Dialogue:Close( eventSourceIndex, args )
	--print( "My event: ( " .. eventSourceIndex .. ", " .. args['key2'] .. " )" )
	
	if in_use < table.getn(queue) then
		
		in_use = in_use + 1

		-- typerä workaround
		CustomUI:DynamicHud_SetDialogVariables(-1, "dialog", {heroname = queue[in_use].speaker:GetUnitName()})
		queue[in_use].speaker = queue[in_use].speaker:GetEntityIndex()
	    CustomGameEventManager:Send_ServerToAllClients( "dialog_pass_info", queue[in_use] )
	    
	else
		in_use = 0
		CustomGameEventManager:Send_ServerToAllClients("dialog_close", {})
		--CustomUI:DynamicHud_Destroy(-1, "dialog")
	end
end

return Dialogue