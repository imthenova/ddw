local f
local g
local h
local function MyDPSCommands()
	if isYgzAuto then
		h:Show();	
	else 
		h:Hide();
	end
	local isAuto = false;
	if UnitCanAttack("player","target") then

		--Init data
		local dstd = {};
		--Spec
		dstd.currentSpec = GetSpecialization();
		dstd.currentSpecName = dstd.currentSpec and select(2, GetSpecializationInfo(dstd.currentSpec)) or "None";
		--utils
		dstd.now = GetTime();
		dstd.cd_gcd=mwGetCoolDown("旋风斩"); --GCD 
		--target
		dstd.tHealth = UnitHealth("target");
		dstd.tMaxHealth = UnitHealthMax("target");
		dstd.tPerHealth = ceil(100 * dstd.tHealth / dstd.tMaxHealth);
		--target inRange count
		dstd.inRange = 0
		for i = 1, 40 do
		 if UnitExists('nameplate' .. i) and IsSpellInRange('致死打击', 'nameplate' .. i) == 1 then
		  dstd.inRange = dstd.inRange + 1
		 end
		end
		--player
		dstd.rage=UnitPower("player");
		dstd.pHealth = UnitHealth("player");
		dstd.pMaxHealth = UnitHealthMax("player");
		dstd.pPerHealth = ceil(100 * dstd.pHealth / dstd.pMaxHealth);
		--watch
		--processed data for Fury
		--cd
		dstd.cd_lumang=mwGetCoolDown("鲁莽"); --鲁莽 CD
		dstd.cd_panzui=mwGetCoolDown("斩杀"); --斩杀 CD
		dstd.cd_sx=mwGetCoolDown("嗜血"); --嗜血 CD
		dstd.cd_odzn=mwGetCoolDown("上古余震"); --上古余震 CD
		dstd.cd_jrfb=mwGetCoolDown("剑刃风暴"); --剑刃风暴 CD
		dstd.cd_wstk=mwGetCoolDown("无视苦痛"); --无视苦痛 CD
		dstd.start_slzw,durantion_slzw,enable_slzw=GetSpellCooldown("胜利在望"); --胜利在望 CD -- 特殊cd
		dstd.currentCharges_nj = select(1,GetSpellCharges("怒击")); -- charge
		--buff
		dstd.buff_jn=mwGetBuffTime("激怒"); -- 激怒buff
		dstd.buff_lumang=mwGetBuffTime("鲁莽"); -- 鲁莽buff
		dstd.buff_wstk=mwGetBuffTime("无视苦痛"); -- 无视苦痛buff
		dstd.buff_cs=mwGetBuffTime("猝死"); -- 猝死buff
		dstd.buff_cszj=mwGetBuffTime("胜利"); --乘胜追击 buff持续时间
		dstd.buff_xfz=mwGetBuffTime("旋风斩"); --旋风斩buff持续时间
		--special treat
		dstd.cd_slzw=999; --胜利在望 cd
		if (start_slzw~=nil and start_slzw~=0) then
			cd_slzw=durantion_slzw + start_slzw - GetTime();
		end
		--processed data for Arms
		--cd
		dstd.cd_avatar=mwGetCoolDown("天神下凡"); --天神 CD
		dstd.cd_giant=mwGetCoolDown("巨人打击"); --巨人打击 CD
		dstd.cd_aftershock=mwGetCoolDown("上古余震"); --上古余震 CD
		dstd.cd_mortal=mwGetCoolDown("致死打击"); --致死打击 CD
		dstd.cd_spear=mwGetCoolDown("上古余震"); --上古余震 cd
		dstd.cd_skull=mwGetCoolDown("碎颅打击"); --碎颅打击 CD
		dstd.cd_sweep=mwGetCoolDown("横扫攻击"); --横扫 CD
		dstd.cd_zdnh=mwGetCoolDown("战斗怒吼"); --战斗怒吼 CD
		dstd.currentCharges_overpower =select(1,GetSpellCharges("压制")); -- 压制可用次数
		--buff
		dstd.buff_sweep=mwGetBuffTime("横扫攻击"); --横扫 buff持续时间
		dstd.debuff_rend=mwGetDebuffTime("撕裂"); --撕裂 debuff持续时间
		dstd.debuff_giant=mwGetDebuffTime("巨人打击"); --巨人打击 debuff持续时间
		dstd.count_mortalenhance = mwGetBuffCount("压制");--压制强化致死 buff 层数
		dstd.count_jjshanghai = mwGetBuffCount("间接伤害");--间接伤害强化旋风斩 buff 层数
		--talent
		dstd.has_talent_suilu = select(10,GetTalentInfo(1,3,1)); --是否有碎颅打击天赋，1排3号1专精
		dstd.has_talent_render = select(10,GetTalentInfo(3,3,1)); --是否有撕裂天赋，3排3号1专精
		dstd.has_talent_tusha = select(10,GetTalentInfo(3,1,1)); --是否有屠杀天赋，3排1号1专精
		dstd.zhanshaPHP = 20;
		if dstd.has_talent_tusha then
			dstd.zhanshaPHP = 35;
		end
		--Protection
		--Protection data
		--cd
		dstd.cd_ravager=mwGetCoolDown("破坏者"); --破坏者 CD
		dstd.cd_thunder=mwGetCoolDown("雷霆一击"); --雷霆一击 CD
		dstd.cd_shield=mwGetCoolDown("盾牌猛击"); --盾牌猛击 CD
		dstd.cd_block=mwGetCoolDown("盾牌格挡"); --盾牌格挡 CD
		dstd.cd_wall=mwGetCoolDown("盾墙"); --盾墙 CD
		dstd.cd_laststand=mwGetCoolDown("破釜沉舟"); --破釜沉舟 CD
		dstd.currentCharges_block =select(1,GetSpellCharges("盾牌格挡")); -- 盾牌格挡层数
		--buff
		dstd.buff_revenge=mwGetBuffTime("复仇！"); --复仇！ buff持续时间
		dstd.buff_block=mwGetBuffTime("盾牌格挡"); --盾牌格挡 buff持续时间



		--Play
		if dstd.currentSpecName == "狂怒" then
			dsdtFuryPlay(dstd,f,g);
		elseif dstd.currentSpecName == "武器" then
			dsdtArmsPlay(dstd,f,g);
		elseif dstd.currentSpecName == "防护" then
			dsdtProtectionPlay(dstd,f,g);
		end		
	end
