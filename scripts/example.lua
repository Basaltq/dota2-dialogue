
require('dialogue')

function OnStartTouch(args)
	
	hero = args.activator
	partner = Dialogue:GetConversationPartner(hero)

	-- Sounds can be found https://github.com/SteamDatabase/GameTracking-Dota2/tree/master/game/dota/pak01_dir/soundevents/voscripts
	queue = {
		{
			message = "Hei ystävä. Miten sinulla menee? Minulla olisi tässä kaurapuuroa tarjolla jos maistuu. Olen jo syönyt mahani täyteen, joten loppu on sinulle.",
			sound = "lina_lina_happy_02",
			speaker = partner
		},
		{
			message ="No jopa nyt onni potkaisi. Kyllä kiitos, kelpaa puuro! Höhhöö!",
			sound = "kunkka_kunk_happy_01",
			speaker = hero
		},
		{
			message = "Mukavaa nähdä sinut noin iloisena.",
			sound = "lina_lina_spawn_01",
			speaker = partner
		}
	}
	
	Dialogue:Start(hero, queue)

end

function OnEndTouch(args)

	--print ("Kosketus loppuu")
	local trigger = args.caller
end
