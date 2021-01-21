require("TSLib")
require("util")
require("color_source_750")

AppInit = {}

AppInit.startFlag = true

AppInit.judgeList = {
    {color = gameRun["startGameColor"], log = "游戏启动 开始游戏界面按钮", x = 342, y = 795, sleep = 2000},
    {color = general["fullScreenPopBackColor"], log = "通用 全屏弹框左下角返回", x = 63, y = 1229},
    {
        color = general["loginAfterMain"],
        log = "通用 登录后游戏主页面",
        func = function()
            AppInit.startFlag = false
        end
    }
}

AppInit.run = function()
    -- 初始化屏幕
    init(0)
    -- 启动APP
    if (not (runApp("com.netease.ma84") == 0)) then
        nLog("启动失败")
        AppInit.run()
    end
    --循环主体
    while (AppInit.startFlag) do
        Util.loopJudge(AppInit.judgeList)
    end
    nLog("App启动成功")
end
