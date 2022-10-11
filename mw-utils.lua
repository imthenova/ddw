function mwGetBuffTime(spellName)
	local expirationTime_buff = select(6,AuraUtil.FindAuraByName(spellName,"player",'HELPFUL'));--buff
	local buffTime=0; --buff持续时间
	if (expirationTime_buff~=nil and expirationTime_buff~=0) then
		buffTime= expirationTime_buff - GetTime();
	end
	return buffTime;
end
function mwGetPetBuffTime(spellName)
	local expirationTime_buff = select(6,AuraUtil.FindAuraByName(spellName,"pet",'HELPFUL'));--buff
	local buffTime=0; --buff持续时间
	if (expirationTime_buff~=nil and expirationTime_buff~=0) then
		buffTime= expirationTime_buff - GetTime();
	end
	return buffTime;
end

function mwGetDebuffTime(spellName)
	local expirationTime_buff = select(6,AuraUtil.FindAuraByName(spellName,"target",'HARMFUL'));--debuff
	local debuffTime=0; --debuff持续时间
	if (expirationTime_buff ~=nil and expirationTime_buff ~=0) then
		debuffTime = expirationTime_buff - GetTime();
	end
	return debuffTime;
end

function mwGetDebuffCount(spellName)
	local count = select(3,AuraUtil.FindAuraByName(spellName,"target",'HARMFUL'));--debuff
	local debuffCount=0; --debuff持续时间
	if (count ~=nil and count ~=0) then
		debuffCount = count;
	end
	return debuffCount;
end

function mwGetTargetBuff(spellName)
	local expirationTime_buff = select(6,AuraUtil.FindAuraByName(spellName,"target"));--debuff
	local debuffTime=0; --debuff持续时间
	if (expirationTime_buff ~=nil and expirationTime_buff ~=0) then
		debuffTime = expirationTime_buff - GetTime();
	end
	return debuffTime;
end

function mwGetCoolDown(spellName)
	local start,durantion,enable=GetSpellCooldown(spellName); -- CD
	local cd=0;
	if (start~=nil and start~=0) then
		cd=durantion + start - GetTime();
	end
	return cd;
end

function mwGetItemCoolDown(itemID)
	local start,durantion,enable=GetItemCooldown(itemID); -- CD
	local cd=0;
	if (start~=nil and start~=0) then
		cd=durantion + start - GetTime();
	end
	return cd;
end

function mwGetBuffCount(spellName)
	local count = select(3,AuraUtil.FindAuraByName(spellName,"player",'HELPFUL'));--buff 层数
	if count == nil then
		count = 0;
	end
	return count;
end

function mwBuffCheck(...)
	local buffNameList={...};    
	local result = 0;
	local string = "Lack buff:"
	for i,v in ipairs(buffNameList) do
		local buffTime = mwGetBuffTime(v);
		if buffTime == 0 then
			result = result+i;
			string = string..v..",";
		end
	end
	local hasMainHandEnchant,mainHandExpiration,mainHandCharges,mainHandEnchantID,hasOffHandEnchant,offHandExpiration,offHandCharges,offHandEnchantID = GetWeaponEnchantInfo();
	
	local currentSpec = GetSpecialization();
	local currentSpecName = select(2, GetSpecializationInfo(currentSpec));
	if currentSpec==2 then -- 2 是狂怒
		if hasMainHandEnchant == false then
			string = string.."MainHand,";
			result = result+1;
		end
		if hasOffHandEnchant == false then
			string = string.."OffHand,";
			result = result+1;
		end	
	else
		if hasMainHandEnchant == false then
			string = string.."MainHand,";
			result = result+1;
		end
	end
	
	if result==0 then 
		print("all buffed");
	else 
		print(string);
	end
end