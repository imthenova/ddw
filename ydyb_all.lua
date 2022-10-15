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
	
	if playerName == "野德一逼" then
		f:SetScript("OnUpdate", function()
			YdybDPSCommands()
		end)
	end

	f.textures = {}
	local tex = f:CreateTexture()
	f.textures[0]=tex
	tex:SetAllPoints(f)
	tex:SetColorTexture(0.5, 0.5, 0.5)
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
	tex:SetColorTexture(0.6, 0.6, 0.6)
	h:Show()

end

SLASH_DDW1 = '/dstd'

SlashCmdList["DSTD"] = YdybDPSCommands