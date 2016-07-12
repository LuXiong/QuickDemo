
local ScrollViewScene = class("ScrollViewScene", function()
    return display.newScene("ScrollViewScene")
end)

function ScrollViewScene:ctor()
   	local sp = display.newScale9Sprite("background.jpg")
	sp:pos(display.cx, display.cy)
	-- :addTo(self)

	local bound = {x = 100, y = 100, width = display.width-200, height = display.height-200}

	-- print(tostring(sp))
	cc.ui.UIScrollView.new({
	    direction = cc.ui.UIScrollView.DIRECTION_BOTH,
	    viewRect = bound, 
	    bgColor = cc.c4b(255,0,0,255)
	})
    :addScrollNode(sp)
    :onScroll(function (event)
        print("ScrollListener:" .. event.name)
    end) --注册scroll监听
    :addTo(self)
    :setBounceable(true) -- 是否有回弹效果(默认支持)

   
end

function ScrollViewScene:onEnter()

	-- cc.ui.UIScrollView.new({direction = UIScrollView.DIRECTION_BOTH, bg = "background.jpg"})
	-- :addTo(self)
end

function ScrollViewScene:onExit()
end

return ScrollViewScene