变量 全局变量
局部变量 local 作用于一个代码块之内 代码块外失去效果
x = 10                -- 全局变量  
 do                    -- 新的语句块  
   local x = x         -- 新的一个 'x', 它的值现在是 10  
   print(x)            --> 10  
   x = x+1  
   do                  -- 另一个语句块  
     local x = x+1     -- 又一个 'x'  
     print(x)          --> 12  
   end  
   print(x)            --> 11  
 end  
 print(x)              --> 10 （取到的是全局的那一个）  

--pairs和ipairs的区别
localtbl = {"alpha", "beta", [3] = "uno", ["two"] = "dos"}  
  
for i,v in ipairs(tbl) do    --输出前三个  
    print( tbl[i] )  
end  


for i,v in pairs(tbl) do    --全部输出  
    print( tbl[i] )  
end  

--pairs可以遍历表中所有的key，并且除了迭代器本身以及遍历表本身还可以返回nil;
--但是ipairs则不能返回nil,只能返回数字0，如果遇到nil则退出。它只能遍历到表中出现的第一个不是整数的key
