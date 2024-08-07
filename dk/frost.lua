function p940FrostPlay(p940, f, g)
    local cd_gcd = p940.cd_gcd;
    local color08 = "0.8";
    --buff
    local energy = UnitPower("player");
    local blood1CD = select(3,GetRuneCooldown(1));
    --/script print(GetRuneType(1));
    local blood2CD = select(3,GetRuneCooldown(2));
    local cd_bloodRune1 = mwGetRuneCoolDown(1);
    local cd_bloodRune2 = mwGetRuneCoolDown(2);
    local blood1GCD = mwGetRuneCoolDown(1)<=cd_gcd;
    local blood2GCD = mwGetRuneCoolDown(2)<=cd_gcd;
    local frost1CD = select(3,GetRuneCooldown(5));
    local frost2CD = select(3,GetRuneCooldown(6));
    local frost1GCD = mwGetRuneCoolDown(5)<=cd_gcd;
    local frost2GCD = mwGetRuneCoolDown(6)<=cd_gcd;
    local frost1Next = mwGetRuneCoolDown(5)<=cd_gcd+1;
    local frost2Next = mwGetRuneCoolDown(6)<=cd_gcd+1;
    local unholy1CD = select(3,GetRuneCooldown(3));
    local unholy2CD = select(3,GetRuneCooldown(4));
    local unholy1GCD = mwGetRuneCoolDown(3)<=cd_gcd;
    local unholy2GCD = mwGetRuneCoolDown(4)<=cd_gcd;
    local unholy1Next = mwGetRuneCoolDown(3)<=cd_gcd+1;
    local unholy2Next = mwGetRuneCoolDown(4)<=cd_gcd+1;
    local usable_overpower = IsUsableSpell("符文打击");
    --/script print(IsUsableSpell("符文打击"));
    local death1CD = GetRuneType(1) == 4 and blood1CD;
    local death2CD = GetRuneType(2) == 4 and blood2CD;
    local death3CD = GetRuneType(3) == 4 and unholy1CD;
    local death4CD = GetRuneType(4) == 4 and unholy2CD;
    local death5CD = GetRuneType(5) == 4 and frost1CD;
    local death6CD = GetRuneType(6) == 4 and frost2CD;


    local death1Ready = death1CD or death2CD;
    local death2Ready = death1CD and death2CD;
    local death1GCD = GetRuneType(1) == 4 and mwGetRuneCoolDown(1)<=cd_gcd;
    local death2GCD = GetRuneType(2) == 4 and mwGetRuneCoolDown(2)<=cd_gcd;
    local deathBothGCD = death1GCD and death2GCD;


    local deathReady = death1CD or death2CD or death3CD or death4CD or death5CD or death6CD;

    local isBloodReady =  blood1CD or blood2CD;
    local isBloodBothReady =  blood1CD and blood2CD;
    local isFrostReady =  frost1CD or frost2CD;
    local isFrostBothReady =  frost1CD and frost2CD;
    local isUnholyReady =  unholy1CD or unholy2CD;
    local isUnholyBothReady =  unholy1CD and unholy2CD;
    local isBloodGCD = blood1GCD or blood2GCD;
    local isFrostGCD = frost1GCD or frost2GCD;
    local isUnholyGCD = unholy1GCD or unholy2GCD;
    local isFrostNext = frost1Next or frost2Next;
    local isUnholyNext = unholy1Next or unholy2Next;
    local debuf_frost = mwGetPlayerDebuffTime("冰霜疫病");
    local debuf_blood = mwGetPlayerDebuffTime("血之疫病");
    local buff_roar = mwGetBuffTime("寒冬号角");
    local buff_strongtt = mwGetBuffTime("大地之力");
    local buff_killing_machine = mwGetBuffTime("杀戮机器");
    local buff_whiteFrost = mwGetBuffTime("冰冻之雾");
    local cd_roar = mwGetCoolDown("寒冬号角");
    local cd_swdl = mwGetCoolDown("枯萎凋零");
    local cd_lfcj = mwGetCoolDown("凛风冲击");
    local cd_fenliu = mwGetCoolDown("活力分流");
    local cd_tongqiang = mwGetCoolDown("铜墙铁壁");
    local min_debuff = min(debuf_frost,debuf_blood);
    local can_spread = cd_bloodRune1<min_debuff-4.9 and cd_bloodRune2<min_debuff-4.9;
    if buff_roar <= 0 and buff_strongtt<=0 and cd_roar<=cd_gcd then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    elseif debuf_frost <=0 and (isFrostGCD or death1Ready) then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
        g.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif debuf_blood <=0 and (isUnholyGCD or death1Ready) then
        f.textures[0]:SetColorTexture(0, 1, 1); --暗打
        g.textures[0]:SetColorTexture(0, 1, 1); --暗打
    elseif isYgzAuto and (isFrostReady==false and death1Ready and cd_fenliu<=0 and cd_tongqiang<=0) then
        f.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --铜墙铁壁 f10
        g.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --铜墙铁壁 f10
    elseif (min_debuff <=4.9 and min_debuff>0.1) and (isBloodGCD) then
        f.textures[0]:SetColorTexture(1, color08, color08) --8传染
        g.textures[0]:SetColorTexture(1, color08, color08) --8传染
    elseif (min_debuff <=3 and min_debuff>0.1) and (cd_fenliu<=0) then
        f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --分流传染宏 F11
        g.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --分流传染宏 F11
    elseif (isFrostGCD and isUnholyGCD
            or (death2Ready and cd_fenliu<=0)-- and min_debuff>11
    ) then
        f.textures[0]:SetColorTexture(color08, 1, color08); --8 --湮灭
        g.textures[0]:SetColorTexture(color08, 1, color08); --8 --湮灭
        if cd_lfcj<=p940.cd_gcd then
            g.textures[0]:SetColorTexture(1, 1, 0); --3 凛风
        end
    elseif buff_killing_machine>0.2 and energy>=40 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
        g.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif buff_whiteFrost>0.2 then
        f.textures[0]:SetColorTexture(1, 1, 0); --3 凛风
        g.textures[0]:SetColorTexture(1, 1, 0); --3 凛风
    elseif energy>=85 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
        g.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    --elseif (isFrostNext and isUnholyNext
    --        --or deathBothGCD and min_debuff>11
    --)then
    --    f.textures[0]:SetColorTexture(color08, 1, color08); --8 --湮灭
    --    g.textures[0]:SetColorTexture(color08, 1, color08); --8 --湮灭
    --    if cd_lfcj<=p940.cd_gcd then
    --        g.textures[0]:SetColorTexture(1, 1, 0); --3 凛风
    --    end
    elseif (can_spread==false and min_debuff>0.2) and isBloodGCD
        --and min_debuff<12
    then
        f.textures[0]:SetColorTexture(1, color08, color08) --8传染
        g.textures[0]:SetColorTexture(1, color08, color08) --8传染
    --elseif (isBloodGCD or deathReady) and min_debuff>=5 and can_spread  then
    elseif (isBloodGCD or deathReady) and can_spread
        --and min_debuff<12
    then
        f.textures[0]:SetColorTexture(0, 0, 0); --血打
        g.textures[0]:SetColorTexture(1, 0, 1); --5 血沸
    elseif energy>=40 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
        g.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif cd_roar<=cd_gcd then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5); -- 等着
        g.textures[0]:SetColorTexture(0.5, 0.5, 0.5); -- 等着
    end
end