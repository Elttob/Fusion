local RunService = game:GetService("RunService")

local Package = game:GetService("ReplicatedStorage").Fusion
local New = require(Package.Instances.New)
local Children = require(Package.Instances.Children)
local OnChange = require(Package.Instances.OnChange)

local function waitForDefer()
	RunService.RenderStepped:Wait()
	RunService.RenderStepped:Wait()
end

return function()
	it("should connect property change handlers", function()
		local fires = 0
		local ins = New "Folder" {
			Name = "Foo",

			[OnChange "Name"] = function()
				fires += 1
			end
		}

		ins.Name = "Bar"

		waitForDefer()

		expect(fires).never.to.equal(0)
	end)

	it("should throw when connecting to non-existent property changes", function()
		expect(function()
			New "Folder" {
				Name = "Foo",

				[OnChange "Frobulate"] = function() end
			}
		end).to.throw("cannotConnectChange")
	end)

	it("shouldn't fire property changes during initialisation", function()
		local fires = 0
		local ins = New "Folder" {
			Parent = game,
			Name = "Foo",

			[OnChange "Name"] = function()
				fires += 1
			end,

			[OnChange "Parent"] = function()
				fires += 1
			end
		}

		local totalFires = fires
		ins:Destroy()

		waitForDefer()

		expect(totalFires).to.equal(0)
	end)
end