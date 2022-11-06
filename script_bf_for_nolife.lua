if not game:IsLoaded() then 
    repeat game.Loaded:Wait()
    until game:IsLoaded() 
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("NOLIFE HUB", "DarkTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("farm")

local Weapon2 = nil
local Weapon = nil

spawn(function()
while wait() do
    if AutoEquiped then
        if Weapon == Melee then
            for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sharkman Karate")) do
                table.insert(Weapon2,v.Name)
            end
        end
    end
end
end)

Section:NewDropdown("select weapon", " ", {"Melee", "Sword"}, function(wp1)
    local Weapon = wp1
end)

Section:NewToggle("Auto Equip", " ", function(a)
AutoEquiped = a
end)

spawn(function()
while wait() do
if AutoEquiped then
pcall(function()
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(Weapon2))
end)
end
end
end)



local Tab = Window:NewTab("Melee")
local Section = Tab:NewSection("Melee")
Section:NewButton("BuyDeathStep", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
end)
Section:NewButton("BuyElectricClaw", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
end)
Section:NewButton("BuySuperhuman", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
end)
Section:NewButton("BuyGodhuman", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
end)
Section:NewButton("BuySharkmanKarate", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end)
Section:NewButton("Restats", "ButtonInfo", function()
    local args = {
    [1] = "BlackbeardReward",
    [2] = "Refund",
    [3] = "2"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
local Tab = Window:NewTab("TP World")
local Section = Tab:NewSection("TP World")
Section:NewButton("TP World1", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
end)
Section:NewButton("TP World2", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
end)
Section:NewButton("TP World3", "ButtonInfo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
end)
local Tab = Window:NewTab("setting")
local Section = Tab:NewSection("function rejoin")
Section:NewToggle("rejoin", "ToggleInfo", function(vs)
_G.Rejoin = vs
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
Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
