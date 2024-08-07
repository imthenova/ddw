function p940BloodPlay(p940, f, g)
    local cd_gcd = p940.cd_gcd;
    local color08 = "0.8";
    --buff
    local energy = UnitPower("player");
    local blood1CD = select(3, GetRuneCooldown(1));
    local blood2CD = select(3, GetRuneCooldown(2));
    local blood1GCD = mwGetRuneCoolDown(1)<=cd_gcd;
    local blood2GCD = mwGetRuneCoolDown(2)<=cd_gcd;
    local cd_bloodRune1 = mwGetRuneCoolDown(1);
    local cd_bloodRune2 = mwGetRuneCoolDown(2);
    local frost1CD = select(3, GetRuneCooldown(5));
    local frost2CD = select(3, GetRuneCooldown(6));
    local frost1GCD = mwGetRuneCoolDown(5)<=cd_gcd;
    local frost2GCD = mwGetRuneCoolDown(6)<=cd_gcd;
    local unholy1CD = select(3, GetRuneCooldown(3));
    local unholy2CD = select(3, GetRuneCooldown(4));
    local unholy1GCD = mwGetRuneCoolDown(3)<=cd_gcd;
    local unholy2GCD = mwGetRuneCoolDown(4)<=cd_gcd;
    local usable_overpower = select(1,IsUsableSpell("符文打击")) or select(2,IsUsableSpell("符文打击"));
    --/script print(GetRuneCooldown(5));
    --/script print(IsUsableSpell("符文打击"));
    local death1CD = GetRuneType(1) == 4 and blood1CD;
    local death2CD = GetRuneType(2) == 4 and blood2CD;
    local death3CD = GetRuneType(3) == 4 and unholy1CD;
    local death4CD = GetRuneType(4) == 4 and unholy2CD;
    local death5CD = GetRuneType(5) == 4 and frost1CD;
    local death6CD = GetRuneType(6) == 4 and frost2CD;
    local death1Ready = death1CD or death2CD;
    local death2Ready = death1CD and death2CD;
    local deathReady = death1CD or death2CD or death3CD or death4CD or death5CD or death6CD;
    local death3GCD = GetRuneType(3) == 4 and mwGetRuneCoolDown(3)<=cd_gcd;
    local death4GCD = GetRuneType(4) == 4 and mwGetRuneCoolDown(4)<=cd_gcd;
    local death5GCD = GetRuneType(5) == 4 and mwGetRuneCoolDown(5)<=cd_gcd;
    local death6GCD = GetRuneType(6) == 4 and mwGetRuneCoolDown(6)<=cd_gcd;
    local deathAnyGCD = death3GCD or death4GCD or death5GCD or death6GCD;

    local isBloodReady = blood1CD or blood2CD;
    local isBloodGCD = blood1GCD or blood2GCD;
    local isBloodBothReady = blood1CD and blood2CD;
    local isFrostReady = frost1CD or frost2CD;
    local isFrostGCD = frost1GCD or frost2GCD;
    local isFrostBothReady = frost1CD and frost2CD;
    local isUnholyReady = unholy1CD or unholy2CD;
    local isUnholyGCD = unholy1GCD or unholy2GCD;
    local isUnholyBothReady = unholy1CD and unholy2CD;
    local debuf_frost = mwGetPlayerDebuffTime("冰霜疫病");
    local debuf_blood = mwGetPlayerDebuffTime("血之疫病");
    local buff_roar = mwGetBuffTime("寒冬号角");
    local buff_strongtt = mwGetBuffTime("大地之力");
    local buff_killing_machine = mwGetBuffTime("杀戮机器");
    local buff_whiteFrost = mwGetBuffTime("冰冻之雾");
    local cd_roar = mwGetCoolDown("寒冬号角");
    local cd_swdl = mwGetCoolDown("枯萎凋零");
    local cd_lfcj = mwGetCoolDown("凛风冲击");
    local min_debuff = min(debuf_frost,debuf_blood);
    local can_spread = cd_bloodRune1<min_debuff-3.5 and cd_bloodRune2<min_debuff-3.5;
    --print(deathAnyGCD);
    if buff_roar <= 0 and buff_strongtt<=0 and cd_roar<=cd_gcd then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    elseif IsCurrentSpell("符文打击") == false and energy >= 20 and usable_overpower then
        f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
    elseif debuf_frost <= 0 and (isFrostReady or deathAnyGCD) then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
        g.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif debuf_blood <= 0 and (isUnholyReady or deathAnyGCD) then
        f.textures[0]:SetColorTexture(0, 1, 1); --暗打
        g.textures[0]:SetColorTexture(0, 1, 1); --暗打
        --     elseif (isFrostReady and isUnholyReady or death2Ready) and p940.pPerHealth<=50 then
        --         f.textures[0]:SetColorTexture(1, color08, color08) --灵打
    elseif (min_debuff <=4.2 and min_debuff>0.1) and isBloodGCD then
        f.textures[0]:SetColorTexture(1, color08, color08) --8传染
        g.textures[0]:SetColorTexture(1, color08, color08) --8传染
    elseif deathAnyGCD
            and p940.pPerHealth > 80
    then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
        g.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif (isFrostReady and isUnholyReady or
            isFrostBothReady and death1Ready or
            isUnholyReady and death1Ready or
            death2Ready)
            --and p940.pPerHealth <= 75
    then
        f.textures[0]:SetColorTexture(color08, 1, color08); --8 --灵打
        g.textures[0]:SetColorTexture(color08, 1, color08); --8 --灵打
    elseif (can_spread==false and min_debuff>0.2) and isBloodGCD then
        f.textures[0]:SetColorTexture(1, color08, color08) --8传染
        g.textures[0]:SetColorTexture(1, color08, color08) --8传染
    elseif (blood1CD) and can_spread then
        f.textures[0]:SetColorTexture(0, 0, 0); --血打
        --g.textures[0]:SetColorTexture(0, 0, 0); --血打
        g.textures[0]:SetColorTexture(1, 0, 1); --5 血沸
        --     elseif (isFrostReady and isUnholyReady or death2Ready) then
        --         f.textures[0]:SetColorTexture(1, color08, color08) --灵打
        --elseif isFrostReady then
        --    f.textures[0]:SetColorTexture(1, 0, 0); --冰触
        --elseif isUnholyReady then
        --    f.textures[0]:SetColorTexture(0, 1, 1); --暗打
    elseif energy >= 100 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
        g.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif cd_roar <= cd_gcd then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    else
        f.textures[0]:SetColorTexture(0.25, 0.25, 0.25); -- 等着
        g.textures[0]:SetColorTexture(0.25, 0.25, 0.25); -- 等着
    end

    --if isFrostReady and isUnholyBothReady and (isBloodReady or deathReady) and cd_swdl <= cd_gcd then
    --    g.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --f10 取消
    --end
end