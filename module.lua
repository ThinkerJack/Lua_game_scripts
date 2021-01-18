require("TSLib")
require("color_source")
require("util")
require("module")
function appInit()
    -- 初始化屏幕
    init(0)
    -- 启动APP
    if runApp("com.netease.ma84") == 0 then
        local judgeList = {
            {color = gameRun["startGameColor"], log = "游戏启动 开始游戏界面按钮", x = 273, y = 597},
            {color = gameRun["fullScreenPopBackColor"], log = "通用 全屏弹框左下角返回", x = 46, y = 923},
            {
                color = gameRun["loginAfterMain"],
                log = "通用 登录后游戏主页面",
                func = function()
                    flag = false
                end
            }
        }
        flag = true
        while (flag) do
            loopJudge(judgeList)
        end
    else
        nLog("启动失败")
        appInit()
    end
end

function funntPvpRun()
    while (true) do
        -- 确认弹框
        if (multiColor(gameMainPop["loginPopSureColor"])) then
            tap(276, 714)
            mSleep(1000)
        end
        -- 选择场地
        if (multiColor(pvpFieldMain["pvpFieldChoosedColor"])) then
            tap(174, 920)
            mSleep(1000)
        end
        -- 休闲决斗
        if (multiColor(funnyPvp["listFunnyPvpColor"])) then
            tap(258, 623)
            mSleep(1000)
        end
        -- 点击确定
        if multiColor(general["bottomSureColor"]) then
            nLog("确定")
            tap(274, 911)
            mSleep(500)
        end
        -- 点击下一步
        if multiColor(general["bottomNextColor"]) then
            nLog("下一步")
            tap(274, 911)
            mSleep(500)
        end
        -- 点击决斗
        if multiColor(funnyPvp["funnyPvpStartColor"]) then
            mSleep(1000)
            nLog("决斗开始")
            tap(271, 406)
            mSleep(500)
        end

        beat()

        --升级
        if multiColor(general["battleAfterLevelUpColor"]) then
            nLog("升级")
            tap(275, 480)
            mSleep(500)
        end
    end
