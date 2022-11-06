function scwArmsPlay(scw, f, g)
    local rage = UnitPower("player", 1);
    local usable_overpower = IsUsableSpell("压制");
    local usable_cszj = IsUsableSpell("乘胜追击");
    local cd_overpower = mwGetCoolDown("压制");
    local cd_zhisi = mwGetCoolDown("致死打击");
    local debuff_rend = mwGetDebuffTime("撕裂");
    --local debuff_rend = mwGetPlayerDebuffTime("撕裂");
    local buff_roar = mwGetBuffTime("战斗怒吼");
    local buff_liliang = mwGetBuffTime("力量祝福");
    local buff_qiangxiaoliliang = mwGetBuffTime("强效力量祝福");
    local buff_cs = mwGetBuffTime("猝死");
    local buff_yazhi = mwGetBuffTime("血之气息");
    local members = GetNumGroupMembers();
    local debuff_count_pojia = mwGetDebuffCount("破甲攻击");
    local debuff_pojia = mwGetDebuffTime("破甲攻击");

    if debuff_rend <= 0 and rage >= 10 then
        f.textures[0]:SetColorTexture(0, 1, 0); --撕裂
        g.textures[0]:SetColorTexture(0, 1, 0); --撕裂
    elseif scw.tMaxHealth>1000000 and scw.tHealth>1000000 and rage>=15 and debuff_pojia<=3 then
        f.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
        g.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
    elseif IsCurrentSpell("英勇打击") == false and rage >= 75 and (scw.tPerHealth <= 20 or buff_cs <= 0.2 or cd_zhisi > 1) then
        f.textures[0]:SetColorTexture(1, 0.8, 0.8); --7 英勇
        g.textures[0]:SetColorTexture(1, 0.8, 0.8); --7 英勇
    elseif buff_yazhi > 0.1 and buff_yazhi <= 5 and rage >= 5 then
        f.textures[0]:SetColorTexture(1, 0, 1); --压制
        g.textures[0]:SetColorTexture(1, 0, 1); --压制
    elseif buff_cs > 0.2 and rage >= 15 then
        f.textures[0]:SetColorTexture(0, 0, 1); --斩杀
        g.textures[0]:SetColorTexture(0, 0, 1); --斩杀
    elseif scw.tMaxHealth>1000000 and scw.tHealth>1000000 and rage>=15 and (debuff_count_pojia < 5 or debuff_pojia<=5) then
        f.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
        g.textures[0]:SetColorTexture(0, 1, 1); -- ; 破甲
    elseif (usable_overpower or buff_yazhi > 0.1) and rage >= 5 then
        f.textures[0]:SetColorTexture(1, 0, 1); --压制
        g.textures[0]:SetColorTexture(1, 0, 1); --压制
    elseif usable_cszj then
        f.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎 乘胜追击
        g.textures[0]:SetColorTexture(1, 0, 0); --3 撕碎 乘胜追击
    elseif scw.tPerHealth <= 20 then
        f.textures[0]:SetColorTexture(0, 0, 1); --割裂 斩杀
        g.textures[0]:SetColorTexture(0, 0, 1); --割裂 斩杀
    elseif buff_roar <= 20 and buff_liliang <= 20 and buff_qiangxiaoliliang<=20 then
        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); -- f9 猛虎 战吼
    elseif cd_zhisi <= scw.cd_gcd and rage >= 50 then
        f.textures[0]:SetColorTexture(0, 0, 0); -- 黑色致死
        g.textures[0]:SetColorTexture(0, 0, 0); -- 黑色致死
    elseif IsCurrentSpell("猛击") == false and rage >= 30 then
        f.textures[0]:SetColorTexture(0.8, 1, 0.8); --8 猛击
        g.textures[0]:SetColorTexture(0.8, 1, 0.8); --8 猛击
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5);
        g.textures[0]:SetColorTexture(0.5, 0.5, 0.5);
    end


end