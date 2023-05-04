# Combat Framework
In a general overview, this specific script is made to make combat-systems in ROBLOX Studio easier to create in manage.

# Documentation
The line of code below should be at the top of your script, and you should understand how to reference and use modules.
```lua
local Module = require(game:GetService("ServerStorage"):WaitForChild("CombatFramework"))
```

Now, the lines of code will callback for that local value, Module.
```lua 
local HitBox = Module.HitBox.Execute(Character: Model, CFramePosition: CFrame, Size: Vector3)
```
```lua 
local DebugHitBox = Module.DebugHitBox.Execute(Character: Model, CFramePosition: CFrame, Size: Vector3)
```
```lua
Module.Damage.Execute(Character: Model, Amount: number)
```
```lua
Module.EmittParticles.Execute() --DEPRECATED!
```
```lua
Module.PlaySound.Execute(Character: Model, Timer: number, SoundInstance: Sound)
```
```lua
Module.PlayAnimation.Execute(Character: Model, AnimationInstance: Animation)
```
```lua
Module.Knockback.Execute(Character: Model, Target: Model, ZValue: number, YValue: number, XValue: number)
```
```lua
Module.MoveForward.Execute(Character: Model, ZValue: number)
```
```lua
Module.MoveBackward.Execute(Character: Model, ZValue: number)
```
```lua
Module.GroundUproot.Execute(Character: Model) -- WARNING: BETA FEATURE
```
```lua
Module.CreateCoreValue.Boolean(Character: Model, Expires: boolean, Name: string)
```
```lua
Module.CreateCoreValue.Integer(Character: Model, Expires: boolean, Name: string)
```
