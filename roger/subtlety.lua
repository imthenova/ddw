function ddwSubtletyPlay(ddw,f,g)
		--buff
		local buff_slice=mwGetBuffTime("切割"); --切割buff
		local buff_snd=mwGetBuffTime("死亡符记"); --死亡符记buff
		local buff_shadow_dance=mwGetBuffTime("暗影之舞"); --暗影之舞buff
		local debuff_rupture=mwGetDebuffTime("割裂");--割裂debuff
		local debuff_flagellation=mwGetDebuffTime("狂热鞭笞");--狂热鞭笞debuff
		local isStealthed = IsStealthed() or buff_shadow_dance>0.1;
		local buff_xiujian_storm = mwGetBuffTime("袖剑旋风"); --袖剑旋风 buff
		local buff_shadow_blade = mwGetBuffTime("暗影之刃"); --暗影之刃 buff
		--cd
		local cd_flagellation=mwGetCoolDown("狂热鞭笞"); --狂热鞭笞 cd
		local cd_snd=mwGetCoolDown("死亡符记"); --死亡符记 cd
		local cd_shadow_blade=mwGetCoolDown("暗影之刃"); --暗影之刃 cd
		local cd_xiujian_storm = mwGetCoolDown("袖剑旋风"); --袖剑旋风 cd
		
		--single usable
		--var
		local is_shadow_blade_up = 0;
		if cd_shadow_blade>0.1 then
			is_shadow_blade_up = 1;
		end
		--todo 死符爆击*
		local members = GetNumGroupMembers();
		local ruptureHP = 50000*0.8*members;--动态 24w
		if members <=1 then 
			ruptureHP = 10000;
		end
		local flagellationHP = ruptureHP * 1.5; -- 36w
		local SNDHP = ruptureHP * 1; -- 24W
		local shadowbladeHP = ruptureHP * 3; -- 72w
		if members <=1 then 
			ruptureHP = 25000;
		end
		--target inRange count
		local inRange = 0
		for i = 1, 40 do
			--if UnitExists('nameplate' .. i) and IsSpellInRange('致死打击', 'nameplate' .. i) == 1 then
			if UnitExists('nameplate' .. i) and UnitCanAttack("player","target") and CheckInteractDistance('nameplate' .. i,2) and UnitName('nameplate' .. i)~=nil and UnitName('nameplate' .. i)~="赛季大吊威" then
				inRange = inRange + 1
			end
		end
		
		local snd_condition = isYgzAuto and buff_slice>=10;
		local refreshable_slice = buff_slice<=42*0.3;
		local refreshable_rupture = debuff_rupture<=28*0.3 and ddw.tHealth>ruptureHP;
		local currentCharges_shadow_dance = select(1,GetSpellCharges("暗影之舞")); --暗影之舞charge
		local fullchargetime_shadow_dance = select(4,GetSpellCharges("暗影之舞"))-GetTime()+select(3,GetSpellCharges("暗影之舞"));
		--cds
		local st_usable_cds_flagellation = ddw.tHealth>flagellationHP and snd_condition and buff_snd>1 and ddw.combo_points>=5 and cd_flagellation<=ddw.cd_gcd;
		local st_usable_cds_snd = ddw.tHealth>ruptureHP and snd_condition and ((cd_flagellation<=ddw.cd_gcd+0.1 and ddw.combo_points>=5) or cd_flagellation>10) and cd_snd<=ddw.cd_gcd +0.1;
		local st_usable_cds_shadow_blade = ddw.tHealth>shadowbladeHP and debuff_flagellation>5 and buff_snd>5 and ddw.combo_points<5 and cd_shadow_blade<=ddw.cd_gcd;
		local st_usable_cds_xiujian_storm = ddw.tHealth>ruptureHP and debuff_flagellation>5 and buff_snd>5 and cd_xiujian_storm<=ddw.cd_gcd and ddw.energy>=50;
		--emergency_slice
		local st_usable_emergency_slice=buff_slice<=ddw.cd_gcd and ddw.combo_points>=2;
		--stealthed all
		local st_usable_shadow_dance = buff_shadow_dance<=0 and currentCharges_shadow_dance>=1 and ddw.combo_points<=4 and (buff_snd>=1.5 or debuff_flagellation>5 or fullchargetime_shadow_dance<=6 or currentCharges_shadow_dance>=2);
		--finisher
		local st_usable_finisher_slice = buff_shadow_dance<=0 and refreshable_slice;
		local st_usable_rupture = refreshable_rupture;
		local st_usable_rupture_4SnD = snd_condition and cd_snd<=5 and debuff_rupture<=cd_snd+10;

		
		--Time to Play
		local st_finalSpell = "wait";
		local aoe_finalSpell = "wait";
		--single
		if inRange>=3 and buff_xiujian_storm>=0.00001 then
			if ddw.combo_points<=3 then
				if ddw.combo_points+2+is_shadow_blade_up<=6-inRange then
					f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
					g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
				else
					f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
					g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
				end
			else
				f.textures[0]:SetColorTexture(0, 0, 0) --剔骨 （杀戮命令）
				g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黑火药 （爆炸射击同键）
				st_finalSpell = "black_huoyao";
			end
		elseif st_usable_cds_flagellation then -- 狂热鞭笞 -- 劫掠射击
			f.textures[0]:SetColorTexture(0, 0, 1) --蓝色巨龙 .
			g.textures[0]:SetColorTexture(0, 0, 1) --蓝色巨龙 .
			st_finalSpell = "flagellation";
		elseif st_usable_cds_snd then 
			f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
			g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
			st_finalSpell = "SnD";
		--elseif st_usable_cds_xiujian_storm and inRange>=3 then -- aoe 袖剑旋风
		--	f.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
		----	g.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
		--	st_finalSpell = "xiujian_storm";
		--elseif st_usable_cds_xiujian_storm and ddw.tHealth>shadowbladeHP then -- st 袖剑旋风
		--	f.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
		--	g.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
		--	st_finalSpell = "xiujian_storm";
		elseif st_usable_cds_shadow_blade then
			f.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
			g.textures[0]:SetColorTexture(0.6, 0.6, 0.6); --"999999" F11
			st_finalSpell = "xiujian_storm";
		elseif isStealthed then
			--if IsStealthed() then -- 暗打 
			--	f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
			--	g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
			--	st_finalSpell = "shadowstrike";
			if ddw.combo_points>=5 then
				playStFinisher(ddw,f,g,st_finalSpell,st_usable_finisher_slice,st_usable_rupture,st_usable_rupture_4SnD,inRange);
			else
				if inRange >= 4 then
					f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					st_finalSpell = "xiujian_storm";
				elseif inRange==3 then
					if ddw.combo_points <3 then-- 1~2 
						f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
						g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
						st_finalSpell = "xiujian_storm";
					else
						f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
						g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
						st_finalSpell = "shadowstrike";
					end
				else
					f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
					g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
					st_finalSpell = "shadowstrike";
				end
			end
		elseif st_usable_emergency_slice then -- 紧急补切割
			f.textures[0]:SetColorTexture(1, 0.8, 0.8) --治疗宠物 7
			g.textures[0]:SetColorTexture(1, 0.8, 0.8) --治疗宠物 7
			st_finalSpell = "emergency_slice";
		elseif st_usable_shadow_dance then -- 暗影之舞
			if ddw.energy<=50 or ddw.cd_gcd >=0.5 then
				f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
				g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
			else
				f.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
				g.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
				st_finalSpell = "shadow_dance";
			end
		elseif ddw.combo_points>=5 then 
			playStFinisher(ddw,f,g,st_finalSpell,st_usable_finisher_slice,st_usable_rupture,st_usable_rupture_4SnD,inRange);
		else
			if ddw.energy<=50 then
				f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
				g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.5 等着
			else
				if inRange >= 2 then
					f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					st_finalSpell = "xiujian_storm";
				else
					f.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
					g.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
					st_finalSpell = "backstab";
				end
				
			end
		end
		
		
		-- priority action 
		local cd_kidney_hit = mwGetCoolDown("肾击"); --肾击 cd
		if usingKidneyHit ~= nil and usingKidneyHit and ddw.combo_points>=2 then
			if cd_kidney_hit>= ddw.cd_gcd+0.1 then
				usingKidneyHit = false;
			else 
				f.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --kidney_hit =
				g.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --kidney_hit =
			end
			print("usingKidneyHit");
		elseif aoeAndStBurst ~= nil and aoeAndStBurst then
			if cd_xiujian_storm >= ddw.cd_gcd+0.1 and cd_snd >= ddw.cd_gcd+0.1 and cd_flagellation >= ddw.cd_gcd+0.1 then
				aoeAndStBurst = false;
			else
				if buff_slice <= 10 then -- 起手先切割
					if ddw.combo_points>=2 then
						f.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
						g.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
					elseif isStealthed then
						f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
						g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
					elseif inRange>=2 then
						f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
						g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					else
						f.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
						g.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
					end
				elseif cd_flagellation <= ddw.cd_gcd+0.1 then
					f.textures[0]:SetColorTexture(0, 0, 1) --狂热鞭笞
					g.textures[0]:SetColorTexture(0, 0, 1) --狂热鞭笞
				elseif cd_xiujian_storm <= ddw.cd_gcd+0.1 then
					f.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
					g.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
				elseif cd_snd <= ddw.cd_gcd+0.1 then
					f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
					g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
				end
			end
			print("aoeAndStBurst");
		elseif StBurst ~= nil and StBurst then
			if cd_snd >= ddw.cd_gcd+0.1 and cd_flagellation >= ddw.cd_gcd+0.1 then
				StBurst = false;
			else
				if buff_slice <= 10 then -- 起手先切割
					if ddw.combo_points>=2 then
						f.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
						g.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
					elseif isStealthed then
						f.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
						g.textures[0]:SetColorTexture(1, 0, 0) -- 暗打 （夺命射击）
					elseif inRange>=2 then
						f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
						g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					else
						f.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
						g.textures[0]:SetColorTexture(0, 1, 0) -- 背刺 （眼镜蛇）
					end
				elseif cd_flagellation <= ddw.cd_gcd+0.1 and ddw.combo_points>=5 then
					f.textures[0]:SetColorTexture(0, 0, 1) --狂热鞭笞
					g.textures[0]:SetColorTexture(0, 0, 1) --狂热鞭笞
				elseif cd_snd <= ddw.cd_gcd+0.1 and ddw.combo_points>=5 then
					f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
					g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
				end
			end
			print("StBurst");
		elseif aoeBurst ~= nil and aoeBurst then
			if cd_xiujian_storm >= ddw.cd_gcd+0.1 and cd_snd >= ddw.cd_gcd+0.1 then
				aoeBurst = false;
			else
				if buff_slice <= 10 then -- 起手先切割
					if ddw.combo_points>=2 then
						f.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
						g.textures[0]:SetColorTexture(1, 0.8, 0.8) --切割 7
					else
						f.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
						g.textures[0]:SetColorTexture(0, 0.4, 0.4) --袖箭风暴（多重）
					end
				elseif cd_xiujian_storm <= ddw.cd_gcd+0.1 then
					f.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
					g.textures[0]:SetColorTexture(0.4, 0.4, 0.4) --"666666" F10
				elseif cd_snd <= ddw.cd_gcd+0.1 then
					f.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
					g.textures[0]:SetColorTexture(0.2, 0.2, 0.2); --"333333" F9
				end
			end
			print("aoeBurst");
		end