end


local function YigeziDPSCommands()
	if isYgzAuto then
		h:Show();	
	else 
		h:Hide();
	end
	if UnitCanAttack("player","target") then
		--auto


		--Init data
		local ygz = {};
		--utils
		ygz.now = GetTime();
		ygz.cd_gcd=mwGetCoolDown("猎人印记"); --gcd 
		--Spec
		ygz.currentSpec = GetSpecialization();
		ygz.currentSpecName = ygz.currentSpec and select(2, GetSpecializationInfo(ygz.currentSpec)) or "None";
		--target
		ygz.tHealth = UnitHealth("target");
		ygz.tMaxHealth = UnitHealthMax("target");
		ygz.tPerHealth = ceil(100 * ygz.tHealth / ygz.tMaxHealth);
		ygz.petHealth = UnitHealth("pet");
		ygz.petMaxHealth = UnitHealthMax("pet");
		ygz.petPerHealth = ceil(100 * ygz.petHealth / ygz.petMaxHealth);
		--target inRange count
		ygz.inRange = 0
		--player
		ygz.focus=UnitPower("player");
		ygz.pHealth = UnitHealth("player");
		ygz.pMaxHealth = UnitHealthMax("player");
		ygz.pPerHealth = ceil(100 * ygz.pHealth / ygz.pMaxHealth);
		--watch
		ygz.currentCharges_barbed_shot =select(1,GetSpellCharges("倒刺射击")); -- 倒刺射击可用次数
		ygz.cd_kill_command=mwGetCoolDown("杀戮命令"); --杀戮命令 cd
		ygz.cd_bestial_wrath=mwGetCoolDown("狂野怒火"); --狂野怒火 cd
		ygz.cd_heal_pet=mwGetCoolDown("治疗宠物"); --治疗宠物 cd
		ygz.buff_pet_barbed_shot=mwGetPetBuffTime("狂暴"); -- 倒刺射击宝宝buff

		--play
		if ygz.currentSpecName == "野兽控制" then
			ygzBeastPlay(ygz,f,g);
		elseif ygz.currentSpecName == "生存" then
			ygzSurvivalPlay(ygz,f,g);
		else --射击
			ygzMarksmanshipPlay(ygz,f,g);
		end

		
	end
