--!SerializeField
local X : GameObject = nil
--!SerializeField
local O : GameObject = nil

local tapRequest = Event.new("TapRequest")
local tapEvent = Event.new("TapEvent")

function Client()

    if(X)then X:SetActive(false) end
    if(O)then O:SetActive(false) end

    local Manager = self.transform.parent.gameObject:GetComponent("TicTacToeManager")
    local active = false
    
    function Interact()
        if(active == false)then
            active = true
            Turn = Manager.Turn
            if(Turn == 0)then
                O:SetActive(false)
                X:SetActive(true)
                Manager.Turn = 1
            elseif(Turn == 1) then
                X:SetActive(false)
                O:SetActive(true)
                Manager.Turn = 0
            end
        else
            O:SetActive(false)
            X:SetActive(false)
            active = false
        end
    end

    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
        tapRequest:FireServer()
    end)

    tapEvent:Connect(function()
        Interact()
    end)
end

function Server()
    tapRequest:Connect(function()
        tapEvent:FireAllClients()
    end)
end

if server then
    Server()
else
    Client()
end