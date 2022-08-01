function dsdtArmsPlay(dstd,f,g)
			local isAuto = false;
			--防御姿态
			local has_talent_protect = select(10,GetTalentInfo(4,3,1));
			local buff_protection = AuraUtil.FindAuraByName("防御姿态","player",'HELPFUL');--防御姿态 buff
			local cd_protection=mwGetCoolDown("防御姿态"); --防御姿态 CD
			--Single
			local members = GetNumGroupMembers();
			local rendHP = 60000*0.8*members;--动态
			if members <=1 then 
				rendHP = 70000;
			end
			--如果大于等于五人降低无视痛苦血量到30%，
			--如果1-4人，无视痛苦血量60%
			local wstkHPLine = 60;
			if members >=5 then 
				wstkHPLine = 30;
			end

			local hasCDSkill = true;
			--local rendHP = 70000;--单体
			--local rendHP = 240000;--秘境
			--local rendHP = 500000;--10人团本
			--local rendHP = 800000;--20+团本
			--execute
			local isZhanShaPeriod = false;
			if dstd.tPerHealth<=dstd.zhanshaPHP then
				isZhanShaPeriod = true;
			end
			--起手冲锋，撕裂，天神，灭站，上古，压制2，致死，
			if (dstd.buff_cszj>0.5 or dstd.cd_slzw<=dstd.cd_gcd) and dstd.pPerHealth<=75 then
				f.textures[0]:SetColorTexture(0.8, 1, 0.8) --优1：乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%
				g.textures[0]:SetColorTexture(0.8, 1, 0.8) --优1：乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%				
			elseif members < 5 and has_talent_protect and buff_protection == nil and cd_protection<0.1 and dstd.pPerHealth<=40 then 
				f.textures[0]:SetColorTexture(0.7, 0.3, 0) --优2：5人以下副本，有防御姿态天赋，如果不是防御姿态，血量少于40% 开启防御姿态
				g.textures[0]:SetColorTexture(0.7, 0.3, 0)
			elseif dstd.pPerHealth<=wstkHPLine and dstd.rage>=40 and dstd.cd_wstk<=dstd.cd_gcd and dstd.buff_wstk<=0.1 then 
				f.textures[0]:SetColorTexture(0.8, 0.8, 1) --优3：无视苦痛 c：player血量低于60%，有无视苦痛cd，没有无视痛苦buff，并且有40怒气
				g.textures[0]:SetColorTexture(0.8, 0.8, 1)
			elseif dstd.inRange >=2 and dstd.cd_sweep <= dstd.cd_gcd then
				f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- 优4：横扫攻击 6
				g.textures[0]:SetColorTexture(0.4, 0, 0.4)
			elseif isZhanShaPeriod then -- 斩杀期
				if dstd.has_talent_render and dstd.debuff_rend <= dstd.cd_gcd and dstd.tHealth>rendHP and dstd.rage>=30 and dstd.cd_giant>1.2 and dstd.cd_giant<=4 then
					f.textures[0]:SetColorTexture(1, 1, 0) --斩杀优5： 撕裂 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif isAuto and dstd.cd_avatar<=dstd.cd_gcd then
					if dstd.cd_gcd >=0.2 then
						f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --斩杀优6：gcd>=0.2 等着开天神
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
					else
						f.textures[0]:SetColorTexture(1, 0, 1) --斩杀优6：gcd<0.2 开天神
						g.textures[0]:SetColorTexture(1, 0, 1)
					end
				elseif isAuto and dstd.cd_giant<=dstd.cd_gcd then
					f.textures[0]:SetColorTexture(1, 0, 1) --斩杀优6：巨人/灭战
					g.textures[0]:SetColorTexture(1, 0, 1)
				elseif isAuto and dstd.cd_spear<=dstd.cd_gcd and dstd.debuff_giant>0.1 then
					f.textures[0]:SetColorTexture(0, 0, 1) --斩杀优6：巨人中：上古余震
					g.textures[0]:SetColorTexture(0, 0, 1)
				elseif dstd.buff_cs>0.5 then                        --斩杀优7：触发猝死打斩杀
					f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
					g.textures[0]:SetColorTexture(1, 0, 0)
				elseif dstd.currentCharges_overpower>=2 then
					f.textures[0]:SetColorTexture(0, 1, 1) --斩杀优8：压制两层 打压制
					g.textures[0]:SetColorTexture(0, 1, 1)
				elseif dstd.cd_mortal<=dstd.cd_gcd and dstd.rage>=30 and dstd.count_mortalenhance >= 2 then
					f.textures[0]:SetColorTexture(0, 0, 0) --斩杀优9 强化致死buff两层 打致死
					g.textures[0]:SetColorTexture(0, 0, 0)
				elseif dstd.has_talent_suilu and dstd.cd_skull<=dstd.cd_gcd and dstd.rage<=45 then 
					f.textures[0]:SetColorTexture(0.4, 0.4, 0) --斩杀优10*可选 怒气<=45碎颅打击 c
					g.textures[0]:SetColorTexture(0.4, 0.4, 0)
				elseif isAuto and dstd.cd_jrfb<=dstd.cd_gcd and dstd.rage<=30 then
					f.textures[0]:SetColorTexture(0, 0.4, 0.4) --斩杀优11 怒气<=30 剑刃风暴 ·
					g.textures[0]:SetColorTexture(0, 0.4, 0.4)
				elseif dstd.rage>=20 then
					f.textures[0]:SetColorTexture(1, 0, 0) --斩杀优12 怒气>=20 斩杀 ·
					g.textures[0]:SetColorTexture(1, 0, 0)
					hasCDSkill = false;
				elseif dstd.currentCharges_overpower>=1 then
					f.textures[0]:SetColorTexture(0, 1, 1) --斩杀优13 压制1层
					g.textures[0]:SetColorTexture(0, 1, 1)
					hasCDSkill = false;
				else
					if dstd.cd_zdnh > 1.2 then
						f.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --斩杀优14 压制1层
						g.textures[0]:SetColorTexture(0.8, 0.8, 0.8)
						hasCDSkill = false;
					else
						f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
						hasCDSkill = false;
					end
				end

				--自动g frame
				if hasCDSkill==false and dstd.cd_jrfb<=dstd.cd_gcd and dstd.rage<=30 then
					g.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 剑刃风暴 ·
				end
				if dstd.cd_spear<=dstd.cd_gcd and dstd.debuff_giant>0.1 then
					g.textures[0]:SetColorTexture(0, 0, 1) --蓝 上古余震 e
				end
				if dstd.cd_giant<=dstd.cd_gcd then
					g.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
				end
				if dstd.cd_avatar<=dstd.cd_gcd then
					if dstd.cd_gcd >=0.2 then
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.2 等着开天神
					else
						g.textures[0]:SetColorTexture(1, 0, 1) --紫色天神 h
					end
				end
			else --非斩杀期
				if dstd.has_talent_render and dstd.debuff_rend <= dstd.cd_gcd and dstd.tHealth>rendHP and dstd.rage>=30 then
					f.textures[0]:SetColorTexture(1, 1, 0) --黄 撕裂 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif isAuto and dstd.cd_avatar<=dstd.cd_gcd then
					if dstd.cd_gcd >=0.2 then
						f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.2 等着开天神
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
					else
						f.textures[0]:SetColorTexture(1, 0, 1) --紫色天神 h
						g.textures[0]:SetColorTexture(1, 0, 1)
					end
				elseif isAuto and dstd.cd_giant<=dstd.cd_gcd then
					f.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
					g.textures[0]:SetColorTexture(1, 0, 1)
				elseif isAuto and dstd.cd_spear<=dstd.cd_gcd and dstd.debuff_giant>0.1 then
					f.textures[0]:SetColorTexture(0, 0, 1) -- 上古余震 e
					g.textures[0]:SetColorTexture(0, 0, 1)
				elseif dstd.buff_cs>0.5 then                        --猝死斩杀
					f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
					g.textures[0]:SetColorTexture(1, 0, 0)
				elseif dstd.currentCharges_overpower>=2 then
					f.textures[0]:SetColorTexture(0, 1, 1) --压制 4
					g.textures[0]:SetColorTexture(0, 1, 1)
				elseif dstd.cd_mortal<=dstd.cd_gcd and dstd.rage>=30 then
					f.textures[0]:SetColorTexture(0, 0, 0) -- 致死 2
					g.textures[0]:SetColorTexture(0, 0, 0)
				elseif dstd.has_talent_suilu and dstd.cd_skull<=dstd.cd_gcd and dstd.rage<=55 then 
					f.textures[0]:SetColorTexture(0.4, 0.4, 0) -- 碎颅打击 c
					g.textures[0]:SetColorTexture(0.4, 0.4, 0)
				elseif isAuto and dstd.cd_jrfb<=dstd.cd_gcd and dstd.rage<=30 then
					f.textures[0]:SetColorTexture(0, 0.4, 0.4) -- 剑刃风暴 ·
					g.textures[0]:SetColorTexture(0, 0.4, 0.4)
				elseif dstd.currentCharges_overpower>=1 then
					f.textures[0]:SetColorTexture(0, 1, 1) -- 压制 4
					g.textures[0]:SetColorTexture(0, 1, 1)
					hasCDSkill = false;
				elseif dstd.has_talent_render and dstd.debuff_rend <= 4.5 and dstd.tHealth>400000 and dstd.rage>=30 then
					f.textures[0]:SetColorTexture(1, 1, 0) -- 撕裂 3
					g.textures[0]:SetColorTexture(1, 1, 0)
					hasCDSkill = false;
				elseif dstd.rage>=50 or (dstd.debuff_giant>0.1 and dstd.rage>20) then
					if (dstd.buff_sweep<0.1 and dstd.inRange >= 3) or (dstd.buff_sweep>=0.1 and dstd.inRange >= 5) or (dstd.count_jjshanghai >= 7) then
						f.textures[0]:SetColorTexture(1, 0.8, 0.8) -- 旋风斩 7
						g.textures[0]:SetColorTexture(1, 0.8, 0.8)
					else
						f.textures[0]:SetColorTexture(0, 1, 0) -- 猛击 5
						g.textures[0]:SetColorTexture(0, 1, 0)
					end
					hasCDSkill = false;
				else
					if dstd.cd_zdnh > 1.2 then
						f.textures[0]:SetColorTexture(0.8, 0.8, 0.8) --战斗怒吼
						g.textures[0]:SetColorTexture(0.8, 0.8, 0.8)
						hasCDSkill = false;
					else
						f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
						hasCDSkill = false;
					end
				end

				--自动g frame
				if hasCDSkill == false and dstd.cd_jrfb<=dstd.cd_gcd and dstd.rage<=30 then
					g.textures[0]:SetColorTexture(0, 0.4, 0.4) --藏青 剑刃风暴 ·
				end
				if dstd.cd_spear<=dstd.cd_gcd and dstd.debuff_giant>0.1 then
					g.textures[0]:SetColorTexture(0, 0, 1) --蓝 上古余震 e
				end
				if dstd.cd_giant<=dstd.cd_gcd then
					g.textures[0]:SetColorTexture(1, 0, 1) --紫色巨人（天神同键） h
				end
				if dstd.cd_avatar<=dstd.cd_gcd then
					if dstd.cd_gcd >=0.2 then
						g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.2 等着开天神
					else
						g.textures[0]:SetColorTexture(1, 0, 1) --紫色天神 h
					end
				end
			end
			
			--AOE
end