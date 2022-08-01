function ygzSurvivalPlay(ygz, f, g)
    --play
    local buff_petaoe = 0;
    for i = 1, 20 do
        local n, _, _, _, _, x = UnitBuff("pet", i);
        if n ~= neil and n == "野兽顺劈" then
            buff_petaoe = x - GetTime();
            break ;
        end
    end
    --env
    local members = GetNumGroupMembers();
    local outburst_HP = 35000 * 0.8 * members;--动态
    if members <= 1 then
        bestial_wrath_HP = 70000;
    end
    local mouseOverUnitName = select(1, UnitName("mouseover"));
    local isMouseOverExplosives = (mouseOverUnitName ~= nil and mouseOverUnitName == "爆炸物");
    local st_finalSpell = "wait";
    local aoe_finalSpell = "wait";
    --buff
    local buff_mad_bombardier = mwGetBuffTime("疯狂掷弹兵");
    --debuff
    local debuff_serpent_sting = mwGetDebuffTime("毒蛇钉刺"); --毒蛇钉刺debuff
    local cd_jielvesheji = mwGetCoolDown("劫掠射击"); --劫掠射击 cd
    local cd_echoshot = mwGetCoolDown("共鸣箭"); --共鸣箭 cd
    local cd_anfu = mwGetCoolDown("宁神射击"); --安抚 cd
    --cd
    local cd_duomingsheji = mwGetCoolDown("夺命射击"); --夺命射击 斩杀 cd
    local currentCharges_wildfire_bomb = select(1, GetSpellCharges("野火炸弹")); -- 野火炸弹可用次数
    local fullchargetime_wildfire_bomb = select(4, GetSpellCharges("野火炸弹")) - GetTime() + select(3, GetSpellCharges("野火炸弹"));
    local bomb_name = select(1, GetSpellInfo("野火炸弹"));
    local bomb_color;
    if bomb_name=="散射炸弹" then
        bomb_color = "blue";
    elseif bomb_name=="动荡炸弹" then
        bomb_color = "green";
    elseif bomb_name=="信息素炸弹" then
        bomb_color = "red";
    end
    --usable
    local st_cap_usable_wildfire_bomb = currentCharges_wildfire_bomb >= 2 or (currentCharges_wildfire_bomb == 1 and fullchargetime_wildfire_bomb <= 2*ygz.gcd)
            and buff_mad_bombardier > 0.2;
    --single
    if ygz.focus >= 20 and debuff_serpent_sting <= ygz.cd_gcd then
        --钉刺没有先上钉刺
        f.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        st_finalSpell = "serpent_sting";
    elseif isYgzAuto and cd_echoshot <= ygz.cd_gcd then --回响爆发
        f.textures[0]:SetColorTexture(0, 0, 1)
        st_finalSpell = "echo_shot";
    elseif st_cap_usable_wildfire_bomb then -- 野火炸弹不溢出（同眼镜蛇射击）
        f.textures[0]:SetColorTexture(0, 1, 1);
        st_finalSpell = "wildfire_bomb";
    elseif buff_jielvezhe_mark >= 0.2 or (cd_duomingsheji <= ygz.cd_gcd and ygz.focus >= 10 and ygz.tPerHealth <= 20) then
        -- 夺命射击 （斩杀）
        f.textures[0]:SetColorTexture(1, 0, 0) -- 斩杀 z
        st_finalSpell = "kill_shot";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 95 and members < 5 then
        -- 单人或者jjc，95血量就高优先级治疗宠物
        f.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        st_finalSpell = "heal_pet";
    elseif ygz.buff_pet_barbed_shot <= 1.315 + 0.4 and ygz.currentCharges_barbed_shot >= 1 then
        -- 倒刺设计没有补
        if ygz.buff_pet_barbed_shot >= 0.5 then
            f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
        else
            f.textures[0]:SetColorTexture(0, 1, 1);        --青 倒刺射击
            st_finalSpell = "barbed_shot";
        end
    elseif cd_echoshot >= 20 and ygz.cd_bestial_wrath <= ygz.cd_gcd and (isYgzAuto or ygz.tHealth >= bestial_wrath_HP) then
        -- 狂野怒火好了就用
        f.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
        st_finalSpell = "bestial_wrath";
    elseif ygz.cd_kill_command <= ygz.cd_gcd then
        -- 杀戮命令
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        st_finalSpell = "kill_command";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 80 then
        -- 治疗宠物
        f.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        st_finalSpell = "heal_pet";
    elseif ygz.focus >= 50 and ygz.focus - 35 >= 30 - max(ygz.cd_kill_command - ygz.cd_gcd - 1, 0) * 8 then
        f.textures[0]:SetColorTexture(0, 1, 0) --绿色 猛击 5
        st_finalSpell = "cobra_shot";
    end
    --aoe
    if isYgzAuto and cd_echoshot <= ygz.cd_gcd then
        -- 劫掠射击
        g.textures[0]:SetColorTexture(0, 0, 1) --蓝色巨龙 .
        aoe_finalSpell = "echo_shot";
    elseif ygz.currentCharges_barbed_shot >= 2 or (ygz.currentCharges_barbed_shot >= 1 and
            (cd_echoshot >= 20 and ygz.cd_bestial_wrath <= ygz.cd_gcd and (isYgzAuto or ygz.tHealth >= bestial_wrath_HP))) then
        -- 倒刺射击不溢出
        g.textures[0]:SetColorTexture(0, 1, 1) --青 倒刺射击
        aoe_finalSpell = "barbed_shot";
    elseif ygz.buff_pet_barbed_shot <= 1.315 + 0.4 and ygz.currentCharges_barbed_shot >= 1 then
        -- 倒刺设计没有补
        if ygz.buff_pet_barbed_shot >= 0.5 then
            g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
        else
            g.textures[0]:SetColorTexture(0, 1, 1) --青 倒刺射击
            aoe_finalSpell = "barbed_shot";
        end
    elseif cd_echoshot >= 20 and ygz.cd_bestial_wrath <= ygz.cd_gcd and (isYgzAuto or ygz.tHealth >= bestial_wrath_HP) then
        -- 狂野怒火好了就用
        g.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
        aoe_finalSpell = "bestial_wrath";
    elseif buff_petaoe <= 1.315 + 0.4 and ygz.focus >= 40 then
        -- 多重射击
        if buff_petaoe >= 0.5 then
            g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
        else
            g.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 剑刃风暴 ·
            aoe_finalSpell = "multiple_shot";
        end
    elseif buff_jielvezhe_mark >= 0.2 or (cd_duomingsheji <= ygz.cd_gcd and ygz.focus >= 10 and ygz.tPerHealth <= 20) then
        -- 夺命射击 （斩杀）
        g.textures[0]:SetColorTexture(1, 0, 0) -- 斩杀 z
        aoe_finalSpell = "kill_shot";
    elseif ygz.cd_kill_command <= ygz.cd_gcd then
        -- 杀戮命令
        g.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        aoe_finalSpell = "kill_command";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 80 then
        -- 治疗宠物
        g.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        aoe_finalSpell = "heal_pet";
    elseif ygz.focus >= 80 or (ygz.focus >= 70 and buff_yexingshouhu > 1) then
        g.textures[0]:SetColorTexture(0, 1, 0) --绿色 猛击 5
        aoe_finalSpell = "cobra_shot";
    else
        g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
    end

    --打球
    if isMouseOverExplosives then
        if st_finalSpell == "barbed_shot" then
            st_finalSpell = "mouseover_barbed_shot";
            f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
        elseif st_finalSpell == "kill_command" then
            st_finalSpell = "mouseover_kill_command";
            f.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --"666666" F10
        elseif st_finalSpell == "cobra_shot" then
            st_finalSpell = "mouseover_cobra_shot";
            f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
        end

        if aoe_finalSpell == "barbed_shot" then
            aoe_finalSpell = "mouseover_barbed_shot";
            g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
        elseif aoe_finalSpell == "kill_command" then
            aoe_finalSpell = "mouseover_kill_command";
            g.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --"666666" F10
        elseif aoe_finalSpell == "cobra_shot" then
            aoe_finalSpell = "mouseover_cobra_shot";
            g.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
        elseif aoe_finalSpell == "multiple_shot" then
            aoe_finalSpell = "mouseover_multiple_shot";
            g.textures[0]:SetColorTexture(0.4, 0.4, 0) --c
        end
    end
    --驱散激怒
    local debuff_baonu = mwGetTargetBuff(228318);

    if debuff_baonu >= 1 and cd_anfu <= ygz.cd_gcd then
        if st_finalSpell ~= "barbed_shot" then
            st_finalSpell = "anfu";
            f.textures[0]:SetColorTexture(0.8, 0.8, 0.8); --"CCCCCC" F12
        end

        if aoe_finalSpell ~= "barbed_shot" then
            aoe_finalSpell = "anfu";
            g.textures[0]:SetColorTexture(0.8, 0.8, 0.8); --"CCCCCC" F12
        end
    end


end