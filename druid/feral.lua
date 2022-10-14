function ydybFeralPlay(ydyb, f, g)
    --buff
    local energy = UnitPower("player", 3);
    local comboPoint = GetComboPoints("player", "target");
    local debuff_lieshangbao = mwGetDebuffTime("裂伤（豹）");
    local debuff_xielve = mwGetDebuffTime("斜掠");
    local debuff_gelie = mwGetDebuffTime("割裂");
    local buff_yemanpaoxiao = mwGetBuffTime("野蛮咆哮");
    local buff_kuangbao = mwGetBuffTime("狂暴");
    local buff_jienengshifa = mwGetBuffTime("节能施法");
    local cd_item = mwGetItemCoolDown(37873);
    local cd_kuangbao = mwGetCoolDown("狂暴");
    local cd_menghu = mwGetCoolDown("猛虎之怒");
    --single

    if isYgzAuto and cd_menghu>10 and energy>80 and cd_kuangbao<=ydyb.cd_gcd and (buff_yemanpaoxiao<10 or debuff_gelie<10 or comboPoint<=2) then
        --狂暴
        f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
    elseif isYgzAuto and cd_menghu<=ydyb.cd_gcd and (energy>20 or cd_kuangbao>ydyb.cd_gcd+1) and energy<35
    --        and (buff_yemanpaoxiao<10 or debuff_gelie<10 or comboPoint<=2)
    then
        --猛虎
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎
    elseif debuff_lieshangbao <= 4 then
        f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
    elseif buff_jienengshifa>0.1 and comboPoint < 5 then
        f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
    elseif comboPoint <= 0 then
        if energy >= 40 then
            if debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
        else
            --变熊
            f.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
        end
    elseif buff_yemanpaoxiao <= 0.5 then
        f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
        --CP>=1
    elseif debuff_gelie <= 4 then
        if comboPoint < 5 or energy>95 then
            if debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
        else
            if debuff_gelie <= 0 then
                f.textures[0]:SetColorTexture(0, 0, 1); --割裂
            else
                f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
            end
        end
    elseif buff_yemanpaoxiao <= 20 and comboPoint >= 5 then
        if energy>90 then
            f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
        else
            if debuff_xielve <= 0 and buff_yemanpaoxiao>10 and debuff_gelie>10 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
            end
        end
    else
        if debuff_xielve <= 0 then
            f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
        elseif comboPoint<5 and (energy> math.max(25-debuff_xielve*10,0) + 42) then
            f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
        elseif energy >= 95 or buff_kuangbao>0 or buff_jienengshifa>0 then
            f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
        else
            f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
        end
    end

end