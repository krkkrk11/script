HttpService = game:GetService("HttpService")
local plrcount = 0
local PlayerName = game.Players.LocalPlayer.Name
function getworld()
    local ReturnText = ""
        if game.PlaceId == 10321372166 then
            ReturnText = "Hardcore World"
        else
            ReturnText = "Normal World"
        end
    return ReturnText
end
function HopLowServer()
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            function TPReturner()
                local Site;
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0;
                for i,v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _,Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        -- delfile("NotSameServers.json")
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                    end)
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(function()
                                -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                                wait()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                            end)
                            wait(.1)
                        end
                    end
                end
            end
            function Teleport()
                while wait(.2) do
                    pcall(function()
                        TPReturner()
                        if foundAnything ~= "" then
                            TPReturner()
                        end
                    end)
                end
            end
            Teleport()
end
function TripleDamage()
    local ReturnText = ""
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Triple Damage") then
        ReturnText = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts["Server Triple Damage"].TimeLeft.Text
    elseif not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Triple Damage") then
        ReturnText = "N/A"
    end
    return ReturnText
end
function TripleCoins()
    local ReturnText = ""
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Triple Coins") then
        ReturnText = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts["Server Triple Coins"].TimeLeft.Text
    elseif not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Triple Coins") then
        ReturnText = "N/A"
    end
    return ReturnText
end
function SuperLucky()
    local ReturnText = ""
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Super Lucky") then
        ReturnText = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts["Server Super Lucky"].TimeLeft.Text
    elseif not game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Server Super Lucky") then
        ReturnText = "N/A"
    end
    return ReturnText
end
for i,v in pairs(game.Players:GetChildren()) do
if v:IsA("Player") then -- Check if it's a player.
       plrcount = plrcount+1 -- Update the player count.
    end
end
local Embeds = {{
    ["title"] = "**Server Webhooks Status**",
    ["color"] = tonumber(0xD936FF),
    ["fields"] = {
    	{
    		["name"] = "User Name",
    		["value"] = "||"..tostring(game.Players.LocalPlayer.Name).."||",
    		["inline"] = false
    	},
    	{
            ["name"] = "🌐World",
            ["value"] = tostring(getworld()),
            ["inline"] = true
        },
        {
            ["name"]  = "Server-jobId",
            ["value"] = "`"..tostring(game.jobId).."`",
            ["inline"] = true
        },
        {
            ["name"] = "▶Player",
            ["value"] = "Players : "..tostring(plrcount).."/12",
            ["inline"] = false
        },
        {
            ["name"] = "Server Boosts",
            ["value"] = "Server Triple Damage : "..tostring(TripleDamage()).."\nServer Triple Coin : "..tostring(TripleCoins()).."\nServer Super Lucky : "..tostring(SuperLucky()),
            ["inline"] = false
        },
    },
    ["footer"] = {
    	["text"] = "Made by ! Nolife#2140".."\nTime".." : "..os.date("%c").." ("..os.date("%X")..")",
    	["icon_url"] = "https://cdn.discordapp.com/attachments/1005104534072332330/1048216661750190161/lol.png"
    },
}}



Message = {
			['username'] = "Psx-Webhook",
			["avatar_url"] = "https://cdn.discordapp.com/attachments/1005104534072332330/1048216661750190161/lol.png",
			["content"] = "@everyone",
			["embeds"] = Embeds,
		}
if syn then
   AllRequest = syn.request
   else
   AllRequest = http_request
end

AllRequest({
	Url = Webhook_URL,
	Method = 'POST',
	Headers = {
		["Content-Type"] = "application/json"
		},
	Body = game:GetService("HttpService"):JSONEncode(Message)
})
wait(3)
HopLowServer()
