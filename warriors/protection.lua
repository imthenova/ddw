function dsdtProtectionPlay(dstd,f,g)
			local isAuto = false;
			--Single
			local hasCDSkill = true;
			--execute
			local isZhanShaPeriod = false;
			if dstd.tPerHealth<=20 then
				isZhanShaPeriod = true;
			end
			if dstd.pPerHealth<=25 and dstd.cd_laststand<=dstd.cd_gcd then --破釜
				f.textures[0]:SetColorTexture(0.4, 0.4, 0) --暗黄色 碎颅打击 c
				g.textures[0]:SetColorTexture(0.4, 0.4, 0)
			elseif dstd.buff_block <= 0.1 and dstd.pPerHealth<=45 and dstd.cd_shield<=dstd.cd_gcd then --盾墙
				f.textures[0]:SetColorTexture(1, 0.8, 0.8) --浅粉色 旋风斩 7
				g.textures[0]:SetColorTexture(1, 0.8, 0.8)
			elseif dstd.currentCharges_block >=2 and dstd.rage >= 30 then --盾牌格挡
				f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死 2
				g.textures[0]:SetColorTexture(0, 0, 0)
			elseif (dstd.buff_cszj>0.5 or dstd.cd_slzw<=dstd.cd_gcd) and dstd.pPerHealth<=80 then
				f.textures[0]:SetColorTexture(0.8, 1, 0.8) --绿色乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%
				g.textures[0]:SetColorTexture(0.8, 1, 0.8) --绿色乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%				
			elseif dstd.pPerHealth<=75 and dstd.rage>=40 and dstd.cd_wstk<=dstd.cd_gcd and dstd.buff_wstk<=0.1 then 
				f.textures[0]:SetColorTexture(0.8, 0.8, 1) --暗黄色无视苦痛 c：player血量低于60%，有无视苦痛cd，没有无视痛苦buff，并且有40怒气
				g.textures[0]:SetColorTexture(0.8, 0.8, 1)
			elseif dstd.currentCharges_block >= 1 and dstd.rage >= 30 and dstd.buff_block <= 0.1 and dstd.pPerHealth<=65 then --盾牌格挡
				f.textures[0]:SetColorTexture(0, 0, 0) --黑 致死 2
				g.textures[0]:SetColorTexture(0, 0, 0) --todo
			elseif dstd.inRange >=3 then --AOE
				if dstd.rage >= 80 or dstd.buff_revenge >= 0.1 then -- 怒气大于80 或者 有buff复仇
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- 横扫攻击 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_thunder <= dstd.cd_gcd then -- 雷霆
					f.textures[0]:SetColorTexture(1, 1, 0) --黄 撕裂 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif dstd.rage >= 35 then -- 怒气大于50复仇
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- 横扫攻击 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_shield <= dstd.cd_gcd then -- 盾猛
					f.textures[0]:SetColorTexture(0, 1, 1) --青 压制 4
					g.textures[0]:SetColorTexture(0, 1, 1)
				end

			else
				if dstd.cd_shield <= dstd.cd_gcd then -- 盾猛
					f.textures[0]:SetColorTexture(0, 1, 1) --青 压制 4
					g.textures[0]:SetColorTexture(0, 1, 1)
				elseif dstd.buff_revenge >= 0.1 then -- 怒气大于80 或者 有buff复仇
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- 横扫攻击 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_thunder <= dstd.cd_gcd then -- 雷霆
					f.textures[0]:SetColorTexture(1, 1, 0) --黄 撕裂 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif dstd.rage >= 45 then -- 怒气大于30复仇
					if isZhanShaPeriod then
						f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
						g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
					else
						f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- 横扫攻击 6
						g.textures[0]:SetColorTexture(0.4, 0, 0.4)
					end

				else
					f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着
					g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
				end
			end
end