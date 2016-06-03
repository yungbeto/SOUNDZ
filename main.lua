local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.viewableContentWidth
local _H = display.viewableContentHeight
local screenTop = display.screenOriginY
local screenLeft = display.screenOriginX
local bottomMarg = display.viewableContentHeight - display.screenOriginY
local rightMarg = display.viewableContentWidth - display.screenOriginX

-- Grid
numberOfColumns = 16
columnWidth = math.floor( _W / numberOfColumns )    
function getColumnPosition( columnNumber )
   return (columnNumber - 1) * columnWidth
end
function getColumnWidth( numberOfColumns )
   return numberOfColumns * columnWidth
end   


--Variable to store what platform we are on.
local platform

--Check what platform we are running this sample on
if system.getInfo( "platformName" ) == "Android" then
	platform = "Android"
elseif system.getInfo( "platformName" ) == "Mac OS X" then
	platform = "Mac"
elseif system.getInfo( "platformName" ) == "Win" then
	platform = "Win"
else
	platform = "IOS"
end

local soundFileArray = {
	"river.mp3",
	"train.mp3",
	"rain.mp3",
	"burgerjoint.mp3",
	"fan.mp3",
	"city.mp3"
}

local riverSound = audio.loadStream( soundFileArray[1] )
local trainSound = audio.loadStream( soundFileArray[2] )
local rainSound = audio.loadStream( soundFileArray[3] )
local burgerSound = audio.loadStream( soundFileArray[4] )
local fanSound = audio.loadStream( soundFileArray[5] )
local citySound = audio.loadStream( soundFileArray[6] )

local audioVolume = 0.5 --Variables to hold audio states.
local audioWasStopped = false -- Variable to hold whether or not we have manually stopped the currently playing audio.

--Set the initial volume to match our initial audio volume variable
audio.setVolume( audioVolume, { channel = 0 } )





--Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

--Require the widget library ( we will use this to create buttons and other gui elements )
local widget = require( "widget" )
-- The device will auto-select the theme or you can set it here
widget.setTheme( "widget_theme_ios" )	-- iOS5/6 theme
widget.setTheme( "widget_theme_ios7" )	-- iOS7 theme
widget.setTheme( "widget_theme_android" )	  -- android theme

local bgg = {
	type = 'gradient',
	color1 = { 190/255, 250/255, 255/255 },
	color2 = { 190/255, 200/255, 255/255 },
	direction = "down" 
}
--Create a background
local background = display.newRect( centerX, centerY, _W, _H )
background:setFillColor( bgg )
------------------------------------------------
--DEFINING NAVBAR
------------------------------------------------

local gradient = {
   type = 'gradient',
   color1 = { 1, 1, 1 }, 
   color2 = { 1, 1, 1 },
   direction = "down"
}

local statusBox = display.newRect( centerX, 30, _W, 60 )
statusBox:setFillColor( gradient ) 
statusBox.fill = gradient
statusBox.alpha = .7

--Logo in status box
local statusLogo = display.newImageRect( "SOUNDZzz.png", 206, 19 )
statusLogo.x = statusBox.x
statusLogo.y = statusBox.y

------------------------------------------------
--DEFINING BUTTONS
------------------------------------------------

------------------------------------------------
--MUTE BUTTON
------------------------------------------------

--local mute1 = { type="image", filename="MUTE.png" }
--local mute2 = { type="image", filename="UNMUTE.png" }

--local mute = display.newRect( 0, 0, 33, 30 )
--mute.x = 275
--mute.y = 445
--mute.fill = mute1
--mute.whichMute = "1"

--local function handleTouch( event )
--   local t = event.target 
--  local phase = event.phase
--   if ( phase == "began" ) then
--if ( t.whichMute == "1" ) then
--   t.fill = mute2
--   t.whichMute = "2"
--   audio.getVolume( {channel=0} )
--   audio.setVolume( 0.0, {channel=0} )
--else
--   t.fill = mute1
--   t.whichMute = "1"
--   audio.getVolume( {channel=0} )
--   audio.setVolume( 0.5, {channel=0} )

