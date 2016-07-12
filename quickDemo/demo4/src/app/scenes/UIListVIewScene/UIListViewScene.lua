require(app.packageRoot .. ".scenes.".."UIListViewScene.Student")
require(app.packageRoot .. ".scenes.".."UIListViewScene.StudentNode")

local UIListViewScene = class("UIListViewScene", function()
  return display.newScene("UIListViewScene")
  end)

function UIListViewScene:ctor()
   -- cc.ui.UILabel.new({
   --          UILabelType = 2, text = "UIListViewScene", size = 64})
   --      :align(display.CENTER, display.cx, display.cy)
   --      :addTo(self)

 --    local sp = display.newScale9Sprite("background.jpg")
	-- sp:pos(display.cx, display.cy)
	-- :addTo(self)

	local bound = {x = 100, y = 100, width = display.width-200, height = display.height-200}

	-- print(tostring(sp))
	local list = cc.ui.UIListView.new({
   direction = cc.ui.UIScrollView.DIRECTION_BOTH,
   viewRect = bound, 
   bgColor = cc.c4b(120,120,120,255)
   })
  :onScroll(function (event)
    print("ScrollListener:" .. event.name)
    end) --注册scroll监听
  :addTo(self)
  :setBounceable(true)

  local studentList = {}

  for i=1,100 do
  	student = Student:new(nil,"xiongl",i)
    -- studentNode = StudentNode:new(student,bound)
    local lbl_content = cc.ui.UILabel.new({
      UILabelType = 2, 
      text = "student.age:"..tostring(i), 
      size = 24})
    :align(display.CENTER, bound.x+bound.width/2-100, bound.y+bound.height/2+i*30)

    item = list:newItem(lbl_content)
    list:addItem(item,1)
    print("added"..tostring(i))
  end



end

function UIListViewScene:onEnter()
end

function UIListViewScene:onExit()
end

return UIListViewScene