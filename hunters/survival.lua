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
    local mwGCD = 1.5 / (UnitSpellHaste("player")/100 + 1);
    --env
    local members = GetNumGroupMembers();
    local burst_HP = 50000 * 0.8 * members;--动态20w
    if members <= 1 then --
        burst_HP = 50000;
    end
    local big_burse_HP = burst_HP * 1.5;
    local finish_HP = 5000 * 0.8 * members;--动态

    local mouseOverUnitName = select(1, UnitName("mouseover"));
    local isMouseOverExplosives = (mouseOverUnitName ~= nil and mouseOverUnitName == "爆炸物");
    local st_finalSpell = "wait";
    local aoe_finalSpell = "wait";
    --buff
    local buff_mad_bombardier = mwGetBuffTime("疯狂掷弹兵");
    local buffCount_tip_spear = mwGetBuffCount("利矛之尖");
    --debuff
    local debuff_serpent_sting = mwGetDebuffTime("毒蛇钉刺"); --毒蛇钉刺debuff
    local debuff_sanshe_bomb = mwGetDebuffTime("散射炸弹");
    local debuff_pheromone_bomb = mwGetDebuffTime("信息素炸弹");
    --cd
    local cd_duomingsheji = mwGetCoolDown("夺命射击");
    local cd_jielvesheji = mwGetCoolDown("劫掠射击");
    local cd_carve = mwGetCoolDown("削凿");
    local cd_echoshot = mwGetCoolDown("共鸣箭");
    local currentCharges_kill_command = select(1, GetSpellCharges("杀戮命令")); -- 杀戮命令 可用次数
    local fullchargetime_kill_command = select(4, GetSpellCharges("杀戮命令")) - GetTime() + select(3, GetSpellCharges("杀戮命令"));
    local currentCharges_wildfire_bomb = select(1, GetSpellCharges("野火炸弹")); -- 野火炸弹可用次数
    local fullchargetime_wildfire_bomb = select(4, GetSpellCharges("野火炸弹")) - GetTime() + select(3, GetSpellCharges("野火炸弹"));
    local cdTime_wildfire_bomb = select(4, GetSpellCharges("野火炸弹")); --野火cd时间
    local bomb_name = select(1, GetSpellInfo("野火炸弹"));
    local bomb_color;
    if bomb_name == "散射炸弹" then
        bomb_color = "blue";
    elseif bomb_name == "动荡炸弹" then
        bomb_color = "green";
    elseif bomb_name == "信息素炸弹" then
        bomb_color = "red";
    end

    --usable
    local st_cap_usable_wildfire_bomb = currentCharges_wildfire_bomb >= 2 or (currentCharges_wildfire_bomb == 1 and fullchargetime_wildfire_bomb <= mwGCD*2)
            or (currentCharges_wildfire_bomb >= 1 and buff_mad_bombardier > 0.2);
    local aoe_cap_usable_wildfire_bomb = currentCharges_wildfire_bomb >= 2 or (currentCharges_wildfire_bomb == 1 and fullchargetime_wildfire_bomb <= ygz.cd_gcd)
            or (currentCharges_wildfire_bomb >= 1 and buff_mad_bombardier > 0.2);
    local wildfire_bomb_time = 0.2 * ygz.inRange;
    if wildfire_bomb_time > 0.8 then wildfire_bomb_time = 0.8 end
    wildfire_bomb_time = wildfire_bomb_time * cdTime_wildfire_bomb;
    local aoe_usable_wildfire_bomb = currentCharges_wildfire_bomb >= 2 or (currentCharges_wildfire_bomb == 1 and fullchargetime_wildfire_bomb <= wildfire_bomb_time)
            or (currentCharges_wildfire_bomb >= 1 and buff_mad_bombardier > 0.2);
    local st_cap_usable_kill_command = ygz.focus < 90 and (currentCharges_kill_command >= 2 or currentCharges_kill_command == 1 and fullchargetime_kill_command <= mwGCD);
    local aoe_cap_usable_carve = cd_carve <= ygz.cd_gcd and ygz.focus >= 35 and
            (currentCharges_wildfire_bomb == 0 or
                (currentCharges_wildfire_bomb == 1 and fullchargetime_wildfire_bomb > 4.5)
            );
    --local carve_time = 0.5*ygz.inRange;
    --local aoe_usable_carve = cd_carve <= ygz.cd_gcd and ygz.focus >= 35 and currentCharges_wildfire_bomb <= 1 and fullchargetime_wildfire_bomb >= carve_time;
    local aoe_redbomb_kill_command = buff_mad_bombardier <= 0.01 and debuff_pheromone_bomb > 0.01;
    local aoe_kill_command = ygz.focus <= 90 and currentCharges_kill_command>=1;

    --single
    if ygz.tHealth < finish_HP then
        --单体怪没血了猛禽收尾
        f.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        st_finalSpell = "bird_hit";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 95 and members < 4 then
        -- 单人或者jjc，95血量就高优先级治疗宠物
        f.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        st_finalSpell = "heal_pet";
    elseif ygz.focus >= 20 and (debuff_serpent_sting == nil or debuff_serpent_sting <= ygz.cd_gcd) and ygz.tHealth>200000 and
            (debuff_pheromone_bomb<=0 or (buff_mad_bombardier>0.1 and bomb_color=="red")) then
        --钉刺没有先上钉刺
        f.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        st_finalSpell = "serpent_sting";
    elseif ygz.focus >= 30 and (buffCount_tip_spear>=3 and (debuff_pheromone_bomb<=0 or (buff_mad_bombardier>1.1 and bomb_color=="red")))
        or ygz.focus >= 30 and (bomb_color == "red" and buffCount_tip_spear >= 3 and
            ((currentCharges_wildfire_bomb==1 and fullchargetime_wildfire_bomb<2*mwGCD or currentCharges_wildfire_bomb==0) or buff_mad_bombardier>0.1)
            ) then
        f.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        st_finalSpell = "bird_hit";
    elseif isYgzAuto and cd_echoshot <= ygz.cd_gcd and ygz.tHealth > burst_HP then
        --爆发
        if ygz.tHealth > big_burse_HP then
            f.textures[0]:SetColorTexture(0, 0, 1)
            st_finalSpell = "big_burst"; --大爆发，共鸣箭+协同
        else
            f.textures[0]:SetColorTexture(1, 0, 1) --小爆发，共鸣箭 h
            st_finalSpell = "echo_shot";
        end
    elseif st_cap_usable_wildfire_bomb then
        -- 野火炸弹不溢出（同眼镜蛇射击）
        f.textures[0]:SetColorTexture(0, 1, 0) --野火
        st_finalSpell = "wildfire_bomb";
    elseif buff_mad_bombardier<0.2 and debuff_pheromone_bomb>0.1 and currentCharges_kill_command >= 1  then
        -- 杀戮命令
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        st_finalSpell = "kill_command";
    elseif (cd_duomingsheji <= ygz.cd_gcd and ygz.focus >= 10 and ygz.tPerHealth <= 20) then
        -- 夺命射击 （斩杀）
        f.textures[0]:SetColorTexture(1, 0, 0) -- 斩杀 z
        st_finalSpell = "kill_shot";
    elseif st_cap_usable_kill_command then
        -- 杀戮命令
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        st_finalSpell = "kill_command";
    elseif buffCount_tip_spear >= 3 or debuff_sanshe_bomb >= 0.2 then
        f.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        st_finalSpell = "bird_hit";
    elseif (debuff_serpent_sting == nil or debuff_serpent_sting <= 3.8) and ygz.tHealth>200000 then
        f.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        st_finalSpell = "serpent_sting";
    elseif ygz.focus < 90 and currentCharges_kill_command >= 1 then
        -- 杀戮命令
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        st_finalSpell = "kill_command";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 50 then
        -- 治疗宠物
        f.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        st_finalSpell = "heal_pet";
    elseif ygz.focus >= 30 then
        f.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        st_finalSpell = "bird_hit";
    else
        f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --等着
    end
    --aoe
    if ygz.tHealth < finish_HP / 20 then
        --单体怪没血了猛禽收尾 收尾血量是单体的1/5 = 1000
        g.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        aoe_finalSpell = "bird_hit";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 95 and members < 3 then
        -- 单人或者jjc，95血量就高优先级治疗宠物
        g.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        aoe_finalSpell = "heal_pet";
    elseif isYgzAuto and cd_echoshot <= ygz.cd_gcd and ygz.tHealth > burst_HP/2 then
        --爆发
        if ygz.tHealth > big_burse_HP then
            g.textures[0]:SetColorTexture(0, 0, 1)
            aoe_finalSpell = "big_burst"; --大爆发，共鸣箭+协同
        else
            g.textures[0]:SetColorTexture(1, 0, 1) --小爆发，共鸣箭 h
            aoe_finalSpell = "echo_shot";
        end
    elseif aoe_cap_usable_carve then
        g.textures[0]:SetColorTexture(0, 0.4, 0.4) --削凿
        aoe_finalSpell = "carve";
    elseif bomb_color=="red" and (debuff_serpent_sting == nil or debuff_serpent_sting <= 3.8) and (currentCharges_wildfire_bomb <= 1 and fullchargetime_wildfire_bomb>mwGCD)
        and ygz.tHealth>400000 then
        g.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        aoe_finalSpell = "serpent_sting";
    elseif aoe_cap_usable_wildfire_bomb then
        -- 野火炸弹不溢出（同眼镜蛇射击）
        g.textures[0]:SetColorTexture(0, 1, 0) --野火
        aoe_finalSpell = "wildfire_bomb";
    elseif aoe_redbomb_kill_command then
        -- 杀戮命令
        g.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        aoe_finalSpell = "kill_command";
    elseif aoe_usable_wildfire_bomb then
        --if bomb_color=="green" and debuff_serpent_sting == nil then
        --    g.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        --    aoe_finalSpell = "serpent_sting";
        --else
            g.textures[0]:SetColorTexture(0, 1, 0) --野火
            aoe_finalSpell = "wildfire_bomb";
        --end
    elseif aoe_kill_command then
        -- 杀戮命令
        g.textures[0]:SetColorTexture(0, 0, 0) --黑 致死两层 2
        aoe_finalSpell = "kill_command";
    elseif (cd_duomingsheji <= ygz.cd_gcd and ygz.focus >= 10 and ygz.tPerHealth <= 20) then
        -- 夺命射击 （斩杀）
        g.textures[0]:SetColorTexture(1, 0, 0) -- 斩杀 z
        aoe_finalSpell = "kill_shot";
    elseif (debuff_serpent_sting == nil or debuff_serpent_sting <= 3.8) and ygz.tHealth>200000 and ygz.focus>=20  then
        g.textures[0]:SetColorTexture(0, 1, 1);        --青钉刺 （同倒刺射击）
        aoe_finalSpell = "serpent_sting";
    elseif ygz.focus >= 55 then
        g.textures[0]:SetColorTexture(0.8, 0.8, 0.8);        --猛禽 （同奥术）
        aoe_finalSpell = "bird_hit";
    elseif ygz.cd_heal_pet <= ygz.cd_gcd and ygz.petPerHealth <= 80 then
        -- 治疗宠物
        g.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
        aoe_finalSpell = "heal_pet";
    else
        g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
    end


    ----打球
    --if isMouseOverExplosives then
    --    if st_finalSpell == "barbed_shot" then
    --        st_finalSpell = "mouseover_barbed_shot";
    --        f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
    --    elseif st_finalSpell == "kill_command" then
    --        st_finalSpell = "mouseover_kill_command";
    --        f.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --"666666" F10
    --    elseif st_finalSpell == "cobra_shot" then
    --        st_finalSpell = "mouseover_cobra_shot";
    --        f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
    --    end
    --
    --    if aoe_finalSpell == "barbed_shot" then
    --        aoe_finalSpell = "mouseover_barbed_shot";
    --        g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
    --    elseif aoe_finalSpell == "kill_command" then
    --        aoe_finalSpell = "mouseover_kill_command";
    --        g.textures[0]:SetColorTexture(0.4, 0.4, 0.4); --"666666" F10
    --    elseif aoe_finalSpell == "cobra_shot" then
    --        aoe_finalSpell = "mouseover_cobra_shot";
    --        g.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
    --    elseif aoe_finalSpell == "multiple_shot" then
    --        aoe_finalSpell = "mouseover_multiple_shot";
    --        g.textures[0]:SetColorTexture(0.4, 0.4, 0) --c
    --    end
    --end


end