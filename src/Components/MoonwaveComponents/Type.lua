-- Created by @metricsrbx
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")

local Fusion = require(Plugin:FindFirstChild("Fusion", true))
local New = Fusion.New
local Children = Fusion.Children
local ForKeys = Fusion.ForKeys

local COMPONENT_ONLY_PROPERTIES = {
	"StudioStyleGuideColor",
	"StudioStyleGuideModifier",
}

local StudioComponents = script.Parent.Parent.StudioComponents
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")
local themeProvider = require(StudioComponentsUtil.themeProvider)

local stripProps = require(StudioComponentsUtil.stripProps)

local Background = require(StudioComponents.Background)
local Label = require(StudioComponents.Label)
local Title = require(StudioComponents.Title)
local IconButton = require(StudioComponents.IconButton)

local Styling = require(script.Parent.Parent.Parent.Styling)
export type Variables = {
	Name: string,
	Fields: table,
	Badges: table,
	Description: string,
}

return function(props: Variables)
	local Interface = Background({
		[Children] = {
			New("UIListLayout")({
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 7),
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
			}),

			New("Frame")({ -- Header
				Name = "Header",
				Size = UDim2.fromScale(1, 0.1),
				Position = UDim2.fromScale(0, 0),
				AnchorPoint = Vector2.new(0, 0),
				LayoutOrder = 0,
				ZIndex = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = themeProvider:GetColor(
					props.StudioStyleGuideColor or Enum.StudioStyleGuideColor.MainBackground,
					props.StudioStyleGuideModifier
				),
				[Children] = {
					New("UIListLayout")({
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 3.5),
					}),
					Title({
						Text = "Types",
						TextSize = 35,
					}),
                    --TODO: Padding and syncing to Styling
					New("Frame")({
						Name = "Line",
						Size = UDim2.fromScale(1, 0.01),
						Position = UDim2.fromScale(0, 0),
						BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText, props.StudioStyleGuideModifier),
					}),
				},
			}),
			New("Frame")({ -- Topbar
				Name = "Topbar",
				Size = UDim2.fromScale(1, 0.1),
				Position = UDim2.fromScale(0, 0),
				AnchorPoint = Vector2.new(0, 0),
				LayoutOrder = 0,
				ZIndex = 1,
				BorderSizePixel = 0,
				BackgroundColor3 = themeProvider:GetColor(
					props.StudioStyleGuideColor or Enum.StudioStyleGuideColor.MainBackground,
					props.StudioStyleGuideModifier
				),

				[Children] = {
					New("UIListLayout")({
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 5),
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),
					New("UIPadding")({
						Name = "BorderUIPadding",
						PaddingRight = UDim.new(0, 1),
						PaddingLeft = UDim.new(0, 1),
						PaddingTop = UDim.new(0, 1),
						PaddingBottom = UDim.new(0, 1),
					}),

					Title({
						Text = props.Name,
						TextSize = 35,
					}),
					-- 		ForKeys(vars.Badges, function(index) end),

					IconButton({
						Icon = "rbxassetid://7072707514",
						Size = UDim2.fromScale(0.05, 0.5),
						Activated = function()
							print("Yooo")
						end,
						[Children] = {
							{
								New("UICorner")({
									CornerRadius = UDim.new(0.5, 0),
								}),

								New("UIStroke")({
									ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
									Color = Styling.White,
									Thickness = 0.2,
									Transparency = 0,
								}),
							},
						},
					}),
				},
			}),

			Label({
				Text = `Markdown`,
			}),
			Label({
				Text = props.Description,
			}),
		},
	})

	local hydrateProps = stripProps({}, COMPONENT_ONLY_PROPERTIES)
	return Fusion.Hydrate(Interface)(hydrateProps)
end
