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
	local widgetsEnabled = Value(false)
	local selection = game:GetService("Selection")
	local selectedObject = Value()

	local pluginToolbar = Toolbar({
		Name = "rowave",
	})

	selection.SelectionChanged:Connect(function()
		local selected = selection:Get()[1]
		if selected ~= nil then
			if selected:IsA("ModuleScript") then
				widgetsEnabled:set(true) -- POPUP
				return selectedObject:set(selected)
			end
		else
			widgetsEnabled:set(false) -- CLOSE
			return selectedObject:set(nil)
		end
	end)

	Plugin.Unloading:Connect(Observer(widgetsEnabled):onChange(function()
		widgetsEnabled:set(false)
	end))

	local function APIWidget(children)
		return Widget({
			Id = game:GetService("HttpService"):GenerateGUID(),
			Name = "API",

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
		-- DARK THIS IS WHERE WE EDIT AND ADD SHIT OK 
		},
	})
end
