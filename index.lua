local CombatFramework = {
	["HitBox"] = {
		Execute = function (Character: Model, CFramePosition: CFrame, Size: Vector3)
			local valueToReturn
			if not Character or not CFramePosition or not Size then
				warn("Error (HitBox): Missing arguments, aborting")
			elseif Character:IsA("Model") and Character:FindFirstChild("Humanoid") then
				local newHitBox = Instance.new("Part", workspace)
				newHitBox.Anchored = true; newHitBox.Transparency = 1; newHitBox.CFrame = CFramePosition; newHitBox.CastShadow = false; newHitBox.Size = Size; newHitBox.CanCollide = false; valueToReturn = newHitBox
			end
			return valueToReturn
		end,
	},
	
	["DebugHitBox"] = {
		Execute = function (Character: Model, CFramePosition: CFrame, Size: Vector3)
			local valueToReturn
			if not Character or not CFramePosition or not Size then
				warn("Error (DebugHitBox): Missing arguments, aborting")
			elseif Character:IsA("Model") and Character:FindFirstChild("Humanoid") then
				local newHitBox = Instance.new("Part", workspace)
				newHitBox.Anchored = true; newHitBox.Transparency = 0; newHitBox.CFrame = CFramePosition; newHitBox.CastShadow = false; newHitBox.Size = Size; newHitBox.CanCollide = false; newHitBox.Color = Color3.fromRGB(255,0,0); newHitBox.Material = Enum.Material.ForceField; valueToReturn = newHitBox
			end
			return valueToReturn
		end,
	},
	
	["Damage"] = {
		Execute = function (Character: Model, Amount: number)
			if not Character or not Amount then
				warn("Error (Damage): Missing arguments, aborting")
			elseif Character:IsA("Model") and Character:FindFirstChild("Humanoid") then
				print(Amount)
				Character.Humanoid:TakeDamage(Amount)
			end
		end,
	},
	
	["PlaySound"] = {
		Execute = function (Character: Model, Timer: number, SoundInstance: Sound)
			if not Character or not Timer or not SoundInstance then
				warn("Error (PlaySound): Missing arguments, aborting")
			elseif Character:IsA("Model") and Character:FindFirstChild("Humanoid") then
				local newAudio = SoundInstance:Clone(); newAudio.Parent = Character:WaitForChild("HumanoidRootPart", 5); newAudio:Play()
				task.delay(Timer, function()
					game.Debris:AddItem(newAudio, 0)
				end)
			end
		end,
	},
	
	["PlayAnimation"] = {
		Execute = function (Character: Model, AnimationInstance: Animation)
			local valueToReturn
			if not Character or not AnimationInstance then
				warn("Error (PlayAnimation): Missing arguments, aborting")
			elseif Character:IsA("Model") and Character:FindFirstChild("Humanoid") and AnimationInstance:IsA("Animation") then
				local newTrack = Character.Humanoid:LoadAnimation(AnimationInstance); newTrack:Play(); valueToReturn = newTrack; newTrack.Stopped:Connect(function()
					game.Debris:AddItem(newTrack, 0)
				end)
			end
			return valueToReturn
		end,
	},

	["Knockback"] = {
		Execute = function (Character: Model, Target: Model, ZValue: number, YValue: number, XValue: number)
			if not Character or not Target or not ZValue then
				warn("Error (Knockback): Missing arguments, aborting")
			else
				local KnockBackPos = Target.HumanoidRootPart.Position + Vector3.new(XValue, YValue, ZValue)
				local KnockBack = Instance.new("LinearVelocity", Target.HumanoidRootPart)
				local Attachment = Instance.new("Attachment", Target.HumanoidRootPart)
				KnockBack.MaxForce = math.huge
				KnockBack.VectorVelocity = KnockBackPos
				KnockBack.Attachment0 = Attachment
				game.Debris:AddItem(KnockBack, .5); game.Debris:AddItem(Attachment, .5)
			end
		end,
	},
	
	["MoveForward"] = {
		Execute = function (Character: Model, ZValue: number)
			if not Character or not ZValue then
				warn("Error (MoveForward): Missing arguments, aborting")
			else
				local KnockBackPos = Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(0,0,-ZValue))
				local KnockBack = Instance.new("BodyPosition", Character.HumanoidRootPart)
				KnockBack.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				KnockBack.Position = KnockBackPos.p
				KnockBack.D = 150
				KnockBack.P = 2500
				game.Debris:AddItem(KnockBack, .5)
			end
		end,
	},
	
	["MoveBackward"] = {
		Execute = function (Character: Model, ZValue: number)
			if not Character or not ZValue then
				warn("Error (MoveBackward): Missing arguments, aborting")
			else
				local KnockBackPos = Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(0,0,ZValue))
				local KnockBack = Instance.new("BodyPosition", Character.HumanoidRootPart)
				KnockBack.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				KnockBack.Position = KnockBackPos.p
				KnockBack.D = 150
				KnockBack.P = 10000
				game.Debris:AddItem(KnockBack, .1)
			end
		end,
	},
	
	["GroundUproot"] = { -- No arg checks
		Execute = function(Character: Model)
			if not workspace:FindFirstChild("DebrisFolder") then
				local A_1 = Instance.new("Folder", workspace); A_1.Name = "DebrisFolder"
			end
			local RayParams = RaycastParams.new()
			RayParams.FilterDescendantsInstances = {workspace.DebrisFolder}
			RayParams.FilterType = Enum.RaycastFilterType.Blacklist
			local Angle = 0
			for i = 1,30 do
				local HRP = Character:WaitForChild("HumanoidRootPart", 5)
				local Size = math.random(2,3)
				local Part = Instance.new("Part"); Part.Anchored = true; Part.Size = Vector3.new(4,4,4)
				Part.CFrame = HRP.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(Angle), 0) * CFrame.new(10, 5, 0); game.Debris:AddItem(Part, 5)
				
				local RayCast = workspace:Raycast(Part.CFrame.p, Part.CFrame.UpVector * -10, RayParams)
				if RayCast then
					Part.Position = RayCast.Position + Vector3.new(0, -5, 0)
					Part.Material = RayCast.Instance.Material
					Part.Color = RayCast.Instance.Color
					Part.Orientation = Vector3.new(math.random(-180,180), math.random(-180,180), math.random(-180,180))
					Part.Parent = workspace.DebrisFolder
					
					local Tween = game:GetService("TweenService"):Create(Part, TweenInfo.new(.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut), {Position = Part.Position + Vector3.new(0, 5, 0)}):Play()
					task.delay(4, function()
						local Tween = game:GetService("TweenService"):Create(Part, TweenInfo.new(1), {Transparency = 1, Position = Part.Position + Vector3.new(0, -5, 0)}):Play()
					end)
				end
				Angle += 25
			end
		end,

		["CreateCoreValue"] = {
			Boolean = function(Character: Model, Expires: boolean, Name: string)
				if not Character or not Expires or not Name then
					warn("Error (CreateCoreValue[Boolean]): Missing arguments, aborting")
				else
					local newCoreValue = Instance.new("BoolValue", Character)
					newCoreValue.Name = Name
				end
			end,

			Integer = function(Character: Model, Expires: boolean, Name: string)
				if not Character or not Expires or not Name then
					warn("Error (CreateCoreValue[Integer]): Missing arguments, aborting")
				else
					if Character:FindFirstChild(Name) then
						local OldValue = Character[Name]
						OldValue.Value += Expires
					else
						local newCoreValue = Instance.new("IntValue", Character)
						newCoreValue.Name = Name
						newCoreValue.Value = Expires
						task.spawn(function()
							while task.wait(1) do
								if newCoreValue <= 0 then break end
								newCoreValue.Value -= 1
							end

							newCoreValue:Destroy()
						end)
					end
				end
			end
		}
	};
}

return CombatFramework
