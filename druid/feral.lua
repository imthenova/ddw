function ydybFeralPlay(ydyb, f, g)
    --buff
    local energy = UnitPower("player", 3);
    local rage = UnitPower("player", 1);
    local comboPoint = GetComboPoints("player", "target");
    local debuff_lieshangbao = mwGetDebuffTime("裂伤（豹）");
    local debuff_lieshangxiong = mwGetDebuffTime("裂伤（熊）");
    local debuff_chuangshang = mwGetDebuffTime("创伤");
    local debuff_xielve = mwGetPlayerDebuffTime("斜掠");
    local debuff_gelie = mwGetPlayerDebuffTime("割裂");
    local buff_yemanpaoxiao = mwGetBuffTime("野蛮咆哮");
    local buff_kuangbao = mwGetBuffTimeById(50334); -- 狂暴

    local buff_jienengshifa = mwGetBuffTime("节能施法");
    local buff_jinu = mwGetBuffTime("激怒");
    local cd_jinu = mwGetCoolDown("激怒");
    local cd_item = mwGetItemCoolDown(37873);
    local cd_kuangbao = mwGetCoolDown("狂暴");
    local cd_menghu = mwGetCoolDown("猛虎之怒");
    local cd_jinglingzhihuo = mwGetCoolDown("精灵之火（野性）");
    local cd_lieshangxiong = mwGetCoolDown("裂伤（熊）");
    local debuff_count_geshang = mwGetPlayerDebuffCount("割伤");
    local debuff_geshang = mwGetPlayerDebuffTime("割伤");
    local nStance = GetShapeshiftForm();
    if nStance == 3 then
        rage = 10;
        if isYgzAuto and cd_menghu > 10 and energy > 60 and cd_kuangbao <= ydyb.cd_gcd and (buff_yemanpaoxiao < 10 or debuff_gelie < 10 or comboPoint <= 2) then
            --狂暴
            f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
        elseif isYgzAuto and cd_menghu <= 0.5 and (energy > 20 or cd_kuangbao > ydyb.cd_gcd + 1) and energy < 35
        --and (buff_yemanpaoxiao<10 or debuff_gelie<10)
        --        and (buff_yemanpaoxiao<10 or debuff_gelie<10 or comboPoint<=2)
        then
            --猛虎
            f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎
        elseif debuff_lieshangbao <= 0 and debuff_chuangshang <= 0 and debuff_lieshangxiong <= 0 then
            f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
        elseif buff_jienengshifa > 0.2 then
            if comboPoint == 5 and debuff_gelie == 0 then
                f.textures[0]:SetColorTexture(0, 0, 1); --割裂
            elseif comboPoint == 5 and buff_yemanpaoxiao == 0 then
                f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
            elseif debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
            --elseif energy<=30 and buff_kuangbao<=0.1 and (comboPoint>=5 and debuff_gelie<=ydyb.cd_gcd+1.5)==false then
        elseif energy <= 34 and buff_kuangbao <= 1 then
            f.textures[0]:SetColorTexture(1, 0.8, 0.8)--变熊
        elseif comboPoint <= 0 then
            if debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
        elseif buff_yemanpaoxiao <= 0.5 and energy >= 60 then
            f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
            --CP>=1
        elseif (debuff_gelie >= 15 and buff_yemanpaoxiao >= 15 and comboPoint >= 5 and (cd_menghu < 10 or buff_kuangbao > 1)) or (ydyb.tHealth < 100000 and comboPoint >= 5) then
            f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --f11 凶猛撕咬
        elseif debuff_gelie <= 3 then
            if comboPoint < 5 then
                if debuff_xielve <= 0 then
                    f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
                else
                    f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
                end
            elseif debuff_gelie <= 0 then
                f.textures[0]:SetColorTexture(0, 0, 1); --割裂
            elseif energy > 95 and debuff_gelie > 1 then
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
        elseif buff_yemanpaoxiao <= 16 and comboPoint >= 5 then
            if energy > 85 or buff_kuangbao >= 2 then
                f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
            else
                if debuff_xielve <= 0 and buff_yemanpaoxiao > 10 and debuff_gelie > 10 then
                    f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
                elseif energy > 70 then
                    f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
                elseif energy <= 35 then
                    f.textures[0]:SetColorTexture(1, 0.8, 0.8)--变熊
                else
                    f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
                end
            end
        elseif debuff_lieshangbao <= 6 and debuff_chuangshang <= 0 and debuff_lieshangxiong <= 0 then
            f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
        else
            if debuff_xielve <= 0 then
                f.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            elseif comboPoint < 5 and (energy > math.max(25 - debuff_xielve * 10, 0) + 42) then
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            elseif energy >= 50 or buff_kuangbao > 0 or buff_jienengshifa > 0 then
                f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            elseif comboPoint == 5 and energy < 50 then
                f.textures[0]:SetColorTexture(1, 0.8, 0.8)--变熊
                --f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
                --f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
        end
    else
        if (buff_jienengshifa > 0.5 and energy > 60) or energy > 80 or (debuff_gelie <= ydyb.cd_gcd and comboPoint >= 4 and energy > 55) then
            f.textures[0]:SetColorTexture(1, 0.8, 0.8)
        elseif cd_jinu <= ydyb.cd_gcd then
            f.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
        elseif IsCurrentSpell("重殴") == false and (rage >= 38 or buff_jienengshifa >= 1) then
            f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
        elseif IsCurrentSpell("重殴") and rage <= 13 and (debuff_geshang < 9 or debuff_count_geshang < 5) and buff_jienengshifa <= 0 then
            f.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --f10 取消
        elseif rage >= 13 and (debuff_count_geshang >= 5 and debuff_geshang < 9 or debuff_count_geshang < 5) then
            f.textures[0]:SetColorTexture(0, 1, 1);
            --elseif debuff_count_geshang<5 or debuff_geshang<8 or energy>70 then
            --    f.textures[0]:SetColorTexture(0, 1, 1);
        elseif IsCurrentSpell("重殴") == false and rage >= 10 and debuff_geshang > 9 and debuff_count_geshang >= 5 then
            f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
        elseif rage >= 15 and cd_lieshangxiong <= ydyb.cd_gcd then
            f.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
        end
    end

    --aoe
    if nStance == 3 then
        if isYgzAuto and cd_menghu > 22 and cd_kuangbao <= ydyb.cd_gcd  then
            --狂暴
            g.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
        elseif isYgzAuto and cd_menghu <= 0.5 and (energy > 20 or cd_kuangbao > ydyb.cd_gcd + 1) and energy < 35
        --and (buff_yemanpaoxiao<10 or debuff_gelie<10)
        --        and (buff_yemanpaoxiao<10 or debuff_gelie<10 or comboPoint<=2)
        then
            --猛虎
            g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎
        elseif isYgzAuto and comboPoint <= 0 and buff_yemanpaoxiao <= 0.5 then
            if debuff_xielve <= 0 then
                g.textures[0]:SetColorTexture(0, 1, 0); --斜掠
            else
                g.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎
            end
        elseif isYgzAuto and buff_yemanpaoxiao <= 0.5 and energy > 40 then
            g.textures[0]:SetColorTexture(1, 0, 1); --野蛮咆哮
            --CP>=1
        elseif energy < 40 and cd_menghu <= 0.5 then
            g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎
        elseif energy > 40 or buff_jienengshifa > 0.5 or (energy>20 and buff_kuangbao>0.1) then
            g.textures[0]:SetColorTexture(0.8, 0.8, 0.8); -- = 横扫
        else
            g.textures[0]:SetColorTexture(1, 0.8, 0.8)--变熊
        end
    elseif nStance == 1 then
        if cd_jinu <= ydyb.cd_gcd and rage < 15 then
            g.textures[0]:SetColorTexture(1, 0, 1); --激怒
        elseif IsCurrentSpell("重殴") == false and rage>39 then
            g.textures[0]:SetColorTexture(0.8, 1, 0.8); --8
        elseif buff_kuangbao>0.1 then
            g.textures[0]:SetColorTexture(1, 1, 0); --3 裂伤
        elseif buff_jienengshifa > 1.5 or energy > 86 then
            g.textures[0]:SetColorTexture(1, 0.8, 0.8)
        else
            g.textures[0]:SetColorTexture(0.8, 0.8, 0.8); -- = 横扫
        end
    end

end