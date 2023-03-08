local f
local g
local h

local function YdybDPSCommands()
	if isYgzAuto then
		h:Show();	
	else 
		h:Hide();
	end
	if UnitCanAttack("player","target") then
		--Init data
		local ydyb = {};
		--utils
		ydyb.now = GetTime();
		ydyb.cd_gcd=mwGetCoolDown("野性印记"); --gcd
		--Spec
		--ydyb.currentSpec = GetSpecialization();
		--ydyb.currentSpecName = ydyb.currentSpec and select(2, GetSpecializationInfo(ydyb.currentSpec)) or "None";
		--target
		ydyb.tHealth = UnitHealth("target");
		ydyb.tMaxHealth = UnitHealthMax("target");
		ydyb.tPerHealth = ceil(100 * ydyb.tHealth / ydyb.tMaxHealth);
		--target inRange count
		ydyb.inRange = 0
		--player
		ydyb.focus=UnitPower("player");
		ydyb.pHealth = UnitHealth("player");
		ydyb.pMaxHealth = UnitHealthMax("player");
		ydyb.pPerHealth = ceil(100 * ydyb.pHealth / ydyb.pMaxHealth);
		local talent = select(9,GetTalentInfo(2,3))
		--play
		if talent <=0 then
			ydybBalancePlay(ydyb,f,g);
        else
		    ydybFeralPlay(ydyb,f,g);
		end

		
	end
end


local function ScwDPSCommands()
	if isYgzAuto then
		h:Show();
	else
		h:Hide();
	end
	if UnitCanAttack("player","target") then
		--Init data
		local scw = {};
		--utils
		scw.now = GetTime();
		scw.cd_gcd=mwGetCoolDown("野性印记"); --gcd
		--Spec
		--scw.currentSpec = GetSpecialization();
		--scw.currentSpecName = scw.currentSpec and select(2, GetSpecializationInfo(scw.currentSpec)) or "None";
		--target
		scw.tHealth = UnitHealth("target");
		scw.tMaxHealth = UnitHealthMax("target");
		scw.tPerHealth = ceil(100 * scw.tHealth / scw.tMaxHealth);
		--target inRange count
		scw.inRange = 0
		--player
		scw.focus=UnitPower("player");
		scw.pHealth = UnitHealth("player");
		scw.pMaxHealth = UnitHealthMax("player");
		scw.pPerHealth = ceil(100 * scw.pHealth / scw.pMaxHealth);
		local talent = select(9,GetTalentInfo(2,3))
		--play
		if talent <=0 then
			scwArmsPlay(scw,f,g);
		else
			scwFuryPlay(scw,f,g);
		end


	end
end

local function p940DPSCommands()
	--if isYgzAuto then
	--	h:Show();
	--else
		h:Hide();
	--end
	if UnitCanAttack("player","target") then
		--Init data
		local p940 = {};
		--utils
		p940.now = GetTime();
		p940.cd_gcd=mwGetCoolDown("凋零缠绕"); --gcd
		--Spec
		--p940.currentSpec = GetSpecialization();
		--p940.currentSpecName = p940.currentSpec and select(2, GetSpecializationInfo(p940.currentSpec)) or "None";
		--target
		p940.tHealth = UnitHealth("target");
		p940.tMaxHealth = UnitHealthMax("target");
		p940.tPerHealth = ceil(100 * p940.tHealth / p940.tMaxHealth);
		--target inRange count
		p940.inRange = 0
		--player
		p940.energy=UnitPower("player");
		p940.pHealth = UnitHealth("player");
		p940.pMaxHealth = UnitHealthMax("player");
		p940.pPerHealth = ceil(100 * p940.pHealth / p940.pMaxHealth);
		local talent = select(9,GetTalentInfo(2,29)) --萨萨里安的威胁
		--play
		if talent>0 then
			p940FrostPlay(p940,f,g);
			--p940FrostPlayHDR(p940,f,g);
		else
			p940BloodPlay(p940,f,g);
			--p940BloodPlayHDR(p940,f,g);
		end



	end
end

do

	local playerName, realm = UnitName("player")

	f = CreateFrame("Frame",nil,UIParent)
	f:SetFrameStrata("BACKGROUND")
	f:SetWidth(40) -- Set these to whatever height/width is needed 
	f:SetHeight(40) -- for your Texture
	f:SetPoint("CENTER",-730,380)
	--f:SetPoint("CENTER",-100,100)

	--f:EnableKeyboard(true)
	--f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	if playerName == "野德一逼" or playerName == "野德威" then
		f:SetScript("OnUpdate", function()
			YdybDPSCommands()
		end)
	elseif playerName == "酥粗威" then
		f:SetScript("OnUpdate", function()
			ScwDPSCommands()
		end)
	elseif playerName == "玩家九四零" or playerName == "迪凯威" or playerName == "迪凯威威" then
		f:SetScript("OnUpdate", function()
			p940DPSCommands()
		end)
	end

	f.textures = {}
	local tex = f:CreateTexture()
	f.textures[0]=tex
	tex:SetAllPoints(f)
	tex:SetColorTexture(0.8, 1, 0.8)
	f:Show()


	g = CreateFrame("Frame",nil,UIParent)
	g:SetFrameStrata("BACKGROUND")
	g:SetWidth(40) -- Set these to whatever height/width is needed 
	g:SetHeight(40) -- for your Texture
	g:SetPoint("CENTER",-580,330)
	g.textures = {}


	local tex = g:CreateTexture()
	g.textures[0]=tex
	tex:SetAllPoints(g)
	tex:SetColorTexture(0.5, 0.5, 0.5)
	g:Show()


	
	h = CreateFrame("Frame",nil,UIParent)
	h:SetFrameStrata("BACKGROUND")
	h:SetWidth(60) -- Set these to whatever height/width is needed 
	h:SetHeight(60) -- for your Texture
	h:SetPoint("CENTER",-250,100)
	h.textures = {}
	local tex = h:CreateTexture()
	h.textures[0]=tex
	tex:SetAllPoints(h)
	tex:SetColorTexture(0.2, 0.2, 0.2)
	h:Show()
	h:Hide()

end

SLASH_DDW1 = '/dstd'

SlashCmdList["DSTD"] = YdybDPSCommands