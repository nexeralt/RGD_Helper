local ScriptLaunched, ScriptError = pcall(function()
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/nexeralt/Die-Of-Death/refs/heads/main/main.lua"))()

--[[

Function List Begins NOW!

]]--

function CreateMSG(msg)
  local msg = tostring(msg)
  game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(msg)
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
if not instance:IsA("BasePart") then return false end
if instance.Anchored == true then
return false
end
return instance.ReceiveAge == 0
end

game:GetService("RunService").RenderStepped:Connect(function()
game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(9e9,9e9)*9e9
game:GetService("Players").LocalPlayer.SimulationRadius = math.pow(9e9,9e9)*9e9
pcall(function()
local shp = sethiddenproperty or set_hidden_property or set_hidden_prop or sethidden
if shp then
shp(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", math.pow(9e9,9e9)*9e9)
shp(game:GetService("Players").LocalPlayer, "SimulationRadius", math.pow(9e9,9e9)*9e9)
end
end)
pcall(function()
settings().Physics.AllowSleep = false
end)
pcall(function()
setsimulationradius(math.huge*math.huge,math.huge*math.huge)
end)
task.wait()
end)

function TableFirstElementToString(tbl)
if type(tbl) == "table" then
for _,element in ipairs(tbl) do
return tostring(element)
end
else
return tostring(tbl)
end
end

pcall(function()
Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
end)

pcall(function()
Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

function Notify(title, content, time, mode)
time = time or 10
mode = mode or false
if mode == true then
img = 136186846844342
elseif mode == false then
img = 71508738660632
end
Rayfield:Notify({
	Title = title,
	Content = content,
	Duration = time,
	Image = img,
	Actions = {},
})
end

pcall(function()
WebHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pro666Pro/CustomFunctions/refs/heads/main/funcs.txt"))()
end)

pcall(function()
game:GetService("CoreGui")
end)

if not game:FindService("CoreGui") then
game:GetService("StarterGui"):SetCore("SendNotification",{Title = "Error!",Text = "Your executor don't have access to core gui which is being used for UI library! Script stopped loading.",Icon = "rbxassetid://125704683916878",Duration = 36000,Button1 = "Ok!"})
return nil
end

pcall(function()
game = game or workspace.Parent or Ugc or _game or __game
end)
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

Window = Rayfield:CreateWindow({
   Name = "RGD - nexer hub",
   Icon = 0,    
   LoadingTitle = "RGD - nexer hub",
   LoadingSubtitle = "by nexer",
   Theme = "Ocean",
   DisableRayfieldPrompts = true,
   DisableBuildWarnings = true,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = "Server_Management",
      FileName = "Servers_Management"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "WARNING ⚠️",
      Subtitle = "Please note that any form of exploiting is always bannable.",
      Note = "If you accept the risk, you can continue. The key is ''nexer1234''",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"nexer1234","NEXER1234","Nexer1234"}
   }
})

local MainTab = Window:CreateTab("Main Functions",0)

local NWOAbuseTab = Window:CreateTab("Network Ownership Abuse",0)
    
local CircuitsTab = Window:CreateTab("Circuits",0)
    

    
UpdateRate = 1
CurrentServer:CreateInput({Name = "Update Rate (in seconds)"; PlaceholderText = "1"; NumbersOnly = true; OnEnter = true; RemoveTextAfterFocusLost = false; Callback = function(Value)
UpdateRate = tonumber(Value)
end; })
    
CurrentServer:CreateSection("Server Geolocation")
    
AutoUpdateGeolocation = true
CurrentServer:CreateToggle({Name = "Auto-Update Geolocation"; CurrentValue = true; Callback = function(Value)
AutoUpdateGeolocation = Value
end; })

game:GetService("NetworkClient").ConnectionAccepted:Connect(function(serverip)
	local sinfo = game:GetService("HttpService"):JSONDecode(game:HttpGet("http://ipinfo.io/"..string.split(serverip, "|")[1].."/json"))
	ServerInfo["ServerCountry"] = tostring(sinfo["country"])
  ServerInfo["ServerRegion"] = tostring(sinfo["region"])
	ServerInfo["ServerCity"] = tostring(sinfo["city"])
end)
    
local CountryLabel = CurrentServer:CreateLabel("")
local RegionLabel = CurrentServer:CreateLabel("")
local CityLabel = CurrentServer:CreateLabel("")

task.delay(0,function()
task.spawn(function()
while true do
if AutoUpdateGeolocation ~= false then
CountryLabel:Set("Server Country Position: "..ServerInfo["ServerCountry"].."")
RegionLabel:Set("Server Region Position: "..ServerInfo["ServerRegion"].."")
CityLabel:Set("Server City: "..ServerInfo["ServerCity"].."")
end
task.wait(UpdateRate)
end
end)
end)

CurrentServer:CreateSection("Server Properties/Parametres")

AutoUpdateProps = true
CurrentServer:CreateToggle({Name = "Auto-Update Properties/Parametres"; CurrentValue = true; Callback = function(Value)
AutoUpdateProps = Value
end; })

game:GetService("RunService").RenderStepped:Connect(function()
  ServerInfo["ServerGameID"] = tostring(game.PlaceId)
  ServerInfo["ServerJobID"] = tostring(game.JobId)
  ServerInfo["ServerAge"] = ""..math.floor(workspace.DistributedGameTime / 60 / 60).." Hour(s) and "..math.floor(workspace.DistributedGameTime / 60) - (math.floor(workspace.DistributedGameTime / 60 / 60) * 60).." Minutes"
  ServerInfo["ServerPlayers"] = ""..#game.Players:GetPlayers().."/"..game.Players.MaxPlayers..""
  ServerInfo["ServerPing"] = ""..tostring(tonumber(string.split(stats:WaitForChild("Network"):WaitForChild("ServerStatsItem"):WaitForChild("Data Ping"):GetValueString(), " ")[1])).."ms"
end)

local GameIDLabel = CurrentServer:CreateLabel("")
local JobIDLabel = CurrentServer:CreateLabel("")
local PlayerCountLabel = CurrentServer:CreateLabel("")
local ServerAgeLabel = CurrentServer:CreateLabel("")
local PingLabel = CurrentServer:CreateLabel("")

task.delay(0,function()
task.spawn(function()
while true do
if AutoUpdateProps ~= false then
PingLabel:Set("Server Ping: "..ServerInfo["ServerPing"].."")
PlayerCountLabel:Set("Player Count: "..ServerInfo["ServerPlayers"].."")
ServerAgeLabel:Set("Server Age: "..ServerInfo["ServerAge"].."")
ServerAgeLabel:Set("Server Game ID: "..ServerInfo["ServerGameID"].."")
ServerAgeLabel:Set("Server Job ID: "..ServerInfo["ServerJobID"].."")
end
task.wait(UpdateRate)
end
end)
end)

local ServersManagement = Window:CreateTab("Servers Manager",0)

ServersManagement:CreateSection("Settings")
  
ExcludeFullServers = true
ServersManagement:CreateToggle({Name = "Exclude Full Servers"; CurrentValue = true; Callback = function(Value)
ExcludeFullServers = Value
end; })

ServerSortType = "Descending"
ServersManagement:CreateDropdown({Name = "Server Sort"; Options = {"Descending","Ascending","Random"}; CurrentOption = "Descending"; MultiSelection = false; Callback = function(Value)
ServerSortType = TableFirstElementToString(Value)
end; })

PingTrigger = 300
CurrentServer:CreateInput({Name = "Ping Trigger"; PlaceholderText = "300"; NumbersOnly = true; OnEnter = true; RemoveTextAfterFocusLost = false; Callback = function(Value)
PingTrigger = tonumber(Value)
end; })

IgnoreIfTooMuchPing = true
ServersManagement:CreateToggle({Name = "Ignore Servers with More Ping than Trigger"; CurrentValue = true; Callback = function(Value)
IgnoreIfTooMuchPing = Value
end; })

ServersManagement:CreateSection("Settings")
    
local ServerList = ServersManagement:CreateDropdown({Name = "Server List"; Options = {"No Servers"}; CurrentOption = ""; MultiSelection = false; Callback = function(Value)
ChoosenServer = TableFirstElementToString(Value)
end; })
    
ServersManagement:CreateButton({Name = "Scan Servers"; Callback = function()

end; })

ServerList:Refresh()
  
PremiumFeatures:CreateSection("Advanced Anti (｡･∀･)ﾉﾞ")

PremiumFeatures:CreateToggle({Name = "Anti-Stun"; CurrentValue = false; Callback = function(Value)
if HavePremium() ~= true then
ErrorPremium()
return nil
end
AntiStun = Value
if AntiStun == true then
Notify("Success!", "Anti-Stun is now enabled!", 4, true)
repeat task.wait()
if HaveAtt("WalkSpeedModifier") and GetAtt("WalkSpeedModifier") ~= 0 then
SetAtt("WalkSpeedModifier", 0)
end
if HaveAtt("StaminaModifier") and GetAtt("StaminaModifier") ~= 0 then
SetAtt("StaminaModifier", 0)
end
until AntiStun == false
end
end; })




end)
if not ScriptLaunched then
print(ScriptError)
warn(ScriptError)
error(ScriptError)
end
