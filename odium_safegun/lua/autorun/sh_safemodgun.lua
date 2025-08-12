hook.Add("InitPostEntity", "ODIUM::safemod", function()
	weapons.GetStored("wf_wpn_base").AddSafeMode = true

	local glFix = {
		["wf_wpn_ar27_bp05"] = 4,
		["wf_wpn_ar04_xmas02"] = 4,
		["wf_wpn_ar04_afro01"] = 4,
		["wf_wpn_ar02_camo02"] = 4,
		["wf_wpn_ar27_rad01"] = 4,
		["wf_wpn_ar27_ice01"] = 4,
		["wf_wpn_ar27_camo09"] = 4,
		["wf_wpn_ar27_camo08"] = 4,
		["wf_wpn_ar04_camo05"] = 4,
		["wf_wpn_ar04"] = 4,
		["wf_wpn_ar02_camo07"] = 4,
		["wf_wpn_ar02"] = 4,
		["wf_wpn_ar27"] = 4,
		["wf_wpn_ar27_set10"] = 4,
		["wf_wpn_ar02_eua01"] = 4,

		["wf_wpn_ar27_gold01"] = 3,

		["wf_wpn_ar31_xmas04"] = 2,
		["wf_wpn_ar31_set12"] = 2,
		["wf_wpn_ar31"] = 2
	}

	for k, v in pairs(glFix) do
		table.remove(weapons.GetStored(k).Attachments[3].atts, v)
	end

	if not SERVER then return end
	CustomizableWeaponry.enableWeaponDrops = false
	CustomizableWeaponry.canDropWeapon = false

	hook.Add("zvm_OnPackageItemSpawned", "removeCWammoBoxes", function(ply, ent)
		if ent:GetClass() ~= "cw_ammo_kit_regular" then return end

		timer.Simple(40, function()
			if not IsValid(ent) then return end
			ent:Remove()
		end)
	end)
end)