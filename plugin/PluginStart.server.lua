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
	local APIwidgetEnabled = Value(false)
	local ExplorerEnabled = Value(false)
	local selection = game:GetService("Selection")
	local selectedObject = Value()

	local pluginToolbar = Toolbar({
		Name = "rowave",
	})

	selection.SelectionChanged:Connect(function()
		local selected = selection:Get()[1]
		if selected ~= nil then
			if selected:IsA("ModuleScript") then
				print("Enabled")
				APIwidgetEnabled:set(true) -- POPUP
				return selectedObject:set(selected)
			end
		else
			print("disabled")
			APIwidgetEnabled:set(false) -- CLOSE
			return selectedObject:set(nil)
		end
	end)

	local APIButton = ToolbarButton({
		Toolbar = pluginToolbar,

		ClickableWhenViewportHidden = true,
		Name = "View API",
		ToolTip = "View file's API",
		Image = "",
		Active = false,
	})
	
	local ExplorerButton = ToolbarButton({
		Toolbar = pluginToolbar,

		ClickableWhenViewportHidden = true,
		Name = "Explorer",
		ToolTip = "View Moonwave API",
		Image = "",

		[OnEvent("Click")] = function()
			ExplorerEnabled:set(not ExplorerEnabled:get())
		end,
	})

	Plugin.Unloading:Connect(Observer(APIwidgetEnabled):onChange(function()
		APIButton:SetActive(APIwidgetEnabled:get(false))
		ExplorerButton:SetActive(ExplorerEnabled:get(false))
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

			Enabled = APIwidgetEnabled,
			[OnChange("Enabled")] = function(isEnabled)
				APIwidgetEnabled:set(isEnabled)
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

	local function ExplorerWidget(children)
		return Widget({
			Id = game:GetService("HttpService"):GenerateGUID(),
			Name = "Explorer",

			InitialDockTo = Enum.InitialDockState.Float,
			InitialEnabled = false,
			ForceInitialEnabled = false,
			FloatingSize = Vector2.new(250, 200),
			MinimumSize = Vector2.new(250, 200),

			Enabled = ExplorerEnabled,
			[OnChange("Enabled")] = function(isEnabled)
				ExplorerEnabled:set(isEnabled)
			end,
			[Children] = {
				Label({
					Text = "Explorer",
				}),
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

					[Children] = children,
				}),
			},
		})
	end
	ExplorerWidget({
		[Children] = {
			Fusion.ForPairs(game:GetDescendants(), function(instance)
				if instance:IsA("ModuleScript") then
					
				end
			end),
		},
	})
end
