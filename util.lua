-- 判断函数

--    参数 color,log,x,y,sleep
--    判断颜色 color
--    输出log log
--    点击坐标 x,y
--    延时等待 sleep
--    执行的函数 func
function judge(data)
   if (multiColor(data.color)) then
      if (not (data.log == nil)) then
         nLog(data.log)
      end
      if (not (data.x == nil)) then
         tap(data.x, data.y)
      end
      if (not (data.sleep == nil)) then
         mSleep(data.sleep)
      else
         mSleep(800)
      end
      if (not (data.func == nil)) then
         data.func()
      end
   end
end

-- 循环判断

-- 参数 judgeList
function loopJudge(judgeList)
   for i = 1, #judgeList, 1 do
      print(i)
      judge(judgeList[i])
   end
end