end
function beat()
    -- 抽卡阶段
    if
        multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourInCardColor"]) and
            ((not multiColor(battleIng["fristRoundColor"])) or (not multiColor(battleIng["oneDigitRoundColor"])))
     then
        mSleep(500)
        nLog("抽卡阶段")
        touchDown(260, 450)
        mSleep(30)
        touchMove(260, 500)
        mSleep(30)
        touchMove(260, 550)
        mSleep(30)
        touchMove(260, 600)
        mSleep(30)
        touchMove(260, 650)
        mSleep(30)
        touchMove(260, 700)
        mSleep(30)
        touchUp(260, 700)
        mSleep(1000)
        tap(272, 479)
        mSleep(500)
    end
    -- 主要阶段
    if multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["yourMainColor"]) then
        nLog("你的主要阶段")
        nLog("出卡阶段")
        mSleep(500)
        touchDown(230, 860)
        mSleep(30)
        touchMove(230, 810)
        mSleep(30)
        touchMove(230, 760)
        mSleep(30)
        touchMove(230, 710)
        mSleep(30)
        touchUp(230, 710)
        mSleep(800)
        if (multiColor(battleIng["mainWakeCardColor"])) then
            nLog("召唤卡阶段")
            tap(204, 706)
            mSleep(1000)
            while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourMainColor"])) do
            end
            mSleep(1000)
        end
        if (multiColor(battleIng["pvpYourRoundColor"]) and multiColor(battleIng["changeRoundColor"])) then
            nLog("结束回合or切换回合")
            tap(495, 606)
            mSleep(500)
            tap(419, 638)
            mSleep(1000)
        end
    end
    --弹出框
    if (multiColor(battleIng["fightRollBackColor"])) then
        nLog("发生倒回")
        mSleep(2000)
        tap(166, 527)
        mSleep(1000)
    end
    --网络失败
    if (multiColor(netWorkError["noNetWorkColor"])) then
        nLog("网络失败")
        mSleep(2000)
        tap(392, 540)
        mSleep(1000)
    end
    --连接错误
    if (multiColor(netWorkError["connectErrorColor"])) then
        nLog("连接错误")
        mSleep(2000)
        tap(280, 533)
        mSleep(1000)
    end
    -- x, y = findImage("eye.png", 0, 0, 535, 947);--在（0,0）到（w-1,h-1）寻找刚刚截图的图片
    -- if x ~= -1 and y ~= -1 then        --如果在指定区域找到某图片符合条件
    --     nLog("x:"..x.."\r\n".."y:"..y,5);                   --显示坐标
    -- else                               --如果找不到符合条件的图片
    --     nLog("没有找到图片!",5);
    -- end
    -- --寻找符合条件的点
    -- x, y = findColorInRegionFuzzy( 0xffcc00, 100, 310, 0, 349, 39);
    -- if x ~= -1 and y ~= -1 then  --如果在指定区域找到某点符合条件
    --     touchDown(x, y);		 --那么单击该点
    --     mSleep(30);
    --     touchUp(x, y);
    --     nLog("test");

    -- else						 --如果找不到符合条件的点
    --     nLog("未找到符合条件的坐标！");
    -- end
    --链接超时
    if (multiColor(netWorkError["netWorkOutTimeColor"])) then
        nLog("链接超时")
        mSleep(2000)
        tap(269, 522)
        mSleep(1000)
    end
    -- 战斗阶段
    if multiColor(battleIng["yourFightColor"]) then
        nLog("战斗阶段")
        flag = true
        while (flag and multiColor(battleIng["yourFightColor"])) do
            -- 有卡加上没有绿光
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutSecondCardColor"])) and
                    (not multiColor(battleIng["secondCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                mSleep(1000)
                nLog("二号槽位有卡")
                touchDown(268, 550)
                mSleep(30)
                touchMove(268, 500)
                mSleep(30)
                touchMove(268, 450)
                mSleep(30)
                touchMove(268, 400)
                mSleep(30)
                touchUp(268, 350)
                mSleep(1000)
                local i = 1000
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    if (multiColor(battleIng["fightRollBackColor"])) then
                        nLog("发生倒回")
                        mSleep(2000)
                        tap(166, 527)
                        mSleep(1000)
                    end
                end
                mSleep(1500)
            end
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutThirdCardColor"])) and
                    (not multiColor(battleIng["thirdCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                nLog("三号槽位有卡")
                touchDown(380, 550)
                mSleep(30)
                touchMove(380, 500)
                mSleep(30)
                touchMove(380, 450)
                mSleep(30)
                touchMove(380, 400)
                mSleep(30)
                touchUp(380, 350)
                mSleep(1000)
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    if (multiColor(battleIng["fightRollBackColor"])) then
                        nLog("发生倒回")
                        mSleep(2000)
                        tap(166, 527)
                        mSleep(1000)
                    end
                end
                mSleep(1500)
            end
            if
                (multiColor(battleIng["pvpYourRoundColor"]) and (not multiColor(battleIng["withoutFirstCardColor"])) and
                    (not multiColor(battleIng["firstCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                nLog("一号槽位有卡")
                touchDown(150, 550)
                mSleep(30)
                touchMove(150, 500)
                mSleep(30)
                touchMove(150, 450)
                mSleep(30)
                touchMove(150, 400)
                mSleep(30)
                touchUp(150, 350)
                mSleep(1000)
                while ((not multiColor(battleIng["pvpYourRoundColor"])) and multiColor(battleIng["yourFightColor"])) do
                    if (multiColor(battleIng["fightRollBackColor"])) then
                        nLog("发生倒回")
                        mSleep(2000)
                        tap(166, 527)
                        mSleep(1000)
                    end
                end
                mSleep(1500)
            end
            if (multiColor(battleIng["fightRollBackColor"])) then
                nLog("发生倒回")
                mSleep(2000)
                tap(166, 527)
                mSleep(1000)
            end

            if
                (multiColor(battleIng["pvpYourRoundColor"]) and
                    (multiColor(battleIng["firstCardUsedColor"]) and multiColor(battleIng["secondCardUsedColor"]) and
                        multiColor(battleIng["thirdCardUsedColor"])) and
                    multiColor(battleIng["yourFightColor"]))
             then
                -- if (multiColor(battleIng["pvpYourRoundColor"])) then
                mSleep(1000)
                nLog("结束回合")
                tap(495, 606)
                mSleep(500)
                tap(419, 638)
                flag = false
            end
        end
    end
end

function doorPve()
    while (true) do
        -- 点击确定
        if multiColor(general["bottomSureColor"]) then
            nLog("确定")
            tap(274, 911)
            mSleep(30)
        end
        beat()
        -- 点击下一步
        if multiColor(general["bottomNextColor"]) then
            nLog("下一步")
            tap(274, 911)
            mSleep(30)
        end
        --升级
        if multiColor(general["battleAfterLevelUpColor"]) then
            nLog("升级")
            tap(275, 480)
            mSleep(1000)
        end
        --打完门聊天
        if multiColor(general["bottomChat"]) then
            mSleep(1000)
            nLog("关闭聊天")
            tap(287, 901)
            mSleep(1000)
        end
        --进入主页面
        if (multiColor(general["loginAfterMain"])) then
            nLog("进入主界面")
            tap(382, 418)
            mSleep(1000)
        end
        --选择门
        if (multiColor(door["tapBattleDoorColor"])) then
            nLog("选择门")
            tap(89, 657)
            mSleep(2000)
            tap(280, 832)
            mSleep(1000)
        end
        --弹框确认
        if (multiColor(door["highLevelPopSureColor"])) then
            nLog("弹框确认")
            tap(388, 548)
            mSleep(1000)
        end
        --确认决斗
        if (multiColor(door["bottomBeginBattleColor"])) then
            nLog("确认决斗")
            tap(287, 834)
            mSleep(1000)
        end
        --钥匙数量不足
        if (multiColor(colorTable["doorKeyNoStock"])) then
            nLog("钥匙数量不足")
            tap(523, 462)
            mSleep(1000)
        end
    end
end