end

local function DdwDPSCommands()
	if isYgzAuto then
		h:Show();	
	else 
		h:Hide();
	end
	if UnitCanAttack("player","target") then
		--auto


		--Init data
		local ddw = {};
		--utils
		ddw.now = GetTime();
		ddw.cd_gcd=mwGetCoolDown("背刺"); --gcd 
		--Spec
		ddw.currentSpec = GetSpecialization();
		ddw.currentSpecName = ddw.currentSpec and select(2, GetSpecializationInfo(ddw.currentSpec)) or "None";
		--target
		ddw.tHealth = UnitHealth("target");
		ddw.tMaxHealth = UnitHealthMax("target");
		ddw.tPerHealth = ceil(100 * ddw.tHealth / ddw.tMaxHealth);
		--target inRange count
		ddw.inRange = 0
		--player
		ddw.energy=UnitPower("player");
		ddw.combo_points=UnitPower("player", SPELL_POWER_COMBO_POINTS);
		ddw.pHealth = UnitHealth("player");
		ddw.pMaxHealth = UnitHealthMax("player");
		ddw.pPerHealth = ceil(100 * ddw.pHealth / ddw.pMaxHealth);

		--play
		if ddw.currentSpecName == "敏锐" then
			--print(IsStealthed());
			ddwSubtletyPlay(ddw,f,g);
		end

		
	end
end

do

	local playerName, realm = UnitName("player")

	f = CreateFrame("Frame",nil,UIParent)
	f:SetFrameStrata("BACKGROUND")
	f:SetWidth(40) -- Set these to whatever height/width is needed 
	f:SetHeight(40) -- for your Texture
	f:SetPoint("CENTER",-750,390)
	--f:SetPoint("CENTER",-100,100)

	--f:EnableKeyboard(true)
	--f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	
	if playerName == "一個字" then 
		f:SetScript("OnUpdate", function()
			YigeziDPSCommands()
		end)
	elseif playerName == "赛季大吊威" then
		f:SetScript("OnUpdate", function()
			DdwDPSCommands()
		end)
	else --dstd
		f:SetScript("OnUpdate", function()
			MyDPSCommands()
		end)
	end
	

	f.textures = {}
	--f.textures[0] = f:CreateTexture(nil,"BACKGROUND")
	--f.textures[0]:SetAllPoints(f)
	--f.textures[0]:SetTexture(1,0,0)

	local tex = f:CreateTexture()
	f.textures[0]=tex
	--tex:SetPoint("TOP", f.Background, "TOP", 0, 0)
	--tex:SetPoint("BOTTOM", f.Background, "BOTTOM", 0, 0)
	tex:SetAllPoints(f)
	tex:SetColorTexture(1, 0, 0)
	--tex:SetWidth(f:GetWidth()/f.NUM_SEGMENTS)
	--tex:SetPoint("LEFT")
	f:Show()


	g = CreateFrame("Frame",nil,UIParent)
	g:SetFrameStrata("BACKGROUND")
	g:SetWidth(40) -- Set these to whatever height/width is needed 
	g:SetHeight(40) -- for your Texture
	g:SetPoint("CENTER",-650,390)
	--f:SetPoint("CENTER",-100,100)

	--f:EnableKeyboard(true)
	--g:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	--g:SetScript("OnEvent", function()
	--		MyDPSCommands()
	--	end)

	g.textures = {}
	--f.textures[0] = g:CreateTexture(nil,"BACKGROUND")
	--f.textures[0]:SetAllPoints(g)
	--f.textures[0]:SetTexture(1,0,0)

	local tex = g:CreateTexture()
	g.textures[0]=tex
	--tex:SetPoint("TOP", g.Background, "TOP", 0, 0)
	--tex:SetPoint("BOTTOM", g.Background, "BOTTOM", 0, 0)
	tex:SetAllPoints(g)
	tex:SetColorTexture(1, 0, 0)
	--tex:SetWidth(g:GetWidth()/g.NUM_SEGMENTS)
	--tex:SetPoint("LEFT")
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
	tex:SetColorTexture(1,0,0)
	h:Show()

end

SLASH_DDW1 = '/dstd'

SlashCmdList["DSTD"] = MyDPSCommands   