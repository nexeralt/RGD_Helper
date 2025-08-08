function CreateMSG(msg)
  local msg = tostring(msg)
  if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService then
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
  else
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
  end
end

function getPlrName(name)
  local target_name = tostring(name)
  local playerfound
  for i,v in pairs(game.Players:GetPlayers()) do
    if string.sub(v.Name, 1, #target_name):lower() == target_name:lower() then
      playerfound = v
      break
    end
  end
  if game.Players:FindFirstChild(target_name) then
    return game.Players[target_name]
  end
  if playerfound then
    return playerfound
  end
  return nil
end

function SafeTeleport(cfra)
  pcall(function()
    local time = tick()
    while tick() - time < 1 do
      for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v and v:IsA("BasePart") then
            v.Velocity = Vector3.new(0,0,0)
            v.RotVelocity = Vector3.new(0,0,0)
        end
      end
      game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = cfra
      task.wait()
    end
  end)
end

function IsNetworkOwnerOf(instance)
if not instance:IsA("BasePart") then return nil end
if instance.Anchored == true then
return false
end
return instance.ReceiveAge == 0
end

game:GetService("RunService").Heartbeat:Connect(function()
game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(9e9,9e9)*9e9
game:GetService("Players").LocalPlayer.SimulationRadius = math.pow(9e9,9e9)*9e9
task.wait(0.11)
end)

local PlayerToDefend = game.Players.LocalPlayer
local CurrentlyDefensing = false
local OldSpot = CFrame.new()
local KillauraRadius = 50
local HumanoidsConnection = nil
function Defense(mode)
  CurrentlyDefensing = mode
  if CurrentlyDefensing == true then
    OldSpot = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    task.spawn(function()
      repeat task.wait()
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v and v:IsA("BasePart") then
              v.Velocity = Vector3.new(0,0,0)
              v.RotVelocity = Vector3.new(0,0,0)
            end
          end
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = PlayerToDefend.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0,2,-2)
      until CurrentlyDefensing == false or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health == 0
    end)
    repeat task.wait(1)
      for i,v in pairs(workspace.Room.Enemies:GetChildren()) do
        if v and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Name == "Enemy" and not (v.Name:find("Friendly") or v.Name:find("Friend")) and IsNetworkOwnerOf(v:WaitForChild("HumanoidRootPart")) then
            v:ChangeState(Enum.HumanoidStateType.Dead)
        end
      end
    until CurrentlyDefensing == false or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health == 0
  elseif CurrentlyDefensing == false then
    SafeTeleport(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame)
  end
end

local CurrentlyTakingCircuits = false
local CircuitsConnection = nil
function TakeCircuits(mode)
  CurrentlyTakingCircuits = mode
  if CurrentlyTakingCircuits == true then
    for _,c in pairs(workspace:GetChildren()) do
      if c and c.Parent and c:IsA("UnionOperation") and c.Name == "Circuit" then
        task.spawn(function()
          local rng = tostring(math.random(1,9999999999))
          c.Name = rng
          c.CanCollide = false
          repeat task.wait()
            c.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          until workspace:FindFirstChild(rng) == nil
        end)
      end
    end
    CircuitsConnection = workspace.ChildAdded:Connect(function(c)
        if c and c.Parent and c:IsA("UnionOperation") and c.Name == "Circuit" then
          task.spawn(function()
            local rng = tostring(math.random(1,9999999999))
            c.Name = rng
            c.CanCollide = false
            repeat task.wait()
              c.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            until workspace:FindFirstChild(rng) == nil
          end)
        end
    end)
  elseif CurrentlyTakingCircuits == false then
    if CircuitsConnection then
      CircuitsConnection:Disconnect()
      CircuitsConnection = nil
    end
  end
end

function Commands(message)
  if message:match("-! help") then
    CreateMSG([[All command list:
1. ''-! help'' - list of commands.
2. ''-! target (plr name here)'' - name of player that will be defensed.
3. ''-! defense'' - start defensing player.
4. ''-! undefense'' - stop defensing player.
5. ''-! pickup'' - start loop picking up circuits. (money)
6. ''-! unpickup'' - stop loop picking up circuits. (money)
("..tostring(math.random(1,99))..")]])
    
  elseif message:match("-! target (%a+)") then
    local targetchoosen = getPlrName(message:match("-! target (%a+)"))
    if targetchoosen then
      PlayerToDefend = target
      CreateMSG("Target Choosen: "..tostring(target.Name).." ("..tostring(math.random(1,99))..")")
    end

  elseif message:match("-! defense") then
    pcall(function() Defense(true) CreateMSG("Defense is turned on! ("..tostring(math.random(1,99))..")") end)

  elseif message:match("-! undefense") then
    pcall(function() Defense(false) CreateMSG("Defense is turned off! ("..tostring(math.random(1,99))..")") end)

  elseif message:match("-! pickup") then
    pcall(function() TakeCircuits(true) CreateMSG("Circuits aura is turned on! ("..tostring(math.random(1,99))..")") end)

  elseif message:match("-! unpickup") then
    pcall(function() TakeCircuits(false) CreateMSG("Circuits aura is turned off! ("..tostring(math.random(1,99))..")") end)
    
  end
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
v.Chatted:Connect(Commands)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
v.Chatted:Connect(Commands)
end)

CreateMSG("RGD - Helper Loaded. Write ''-! help'' in chat for more info. ("..tostring(math.random(1,99))..")")
