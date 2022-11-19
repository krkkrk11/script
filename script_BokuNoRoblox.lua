--All local to farm
local ws = game:GetService("Workspace")
local a1 = ws.NPCs["Awakened Tomura"].HumanoidRootPart.CFrame
local hv = CFrame.new(0,96,0)


--All function

function hitmon()
    wait(2)
    local args = {
        [1] = a1 * CFrame.Angles(0,0,0)
    }
    
    game:GetService("Players").LocalPlayer.Character.Main.Swing:FireServer(unpack(args))
    wait(1.6)
    local args2 = {
        [1] = a1 * CFrame.Angles(0,0,0)
    }
    game:GetService("Players").LocalPlayer.Character.Main.RightSwing:FireServer(unpack(args2))
end
function tptomon()
    local TweenService = game:GetService("TweenService")
    local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
    {CFrame = a1*hv}):Play()
end




--ui Library
 

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Nolife Hub", "DarkTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Auto farm")
Section:NewToggle("Autofarm", "ToggleInfo", function(state)
_G.Autofarm = state
end)
Section:NewButton("Equip gun", "ButtonInfo", function()
    local args = {
    [1] = "OrnamentBlaster"
    }
    
    game:GetService("ReplicatedStorage").WeaponShop.Equip:FireServer(unpack(args))
end)
local Tab = Window:NewTab("Stats")
local Section = Tab:NewSection("Auto up Stats")
Section:NewDropdown("Stats", "Stat", {"Strength", "Agility", "Durability"}, function(sadw)

end)
Section:NewToggle("Autoupstat", "ToggleInfo", function(stat)
_G.Autoupstat = stat
end)
local Tab = Window:NewTab("Teleport")
local Section = Tab:NewSection("Teleport to mon")
Section:NewButton("Tp Awakened Tomura", "ButtonInfo", function()
    local TweenService = game:GetService("TweenService")
    local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
    {CFrame = a1}):Play()
end)
local Tab = Window:NewTab("setting")
local Section = Tab:NewSection("function rejoin")
Section:NewToggle("rejoin", "ToggleInfo", function(rj)
_G.Rejoin = rj
spawn(function()
    while true do wait()
        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(Kick)
            if _G.Rejoin then
                if Kick.Name == 'ErrorPrompt' and Kick:FindFirstChild('MessageArea') and Kick.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                    wait(50)
                end
            end
        end)
    end
end)
end)
local Section = Tab:NewSection("Hide Ui")
Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)









--Auto All


spawn(function()
    while wait() do
        if _G.Autoupstat then
            if sadw == Strength then
                local args = {
                    [1] = 1
                }
                
                game:GetService("ReplicatedStorage").Remotes.Strength:FireServer(unpack(args))
            elseif Stats == Agility then
                local args = {
                    [1] = 1
                }
                
                game:GetService("ReplicatedStorage").Remotes.Agility:FireServer(unpack(args))
            elseif Stats == Durability then
                local args = {
                    [1] = 1
                }
                
                game:GetService("ReplicatedStorage").Remotes.Durability:FireServer(unpack(args))
            end
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Autofarm then
            hitmon()
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Autofarm then
            tptomon()
            game.workspace.Gravity = 0
        else
            game.workspace.Gravity = 196
        end
    end
end)
