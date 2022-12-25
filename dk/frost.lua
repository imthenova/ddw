function p940FrostPlay(p940, f, g)
    --buff
    local energy = UnitPower("player");
    local blood1CD = select(3,GetRuneCooldown(1));
    --/script print(GetRuneType(1));
    local blood2CD = select(3,GetRuneCooldown(2));
    local frost1CD = select(3,GetRuneCooldown(5));
    local frost2CD = select(3,GetRuneCooldown(6));
    local unholy1CD = select(3,GetRuneCooldown(3));
    local unholy2CD = select(3,GetRuneCooldown(4));
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
    local deathReady = death1CD or death2CD or death3CD or death4CD or death5CD or death6CD;

    local isBloodReady =  blood1CD or blood2CD;
    local isBloodBothReady =  blood1CD and blood2CD;
    local isFrostReady =  frost1CD or frost2CD;
    local isFrostBothReady =  frost1CD and frost2CD;
    local isUnholyReady =  unholy1CD or unholy2CD;
    local isUnholyBothReady =  unholy1CD and unholy2CD;
    local debuf_frost = mwGetPlayerDebuffTime("冰霜疫病");
    local debuf_blood = mwGetPlayerDebuffTime("血之疫病");
    local buff_roar = mwGetBuffTime("寒冬号角");
    local buff_killing_machine = mwGetBuffTime("杀戮机器");
    local buff_whiteFrost = mwGetBuffTime("冰冻之雾");
    local cd_roar = mwGetCoolDown("寒冬号角");
    if energy >=130 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif buff_roar <= 0 and cd_roar<=p940.cd_gcd then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
--     elseif IsCurrentSpell("符文打击") == false and energy>=20 and usable_overpower then
--         f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
    elseif debuf_frost <=0 and (isFrostReady or death1Ready) then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif debuf_blood <=0 and (isUnholyReady or death1Ready) then
        f.textures[0]:SetColorTexture(0, 1, 1); --暗打
--     elseif (isFrostReady and isUnholyReady or death2Ready) and p940.pPerHealth<=50 then
--         f.textures[0]:SetColorTexture(1, 0.8, 0.8) --灵打
    elseif debuf_frost <=3 or debuf_blood <=3 and isBloodReady then
    --传染

    elseif (isFrostReady and isUnholyReady or
        isFrostBothReady and death1Ready or
        isUnholyReady and death1Ready or
        death2Ready) then
        f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8 --湮灭
    elseif buff_killing_machine>0.2 and energy>=40 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif buff_whiteFrost>0.2 then
        f.textures[0]:SetColorTexture(1, 1, 0); --3 凛风
    elseif energy>=40 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕 冰打
    elseif isBloodReady or deathReady then
        f.textures[0]:SetColorTexture(0, 0, 0); --血打
--     elseif (isFrostReady and isUnholyReady or death2Ready) then
--         f.textures[0]:SetColorTexture(1, 0.8, 0.8) --灵打
    --elseif isFrostReady then
    --    f.textures[0]:SetColorTexture(1, 0, 0); --冰触
    --elseif isUnholyReady then
    --    f.textures[0]:SetColorTexture(0, 1, 1); --暗打
    elseif cd_roar<=p940.cd_gcd then
       f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
       g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5); -- 等着
    end
end