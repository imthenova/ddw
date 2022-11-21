function p940FrostPlay(p940, f, g)
    --buff
    local energy = UnitPower("player");
    local blood1CD = select(3,GetRuneCooldown(1));
    local blood2CD = select(3,GetRuneCooldown(2));
    local frost1CD = select(3,GetRuneCooldown(5));
    local frost2CD = select(3,GetRuneCooldown(6));
    local unholy1CD = select(3,GetRuneCooldown(3));
    local unholy2CD = select(3,GetRuneCooldown(4));
    local isBloodReady =  blood1CD or blood2CD;
    local isBloodBothReady =  blood1CD and blood2CD;
    local isFrostReady =  frost1CD or frost2CD;
    local isFrostBothReady =  frost1CD and frost2CD;
    local isUnholyReady =  unholy1CD or unholy2CD;
    local isUnholyBothReady =  unholy1CD and unholy2CD;
    local debuf_frost = mwGetPlayerDebuffTime("冰霜疫病");
    local debuf_blood = mwGetPlayerDebuffTime("血之疫病");
    if energy >=90 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕
    elseif debuf_frost <=0 and isFrostReady then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif debuf_blood <=0 and isUnholyReady then
        f.textures[0]:SetColorTexture(0, 1, 1); --暗打
    elseif isBloodReady then
        f.textures[0]:SetColorTexture(0, 0, 0); --血打
    elseif isUnholyReady then
        f.textures[0]:SetColorTexture(0, 1, 1); --暗打
    elseif isFrostReady then
        f.textures[0]:SetColorTexture(1, 0, 0); --冰触
    elseif energy >=40 then
        f.textures[0]:SetColorTexture(0, 0, 1); --缠绕
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5);
    end
end