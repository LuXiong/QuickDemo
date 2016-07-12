
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene.clickk(position)
	if position == currentP then
		print("ni ma")
	else
		currentP = position
		transition.moveTo(btn_rect, {time = 0.2, x = display.width/6 + display.width*(position-1)/3, 30})
	end
end

function MainScene:ctor()
	cc.Director:getInstance():setDisplayStats(false)

	currentP = 1

	choosed = cc.c3b(255,0,0)
	normal = cc.c3b(0, 0, 0)

	btn_rect = cc.ui.UIPushButton.new("rect.png")
		:pos( display.width/6, 30)
		:setButtonSize(display.width/3, 40)
	    :addTo(self)

	btn_game = cc.ui.UIPushButton.new()
		:pos(display.width/6, 30)
		:setButtonSize(display.width/3, 40)
		:setButtonLabel("normal",cc.ui.UILabel.new({
	    UILabelType = 2,
	    text = "游戏",
	    size = 20
	    }))
	    :onButtonClicked(function()
	        self.clickk(1)
	    end)
	    :addTo(self)

	btn_paih = cc.ui.UIPushButton.new()
		:pos(display.width*3/6, 30)
		:setButtonSize(display.width/3, 40)
		:setButtonLabel("normal",cc.ui.UILabel.new({
        UILabelType = 2,
        text = "排行",
        size = 20
        }))
        :onButtonClicked(function()
	        self.clickk(2)
	    end)
        :addTo(self)

	btn_huod = cc.ui.UIPushButton.new()
		:pos(display.width*5/6, 30)
		:setButtonSize(display.width/3, 40)
		:setButtonLabel("normal",cc.ui.UILabel.new({
        UILabelType = 2,
        text = "活动专区",
        size = 20
        }))
        :onButtonClicked(function()
	        self.clickk(3)
	    end)
        :addTo(self)
end





function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
