local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("NoName Hub", "DarkTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Auto farm")

local ws = game:GetService("Workspace")
local player = game:GetService("Workspace").krkkrk112233
local a1 = ws.NPCs["Awakened Tomura"].HumanoidRootPart.CFrame
local hv = CFrame.new(0,96,0)
local MONlist = nil
local Weaponlist = nil



for i,v in pairs(game:GetService("Players").krkkrk112233.PlayerGui.MainMenus.WeaponsMenu.ScrollingFrame:GetChildren()) do
    table.insert(Weaponlist,v.Name)
end



Section:NewDropdown("select weapon", " ", Weaponlist, function(wp)
    Weapon = wp
end)




Section:NewToggle("Autofarm", "ToggleInfo", function(state)
_G.tp = state
end)


function equip()
    local args = {
        [1] = Weapon
    }
    
    game:GetService("ReplicatedStorage").WeaponShop.Equip:FireServer(unpack(args))
end

function hitmon()
    wait(2)
    local args = {
        [1] = a1 * CFrame.Angles(0,0,0)
    }
    
    game:GetService("Players").LocalPlayer.Character.Main.Swing:FireServer(unpack(args))
end



spawn(function()
    while wait() do
        if _G.tp then
            player.HumanoidRootPart.CFrame = a1 * hv
            game.workspace.Gravity = 0
            hitmon()
        else
            game.workspace.Gravity = 196
        end
    end
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
