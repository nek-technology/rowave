-- Any styling included here is universal and is a classic template by rowave developers.
-- It is designed to work well within ROBLOX Studio and as a plugin.

-- You can override the default styling variables here.

return {
	-- Colours
	PrimaryColor = Color3.fromHex("#00b1e9"),
	DarkMode = Color3.fromHex("#009fcf"),
	LightMode = Color3.fromHex("#14bbee"),

	-- Badges
	["Server"] = {
		Color = Color3.fromHex("#00CC67"),
		Image = "",
		Tip = "This item only works when running on the server",
	},
	["Client"] = {
		Color = Color3.fromHex("#349AD5"),
		Image = "",
		Tip = "This item only works when running on the client",
	},
	["Plugin"] = {
		Color = Color3.fromHex("#f39c12"),
		Image = "",
		Tip = "This item only works when running in the context of a plugin.",
	},
	["Yields"] = {
		Color = Color3.fromHex("#f1c40f"),
		Image = "",
		Tip = "This is a yielding function. When called, it will pause the Lua thread that called the function until a result is ready to be returned, without interrupting other scripts.",
	},
	["Private"] = {
		Color = Color3.fromHex("#9b59b6"),
		Image = "",
		Tip = "This item is only intended to be used by the module's authors.",
	},
	["Read Only"] = {
		Color = Color3.fromHex("#e74c3c"),
		Image = "",
		Tip = "This item is read only and cannot be modified.",
	},
	-- Other
}