--      end               
--      local parent = t.parent
--      parent:insert( t )
--      display.getCurrentStage():setFocus( t )
--      t.isFocus = true
--      t.x0 = event.x - t.x
--      t.y0 = event.y - t.y
--   elseif ( t.isFocus ) then
--      if ( "moved" == phase ) then
         -- Make object move
--         t.x = event.x - t.x0
--         t.y = event.y - t.y0
--      elseif ( "ended" == phase or "cancelled" == phase ) then
--         display.getCurrentStage():setFocus( nil )
--         t.isFocus = false
--      end
--   end
 
--   return true
--end
--mute:addEventListener( "touch", handleTouch )

--local muteButton = display.newImageRect( "MUTE.png", 33, 30)
--muteButton.x = 275
--muteButton.y = 445

------------------------------------------------
--RIVER BUTTON
------------------------------------------------

local river1 = { type="image", filename="RIVER.png" }
local river2 = { type="image", filename="RIVER_ACTIVE.png" }

local river = display.newRect( 0, 0, 80, 80 )
river.x = getColumnPosition(5.5)
river.y = 160
river.fill = river1
river.whichRiver = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichRiver == "1" ) then
   t.fill = river2
   t.whichRiver = "2"
   audio.setVolume( 0.5, {channel=1} )
   audio.getVolume( { channel=1 } )
   audioHandle = audio.play ( riverSound, {channel=1, loops=-1, fadein=1000} )
else
   t.fill = river1
   t.whichRiver = "1"
   audio.fadeOut ( {channel=1, time=1000} )
   audioWasStopped = true
      end
   end
 
   return true
end
river:addEventListener( "touch", handleTouch )


--local riverButton = display.newImageRect( "RIVER.png", 84, 51)
--riverButton.x = 90
--riverButton.y = 90

------------------------------------------------
--TRAIN BUTTON
------------------------------------------------

local train1 = { type="image", filename="TRAIN.png" }
local train2 = { type="image", filename="TRAIN_ACTIVE.png" }

local train = display.newRect( 0, 0, 80, 80 )
train.x = getColumnPosition(12.5)
train.y = 160
train.fill = train1
train.whichTrain = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichTrain == "1" ) then
   t.fill = train2
   t.whichTrain = "2"
   audio.setVolume( 0.5, {channel=2} )
   audio.getVolume( { channel=2 } )
   audioHandle = audio.play ( trainSound, {channel=2, loops=-1, fadein=1000} )
else
   t.fill = train1
   t.whichTrain = "1"
   audio.fadeOut ( {channel=2, time=1000} )
   audioWasStopped = true
             
      end
   end
 
   return true
end
train:addEventListener( "touch", handleTouch )


--local trainButton = display.newImageRect( "TRAIN.png", 67, 76)
--trainButton.x = 230
--trainButton.y = 90


------------------------------------------------
--RAIN BUTTON
------------------------------------------------

local rain1 = { type="image", filename="RAIN.png" }
local rain2 = { type="image", filename="RAIN_ACTIVE.png" }

local rain = display.newRect( 0, 0, 80, 80 )
rain.x = getColumnPosition(5.5)
rain.y = centerY + 30
rain.fill = rain1
rain.whichRain = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichRain == "1" ) then
   t.fill = rain2
   t.whichRain = "2"
   audio.setVolume( 0.5, {channel=3} )
   audio.getVolume( { channel=3 } )
   audioHandle = audio.play ( rainSound, {channel=3, loops=-1, fadein=1000} )
else
   t.fill = rain1
   t.whichRain = "1"
   audio.fadeOut( {channel=3, time=1000} )
   audioWasStopped = true
      end
   end
 
   return true
end
rain:addEventListener( "touch", handleTouch )

