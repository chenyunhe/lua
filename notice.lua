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
