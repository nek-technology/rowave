local Plugin = plugin

local Components = script.Parent.Components
local Packages = script.Parent.Packages

local PluginComponents = Components:FindFirstChild("PluginComponents")
local Widget = require(PluginComponents.Widget)
local Toolbar = require(PluginComponents.Toolbar)
local ToolbarButton = require(PluginComponents.ToolbarButton)

local StudioComponents = Components:FindFirstChild("StudioComponents")
local ScrollFrame = require(StudioComponents.ScrollFrame)
local Label = require(StudioComponents.Label)

local Fusion = require(Packages.Fusion)

local New = Fusion.New
local Value = Fusion.Value
local Children = Fusion.Children
local OnChange = Fusion.OnChange
local OnEvent = Fusion.OnEvent
local Observer = Fusion.Observer

do
	local pluginToolbar = Toolbar({
		Name = "rowave",
	})

	local widgetsEnabled = Value(false)

	local enableButton = ToolbarButton({
		Toolbar = pluginToolbar,

		ClickableWhenViewportHidden = true,
		Name = "API",
		ToolTip = "View the API for your game",
		Image = "",

		[OnEvent("Click")] = function()
			widgetsEnabled:set(not widgetsEnabled:get())
		end,
	})

	Plugin.Unloading:Connect(Observer(widgetsEnabled):onChange(function()
		enableButton:SetActive(widgetsEnabled:get(false))
	end))

	local function APIWidget(children)
		return Widget({
			Id = game:GetService("HttpService"):GenerateGUID(),
			Name = "View API",

			InitialDockTo = Enum.InitialDockState.Right,
			InitialEnabled = false,
			ForceInitialEnabled = false,
			FloatingSize = Vector2.new(250, 200),
			MinimumSize = Vector2.new(250, 200),

			Enabled = widgetsEnabled,
			[OnChange("Enabled")] = function(isEnabled)
				widgetsEnabled:set(isEnabled)
			end,
			[Children] = ScrollFrame({
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

				[Children] = children,
			}),
		})
	end
	APIWidget({
		[Children] = {
			Label({
				Text = 'Test',
			}),
		},
	})
end