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
    if UnitCanAttack("player", "target") then

        --Init data
        local dstd = {};
        --Spec
        dstd.currentSpec = GetSpecialization();
        dstd.currentSpecName = dstd.currentSpec and select(2, GetSpecializationInfo(dstd.currentSpec)) or "None";
        --utils
        dstd.now = GetTime();
        dstd.cd_gcd = mwGetCoolDown("旋风斩"); --GCD
        --target
        dstd.tHealth = UnitHealth("target");
        dstd.tMaxHealth = UnitHealthMax("target");
        dstd.tPerHealth = ceil(100 * dstd.tHealth / dstd.tMaxHealth);
        --target inRange count
        dstd.inRange = 0
        for id = 1, 40 do
            local unitID = "nameplate" .. id
            if UnitCanAttack("player", unitID) and IsItemInRange(63427, unitID) then
				dstd.inRange = dstd.inRange + 1
            end
        end
        --player
        dstd.rage = UnitPower("player");
        dstd.pHealth = UnitHealth("player");
        dstd.pMaxHealth = UnitHealthMax("player");
        dstd.pPerHealth = ceil(100 * dstd.pHealth / dstd.pMaxHealth);
        --watch
        --processed data for Fury
        --cd
        dstd.cd_lumang = mwGetCoolDown("鲁莽"); --鲁莽 CD
        dstd.cd_panzui = mwGetCoolDown("斩杀"); --斩杀 CD
        dstd.cd_sx = mwGetCoolDown("嗜血"); --嗜血 CD
        dstd.cd_odzn = mwGetCoolDown("上古余震"); --上古余震 CD
        dstd.cd_jrfb = mwGetCoolDown("剑刃风暴"); --剑刃风暴 CD
        dstd.cd_wstk = mwGetCoolDown("无视苦痛"); --无视苦痛 CD
        dstd.start_slzw, durantion_slzw, enable_slzw = GetSpellCooldown("胜利在望"); --胜利在望 CD -- 特殊cd
        dstd.currentCharges_nj = select(1, GetSpellCharges("怒击")); -- charge
        --buff
        dstd.buff_jn = mwGetBuffTime("激怒"); -- 激怒buff
        dstd.buff_lumang = mwGetBuffTime("鲁莽"); -- 鲁莽buff
        dstd.buff_wstk = mwGetBuffTime("无视苦痛"); -- 无视苦痛buff
        dstd.buff_cs = mwGetBuffTime("猝死"); -- 猝死buff
        dstd.buff_cszj = mwGetBuffTime("胜利"); --乘胜追击 buff持续时间
        dstd.buff_xfz = mwGetBuffTime("旋风斩"); --旋风斩buff持续时间
        --special treat
        dstd.cd_slzw = 999; --胜利在望 cd
        if (start_slzw ~= nil and start_slzw ~= 0) then
            cd_slzw = durantion_slzw + start_slzw - GetTime();
        end
        --processed data for Arms
        --cd
        dstd.cd_avatar = mwGetCoolDown("天神下凡"); --天神 CD
        dstd.cd_giant = mwGetCoolDown("巨人打击"); --巨人打击 CD
        dstd.cd_aftershock = mwGetCoolDown("上古余震"); --上古余震 CD
        dstd.cd_mortal = mwGetCoolDown("致死打击"); --致死打击 CD
        dstd.cd_spear = mwGetCoolDown("上古余震"); --上古余震 cd
        dstd.cd_skull = mwGetCoolDown("碎颅打击"); --碎颅打击 CD
        dstd.cd_sweep = mwGetCoolDown("横扫攻击"); --横扫 CD
        dstd.cd_zdnh = mwGetCoolDown("战斗怒吼"); --战斗怒吼 CD
        dstd.currentCharges_overpower = select(1, GetSpellCharges("压制")); -- 压制可用次数
        --buff
        dstd.buff_sweep = mwGetBuffTime("横扫攻击"); --横扫 buff持续时间
        dstd.debuff_rend = mwGetDebuffTime("撕裂"); --撕裂 debuff持续时间
        dstd.debuff_giant = mwGetDebuffTime("巨人打击"); --巨人打击 debuff持续时间
        dstd.count_mortalenhance = mwGetBuffCount("压制");--压制强化致死 buff 层数
        dstd.count_jjshanghai = mwGetBuffCount("间接伤害");--间接伤害强化旋风斩 buff 层数
        --talent
        dstd.has_talent_suilu = select(10, GetTalentInfo(1, 3, 1)); --是否有碎颅打击天赋，1排3号1专精
        dstd.has_talent_render = select(10, GetTalentInfo(3, 3, 1)); --是否有撕裂天赋，3排3号1专精
        dstd.has_talent_tusha = select(10, GetTalentInfo(3, 1, 1)); --是否有屠杀天赋，3排1号1专精
        dstd.zhanshaPHP = 20;
        if dstd.has_talent_tusha then
            dstd.zhanshaPHP = 35;
        end
        --Protection
        --Protection data
        --cd
        dstd.cd_ravager = mwGetCoolDown("破坏者"); --破坏者 CD
        dstd.cd_thunder = mwGetCoolDown("雷霆一击"); --雷霆一击 CD
        dstd.cd_shield = mwGetCoolDown("盾牌猛击"); --盾牌猛击 CD
        dstd.cd_block = mwGetCoolDown("盾牌格挡"); --盾牌格挡 CD
        dstd.cd_wall = mwGetCoolDown("盾墙"); --盾墙 CD
        dstd.cd_laststand = mwGetCoolDown("破釜沉舟"); --破釜沉舟 CD
        dstd.currentCharges_block = select(1, GetSpellCharges("盾牌格挡")); -- 盾牌格挡层数
        --buff
        dstd.buff_revenge = mwGetBuffTime("复仇！"); --复仇！ buff持续时间
        dstd.buff_block = mwGetBuffTime("盾牌格挡"); --盾牌格挡 buff持续时间



        --Play
        if dstd.currentSpecName == "狂怒" then
            dsdtFuryPlay(dstd, f, g);
        elseif dstd.currentSpecName == "武器" then
            dsdtArmsPlay(dstd, f, g);
        elseif dstd.currentSpecName == "防护" then
            dsdtProtectionPlay(dstd, f, g);
        end
    end
