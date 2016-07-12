
local OtherScene = class("OtherScene", function()
	return display.newScene("OtherScene")
	end)

function OtherScene:ctor()
	local function touchListener( envent )
		dump(event, "TestUIPageViewScene - event:")
	end
	self.pv = cc.ui.UIPageView.new({
		viewRect = cc.rect(0,0,200,500),
		column = 2, row = 2,
		padding = {left = 0, right = 0, top = 0, bottom = 0},
		columnSpace = 0, rowSpace = 0, bCirc = false
		})
	:onTouch(touchListener)
	:addTo(self)

	for i=1,4 do
		local item = self.pv:newItem()
		local content = display.newColorLayer(
			cc.c4b(i*50,
				0,
				0,
				250))
		content:setContentSize(200, 200)
		content:setTouchEnabled(false)
		item:addChild(content)
		self.pv:addItem(item)
	end
	self.pv:reload()
end






-- local function touchListener(event)
--     dump(event, "TestUIPageViewScene - event:")
-- end
-- self.pv = cc.ui.UIPageView.new({
--     viewRect = cc.rect(80, 240, 480, 480),
--     column = 3, row = 3,
--     padding = {left = 20, right = 20, top = 20, bottom = 20},
--     columnSpace = 10, rowSapce = 10, bCirc = true})
--     :onTouch(touchListener)
--     :addTo(self)

-- for i=1,18 do
--     local item = self.pv:newItem()
--     local content = display.newColorLayer(
--         cc.c4b(math.random(250),
--             math.random(250),
--             math.random(250),
--             250))
--     content:setContentSize(240, 140)
--     content:setTouchEnabled(false)
--     item:addChild(content)
--     self.pv:addItem(item)
-- end
-- self.pv:reload()

function OtherScene:onEnter()
end

function OtherScene:onExit()
end

return OtherScene