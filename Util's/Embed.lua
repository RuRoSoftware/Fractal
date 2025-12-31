local HttpService = cloneref(game:GetService("HttpService"))

local Embed = {}
Embed.__index = Embed

Embed.Colors = {
    DEFAULT = 0,
    AQUA = 1752220,
    GREEN = 5763719,
    BLUE = 3447003,
    PURPLE = 10181046,
    GOLD = 15844367,
    ORANGE = 15105570,
    RED = 15548997,
    GREY = 9807270,
    DARKER_GREY = 8359053,
    NAVY = 3426654,
    DARK_AQUA = 1146986,
    DARK_GREEN = 2067276,
    DARK_BLUE = 2123412,
    DARK_PURPLE = 7419530,
    DARK_GOLD = 12745742,
    DARK_ORANGE = 11027200,
    DARK_RED = 10038562,
    DARK_GREY = 9936031,
    LIGHT_GREY = 12370112,
    DARK_NAVY = 2899536,
    LUMINOUS_VIVID_PINK = 16580705,
    DARK_VIVID_PINK = 12320855
}

function Embed.new()
    local self = setmetatable({}, Embed)
    self.title = ""
    self.description = ""
    self.url = ""
    self.color = Embed.Colors.DEFAULT
    self.fields = {}
    self.author = {}
    self.thumbnail = {}
    self.image = {}
    self.footer = {}
    self.timestamp = nil
    return self
end

function Embed.from(title, description, color)
    local embed = Embed.new()
    embed:SetTitle(title)
    embed:SetDescription(description)
    if color then
        embed:SetColor(color)
    end
    return embed
end

function Embed:SetTitle(title)
    self.title = tostring(title)
    return self
end

function Embed:SetDescription(description)
    self.description = tostring(description)
    return self
end

function Embed:SetColor(color)
    self.color = color
    return self
end

function Embed:SetURL(url)
    self.url = url
    return self
end

function Embed:SetTimestamp(timestamp)
    if not timestamp then
        timestamp = DateTime.now():ToIsoDate()
    end
    self.timestamp = timestamp
    return self
end

function Embed:AddField(name, value, inline)
    table.insert(self.fields, {
        name = tostring(name),
        value = tostring(value),
        inline = inline or false
    })
    return self
end

function Embed:AddFields(fields)
    for _, field in ipairs(fields) do
        self:AddField(field.name, field.value, field.inline)
    end
    return self
end

function Embed:SetAuthor(name, url, iconUrl)
    self.author = {
        name = tostring(name),
        url = url,
        icon_url = iconUrl
    }
    return self
end

function Embed:SetThumbnail(url)
    self.thumbnail = {url = url}
    return self
end

function Embed:SetImage(url)
    self.image = {url = url}
    return self
end

function Embed:SetFooter(text, iconUrl)
    self.footer = {
        text = tostring(text),
        icon_url = iconUrl
    }
    return self
end

function Embed:ToTable()
    local result = {}
    
    if self.title and #self.title > 0 then
        result.title = self.title
    end
    
    if self.description and #self.description > 0 then
        result.description = self.description
    end
    
    if self.url and #self.url > 0 then
        result.url = self.url
    end
    
    if self.color ~= Embed.Colors.DEFAULT then
        result.color = self.color
    end
    
    if #self.fields > 0 then
        result.fields = self.fields
    end
    
    if next(self.author) then
        result.author = self.author
    end
    
    if next(self.thumbnail) then
        result.thumbnail = self.thumbnail
    end
    
    if next(self.image) then
        result.image = self.image
    end
    
    if next(self.footer) then
        result.footer = self.footer
    end
    
    if self.timestamp then
        result.timestamp = self.timestamp
    end
    
    return result
end

function Embed:Clear()
    local newEmbed = Embed.new()
    for k, v in pairs(newEmbed) do
        self[k] = v
    end
    return self
end

function Embed:Copy()
    local copy = Embed.new()
    
    for key, value in pairs(self) do
        if type(value) == "table" then
            copy[key] = HttpService:JSONDecode(HttpService:JSONEncode(value))
        else
            copy[key] = value
        end
    end
    
    return copy
end

function Embed.Error(title, description)
    return Embed.from(title, description, Embed.Colors.RED)
        :SetFooter("Ошибка • " .. os.date("%H:%M:%S"))
end

function Embed.Success(title, description)
    return Embed.from(title, description, Embed.Colors.GREEN)
        :SetFooter("Успешно • " .. os.date("%H:%M:%S"))
end

function Embed.Warning(title, description)
    return Embed.from(title, description, Embed.Colors.GOLD)
        :SetFooter("Внимание • " .. os.date("%H:%M:%S"))
end

function Embed.Info(title, description)
    return Embed.from(title, description, Embed.Colors.BLUE)
        :SetFooter("Информация • " .. os.date("%H:%M:%S"))
end

return Embed