end

local function YdybDPSCommands()
    if isYgzAuto then
        h:Show();
    else
        h:Hide();
    end
    if UnitCanAttack("player", "target") then
        --Init data
        local ydyb = {};
        --utils
        ydyb.now = GetTime();
        ydyb.cd_gcd = mwGetCoolDown("野性印记"); --gcd
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
        ydyb.focus = UnitPower("player");
        ydyb.pHealth = UnitHealth("player");
        ydyb.pMaxHealth = UnitHealthMax("player");
        ydyb.pPerHealth = ceil(100 * ydyb.pHealth / ydyb.pMaxHealth);
        local talent = select(9, GetTalentInfo(2, 3))
        --play
        if talent <= 0 then
            ydybBalancePlay(ydyb, f, g);
        else
            ydybFeralPlay(ydyb, f, g);
        end


    end
end

local function ScwDPSCommands()
    if isYgzAuto then
        h:Show();
    else
        h:Hide();
    end
    if UnitCanAttack("player", "target") then
        --Init data
        local scw = {};
        --utils
        scw.now = GetTime();
        scw.cd_gcd = mwGetCoolDown("野性印记"); --gcd
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
        scw.focus = UnitPower("player");
        scw.pHealth = UnitHealth("player");
        scw.pMaxHealth = UnitHealthMax("player");
        scw.pPerHealth = ceil(100 * scw.pHealth / scw.pMaxHealth);
        local talent = select(9, GetTalentInfo(2, 3))
        --play
        if talent <= 0 then
            scwArmsPlay(scw, f, g);
        else
            scwFuryPlay(scw, f, g);
        end


    end
end

local function p940DPSCommands()
    if isYgzAuto then
        h:Show();
    else
        h:Hide();
    end
    if UnitCanAttack("player", "target") then
        --Init data
        local p940 = {};
        --utils
        p940.now = GetTime();
        p940.cd_gcd = mwGetCoolDown("凋零缠绕"); --gcd
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
        p940.energy = UnitPower("player");
        p940.pHealth = UnitHealth("player");
        p940.pMaxHealth = UnitHealthMax("player");
        p940.pPerHealth = ceil(100 * p940.pHealth / p940.pMaxHealth);
        local talent = select(9, GetTalentInfo(2, 29)) --萨萨里安的威胁
        --play
        if talent > 0 then
            p940FrostPlay(p940, f, g);
            --p940FrostPlayHDR(p940,f,g);
        else
            p940BloodPlay(p940, f, g);
            --p940BloodPlayHDR(p940,f,g);
        end


    end
end

do

    local playerName, realm = UnitName("player")

    f = CreateFrame("Frame", nil, UIParent)
    f:SetFrameStrata("BACKGROUND")
    f:SetWidth(40) -- Set these to whatever height/width is needed
    f:SetHeight(40) -- for your Texture
    f:SetPoint("CENTER", -730, 380)
    --f:SetPoint("CENTER",-100,100)

    --f:EnableKeyboard(true)
    --f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    if playerName == "野德一逼" or playerName == "肇事咕儿" then
        f:SetScript("OnUpdate", function()
            YdybDPSCommands()
        end)
    elseif playerName == "酥粗威" then
        f:SetScript("OnUpdate", function()
            ScwDPSCommands()
        end)
    elseif playerName == "迪神挺吊" then
        f:SetScript("OnUpdate", function()
            MyDPSCommands()
        end)
    elseif playerName == "玩家九四零" or playerName == "迪凯威" or playerName == "迪凯威威" then
        f:SetScript("OnUpdate", function()
            p940DPSCommands()
        end)
    end

    f.textures = {}
    local tex = f:CreateTexture()
    f.textures[0] = tex
    tex:SetAllPoints(f)
    tex:SetColorTexture(0.8, 1, 0.8)
    f:Show()

    g = CreateFrame("Frame", nil, UIParent)
    g:SetFrameStrata("BACKGROUND")
    g:SetWidth(40) -- Set these to whatever height/width is needed
    g:SetHeight(40) -- for your Texture
    g:SetPoint("CENTER", -580, 330)
    g.textures = {}

    local tex = g:CreateTexture()
    g.textures[0] = tex
    tex:SetAllPoints(g)
    tex:SetColorTexture(0.4, 0.4, 0.4)
    g:Show()

    h = CreateFrame("Frame", nil, UIParent)
    h:SetFrameStrata("BACKGROUND")
    h:SetWidth(40) -- Set these to whatever height/width is needed
    h:SetHeight(40) -- for your Texture
    h:SetPoint("CENTER", -250, 100)
    h.textures = {}
    local tex = h:CreateTexture()
    h.textures[0] = tex
    tex:SetAllPoints(h)
    tex:SetColorTexture(0.8, 0.3, 0.3)
    h:Show()
    --h:Hide()

end

SLASH_DDW1 = '/dstd'

SlashCmdList["DSTD"] = YdybDPSCommands