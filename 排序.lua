--根据每个table中的某个值排序
local list = {}
table.insert(list,{1,'name1',10})
table.insert(list,{2,'name2',5})
table.insert(list,{3,'name3',20})
table.insert(list,{4,'name4',11})
table.insert(list,{5,'name5',10})

table.sort( list,function ( a,b )  
    -- body  
    if a[3]==b[3] then  
        return a[3]>b[3]  
    end  
  
    return a[3] > b[3]  
end )  
  
for i,v in ipairs(list) do  
    print(v[1],v[2],v[3])  
end  
