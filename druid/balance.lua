local ydyb_cast;
function ydybBalancePlay(ydyb, f, g)
    --buff
    local moon = mwGetBuffTime("月蚀");
    local sun = mwGetBuffTime("日蚀");
    local debuff_moonlight = mwGetDebuffTime("月火术");
    local cd_jihuo = mwGetCoolDown("激活");
    local cd_item = mwGetItemCoolDown(25634);
    --single
    if cd_jihuo<=ydyb.cd_gcd and ydyb.focus<=500 then
        --激活
        f.textures[0]:SetColorTexture(0, 1, 0); --浅粉色 旋风斩 7
    elseif sun>0.1 then
        f.textures[0]:SetColorTexture(1, 0, 0);
        ydyb_cast = "愤怒";
        if cd_item<=0 then
            f.textures[0]:SetColorTexture(1, 1, 0);
        end
    elseif moon>0.1 then
        f.textures[0]:SetColorTexture(0, 0, 1);
        ydyb_cast = "星火术";
        if cd_item<=0 then
            f.textures[0]:SetColorTexture(1, 0, 1);
        end
    elseif moon==0 and sun==0 and debuff_moonlight==0 then
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