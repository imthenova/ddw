

local function isZhanShaPeriod(dstd)
    return dstd.tPerHealth <= 20 or dstd.tPerHealth >= 180
end

local function setTextureColor(texture, r, g, b)
    texture:SetColorTexture(r, g, b)
end

local function handleTarget(dstd, texture, isAuto, buffs, cds, healthThreshold, isAOE)
    if (dstd.buff_cszj > 0.5 or dstd.cd_slzw <= dstd.cd_gcd) and dstd.pPerHealth <= 50 then
        --#自保 有乘胜追击buff，并且player血量低于 50%
        setTextureColor(texture, 0, 1, 0) --绿色乘胜追击 0
    elseif isAuto and dstd.tHealth > 3000000 and cds.poHuaiZhe <= dstd.cd_gcd then
        --#大爆发 破坏者
        setTextureColor(texture, 0, 0, 1) --蓝 巨龙 e&.
    elseif isAuto and dstd.tHealth > 3000000 and dstd.cd_lumang <= 0 and dstd.buff_lumang <= 0 then
        --#大爆发，鲁莽
        if dstd.cd_gcd >= 0.3 then
            setTextureColor(texture, 0.5, 0.5, 0.5) --gcd>=0.3 等着开鲁莽
        else
            setTextureColor(texture, 1, 0, 1) --紫色鲁莽 h
        end
    elseif isAuto and dstd.tHealth > 2000000 and cds.leiMingZhiHou <= dstd.cd_gcd then
        --#小爆发 龙吼
        setTextureColor(texture, 0, 0.4, 0.4) --雷鸣之吼 ,

    elseif isAuto and dstd.tHealth > 2000000 and cds.aoDingZhiNu <= dstd.cd_gcd then
        --#小爆发 奥丁
        setTextureColor(texture, 0.8, 0.8, 0.8) --奥丁之怒 =
    elseif isAOE and dstd.buff_xfz == nil or dstd.buff_xfz <= 0.5 then
        --只有AOE走的流程，AOE补旋风斩buff
        setTextureColor(texture, 1, 0.8, 0.8) --藏青 旋风斩 7
    elseif buffs.poHuaiZhe <= 0.5 and buffs.yuXueFenZhan >= 0.5 and dstd.cd_sx <= dstd.cd_gcd then
        --#1有浴血奋战#1优先浴血奋战
        --破坏者期间不主动使用，让破坏者自动触发浴血奋战
        setTextureColor(texture, 0, 0, 0) --黑 嗜血 ]
    elseif buffs.suiJiaMengJi >= 0.5 and dstd.currentCharges_nj >= 1 then
        --#2有碎甲猛击#2优先碎甲猛击
        setTextureColor(texture, 0.4, 0, 0.4) --黄 怒击 6
    elseif (dstd.buff_jn <= dstd.cd_gcd and dstd.rage >= 80) or (dstd.buff_lumang > 0 and dstd.rage >= 80) or dstd.rage >= 110 then
        --#3没有激怒或者有鲁莽时，有80怒气就放鲁莽； 如果有激怒，110怒气（85%*130）放
        setTextureColor(texture, 0, 1, 1) --青 暴怒 ;
    elseif dstd.cd_sx <= dstd.cd_gcd then
        --#4普通嗜血 有就放
        setTextureColor(texture, 0, 0, 0) --黑 嗜血 ]
    elseif dstd.cd_panzui <= dstd.cd_gcd and (isZhanShaPeriod(dstd) or dstd.buff_cs > 0.5) then
        -- 斩杀阶段没激怒
        --#5斩杀阶段有就放
        setTextureColor(texture, 1, 0, 0) --红 斩杀 [
        --elseif dstd.currentCharges_nj>=2 then
        --	setTextureColor(texture, 0.4, 0, 0.4) --黄 怒击 6
    elseif dstd.currentCharges_nj >= 1 then
        --#6 怒击填充
        setTextureColor(texture, 0.4, 0, 0.4) --黄 怒击 6
    else
        --#7旋风斩填充
        setTextureColor(texture, 1, 0.8, 0.8) --藏青 旋风斩 7
    end
end



function dsdtFuryPlay(dstd, f, g)
    local buffs = {
        yuXueFenZhan = mwGetBuffTime("浴血奋战"),
        suiJiaMengJi = mwGetBuffTime("碎甲猛击"),
        poHuaiZhe = mwGetBuffTime("破坏者")
    }
    local cds = {
        leiMingZhiHou = mwGetCoolDown("雷鸣之吼"),
        aoDingZhiNu = mwGetCoolDown("奥丁之怒"),
        poHuaiZhe = mwGetCoolDown("破坏者")
    }
    --execute
    handleTarget(dstd, f.textures[0], isYgzAuto, buffs, cds, 4000000, false)
    handleTarget(dstd, g.textures[0], isYgzAuto, buffs, cds, 2000000, true)
end