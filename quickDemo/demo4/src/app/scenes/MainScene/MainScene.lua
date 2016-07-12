
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    cc.Director:getInstance():setDisplayStats(false)

    local btn_scroll = cc.ui.UIPushButton.new()
					    :pos(display.cx, display.cy+100)
						:setButtonSize(display.width/3, 40)
						:setButtonLabel("normal",cc.ui.UILabel.new({
				        UILabelType = 2,
				        text = "滚动视图",
				        size = 20
				        }))
				        :onButtonClicked(function()
					        app:enterScene("ScrollViewScene/ScrollViewScene", {name = "xiongl",age = "24"}, "SLIDEINT", 0.4)
					    end)
				        :addTo(self)
	local btn_scroll = cc.ui.UIPushButton.new()
					    :pos(display.cx, display.cy)
						:setButtonSize(display.width/3, 40)
						:setButtonLabel("normal",cc.ui.UILabel.new({
				        UILabelType = 2,
				        text = "列表视图",
				        size = 20
				        }))
				        :onButtonClicked(function()
					        app:enterScene("UIListViewScene/UIListViewScene", {name = "xiongl",age = "23"}, "SLIDEINL", 0.4)
					    end)
				        :addTo(self)

	local btn_scroll = cc.ui.UIPushButton.new()
					    :pos(display.cx, display.cy-100)
						:setButtonSize(display.width/3, 40)
						:setButtonLabel("normal",cc.ui.UILabel.new({
				        UILabelType = 2,
				        text = "其他控件",
				        size = 20
				        }))
				        :onButtonClicked(function()
					        app:enterScene("OtherScene/OtherScene", {name = "xiongl",age = "22"}, "SLIDEINR", 0.4)
					    end)
				        :addTo(self)


end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
