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
local themeProvider = require(StudioComponentsUtil.themeProvider)

local stripProps = require(StudioComponentsUtil.stripProps)

local Background = require(StudioComponents.Background)
local Label = require(StudioComponents.Label)
local Title = require(StudioComponents.Title)

export type Variables = {
	ClassName: string,
	Description: string,
}

return function(props, vars: Variables)
	local Class = Background({
		[Children] = {
			New("Frame")({
				ZIndex = 1,
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = themeProvider:GetColor(
					props.StudioStyleGuideColor or Enum.StudioStyleGuideColor.MainBackground, 
					props.StudioStyleGuideModifier
				),
				[Children] = {
					New("UIListLayout")({
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 7),
					}),

					Title({
						Text = vars.ClassName,
						TextSize = 43,
					}),
					Label({
						Text = vars.Description,
					}),
					props.Children,
				},
			}),
		},
	})

	local hydrateProps = stripProps({}, COMPONENT_ONLY_PROPERTIES)
	return Fusion.Hydrate(Class)(hydrateProps)
end
