local TestService = game:GetService("TestService")
local TestEZ = require(TestService.TestEZ)
TestEZ.TestBootstrap:run({
	game.ReplicatedStorage.Plugin,
})
