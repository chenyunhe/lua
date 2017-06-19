local mouseC=function(c,h,i,r,l)
            local self={
            	no=i,--生成顺序
	            hp=h,--血量
		        t=c,--品质
		        p=0,--路线中的位置
		        l=l,--移动过程
		        r=r,--路线
            }
            -- 老鼠移动
            function self.move(positon)
            	self.p=positon
            end
            --掉血计算 a 受到攻击 t攻击类型
            function self.delhp(a,t)
            	self.hp=self.hp-a
                self.setStatus(t)
            end
            --设置状态
            function self.setStatus(t)
            	if self.hp>0 then
            		self.l[self.p]=t
            	else
            		self.l[self.p]=-1
            	end
            end

            return self
	    end
        -- 初始化老鼠
        local mice={}
	    for i=1,10 do
			local mouse,color = getRewardByPool(activeCfg.serverreward.balls)--老鼠
        	local road= getRewardByPool(activeCfg.serverreward.roadpool)--随机路线
        	local l={}---初始化攻击过程

        	for k,v in pairs(towersCfg) do
        		if next(v[road[1]])  then
        			for n=v[road[1]][1],v[road[1]][2] do
        				l[n]=0
        			end
        		end
        	end

            -- 颜色，血量，编号，路线
        	if i==1 then
        		local defhp=activeCfg.serverreward.balls[3][1]
        		table.insert(mice,mouseC(1,defhp,i,road[1],l))
        	else
        		table.insert(mice,mouseC(color[1],mouse[1],i,road[1],l))
        	end
	    end

	    ------------------------------------准备塔的数据
	    --塔类
	    local towerC=function(affectroad,index,mode)
	       local self={
	          roads=affectroad,--{1,2,3}影响的路线
	          no=index,--塔的编号
	          m=mode,--攻击模式 1单体 2火力全开
	       }

           -- 查找可攻击对象
	       function self.find(objs)
	       	-----找对象
	       	 local r={}
	       	 for k,v in pairs(objs) do
	       	 	if table.contains(self.roads,v.r) and v.hp>0 and self.check(v.r,v.p) then
	       	 		--单体攻击
	       	 		if self.m==1 then
	       	 			table.insert(r,v)
	       	 			break
	       	 		else--火力全开
	       	 			table.insert(r,v)
	       	 		end
                end
	       	 end

       	     return r
	       end

           --获取攻击
	       function self.attack(m)
				local a,t=self.getAtt()
		       	m.delhp(a,t)
	       end
           -- 塔攻击
	       function self.getAtt()
	       		setRandSeed()
				local rand=rand(1,100)
				local force=1
				if rand<=activeCfg.criticalRate*100 then
					force=2
					return activeCfg.attack[2],force
				end

				return activeCfg.attack[1],force
	       end
           --判断是否在塔的攻击范围 路线 位置
	       function self.check(r,p)
	       	  if p>=towersCfg[self.no][r][1] and p<=towersCfg[self.no][r][2] then
	       	  	return true
	       	  end

	       	  return false
	       end

	       return self

	    end

        local useTowers={}
	    --初始化塔  且是被激活的塔
        for k,v in pairs(towersCfg) do
        	if table.contains(actTowers,k) then
        		local affectroad={}
        		for i=1,3 do
        			if type(v[i])=='table' and next(v[i]) then
        				table.insert(affectroad,i)
        			end
        		end
        		table.insert(useTowers,towerC(affectroad,k,mode))
        	end
        end


        -- 老鼠移动速度
        local space=activeCfg.miceSpace
        ----------  start -------
       	for i=1,activeCfg.pathLength do
       		local step=i
       		for k,v in pairs(mice) do
       			v.move(step)
       			step=step-space
       		end

       		for k,v in pairs(useTowers) do
       			for _,m in pairs(v.find(mice)) do
       				v.attack(m)
       			end
       		end
        end
        ----------end---------------

	    -- {r=1,t=1,l={1,1,1,1,0,0,0,0,0}}
        -- r 路线
        -- t 老鼠品质
        -- l 0未被打  1普通伤害 2暴击 －1死亡
        local function getresult(mice)
        	local  movelog={}
        	local  r={}
        	for k,v in pairs(mice) do
        		if type(movelog[v.no])~='table' then
        			movelog[v.no]={}
        		end
        		movelog[v.no].t=v.t
        		movelog[v.no].r=v.r

			    local key_table = {}
			    --取出所有的键  
			    for key,_ in pairs(v.l) do  
			       table.insert(key_table,key)  
			    end
                local tmp={}
			    --对所有键进行排序  
		        table.sort(key_table)  
		        for nu,key in pairs(key_table) do
		        	tmp[nu]=v.l[key]
	            end 
	            movelog[v.no].l=tmp
        		if v.hp<=0 then
        			r[v.t]=(r[v.t] or 0)+1
        		end
        	end
        	return movelog,r
        end
