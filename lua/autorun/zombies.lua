CreateConVar("zpp_player", 1, 128, "Players can transfrom to zombie...")
CreateConVar("zpp_barnicle", 1, 128, "This will enable or disable existence of transformed barnicle zombies")
CreateConVar("zpp_headcrab", 1, 128, "This will enable or disable existence of transformed headcrab zombies")
CreateConVar("zpp_zombie", 1, 128, "This will enable or disable existence of transformed zombies")
CreateConVar("zpp_heal", 0, 128, "This will enable or disable the healing of zombies, on transforming an npc or player")
CreateConVar("zpp_head", 1, 128, "Spawn zombies with headcrab")
CreateConVar("zpp_forcehead", 0, 128, "Spawn transformed zombies with headcrab too")

local bonemerge = false



function UltimateZombieMaker(class, Killer, Victim)
		HaveHeadcrab = 1
		local NullVector = Vector(-0.5,-0.5,-0.5)
		
			if (!SERVER) then return end
		local zombietype = ""
		if class == "npc_zombie" then
			zombietype = "npc_zombie"			
			HaveHeadcrab = 0
		elseif class == "npc_fastzombie" then
			zombietype = "npc_fastzombie"			
			HaveHeadcrab = 0
		elseif class == "npc_poisonzombie" then
			zombietype = "npc_poisonzombie"			
			HaveHeadcrab = 0
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
			HaveHeadcrab = 0
		elseif class == "npc_fastzombie_torso" then
			zombietype = "npc_fastzombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/Zombie/fast.mdl" then
			zombietype = "npc_fastzombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/Zombie/Classic.mdl" then
			zombietype = "npc_zombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/zombie/fast_torso.mdl" then
			zombietype = "npc_fastzombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/Zombie/classic_torso.mdl" then
			zombietype = "npc_zombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/Zombie/Poison.mdl" then
			zombietype = "npc_poisonzombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/birdbrainswagtrain/zombie/fast_frame.mdl" then
			zombietype = "npc_fastzombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/birdbrainswagtrain/zombie/classic_frame.mdl" then
			zombietype = "npc_zombie"			
			HaveHeadcrab = 0
		elseif Killer:GetViewEntity().formTable.model == "models/birdbrainswagtrain/zombie/poison_frame.mdl" then
			zombietype = "npc_poisonzombie"			
			HaveHeadcrab = 0
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
		if (GetConVarNumber( "zpp_heal" ) == 1)then
		Killer:SetHealth(Killer:Health() + 10)
		end
		if(bonemerge) then
		
		if(GetConVarNumber( "zpp_head" ) == 1 && HaveHeadcrab == 1 || GetConVarNumber("zpp_forcehead") == 1) then
		bone = model:LookupBone( "ValveBiped.Bip01_Head1" )
		Bonemerged = rb655_ApplyBonemerge( model, npc )
		Bonemerged:ManipulateBoneScale(bone, NullVector)
		npc:SetSubMaterial(0,"Models/effects/vol_light001")
		else
		Bonemerged = rb655_ApplyBonemerge( model, npc )
		npc:SetColor(Color(0,0,0,0))
		npc:SetRenderMode( RENDERMODE_TRANSALPHA )
		end
		
		else
		model:Remove()
		
		
		
		end

		
		if Victim:IsPlayer() then return end
			Victim:Remove()
end

function GenMenu(Panel)
	Panel:ClearControls()
	local barnicle = vgui.Create("DCheckBoxLabel")
	barnicle:SetPos(10,30)
	barnicle:SetParent(Panel)
	barnicle:SetText("Transforming by barnicles.")
	barnicle:SetConVar("zpp_barnicle")
	barnicle:SetValue(0)
	barnicle:SizeToContents()
	local headcrab = vgui.Create("DCheckBoxLabel")
	headcrab:SetPos(10,50)
	headcrab:SetParent(Panel)
	headcrab:SetText("Transforming by headcrabs.")
	headcrab:SetConVar("zpp_headcrab")
	headcrab:SetValue(0)
	headcrab:SizeToContents()
	local zombie = vgui.Create("DCheckBoxLabel")
	zombie:SetPos(10,70)
	zombie:SetParent(Panel)
	zombie:SetText("Transforming by zombies.")
	zombie:SetConVar("zpp_zombie")
	zombie:SetValue(0)
	zombie:SizeToContents()
	local heal = vgui.Create("DCheckBoxLabel")
	heal:SetPos(10,150)
	heal:SetParent(Panel)
	heal:SetText("Healing of zombies, on transforming an npc or player...")
	heal:SetConVar("zpp_heal")
	heal:SetValue(0)
	heal:SizeToContents()
	local Head = vgui.Create("DCheckBoxLabel")
	Head:SetPos(10,90)
	Head:SetParent(Panel)
	Head:SetText("Spawn zombies with headcrab")
	Head:SetConVar("zpp_head")
	Head:SetValue(0)
	Head:SizeToContents()
	local forcehead = vgui.Create("DCheckBoxLabel")
	forcehead:SetPos(10,130)
	forcehead:SetParent(Panel)
	forcehead:SetText("Spawn transformed zombies with headcrab too")
	forcehead:SetConVar("zpp_forcehead")
	forcehead:SetValue(0)
	forcehead:SizeToContents()
	local PlayerMenu = vgui.Create("DCheckBoxLabel")
	PlayerMenu:SetPos(10,110)
	PlayerMenu:SetParent(Panel)
	PlayerMenu:SetText("Players can transfrom to zombie...")
	PlayerMenu:SetConVar("zpp_player")
	PlayerMenu:SetValue(0)
	PlayerMenu:SizeToContents()
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
	if(value["wsid"] == "106427033") then
		pills = value["mounted"]
	end
	
	end)
	
	
	

	local class = Killer:GetClass()
			if (ShouldZombify(class)) then
		
	UltimateZombieMaker(class, Killer, Victim)

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

function ShouldZombify(class)
	return (class=="npc_zombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_poisonzombie" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_barnacle" && GetConVarNumber( "zpp_barnicle" ) == 1 || class=="npc_headcrab" && GetConVarNumber( "zpp_headcrab" ) == 1|| class=="npc_headcrab_fast" && GetConVarNumber( "zpp_headcrab" ) == 1 || class=="npc_zombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 || class=="npc_fastzombie_torso" && GetConVarNumber( "zpp_zombie" ) == 1 );
end


function npcZombify(victim, dmginfo)

		killer = dmginfo:GetInflictor()
		class = killer:GetClass()
		if(victim:GetClass() == "player" && GetConVarNumber( "zpp_player" ) == 1) then
			if (ShouldZombify(class)) then
				makeMeAZombie(killer, victim)
				victim:Kill()
			end
		else

	if !table.HasValue(ZombieingNpcs, victim:GetClass()) then return end
	makeMeAZombie(killer, victim)
	end
	
end


hook.Add("EntityTakeDamage", "ZombiePlusPlusZombify", npcZombify)
hook.Add( "PopulateToolMenu", "ZombiePlusPlusMenu", CreateMenu )
