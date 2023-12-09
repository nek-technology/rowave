-- Created by @metricsrbx
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")

local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local New = Fusion.New
local Children = Fusion.Children

local COMPONENT_ONLY_PROPERTIES = {
	"StudioStyleGuideColor",
	"StudioStyleGuideModifier",
	Children,
}

local StudioComponents = script.Parent.Parent.StudioComponents
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")
-- local themeProvider = require(StudioComponentsUtil.themeProvider)

local stripProps = require(StudioComponentsUtil.stripProps)

local Background = require(StudioComponents.Background)
local Label = require(StudioComponents.Label)
local Title = require(StudioComponents.Title)
local ScrollFrame = require(StudioComponents.ScrollFrame)

export type Variables = {
	ClassName: string,
	Description: string,
}

return function(props, vars: Variables)
	local Class = Background({
		[Children] = {
			ScrollFrame({
				ZIndex = 1,
				Size = UDim2.fromScale(1, 1),

				CanvasScaleConstraint = Enum.ScrollingDirection.X,

				UILayout = New("UIListLayout")({
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 7),
				}),

				UIPadding = New("UIPadding")({
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingBottom = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 10),
				}),

				[Children] = {
					Title({
						Text = vars.ClassName,
						TextSize = 35,
					}),
					Label({
						Text = vars.Description,
					}),
					props[Children],
				},
			}),
		},
	})

	local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	return Fusion.Hydrate(Class)(hydrateProps)
end
