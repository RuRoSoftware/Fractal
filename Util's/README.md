# 🚀 Luau Discord Webhook & Embed Library

A powerful and flexible library for interacting with Discord Webhooks within the Roblox (Luau) environment. This library consists of two main components: **DiscordWebhook** for transmission management and **Embed Builder** for creating rich, professional message cards.

---

## 📖 Documentation

### 1. Embed Builder (Card Module)
A class for constructing and formatting Embed objects. It supports **Method Chaining** for clean and readable code.

#### Core Methods:
| Method | Description |
| :--- | :--- |
| `:SetTitle(text)` | Sets the title of the embed card. |
| `:SetDescription(text)` | Sets the main body text description. |
| `:SetColor(color)` | Sets the sidebar color (use `Embed.Colors`). |
| `:AddField(name, val, inline)` | Adds a field to the card (inline is a boolean). |
| `:SetImage(url)` | Sets a large image in the center of the embed. |
| `:SetThumbnail(url)` | Sets a small thumbnail image in the top-right corner. |
| `:SetFooter(text, iconUrl)` | Sets footer text and an optional footer icon. |
| `:SetTimestamp()` | Adds a dynamic ISO timestamp of the current moment. |

#### Templates (Presets):
* `Embed.Success(title, desc)` — Green card for successful operations.
* `Embed.Error(title, desc)` — Red card for error reporting.
* `Embed.Warning(title, desc)` — Gold card for warnings/alerts.
* `Embed.Info(title, desc)` — Blue card for general information.

---

### 2. Discord Webhook (Sender Module)
A class designed to handle HTTP requests and deliver data payloads to Discord.

#### Core Methods:
| Method | Description |
| :--- | :--- |
| `DiscordWebhook.new(url)` | Initializes a new Webhook object. |
| `:SetContent(text)` | Adds standard message text above the embed cards. |
| `:SetUsername(name)` | Overrides the default webhook name. |
| `:SetAvatar(url)` | Overrides the default webhook avatar icon. |
| `:AddEmbed(embedObject)` | Attaches an Embed object to the message payload. |
| `:Send()` | Executes the request. Returns `success (bool), response`. |

---

## 💡 Usage Examples

### Full Cycle: Creating and Sending
```lua
local WebhookLib = loadstring(game:HttpGet("YOUR_WEBHOOK_SCRIPT_URL"))()
local EmbedLib = loadstring(game:HttpGet("YOUR_EMBED_SCRIPT_URL"))()

local WEBHOOK_URL = "YOUR_DISCORD_WEBHOOK_URL"

-- Create a rich Embed
local logEmbed = EmbedLib.new()
    :SetTitle("🛡️ Security System")
    :SetDescription("Login attempt detected from a suspicious IP address.")
    :SetColor(EmbedLib.Colors.RED)
    :AddField("Player", "Player123", true)
    :AddField("Node", "87.249.37.170", true)
    :SetFooter("Server Protection", "[http://87.249.37.170/shield_icon.png](http://87.249.37.170/shield_icon.png)")
    :SetTimestamp()

-- Send via Webhook
local sender = WebhookLib.new(WEBHOOK_URL)
    :SetUsername("Security Bot")
    :SetAvatar("[http://87.249.37.170/bot_avatar.png](http://87.249.37.170/bot_avatar.png)")
    :AddEmbed(logEmbed)

local success, response = sender:Send()

if success then
    print("Log successfully sent!")
else
    warn("Failed to send log: " .. tostring(response))
end
```

### Quick Text Send (Simple Mode)
```lua
-- Quickly send text without creating complex objects
WebhookLib.SendSimple(WEBHOOK_URL, "Server started on node 87.249.37.170", "System")
```

---

## 🎨 Color Palette (`Embed.Colors`)
The following constants are available for use with the `:SetColor()` method:
`DEFAULT`, `AQUA`, `GREEN`, `BLUE`, `PURPLE`, `GOLD`, `ORANGE`, `RED`, `GREY`, `NAVY`, `LUMINOUS_VIVID_PINK`, and their `DARK_` variants.
