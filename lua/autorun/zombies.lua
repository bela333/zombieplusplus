CreateConVar("zpp_barnicle", 1, 0, "This will enable or disable existence of transformed barnicle zombies")
CreateConVar("zpp_headcrab", 1, 0, "This will enable or disable existence of transformed headcrab zombies")
CreateConVar("zpp_zombie", 1, 0, "This will enable or disable existence of transformed zombies")

bonemerge = false

function GenMenu(Panel)
	Panel:ClearControls()
	local barnicle = vgui.Create("DCheckBoxLabel")
	barnicle:SetPos(10,30)
	barnicle:SetParent(Panel)
	barnicle:SetText("Barnicle zombies")
	barnicle:SetConVar("zpp_barnicle")
	barnicle:SetValue(0)
	barnicle:SizeToContents()
	local headcrab = vgui.Create("DCheckBoxLabel")
	headcrab:SetPos(10,50)
	headcrab:SetParent(Panel)
	headcrab:SetText("Headcrag zombies")
	headcrab:SetConVar("zpp_headcrab")
	headcrab:SetValue(0)
	headcrab:SizeToContents()
	local zombie = vgui.Create("DCheckBoxLabel")
	zombie:SetPos(10,70)
	zombie:SetParent(Panel)
	zombie:SetText("zombies")
	zombie:SetConVar("zpp_zombie")
	zombie:SetValue(0)
	zombie:SizeToContents()
end

function CreateMenu()
	spawnmenu.AddToolMenuOption("Options", "Admin", "zombieplusplusmenu", "Zombie++", "", "", GenMenu)
end
function makeMeAZombie(Killer, Victim)
	addons = engine.GetAddons()
	
	
	table.foreach( addons, function(key, value)
	
	if(value["wsid"] == "170917418") then
		bonemerge = value["mounted"]
	end
	
	end)
	
	
	
	
	local class = Killer:GetClass()
	if (class=="npc_zombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_poisonzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_barnacle" && GetConVarNumber( "zpp_barnicle" ) == 1 || class=="npc_headcrab" && GetConVarNumber( "zpp_headcrab" ) == 1|| class=="npc_headcrab_fast" && GetConVarNumber( "zpp_headcrab" ) == 1 || class=="npc_zombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 ) then
		if (!SERVER) then return end
		local zombietype = ""
		if class == "npc_zombie" then
			zombietype = "npc_zombie"
		elseif class == "npc_fastzombie" then
			zombietype = "npc_fastzombie"
		elseif class == "npc_poisonzombie" then
			zombietype = "npc_poisonzombie"
		elseif class == "npc_barnacle" then
			zombietype = "npc_zombie"
			Killer:Remove()
		elseif class == "npc_headcrab" then
			zombietype = "npc_zombie"
			Killer:Remove()
		elseif class == "npc_headcrab_fast" then
			zombietype = "npc_fastzombie"
			Killer:Remove()
		elseif class == "npc_zombie_torso" then
			zombietype = "npc_zombie"
		elseif class == "npc_fastzombie_torso" then
		zombietype = "npc_fastzombie"
		end
		local npc = ents.Create(zombietype) -- create the entity
		local model = ents.Create("prop_ragdoll")
		model:SetModel(Victim:GetModel())
		npc:Spawn()
		npc:Activate()
		model:Spawn()
		model:Activate()
		
		npc:SetPos(Victim:GetPos()) -- position
		npc:SetAngles(Angle(0,Victim:GetAngles().y,0))
		if(bonemerge) then
		rb655_ApplyBonemerge( model, npc )
		
		npc:SetColor(Color(255, 255, 255, 0))
		
		npc:SetRenderMode( 4 )
		npc.IsAMyZombie = true
		npc.MyModelIs = model:GetModel()
		else
		model:Remove()
		end

		
		if Victim:IsPlayer() then return end
			Victim:Remove()
end
end
local ZombieingNpcs = {
		"npc_mossman",
		"npc_monk",
		"npc_metropolice",
		"npc_kleiner",
		"npc_gman",
		"npc_eli",
		"npc_combine_s",
		"npc_citizen",
		"npc_breen",
		"npc_barney",
		"npc_alyx",
		"npc_vj_bmsfri_scientistfm",
		"npc_vj_bmsfri_scientist",
		"npc_fassassin",

}


function npcZombify(victim, dmginfo)

		killer = dmginfo:GetInflictor()
		class = killer:GetClass()
		if(victim:GetClass() == "player") then
			if (class=="npc_zombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_poisonzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_barnacle" && GetConVarNumber( "zpp_barnicle" ) == 1 || class=="npc_headcrab" && GetConVarNumber( "zpp_headcrab" ) == 1|| class=="npc_headcrab_fast" && GetConVarNumber( "zpp_headcrab" ) == 1 || class=="npc_zombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 ) then
				makeMeAZombie(killer, victim)
				victim:Kill()
			end
		else

	if !table.HasValue(ZombieingNpcs, victim:GetClass()) then return end
	if !killer:IsNPC() then return end
	makeMeAZombie(killer, victim)
	end
	
end


hook.Add("EntityTakeDamage", "onDamage", npcZombify)
hook.Add( "PopulateToolMenu", "Zombieplusplusmenu", CreateMenu )
