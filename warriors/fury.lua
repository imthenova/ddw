function dsdtFuryPlay(dstd,f,g)
			local isAuto = isYgzAuto;
			local buff_bonegrinder=mwGetBuffTime("无情碾骨"); -- 激怒buff
			--print(buff_bonegrinder);
			--execute
			local isZhanShaPeriod = false;
			if dstd.tPerHealth<=20 or dstd.tPerHealth>=180 then
				isZhanShaPeriod = true;
			end
			--单体
			if (dstd.buff_cszj>0.5 or dstd.cd_slzw<=dstd.cd_gcd) and dstd.pPerHealth<=70 then
				f.textures[0]:SetColorTexture(0, 1, 0) --绿色乘胜追击 5： 有乘胜追击buff，并且player血量低于 50%
			elseif dstd.pPerHealth<=35 and dstd.rage>=60 and dstd.cd_wstk<=dstd.cd_gcd and dstd.buff_wstk<=0.1 then 
				f.textures[0]:SetColorTexture(0.8, 0.8, 1) --暗黄色无视苦痛 c：player血量低于40%，有无视苦痛cd，没有无视痛苦buff，并且有60怒气
			elseif isAuto and dstd.tHealth>200000 and dstd.cd_lumang<=0 and dstd.buff_lumang<=0 then -- 鲁莽好了用鲁莽
				if dstd.cd_gcd >=0.3 then
					f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着开鲁莽
				else
					f.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
				end
			elseif (dstd.buff_jn<=dstd.cd_gcd and dstd.rage>=80) or (dstd.buff_lumang>0 and dstd.rage>=80) or dstd.rage>=90 then
				f.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 4
			elseif dstd.currentCharges_nj>=1 and dstd.buff_lumang >0.1 then
				f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 3
			elseif dstd.cd_panzui<=dstd.cd_gcd and (isZhanShaPeriod or dstd.buff_cs>0.5) then -- 斩杀阶段没激怒
				f.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
			elseif dstd.currentCharges_nj>=3 then
				f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 3
			elseif dstd.buff_jn<=0 and dstd.cd_sx<=dstd.cd_gcd then
				f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
			--elseif isAuto and dstd.tHealth>200000 and dstd.buff_jn>2 and dstd.buff_lumang<=0 and dstd.cd_jrfb<=dstd.cd_gcd and dstd.rage<=50 then
			--	f.textures[0]:SetColorTexture(0, 0.4, 0.4) --蓝 剑刃风暴 e
			--elseif isAuto and dstd.buff_jn>0.1 and dstd.cd_spear<=dstd.cd_gcd then
			--	f.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e
			elseif dstd.currentCharges_nj>=1 then
				f.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 3
			elseif dstd.cd_sx<=dstd.cd_gcd then
				f.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
			else
				f.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩
			end
			--AOE
			if (dstd.buff_cszj>0.5 or dstd.cd_slzw<=dstd.cd_gcd) and dstd.pPerHealth<=70 then
				g.textures[0]:SetColorTexture(0, 1, 0) --绿色乘胜追击 5： 有乘胜追击buff，并且player血量低于 70%
			elseif dstd.pPerHealth<=50 and dstd.rage>=60 and dstd.cd_wstk<=dstd.cd_gcd and dstd.buff_wstk<=0.1 then 
				g.textures[0]:SetColorTexture(0.8, 0.8, 1) --暗黄色无视苦痛 c：player血量低于50%，有无视苦痛cd，并且有60怒气
			elseif dstd.buff_xfz == nil or dstd.buff_xfz<=0.5 then
				g.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩
			elseif isAuto and dstd.tHealth>200000 and dstd.cd_lumang<=0 and dstd.buff_lumang<=0 then -- 鲁莽好了用鲁莽
				if dstd.cd_gcd >=0.3 then
					g.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 等着开鲁莽
				else
					g.textures[0]:SetColorTexture(1, 0, 1) --紫色鲁莽 h
				end
			elseif isAuto and buff_bonegrinder<=0.5 and dstd.tHealth>200000 and dstd.buff_jn>2.4 and dstd.cd_jrfb<=dstd.cd_gcd then
				g.textures[0]:SetColorTexture(0, 0.4, 0.4) --蓝 剑刃风暴 e
			elseif (dstd.buff_jn<=1.0 and dstd.rage>=80) or dstd.rage>=90 then
				g.textures[0]:SetColorTexture(0, 1, 1) --青 暴怒 4
			elseif buff_bonegrinder>=0.5 then
				g.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩
			elseif isAuto and dstd.buff_jn>0.1 and dstd.cd_spear<=dstd.cd_gcd then
				g.textures[0]:SetColorTexture(0, 0, 1) --蓝 巨龙 e
			elseif dstd.buff_jn >0.1 and dstd.cd_panzui<=dstd.cd_gcd and (isZhanShaPeriod or dstd.buff_cs>0.5) then -- 斩杀阶段有激怒
				g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
			elseif dstd.cd_panzui<=dstd.cd_gcd and (isZhanShaPeriod or dstd.buff_cs>0.5) then -- 斩杀阶段没激怒
				g.textures[0]:SetColorTexture(1, 0, 0) --红 斩杀 z
			elseif dstd.buff_jn<=0 and dstd.cd_sx<=dstd.cd_gcd then
				g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
			elseif dstd.currentCharges_nj>=2 then
				g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 3
			elseif dstd.cd_sx<=dstd.cd_gcd then
				g.textures[0]:SetColorTexture(0, 0, 0) --黑 嗜血 2
			elseif dstd.currentCharges_nj>=1 then
				g.textures[0]:SetColorTexture(0.4, 0, 0.4) --黄 怒击 3
			else
				g.textures[0]:SetColorTexture(1, 0.8, 0.8) --藏青 旋风斩
			end
end