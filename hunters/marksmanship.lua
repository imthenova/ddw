function ygzMarksmanshipPlay(ygz,f,g)
		--play
		--big cds
		local cd_doubletap=mwGetCoolDown("二连发"); --二连发 cd
		local cd_explosiveshot=mwGetCoolDown("爆炸射击"); --二连发 cd
		local cd_echoshot=mwGetCoolDown("共鸣箭"); --野性之魂 cd
		local cd_volley=mwGetCoolDown("乱射"); --乱射 cd
		local cd_trueshot=mwGetCoolDown("百发百中"); --百发百中 cd
		--small cds
		local currentCharges_aimedshot = select(1,GetSpellCharges("瞄准射击")); -- 瞄准射击charge
		local cd_aimedshot=mwGetCoolDown("瞄准射击"); --瞄准射击 cd
		local cd_rapidfire=mwGetCoolDown("急速射击"); --急速射击 cd
		local cd_killshot=mwGetCoolDown("夺命射击"); --夺命射击 cd
		--buff
		local buff_preciseshot=mwGetBuffTime("弹无虚发"); -- 弹无虚发 (奥术/多重高亮）buff
		local buff_trueshot=mwGetBuffTime("百发百中"); -- 百发百中buff
		local buff_trickshots=mwGetBuffTime("技巧射击"); -- 技巧射击 (aoe弹射）buff //257622 小技巧
		local buff_volley=mwGetBuffTime("乱射"); -- 乱射 大技巧
		--member
		local members = GetNumGroupMembers();
		local bestial_wrath_HP = 60000*0.8*members;--动态
		if members <=1 then 
			bestial_wrath_HP = 70000;
		end
		--引导Channel
		local spellname,_,_,starttime,endtime = UnitCastingInfo("player");
		local channelName = select(1,UnitChannelInfo("player"));
		
		--aoe usable
		local fullchargetime_aimedshot = select(4,GetSpellCharges("瞄准射击"))-GetTime()+select(3,GetSpellCharges("瞄准射击"));
		local aoe_usable_doubletap = (cd_doubletap<=ygz.cd_gcd and (cd_echoshot<=ygz.cd_gcd*2 or cd_echoshot>30)); --*二连发：野性之魂好了 or 野性之魂cd>30  1m
		-----------*************TODO! 完全充能代码是否好用
		local aoe_usable_aimedshot = currentCharges_aimedshot>=1 and ygz.focus>=35 --最少一层充能且35集中制
					and (buff_trickshots>2.5 or buff_volley>2.5) --只有技巧射击buff才使用
					and (buff_preciseshot<=ygz.cd_gcd or buff_trueshot>0.1 or (currentCharges_aimedshot==1 and fullchargetime_aimedshot<=3) ); --百发百中up or 非高亮 or  瞄准充满时间小于3秒
		local aoe_usable_rapidfire = cd_rapidfire<=ygz.cd_gcd and (buff_trickshots>=2 or buff_volley>=2); -- 技巧射击buff>=2秒
		local aoe_usable_killshot = cd_killshot<=ygz.cd_gcd and ygz.tPerHealth<=20 and ygz.focus>=10;
		local aoe_usable_multipleshot = (buff_preciseshot>0.1 and ygz.focus>=50) --高亮45集中
						or ygz.focus>=65;                         --非高亮65集中
		
		
		local st_usable_killshot = cd_killshot<=ygz.cd_gcd and ygz.tPerHealth<=20 and ygz.focus>=10;
		local st_usable_arcshot = (buff_preciseshot>0.1 and ygz.focus>=20) --高亮20集中
						or ygz.focus>=60;                         --非高亮60集中
		local st_usable_aimedshot = currentCharges_aimedshot>=1 and ygz.focus>=35 --最少一层充能且35集中制
						and (buff_preciseshot<=ygz.cd_gcd or buff_trueshot>0.1 or (currentCharges_aimedshot==1 and fullchargetime_aimedshot<=3) ); --百发百中up or 非高亮 or  瞄准充满时间小于3秒
		local st_usable_rapidfire = cd_rapidfire<=ygz.cd_gcd ; -- 技巧射击buff>=2秒

		--single usable
		
		--single
		if channelName == "急速射击" then
			f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) -- 等着急速射击完
		elseif st_usable_killshot then 
			f.textures[0]:SetColorTexture(1, 0, 0) -- 夺命射击 (斩杀)
		elseif isYgzAuto and aoe_usable_doubletap then
			f.textures[0]:SetColorTexture(0.4, 0.4, 0) --二连发
		elseif isYgzAuto and cd_explosiveshot<=ygz.cd_gcd then 
			f.textures[0]:SetColorTexture(0.4, 0, 0.4) --爆炸射击 (怒击 3)
		elseif isYgzAuto and (cd_echoshot<=ygz.cd_gcd) then
			f.textures[0]:SetColorTexture(1, 0, 1) --野性之魂+百发百中大爆发 h
		elseif isYgzAuto and cd_volley<=ygz.cd_gcd then 
			f.textures[0]:SetColorTexture(0, 0, 1) --乱射 e
		elseif st_usable_aimedshot then 
			f.textures[0]:SetColorTexture(0, 0, 0) --瞄准射击 (致死)
		elseif st_usable_rapidfire then 
			f.textures[0]:SetColorTexture(0, 1, 1) --急速射击 (压制)
		elseif st_usable_arcshot then 
			f.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --奥数射击 (战斗怒吼)
		else
			f.textures[0]:SetColorTexture(0, 1, 0) --稳固射击 （猛击）
		end
		--aoe
		if channelName == "急速射击" then
			g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) -- 等着急速射击完
		elseif endtime~=nil and spellname=="瞄准射击" and (endtime-GetTime())/1000 > 0.3 and buff_volley<2.5 then 
			g.textures[0]:SetColorTexture(1, 0.8, 0.8) --多重射击 (旋风斩)
		elseif isYgzAuto and aoe_usable_doubletap then
			g.textures[0]:SetColorTexture(0.4, 0.4, 0) --二连发
		elseif isYgzAuto and cd_explosiveshot<=ygz.cd_gcd then 
			g.textures[0]:SetColorTexture(0.4, 0, 0.4) --爆炸射击 (怒击 3)
		elseif isYgzAuto and (cd_echoshot<=ygz.cd_gcd) then
			g.textures[0]:SetColorTexture(1, 0, 1) --野性之魂+百发百中大爆发 h
		elseif isYgzAuto and cd_volley<=ygz.cd_gcd then 
			g.textures[0]:SetColorTexture(0, 0, 1) --乱射 e
		elseif aoe_usable_aimedshot then 
			g.textures[0]:SetColorTexture(0, 0, 0) --瞄准射击 (致死)
		elseif aoe_usable_rapidfire then 
			g.textures[0]:SetColorTexture(0, 1, 1) --急速射击 (压制)
		elseif aoe_usable_killshot then 
			g.textures[0]:SetColorTexture(1, 0, 0) -- 夺命射击 (斩杀)
		elseif aoe_usable_multipleshot then 
			g.textures[0]:SetColorTexture(1, 0.8, 0.8) --多重射击 (旋风斩)
		else
			g.textures[0]:SetColorTexture(0, 1, 0) --稳固射击 （猛击）
		end


		--打球
		local mouseOverUnitName = select(1,UnitName("mouseover"));
		local isMouseOverExplosives = (mouseOverUnitName~=nil and mouseOverUnitName=="爆炸物");
		if isMouseOverExplosives then
			
			f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
			g.textures[0]:SetColorTexture(0.2, 0.2, 0.2) --"333333" F9
			
		end

		--驱散激怒
		local debuff_baonu = mwGetTargetBuff(228318);
		local cd_anfu=mwGetCoolDown("宁神射击"); --安抚 cd
		if debuff_baonu>=1 and cd_anfu<=ygz.cd_gcd then
			print("baonu");
		end
end