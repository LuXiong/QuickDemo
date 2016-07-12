
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newSprite("background.jpg")
    :pos(display.cx, display.cy)
    :addTo(self)

	local title = display.newSprite("img_flyinggame.png")
	        :pos(display.cx / 2 * 3, display.cy)
	        :addTo(self)
	 
	local move1 = cc.MoveBy:create(0.5, cc.p(0, 10))
	local move2 = cc.MoveBy:create(0.5, cc.p(0, -10))
	local SequenceAction = cc.Sequence:create( move1, move2 )
	transition.execute(title, cc.RepeatForever:create( SequenceAction ))

	cc.ui.UIPushButton.new({ normal = "img_start.png", pressed = "img_start_clicked.png" })
	    :onButtonClicked(function()
	        print("start")
	    end)
	    :pos( display.cx / 2, display.cy )
	    :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
