

--message("hello world!");

local function MyAddonCommands(msg, editbox)
  if msg == 'bye' then
    message('Goodbye, World!')
  else
    message("Hello, World!")
  end
end


local f
local g
local function MyDPSCommands()
	--utils
	local cast=CastSpell;
	local seconds = GetTime();
	local tHealth = UnitHealth("target");
	local tMaxHealth = UnitHealthMax("target");
	local tPerHealth = ceil(100 * tHealth / tMaxHealth);
	--player
	local rage=UnitPower("player");
	local cp=GetComboPoints("player")--combo points
	local pHealth = UnitHealth("player");
	local pMaxHealth = UnitHealthMax("player");
	local pPerHealth = ceil(100 * pHealth / pMaxHealth);
	--target
	local maxMonsterHP = 10000000 * 0;
	--watch
	local start_lumang,durantion_lumang,enable_lumang=GetSpellCooldown("宿敌"); --宿敌 CD
	local start_panzui,durantion_panzui,enable_panzui=GetSpellCooldown("毒刃"); --毒刃 CD
	local start_gcd,durantion_gcd,enable_gcd=GetSpellCooldown("刀扇"); --gcd CD
	local start_sx,durantion_sx,enable_sx=GetSpellCooldown("锁喉"); --锁喉 CD
	--local start_odzn,durantion_odzn,enable_odzn=GetSpellCooldown("巨龙怒吼"); --巨龙怒吼 CD
	local start_jrfb,durantion_jrfb,enable_jrfb=GetSpellCooldown("剑刃风暴"); --剑刃风暴 CD
	local start_rampage,durantion_rampage,enable_rampage=GetSpellCooldown("暴怒"); --暴怒 CD
	local start_nj,durantion_nj,enable_nj=GetSpellCooldown("怒击"); --怒击 CD
	local start_wstk,durantion_wstk,enable_wstk=GetSpellCooldown("无视苦痛"); --无视苦痛 CD
	local usable = IsAttackSpell("旋风斩");
	local currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges("怒击"); -- charge
	local name_0, rank_0, icon_0, count_0, debuffType_0, expirationTime_jn=AuraUtil.FindAuraByName("切割","player",'HELPFUL');--切割 buff
	local name_4, rank_4, icon_4, count_4, debuffType_4, expirationTime_lumang=AuraUtil.FindAuraByName("割裂","target",'HARMFULL');--割裂 buff
	local name_2, rank_2, icon_2, count_2, debuffType_2, expirationTime_wstk=AuraUtil.FindAuraByName("锁喉","target",'HARMFULL');--锁喉 buff
	local name_3, rank_3, icon_3, count_3, debuffType_3, expirationTime_cs=AuraUtil.FindAuraByName("猝死","player",'HELPFUL');--猝死 buff
	local name_1, rank_1, icon_1, count_1, debuffType_1, expirationTime_cszj=AuraUtil.FindAuraByName("胜利","player",'HELPFUL');--乘胜追击 buff
	local name_7, rank_7, icon_7, count_7, debuffType_7, expirationTime_xuanfengzhan=AuraUtil.FindAuraByName("旋风斩","player",'HELPFUL');--旋风斩 buff
	--processed data
	local cd_lumang=0;
	if (start_lumang~=nil and start_lumang~=0) then
		cd_lumang=durantion_lumang + start_lumang - GetTime();
	end
	--local cd_odzn=0;
	--if (start_odzn~=nil and start_odzn~=0) then
	--	cd_odzn=durantion_odzn + start_odzn - GetTime();
	--end
	local cd_jrfb=0;
	if (start_jrfb~=nil and start_jrfb~=0) then
		cd_jrfb=durantion_jrfb + start_jrfb - GetTime();
	end
	local cd_panzui=0;
	if (start_panzui ~=nil and start_panzui~=0) then
		cd_panzui=durantion_panzui + start_panzui - GetTime();
	end
	local cd_gcd=0;
	if (start_gcd~=nil and start_gcd~=0) then
		cd_gcd=durantion_gcd + start_gcd - seconds;
	end
	local buff_jn=0; -- 激怒buff
	if (expirationTime_jn~=nil and expirationTime_jn~=0) then
		buff_jn= expirationTime_jn - GetTime();
	end
	local buff_lumang=0; -- 鲁莽buff
	if (expirationTime_lumang~=nil and expirationTime_lumang~=0) then
		buff_lumang= expirationTime_lumang - GetTime();
	end
	local buff_wstk=0; -- 无视苦痛buff
	if (expirationTime_wstk~=nil and expirationTime_wstk~=0) then
		buff_wstk= expirationTime_wstk - GetTime();
	end
	local buff_cs=0; -- 猝死buff
	if (expirationTime_cs~=nil and expirationTime_cs~=0) then
		buff_cs = expirationTime_cs - GetTime();
	end
	local buff_xfz=0;
	if (expirationTime_xuanfengzhan~=nil and expirationTime_xuanfengzhan~=0) then
		buff_xfz= expirationTime_xuanfengzhan - GetTime();
	end
	local buff_cszj=0; --乘胜追击 buff持续时间
	if (expirationTime_cszj~=nil and expirationTime_cszj~=0) then
		buff_cszj= expirationTime_cszj - GetTime();
	end
	local cd_wstk=0; --无视苦痛cd
	if (start_wstk~=nil and start_wstk~=0) then
		cd_wstk=durantion_wstk + start_wstk - GetTime();
	end
	local cd_sx=0;
	if (start_sx~=nil and start_sx~=0) then
		cd_sx=durantion_sx + start_sx - GetTime();
	end
	
	if UnitCanAttack("player","target") then
		--单体
		if tHealth>20000 and cd_lumang<=0 and buff_lumang<=0 then -- 夙愿好了用夙愿
			f.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
		elseif cp>=1 and buff_jn <=0 then -- 没切割用切割
			f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
		elseif buff_jn <= 11 and cp>=4 then -- 切割小于11秒4星补切割
			f.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 4
		elseif cd_panzui<=1.1 and (tPerHealth<=35 or tPerHealth>=80 or buff_cs>0.5) then -- 锁喉小于5.6秒补锁喉
			f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
		elseif buff_jn<=0 and cd_sx<=1.1 then
			f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
		--elseif buff_jn>0.1 and cd_odzn<=1.1 then
		--	f.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e
		elseif tHealth>100000 and buff_jn>0.1 and buff_lumang<=0 and cd_jrfb<=1.1 and rage<=50 then
			f.textures[0]:SetColorTexture(0, 0, 1) --蓝 剑刃风暴 e
		elseif currentCharges>=2 then
			f.textures[0]:SetColorTexture(1, 1, 0) --黄 怒击 3
		elseif cd_sx<=1.1 then
			f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
		elseif currentCharges>=1 then
			f.textures[0]:SetColorTexture(1, 1, 0) --黄 怒击 3
		else
			f.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 旋风斩
		end
		--AOE
		if buff_cszj>0.5 and pPerHealth<=70 then
			g.textures[0]:SetColorTexture(0, 1, 0) --绿色乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%
		elseif pPerHealth<=50 and rage>=60 and cd_wstk<=1.1 and buff_wstk<=0.1 then 
			g.textures[0]:SetColorTexture(0.4, 0.4, 0) --暗黄色无视苦痛 c：player血量低于40%，有无视苦痛cd，并且有60怒气
		elseif buff_xfz == nil or buff_xfz<=0.5 then
			g.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 旋风斩
		elseif tHealth>100000 and cd_lumang<=0 and buff_lumang<=0 then -- 鲁莽好了用鲁莽
			g.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
		elseif buff_jn >0.1 and cd_panzui<=1.1 and (tPerHealth<=35 or tPerHealth>=80 or buff_cs>0.5) then -- 斩杀阶段有激怒
			g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
		elseif (buff_jn<=1.0 and rage>=80) or rage>=90 then
			g.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 4
		elseif cd_panzui<=1.1 and (tPerHealth<=35 or tPerHealth>=80 or buff_cs>0.5) then -- 斩杀阶段没激怒
			g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
		elseif buff_jn<=0 and cd_sx<=1.1 then
			g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
		--elseif buff_jn>0.1 and cd_odzn<=1.1 then
		--	g.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e
		elseif tHealth>80000 and buff_jn>0.1 and buff_lumang<=0 and cd_jrfb<=1.1 and rage<=50 then
			g.textures[0]:SetColorTexture(0, 0, 1) --蓝 剑刃风暴 e
		elseif currentCharges>=2 then
			g.textures[0]:SetColorTexture(1, 1, 0) --黄 怒击 3
		elseif cd_sx<=1.1 then
			g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
		elseif currentCharges>=1 then
			g.textures[0]:SetColorTexture(1, 1, 0) --黄 怒击 3
		else
			g.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 旋风斩
		end
	end
end

do
	f = CreateFrame("Frame",nil,UIParent)
f:SetFrameStrata("BACKGROUND")
f:SetWidth(40) -- Set these to whatever height/width is needed 
f:SetHeight(40) -- for your Texture
f:SetPoint("CENTER",-500,300)
--f:SetPoint("CENTER",-100,100)

--f:EnableKeyboard(true)
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function()
		MyDPSCommands()
	end)

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
g:SetPoint("CENTER",-400,300)
--f:SetPoint("CENTER",-100,100)

--f:EnableKeyboard(true)
g:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
g:SetScript("OnEvent", function()
		MyDPSCommands()
	end)

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



end

SLASH_DDW1 = '/dstd'

SlashCmdList["DSTD"] = MyDPSCommands   