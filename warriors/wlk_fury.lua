function scwFuryPlay(scw, f, g)
    local rage = UnitPower("player", 1);
    local usable_cszj = IsUsableSpell("乘胜追击");
    local cd_xuanfengzhan = mwGetCoolDown("旋风斩");
    local cd_sx = mwGetCoolDown("嗜血");
    local cd_deathwish = mwGetCoolDown("死亡之愿");
    local cd_xxkb = mwGetCoolDown("血性狂暴");
    local buff_roar = mwGetBuffTime("战斗怒吼");
    local buff_liliang = mwGetBuffTime("力量祝福");
    local buff_qiangxiaoliliang = mwGetBuffTime("强效力量祝福");
    local buff_xueyong = mwGetBuffTime("猛击！");
    local buff_deathwish = mwGetBuffTime("死亡之愿");
    local buff_yazhi = mwGetBuffTime("血之气息");
    local members = GetNumGroupMembers();
    local debuff_count_pojia = mwGetDebuffCount("破甲攻击");
    local debuff_pojia = mwGetDebuffTime("破甲攻击");

    if cd_xxkb <= 0 and rage<48 then
        f.textures[0]:SetColorTexture(0.8, 0.8, 0.8); -- = 血性狂暴
        g.textures[0]:SetColorTexture(0.8, 0.8, 0.8); -- = 血性狂暴
    elseif IsCurrentSpell("英勇打击") == false and IsCurrentSpell("顺劈斩") == false and
            (rage >= 50 or (rage>=45 and buff_deathwish>=1)) then
        f.textures[0]:SetColorTexture(1, 0.8, 0.8); --7 英勇
        g.textures[0]:SetColorTexture(0, 0.4, 0.4); --, 顺劈
    elseif IsCurrentSpell("英勇打击") == true and (rage < 40 or (rage<=30 and buff_deathwish>=1)) then
        f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --7 英勇
        g.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --7 英勇
    elseif scw.tMaxHealth > 3000000 and scw.tHealth > 200000 and rage >= 15 and debuff_pojia <= 4 then
        f.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
        g.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
    elseif cd_deathwish<=scw.cd_gcd and rage >= 20 and isYgzAuto then
        f.textures[0]:SetColorTexture(1, 0, 1); --爆发 h 死亡之愿
        g.textures[0]:SetColorTexture(1, 0, 1); --爆发 h 死亡之愿
    elseif usable_cszj then
        f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎 乘胜追击
        g.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎 乘胜追击
    elseif buff_xueyong >= 0.2 and rage >= 15 and cd_sx > 0.5 then
        f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8 猛击
        g.textures[0]:SetColorTexture(0.8, 1, 0.8); --8 猛击
    elseif cd_sx <= scw.cd_gcd and rage >= 20 then
        if isYgzAuto then
            f.textures[0]:SetColorTexture(0.4, 0.4, 0.4); -- 黑色嗜血
            g.textures[0]:SetColorTexture(0.4, 0.4, 0.4); -- 黑色嗜血
        else
            f.textures[0]:SetColorTexture(0, 0, 0); -- 黑色嗜血
            g.textures[0]:SetColorTexture(0, 0, 0); -- 黑色嗜血
        end
    elseif cd_xuanfengzhan <= scw.cd_gcd and rage >= 25 and cd_sx > 0.5 then
        f.textures[0]:SetColorTexture(0, 1, 0); -- 旋风斩
        g.textures[0]:SetColorTexture(0, 1, 0); -- 旋风斩
    elseif scw.tMaxHealth > 3000000 and scw.tHealth > 200000 and rage >= 15 and (debuff_count_pojia < 5 or debuff_pojia <= 5.8) then
        f.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
        g.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
    elseif scw.tPerHealth <= 20 and rage >= 40 and cd_sx > 0.5 then
        f.textures[0]:SetColorTexture(0, 0, 1); --割裂 斩杀
        g.textures[0]:SetColorTexture(0, 0, 1); --割裂 斩杀
    elseif buff_roar <= 20 and buff_liliang <= 20 and buff_qiangxiaoliliang <= 20 then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5);
        g.textures[0]:SetColorTexture(0.5, 0.5, 0.5);
    end


    if cd_xuanfengzhan <= scw.cd_gcd and rage >= 25 then
        g.textures[0]:SetColorTexture(0, 1, 0); -- 旋风斩
    end

end