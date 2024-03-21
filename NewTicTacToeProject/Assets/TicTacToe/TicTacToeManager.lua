Turn = 0


--[[
local tapRequest = Event.new("TapRequest")
local tapEvent = Event.new("TapEvent")

function Client()
    Turn = 0
    function TileTapped(tile)
        tapRequest:FireServer(tile)
    end

    tapEvent:Connect(function(tile)
        activatedTile = GameObject.Find(tile)
        print(client.localPlayer.name .. " " ..typeof(activatedTile:GetComponent("TicTacToeTileScript")))
        activatedTile:GetComponent("TicTacToeTileScript").Interact(Turn)
    end)
end

function Server()
    tapRequest:Connect(function(player, tile)
        tapEvent:FireAllClients(tile)
    end)
end


if server then
    Server()
else
    Client()
end
--]]