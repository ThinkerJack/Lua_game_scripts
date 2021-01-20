require("TSLib")

-- 基类
Util = {}

-- 取色判断函数

--    参数 color,log,x,y,sleep
--    color 颜色
--    log 条件为真输出的日志
--    x,y 点击坐标
--    sleep 点击事件前后延时 默认800
--    func 找到颜色后执行的函数
Util.judge = function(data)
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

--    func 条件为真执行的函数
--    log 条件为真输出的日志
Util.advancedJudge = function(data)
    local flag = true
    if (not (data.trueColorList == nil)) then
        for i = 1, #data.trueColorList, i do
            flag = flag and multiColor(data.trueColorList[i])
            if (not flag) then
                return
            end
        end
    end
    if (not (data.falseColorList == nil)) then
        for i = 1, #data.falseColorList, i do
            flag = flag and (not multiColor(data.falseColorList[i]))
            if (not flag) then
                return
            end
        end
    end
    if (not (data.flagList == nil)) then
        for i = 1, #data.flagList, i do
            flag = flag and data.flagList[i]
            if (not flag) then
                return
            end
        end
    end
    if (flag) then
        if (not (data.log == nil)) then
            nLog(data.log)
        end
        data.func()
    end
end

-- 循环判断

-- 参数 judgeList
Util.loopJudge = function(judgeList)
    for i = 1, #judgeList, 1 do
        Util.judge(judgeList[i])
    end
end

-- 循环高级判断

-- 参数 advancedJudgeList
Util.loopAdvancedJudge = function(judgeList)
    for i = 1, #judgeList, 1 do
        Util.advancedJudge(judgeList[i])
    end
end

-- 有限制的while循环

-- 参数flag loopTime func
-- flag 判断条件
-- loopTime 延迟时间  默认20s 20s之后退出循环
-- func() 循环里需要执行的函数
-- log 输出的日志
Util.hasLimitWhileLoop = function(data)
    local cur_timestamp = os.time()
    if (data.flag and not (data.log == nil)) then
        nLog(data.log)
    end
    if (data.loopTime == nil) then
        data.loopTime = 20
    end
    while (data.flag) do
        if (os.time() - cur_timestamp > data.loopTime) then
            break
        end
        if (not (data.func == nil)) then
            data.func()
        end
    end
end

-- 延时函数
-- millisecond延时的毫秒值 最少30
Util.wait = function(millisecond)
    local nowTime = os.clock()
    while true do
        if os.clock() - nowTime == (millisecond / 1000) then
            break
        end
    end
end

-- 延时是否到达
-- time 启动时间
-- second 延时长度
Util.timeJudge = function(time, second)
    if ((os.time() - time) % second) == 0 then
        return true
    else
        return flase
    end
end

-- 滑动

-- 参数坐标 x1,y1, x2,y2
-- 方向direction 横向true 纵向false
-- 顺序direction 正向true 反向false 正向 从左到右  从上到下
-- 滑动偏移量整除50
Util.sliding = function(x1, y1, x2, y2, direction, directionFlag)
    if (direction) then
        if (directionFlag) then
            touchDown(x1, y1)
            for i = x1 + 50, x2, 50 do
                touchMove(i, y1)
                mSleep(20)
            end
            mSleep(20)
            touchUp(x2, y1)
            mSleep(50)
        else
            touchDown(x1, y1)
            for i = x1 - 50, x2, -50 do
                touchMove(i, y1)
                mSleep(20)
            end
            mSleep(20)
            touchUp(x2, y1)
            mSleep(50)
        end
    end
    if (not direction) then
        if (directionFlag) then
            touchDown(x1, y1)
            for i = y1 + 50, y2, 50 do
                touchMove(x1, i)
                mSleep(20)
            end
            mSleep(20)
            touchUp(x1, y2)
            mSleep(50)
        else
            touchDown(x1, y1)
            for i = y1 - 50, y2, -50 do
                touchMove(x1, i)
                mSleep(20)
            end
            mSleep(20)
            touchUp(x1, y2)
            mSleep(50)
        end
    end
end
