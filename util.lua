require("TSLib")
require("color_source")

-- 判断函数

--    参数 color,log,x,y,sleep
--    判断颜色 color
--    输出log log
--    点击坐标 x,y
--    延时等待 sleep
--    执行的函数 func
function judge(data)
    if (not (data.color == nil) and multiColor(data.color)) then
        if (not (data.log == nil)) then
            nLog(data.log)
        end
        if (not (data.sleep == nil)) then
            mSleep(data.sleep)
        else
            mSleep(800)
        end
        if (not (data.x == nil)) then
            tap(data.x, data.y)
        end
        if (not (data.sleep == nil)) then
            mSleep(data.sleep)
        else
            mSleep(500)
        end
        if (not (data.func == nil)) then
            data.func()
        end
    end
end

-- 高级判断函数

-- 参数 flag,func
-- 判断条件 flag
-- 执行的函数 func
function advancedJudge(data)
    if (data.flag) then
        if (not (data.log == nil)) then
            nLog(data.log)
        end
        data.func()
    end
end

-- 循环判断

-- 参数 advancedJudgeList
function loopJudge(judgeList)
    for i = 1, #judgeList, 1 do
        judge(judgeList[i])
    end
end

-- 循环高级判断

-- 参数 judgeList
function loopAdvancedJudge(judgeList)
    for i = 1, #judgeList, 1 do
        advancedJudge(judgeList[i])
    end
end

-- 滑动

-- 参数坐标 x1,y1, x2,y2
-- 方向direction 横向true 纵向false
-- 顺序direction 正向true 反向false 正向 从左到右  从上到下
-- 滑动偏移量整除50
function sliding(x1, y1, x2, y2, direction, directionFlag)
    if (direction) then
        if (directionFlag) then
            touchDown(x1, y1)
            for i = x1 + 50, x2, 50 do
                touchMove(i, y1)
                mSleep(30)
            end
            mSleep(70)
            touchUp(x2, y1)
            mSleep(50)
        else
            touchDown(x1, y1)
            for i = x1 - 50, x2, -50 do
                touchMove(i, y1)
                mSleep(30)
            end
            mSleep(70)
            touchUp(x2, y1)
            mSleep(50)
        end
    end
    if (not direction) then
        if (directionFlag) then
            touchDown(x1, y1)
            for i = y1 + 50, y2, 50 do
                touchMove(x1, i)
                mSleep(30)
            end
            mSleep(70)
            touchUp(x1, y2)
            mSleep(50)
        else
            touchDown(x1, y1)
            for i = y1 - 50, y2, -50 do
                touchMove(x1, i)
                mSleep(30)
            end
            mSleep(70)
            touchUp(x1, y2)
            mSleep(50)
        end
    end
end
