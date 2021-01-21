require("TSLib")

-- 工具类
Util = {}

-- 取色判断函数 单色

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

-- 取色判断函数 多色

--    trueColorList 匹配的颜色列表
--    falseColorList 不匹配的颜色列表
--    flagList 自定义条件列表
--    func 条件为真执行的函数
--    log 条件为真输出的日志
Util.advancedJudge = function(data)
    local flag = true
    if (not (data.trueColorList == nil)) then
        for i = 1, #(data.trueColorList), 1 do
            flag = flag and multiColor(data.trueColorList[i])
            if (not flag) then
                return
            end
        end
    end
    if (not (data.falseColorList == nil)) then
        for i = 1, #(data.falseColorList), 1 do
            flag = flag and (not multiColor(data.falseColorList[i]))
            if (not flag) then
                return
            end
        end
    end
    if (not (data.flagList == nil)) then
        for i = 1, #(data.flagList), 1 do
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

-- 循环单色判断

--    参数 judgeList
Util.loopJudge = function(judgeList)
    for i = 1, #judgeList, 1 do
        Util.judge(judgeList[i])
    end
end

-- 循环多色判断

--    参数 advancedJudgeList
Util.loopAdvancedJudge = function(judgeList)
    for i = 1, #judgeList, 1 do
        Util.advancedJudge(judgeList[i])
    end
end

-- 到达时间或条件不符合时自动退出的while循环

--    trueColorList 匹配的颜色列表
--    falseColorList 不匹配的颜色列表
--    loopTime 延迟时间  默认20s 20s之后退出循环
--    func() 循环里需要执行的函数
--    log 循环结束时输出的日志
Util.hasLimitWhileLoop = function(data)
    local cur_timestamp = os.time()
    local flag = true
    local count = 1
    if (data.loopTime == nil) then
        data.loopTime = 20
    end
    while (flag) do
        if (os.time() - cur_timestamp > data.loopTime) then
            break
        end
        flag = true
        if (not (data.trueColorList == nil)) then
            for i = 1, #(data.trueColorList), 1 do
                flag = flag and multiColor(data.trueColorList[i])
                if (not flag) then
                    break
                end
            end
        end
        if (not (data.falseColorList == nil)) then
            for i = 1, #(data.falseColorList), 1 do
                flag = flag and (not multiColor(data.falseColorList[i]))
                if (not flag) then
                    break
                end
            end
        end
        if (not (data.func == nil)) then
            data.func()
        end
        if (count == 1) then
            if (not (data.log == nil)) then
                nLog(data.log)
            end
        end
        count = count + 1
    end
end

-- 延时函数
--    millisecond延时的毫秒值 最少30
Util.wait = function(millisecond)
    local nowTime = os.clock()
    while true do
        if os.clock() - nowTime == (millisecond / 1000) then
            break
        end
    end
end

-- 延时是否到达指定长度
--    time 启动时间
--    second 延时长度
Util.timeJudge = function(time, second)
    if ((os.time() - time) % second) == 0 then
        return true
    else
        return flase
    end
end

-- 滑动

--    参数坐标 x1,y1, x2,y2
--    方向direction 横向true 纵向false
--    顺序direction 正向true 反向false 正向 从左到右  从上到下
--    滑动偏移量整除50
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