--local rainButton = display.newImageRect( "RAIN.png", 64, 73)
--rainButton.x = 90
--rainButton.y = 210


------------------------------------------------
--BURGER BUTTON
------------------------------------------------


local burger1 = { type="image", filename="BURGERJOINT.png" }
local burger2 = { type="image", filename="BURGERJOINT_ACTIVE.png" }

local burger = display.newRect( 0, 0, 80, 80 )
burger.x = getColumnPosition(12.5)
burger.y = centerY + 30
burger.fill = burger1
burger.whichBurger = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichBurger == "1" ) then
   t.fill = burger2
   t.whichBurger = "2"
   audio.setVolume( 0.5, { channel=4} )
   audio.getVolume( { channel=4 } )
   audioHandle = audio.play ( burgerSound, {channel=4, loops=-1, fadein=1000} )
else
   t.fill = burger1
   t.whichBurger = "1"
   audio.fadeOut( {channel=4, time=1000} )
   audioWasStopped = true
      end
   end
 
   return true
end
burger:addEventListener( "touch", handleTouch )

--local burgerButton = display.newImageRect( "BURGERJOINT.png", 68, 77)
--burgerButton.x = 230
--burgerButton.y = 210


------------------------------------------------
--FAN BUTTON
------------------------------------------------


local FAN1 = { type="image", filename="FAN.png" }
local FAN2 = { type="image", filename="FAN_ACTIVE.png" }

local fan = display.newRect( 0, 0, 80, 80 )
fan.x = getColumnPosition(5.5)
fan.y = bottomMarg - 90
fan.fill = FAN1
fan.whichFan = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichFan == "1" ) then
   t.fill = FAN2
   t.whichFan = "2"
   audio.setVolume( 0.5, {channel=5} )
   audio.getVolume( { channel=5 } )
   audioHandle = audio.play ( fanSound, {channel=5, loops=-1, fadein=1000} )
else
   t.fill = FAN1
   t.whichFan = "1"
   audio.fadeOut( {channel=5, time=1000} )
   audioWasStopped = true
      end               
   end
 
   return true
end
fan:addEventListener( "touch", handleTouch )

--local bathroomButton = display.newImageRect( "BATHROOM.png", 64, 73)
--bathroomButton.x = 90
--bathroomButton.y = 330


------------------------------------------------
--CITY BUTTON
------------------------------------------------


local city1 = { type="image", filename="CITY.png" }
local city2 = { type="image", filename="CITY_ACTIVE.png" }

local city = display.newRect( 0, 0, 80, 80 )
city.x = getColumnPosition(12.5)
city.y = bottomMarg - 90
city.fill = city1
city.whichCity = "1"

local function handleTouch( event )
   local t = event.target 
   local phase = event.phase
   if ( phase == "began" ) then
if ( t.whichCity == "1" ) then
   t.fill = city2
   t.whichCity = "2"
   audio.setVolume( 0.5, {channel=6} )
   audio.getVolume( {channel=6} )
   audioHandle = audio.play ( citySound, {channel=6, loops=-1, fadein=1000} )
else
   t.fill = city1
   t.whichCity = "1"
   audio.fadeOut ( {channel=6, time=1000} )
   audioWasStopped = true

      end
   end
 
   return true
end
city:addEventListener( "touch", handleTouch )

--local cityButton = display.newImageRect( "CITY.png", 70, 63)
--cityButton.x = 230
--cityButton.y = 330



local function onSystemEvent( event )

    local eventType = event.type

    if ( eventType == "applicationStart" ) then

    elseif ( eventType == "applicationExit" ) then
    	audio.stop()
    	audioWasStopped = true
    elseif ( eventType == "applicationSuspend" ) then
		audio.stop()
		audioWasStopped = true
    elseif ( eventType == "applicationResume" ) then
    elseif ( eventType == "applicationOpen" ) then
        --occurs when the application is asked to open a URL resource (Android and iOS only)
    end
end

Runtime:addEventListener( "system", onSystemEvent )
