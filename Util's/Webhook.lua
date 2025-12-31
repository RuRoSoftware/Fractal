local HttpService = cloneref(game:GetService("HttpService"))
local Embed = loadstring(game:HttpGet("https://raw.githubusercontent.com/FractalINK/Fractal/refs/heads/main/Util's/Embed.lua"))()

local DiscordWebhook = {}
DiscordWebhook.__index = DiscordWebhook

function DiscordWebhook.new(url)
    local self = setmetatable({}, DiscordWebhook)
    self.url = url
    self.embeds = {}
    self.content = ""
    self.username = nil
    self.avatar_url = nil
    self.tts = false
    return self
end

function DiscordWebhook:SetContent(content)
    self.content = content
    return self
end

function DiscordWebhook:SetUsername(username)
    self.username = username
    return self
end

function DiscordWebhook:SetAvatar(avatarUrl)
    self.avatar_url = avatarUrl
    return self
end

function DiscordWebhook:SetTTS(tts)
    self.tts = tts
    return self
end

function DiscordWebhook:AddEmbed(embed)
    if getmetatable(embed) == Embed then
        table.insert(self.embeds, embed:ToTable())
    elseif type(embed) == "table" then
        table.insert(self.embeds, embed)
    end
    return self
end

function DiscordWebhook:AddEmbeds(embeds)
    for _, embed in ipairs(embeds) do
        self:AddEmbed(embed)
    end
    return self
end

function DiscordWebhook:CreateEmbed()
    local embed = Embed.new()
    self:AddEmbed(embed)
    return embed
end

function DiscordWebhook:ClearEmbeds()
    self.embeds = {}
    return self
end

function DiscordWebhook:GetEmbedCount()
    return #self.embeds
end

function DiscordWebhook:Send()
    local data = {
        content = self.content,
        embeds = #self.embeds > 0 and self.embeds or nil,
        username = self.username,
        avatar_url = self.avatar_url,
        tts = self.tts
    }

    for k, v in pairs(data) do
        if v == nil or (type(v) == "string" and #v == 0) then
            data[k] = nil
        end
    end

    local jsonData = HttpService:JSONEncode(data)
    
    local success, response = pcall(function()
        return HttpService:PostAsync(self.url, jsonData, Enum.HttpContentType.ApplicationJson)
    end)
    
    return success, response
end

function DiscordWebhook.SendSimple(url, content, username, avatar)
    local webhook = DiscordWebhook.new(url)
        :SetContent(content)
    
    if username then
        webhook:SetUsername(username)
    end
    
    if avatar then
        webhook:SetAvatar(avatar)
    end
    
    return webhook:Send()
end

function DiscordWebhook.SendEmbed(url, embed)
    local webhook = DiscordWebhook.new(url)
    webhook:AddEmbed(embed)
    return webhook:Send()
end

return DiscordWebhook
