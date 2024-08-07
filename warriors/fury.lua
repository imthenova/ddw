function dsdtFuryPlay(dstd, f, g)
    local isAuto = isYgzAuto;
    local buff_bonegrinder = mwGetBuffTime("无情碾骨"); -- 激怒buff
    local buff_YuXueFenZhan = mwGetBuffTime("浴血奋战"); -- 激怒buff
    local buff_SuiJiaMengJi = mwGetBuffTime("碎甲猛击"); -- 激怒buff
    local cd_LeiMingZhiHou = mwGetCoolDown("雷鸣之吼"); --雷鸣之吼 CD
    local cd_AoDingZhiNu = mwGetCoolDown("奥丁之怒"); --奥丁之怒 CD
    local cd_PoHuaiZhe = mwGetCoolDown("破坏者"); --破坏者 CD
    --print(buff_bonegrinder);
    --execute
    local isZhanShaPeriod = false;
    if dstd.tPerHealth <= 20 or dstd.tPerHealth >= 180 then
        isZhanShaPeriod = true;
    end
    --单体
    if (dstd.buff_cszj > 0.5 or dstd.cd_slzw <= dstd.cd_gcd) and dstd.pPerHealth <= 50 then
        --#自保 有乘胜追击buff，并且player血量低于 50%
        f.textures[0]:SetColorTexture(0, 1, 0) --绿色乘胜追击 0
    elseif isAuto and dstd.tHealth > 3000000 and cd_PoHuaiZhe <= dstd.cd_gcd then
        --#大爆发 破坏者
        f.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e&.
    elseif isAuto and dstd.tHealth > 3000000 and dstd.cd_lumang <= 0 and dstd.buff_lumang <= 0 then
        --#大爆发，鲁莽
        if dstd.cd_gcd >= 0.3 then
            f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着开鲁莽
        else
            f.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
        end
    elseif isAuto and dstd.tHealth > 2000000 and cd_LeiMingZhiHou <= dstd.cd_gcd then
            --#小爆发 龙吼
            f.textures[0]:SetColorTexture(0, 0.4, 0.4) --雷鸣之吼 ,
    elseif isAuto and dstd.tHealth > 2000000 and cd_AoDingZhiNu <= dstd.cd_gcd then
            --#小爆发 奥丁
            f.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --奥丁之怒 =
    elseif buff_YuXueFenZhan >= 0.5 and dstd.cd_sx <= dstd.cd_gcd then
        --#1有浴血奋战#1优先浴血奋战
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 ]
    elseif buff_SuiJiaMengJi >= 0.5 and dstd.currentCharges_nj >= 1 then
        --#2有碎甲猛击#2优先碎甲猛击
        f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
    elseif (dstd.buff_jn <= dstd.cd_gcd and dstd.rage >= 80) or (dstd.buff_lumang > 0 and dstd.rage >= 80) or dstd.rage >= 110 then
        --#3没有激怒或者有鲁莽时，有80怒气就放鲁莽； 如果有激怒，110怒气（85%*130）放
        f.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 ;
    elseif dstd.cd_sx <= dstd.cd_gcd then
        --#4普通嗜血 有就放
        f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 ]
    elseif dstd.cd_panzui <= dstd.cd_gcd and (isZhanShaPeriod or dstd.buff_cs > 0.5) then
        -- 斩杀阶段没激怒
        --#5斩杀阶段有就放
        f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 [
        --elseif dstd.currentCharges_nj>=2 then
        --	f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
    elseif dstd.currentCharges_nj >= 1 then
        --#6 怒击填充
        f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
    else
        --#7旋风斩填充
        f.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩 7
    end
    --AOE
    if (dstd.buff_cszj > 0.5 or dstd.cd_slzw <= dstd.cd_gcd) and dstd.pPerHealth <= 50 then
            --#自保 有乘胜追击buff，并且player血量低于 50%
            g.textures[0]:SetColorTexture(0, 1, 0) --绿色乘胜追击 0
        elseif isAuto and dstd.tHealth > 7000000 and cd_PoHuaiZhe <= dstd.cd_gcd then
            --#大爆发 破坏者
            g.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e&.
        elseif isAuto and dstd.tHealth > 7000000 and dstd.cd_lumang <= 0 and dstd.buff_lumang <= 0 then
            --#大爆发，鲁莽
            if dstd.cd_gcd >= 0.3 then
                g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着开鲁莽
            else
                g.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
            end
        elseif isAuto and dstd.tHealth > 2000000 and cd_LeiMingZhiHou <= dstd.cd_gcd then
                --#小爆发 龙吼
                g.textures[0]:SetColorTexture(0, 0.4, 0.4) --雷鸣之吼 ,
        elseif isAuto and dstd.tHealth > 2000000 and cd_AoDingZhiNu <= dstd.cd_gcd then
                --#小爆发 奥丁
                g.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --奥丁之怒 =
        elseif dstd.buff_xfz == nil or dstd.buff_xfz <= 0.5 then
                g.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩
        elseif buff_YuXueFenZhan >= 0.5 and dstd.cd_sx <= dstd.cd_gcd then
            --#1有浴血奋战#1优先浴血奋战
            g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 ]
        elseif buff_SuiJiaMengJi >= 0.5 and dstd.currentCharges_nj >= 1 then
            --#2有碎甲猛击#2优先碎甲猛击
            g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
        elseif (dstd.buff_jn <= dstd.cd_gcd and dstd.rage >= 80) or (dstd.buff_lumang > 0 and dstd.rage >= 80) or dstd.rage >= 110 then
            --#3没有激怒或者有鲁莽时，有80怒气就放鲁莽； 如果有激怒，110怒气（85%*130）放
            g.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 ;
        elseif dstd.cd_sx <= dstd.cd_gcd then
            --#4普通嗜血 有就放
            g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 ]
        elseif dstd.cd_panzui <= dstd.cd_gcd and (isZhanShaPeriod or dstd.buff_cs > 0.5) then
            -- 斩杀阶段没激怒
            --#5斩杀阶段有就放
            g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 [
            --elseif dstd.currentCharges_nj>=2 then
            --	g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
        elseif dstd.currentCharges_nj >= 1 then
            --#6 怒击填充
            g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 6
        else
            --#7旋风斩填充
            g.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩 7
        end


end