end

function playStFinisher(ddw,f,g,st_finalSpell,st_usable_finisher_slice,st_usable_rupture,st_usable_rupture_4SnD,inRange)
	if st_usable_finisher_slice then--切割
		f.textures[0]:SetColorTexture(1, 0.8, 0.8) --治疗宠物 7
		g.textures[0]:SetColorTexture(1, 0.8, 0.8) --治疗宠物 7
		st_finalSpell = "slice";
	elseif st_usable_rupture and inRange<=3 then -- 割裂
		f.textures[0]:SetColorTexture(0, 1, 1);		--割裂
		g.textures[0]:SetColorTexture(0, 1, 1);		--割裂
		st_finalSpell = "rupture";
	elseif st_usable_rupture_4SnD and inRange<=3 then-- 割裂
		f.textures[0]:SetColorTexture(0, 1, 1);		--割裂
		g.textures[0]:SetColorTexture(0, 1, 1);		--割裂
		st_finalSpell = "rupture_4SnD";
	else -- 剔骨
		if inRange >= 3 then
			f.textures[0]:SetColorTexture(0, 0, 0) --剔骨 （杀戮命令）
			g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黑火药 （爆炸射击）
			st_finalSpell = "black_huoyao";
		else
			f.textures[0]:SetColorTexture(0, 0, 0) --剔骨 （杀戮命令）
			g.textures[0]:SetColorTexture(0, 0, 0) --剔骨 （杀戮命令）
			st_finalSpell = "ev";
		end
		
	end
end