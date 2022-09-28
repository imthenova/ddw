local ydyb_cast;
local moontime = 0;
function ydybBalancePlay(ydyb, f, g)
    --buff
    local moon = mwGetBuffTime("月蚀");
    local sun = mwGetBuffTime("日蚀");
    local debuff_moonlight = mwGetDebuffTime("月火术");
    local cd_jihuo = mwGetCoolDown("激活");
    local cd_item = mwGetItemCoolDown(25634);
    local affectingCombat = UnitAffectingCombat("player");
    if ydyb.now-moontime > 15 then
        ydyb_cast = "愤怒";
    end
    --single
    if cd_jihuo<=ydyb.cd_gcd and ydyb.focus<=500 then
        --激活
        f.textures[0]:SetColorTexture(0, 1, 0); --浅粉色 旋风斩 7
    elseif sun>0.1 then
        ydyb_cast = "愤怒";
        if cd_item<=0 then
            f.textures[0]:SetColorTexture(1, 1, 0);
        else
            f.textures[0]:SetColorTexture(1, 0, 0);
        end
    elseif moon>0.1 then
        moontime=GetTime();
        ydyb_cast = "星火术";
        if cd_item<=0 then
            f.textures[0]:SetColorTexture(1, 0, 1);
        else
            f.textures[0]:SetColorTexture(0, 0, 1);
        end
    elseif moon==0 and sun==0 and debuff_moonlight==0 and affectingCombat then
    --elseif moon==0 and sun==0 and debuff_moonlight==0 then
        f.textures[0]:SetColorTexture(0, 1, 1);
    elseif cd_jihuo<=ydyb.cd_gcd and ydyb.focus<=3000 then
        --激活
        f.textures[0]:SetColorTexture(0, 1, 0); --浅粉色 旋风斩 7
    elseif ydyb_cast == nil or ydyb_cast == "愤怒" then
        f.textures[0]:SetColorTexture(1, 0, 0);
    elseif ydyb_cast=="星火术" then
        f.textures[0]:SetColorTexture(0, 0, 1);
    end

end