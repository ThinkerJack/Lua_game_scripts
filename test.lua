--require("TSLib")
require("util")
-- 基类
Test = {}

Test.startFlag = true

Test.judgeList = {
    {
        func = function()
            print(Test.startFlag)
            Util.wait(3000)
            Test.startFlag = false
            print(Test.startFlag)
        end
    }
}

Test.run = function()
    print("启动")
    while (Test.startFlag) do
        Test.judgeList[1].func()
    end
    print("启动成功")
end
