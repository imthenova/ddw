function ydybFeralPlay(ydyb, f, g)
    --buff
    local energy = UnitPower("player", 3);
    local comboPoint = GetComboPoints("player", "target");
    local debuff_lieshangbao = mwGetDebuffTime("裂伤（豹）");
    local debuff_xielve = mwGetDebuffTime("斜掠");
    local debuff_gelie = mwGetDebuffTime("割裂");
    local buff_yemanpaoxiao = mwGetBuffTime("野蛮咆哮");
    local buff_kuangbao = mwGetBuffTime("狂暴");
    local cd_item = mwGetItemCoolDown(37873);
    --single
    if debuff_lieshangbao <= 0 then
        f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
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
    else
        --CP>=1
        if buff_yemanpaoxiao <= 1 then
            f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
        elseif debuff_gelie <= 3 then
            if comboPoint < 5 then
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
        else
            if debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            elseif energy >= 90 or buff_kuangbao>0 then
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            else
                f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
            end
        end
    end

end