function dsdtProtectionPlay(dstd,f,g)
			local isAuto = false;
			--Single
			local hasCDSkill = true;
			--execute
			local isZhanShaPeriod = false;
			if dstd.tPerHealth<=20 then
				isZhanShaPeriod = true;
			end
			if dstd.pPerHealth<=25 and dstd.cd_laststand<=dstd.cd_gcd then --�Ƹ�
				f.textures[0]:SetColorTexture(0.4, 0.4, 0) --����ɫ ��­��� c
				g.textures[0]:SetColorTexture(0.4, 0.4, 0)
			elseif dstd.buff_block <= 0.1 and dstd.pPerHealth<=45 and dstd.cd_shield<=dstd.cd_gcd then --��ǽ
				f.textures[0]:SetColorTexture(1, 0.8, 0.8) --ǳ��ɫ ����ն 7
				g.textures[0]:SetColorTexture(1, 0.8, 0.8)
			elseif dstd.currentCharges_block >=2 and dstd.rage >= 30 then --���Ƹ�
				f.textures[0]:SetColorTexture(0, 0, 0) --�� ���� 2
				g.textures[0]:SetColorTexture(0, 0, 0)
			elseif (dstd.buff_cszj>0.5 or dstd.cd_slzw<=dstd.cd_gcd) and dstd.pPerHealth<=80 then
				f.textures[0]:SetColorTexture(0.8, 1, 0.8) --��ɫ��ʤ׷�� 5�� �г�ʤ׷��buff������playerѪ������ 50%
				g.textures[0]:SetColorTexture(0.8, 1, 0.8) --��ɫ��ʤ׷�� 5�� �г�ʤ׷��buff������playerѪ������ 50%				
			elseif dstd.pPerHealth<=75 and dstd.rage>=40 and dstd.cd_wstk<=dstd.cd_gcd and dstd.buff_wstk<=0.1 then 
				f.textures[0]:SetColorTexture(0.8, 0.8, 1) --����ɫ���ӿ�ʹ c��playerѪ������60%�������ӿ�ʹcd��û������ʹ��buff��������40ŭ��
				g.textures[0]:SetColorTexture(0.8, 0.8, 1)
			elseif dstd.currentCharges_block >= 1 and dstd.rage >= 30 and dstd.buff_block <= 0.1 and dstd.pPerHealth<=65 then --���Ƹ�
				f.textures[0]:SetColorTexture(0, 0, 0) --�� ���� 2
				g.textures[0]:SetColorTexture(0, 0, 0) --todo
			elseif dstd.inRange >=3 then --AOE
				if dstd.rage >= 80 or dstd.buff_revenge >= 0.1 then -- ŭ������80 ���� ��buff����
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- ��ɨ���� 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_thunder <= dstd.cd_gcd then -- ����
					f.textures[0]:SetColorTexture(1, 1, 0) --�� ˺�� 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif dstd.rage >= 35 then -- ŭ������50����
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- ��ɨ���� 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_shield <= dstd.cd_gcd then -- ����
					f.textures[0]:SetColorTexture(0, 1, 1) --�� ѹ�� 4
					g.textures[0]:SetColorTexture(0, 1, 1)
				end

			else
				if dstd.cd_shield <= dstd.cd_gcd then -- ����
					f.textures[0]:SetColorTexture(0, 1, 1) --�� ѹ�� 4
					g.textures[0]:SetColorTexture(0, 1, 1)
				elseif dstd.buff_revenge >= 0.1 then -- ŭ������80 ���� ��buff����
					f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- ��ɨ���� 6
					g.textures[0]:SetColorTexture(0.4, 0, 0.4)
				elseif dstd.cd_thunder <= dstd.cd_gcd then -- ����
					f.textures[0]:SetColorTexture(1, 1, 0) --�� ˺�� 3
					g.textures[0]:SetColorTexture(1, 1, 0)
				elseif dstd.rage >= 45 then -- ŭ������30����
					if isZhanShaPeriod then
						f.textures[0]:SetColorTexture(1, 0, 0) --�� նɱ z
						g.textures[0]:SetColorTexture(1, 0, 0) --�� նɱ z
					else
						f.textures[0]:SetColorTexture(0.4, 0, 0.4) -- ��ɨ���� 6
						g.textures[0]:SetColorTexture(0.4, 0, 0.4)
					end

				else
					f.textures[0]:SetColorTexture(0.5, 0.5, 0.5) --gcd>=0.3 ����
					g.textures[0]:SetColorTexture(0.5, 0.5, 0.5)
				end
			end
end