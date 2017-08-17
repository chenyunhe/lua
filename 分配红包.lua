     ------分配红包start-----------
		 local function randbag(total,bn)
		 	local bags={}--分配的结果
		 	local totalgold=total--总金额
		 	local i=0
		 	local rate1=math.ceil(math.max(1,totalgold/20))
		 	local rate2=math.ceil(math.max(1,totalgold/2))
		 	while(i<bn)
		 	do
		 		if i<bn-1 then
          setRandSeed()
		 			local rand=math.floor(rand(100*rate1,math.min(100*rate2,100*(totalgold-rate1*(bn-i))))/100)
		 			table.insert(bags,rand)
		 			totalgold=totalgold-rand
		 		else
		 			table.insert(bags,totalgold)
		 		end
		 		i=i+1
		 	end

		 	return bags
		 end
