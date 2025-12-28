local r0_0 = {
  Players = game:GetService("Players"),
  RunService = game:GetService("RunService"),
  HttpService = game:GetService("HttpService"),
  RS = game:GetService("ReplicatedStorage"),
  VIM = game:GetService("VirtualInputManager"),
  PG = game:GetService("Players").LocalPlayer.PlayerGui,
  Camera = workspace.CurrentCamera,
  GuiService = game:GetService("GuiService"),
  CoreGui = game:GetService("CoreGui"),
}
local r1_0 = _G
local r2_0 = syn
if r2_0 then
  r2_0 = syn.request
  if not r2_0 then
    ::label_54::
    r2_0 = http
    if r2_0 then
      r2_0 = http.request
      if not r2_0 then
        ::label_61::
        r2_0 = http_request
        if not r2_0 then
          r2_0 = fluxus
          if r2_0 then
            r2_0 = fluxus.request or request
          else
            goto label_71	-- block#7 is visited secondly
          end
        end
      end
    else
      goto label_61	-- block#4 is visited secondly
    end
  end
else
  goto label_54	-- block#2 is visited secondly
end
r1_0.httpRequest = r2_0
if not _G.httpRequest then
  return 
end
r1_0 = r0_0.Players.LocalPlayer
if not r1_0.Character or not r1_0.Character:WaitForChild("HumanoidRootPart") then
  r2_0 = r1_0.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
end
local r4_0 = "Chloe X/FishIt" .. "/Position.json"
local r5_0 = {
  MerchantRoot = r0_0.PG.Merchant.Main.Background,
  ItemsFrame = r0_0.PG.Merchant.Main.Background.Items.ScrollingFrame,
  RefreshMerchant = r0_0.PG.Merchant.Main.Background.RefreshLabel,
}
local r6_0 = {
  Net = r0_0.RS.Packages._Index["sleitnick_net@0.2.0"].net,
  Replion = require(r0_0.RS.Packages.Replion),
  FishingController = require(r0_0.RS.Controllers.FishingController),
  TradingController = require(r0_0.RS.Controllers.ItemTradingController),
  ItemUtility = require(r0_0.RS.Shared.ItemUtility),
  VendorUtility = require(r0_0.RS.Shared.VendorUtility),
  PlayerStatsUtility = require(r0_0.RS.Shared.PlayerStatsUtility),
  Effects = require(r0_0.RS.Shared.Effects),
  NotifierFish = require(r0_0.RS.Controllers.TextNotificationController),
  InputControl = require(r0_0.RS.Modules.InputControl),
  VFX = require(r0_0.RS.Controllers.VFXController),
}
local r7_0 = {}
r7_0.Events = {
  RECutscene = r6_0.Net["RE/ReplicateCutscene"],
  REStop = r6_0.Net["RE/StopCutscene"],
  REFav = r6_0.Net["RE/FavoriteItem"],
  REFavChg = r6_0.Net["RE/FavoriteStateChanged"],
  REFishDone = r6_0.Net["RE/FishingCompleted"],
  REFishGot = r6_0.Net["RE/FishCaught"],
  RENotify = r6_0.Net["RE/TextNotification"],
  REEquip = r6_0.Net["RE/EquipToolFromHotbar"],
  REEquipItem = r6_0.Net["RE/EquipItem"],
  REAltar = r6_0.Net["RE/ActivateEnchantingAltar"],
  REAltar2 = r6_0.Net["RE/ActivateSecondEnchantingAltar"],
  UpdateOxygen = r6_0.Net["URE/UpdateOxygen"],
  REPlayFishEffect = r6_0.Net["RE/PlayFishingEffect"],
  RETextEffect = r6_0.Net["RE/ReplicateTextEffect"],
  REEvReward = r6_0.Net["RE/ClaimEventReward"],
  Totem = r6_0.Net["RE/SpawnTotem"],
  REObtainedNewFishNotification = r6_0.Net["RE/ObtainedNewFishNotification"],
  FishingMinigameChanged = r6_0.Net["RE/FishingMinigameChanged"],
  FishingStopped = r6_0.Net["RE/FishingStopped"],
}
r7_0.Functions = {
  Trade = r6_0.Net["RF/InitiateTrade"],
  BuyRod = r6_0.Net["RF/PurchaseFishingRod"],
  BuyBait = r6_0.Net["RF/PurchaseBait"],
  BuyWeather = r6_0.Net["RF/PurchaseWeatherEvent"],
  ChargeRod = r6_0.Net["RF/ChargeFishingRod"],
  StartMini = r6_0.Net["RF/RequestFishingMinigameStarted"],
  UpdateRadar = r6_0.Net["RF/UpdateFishingRadar"],
  Cancel = r6_0.Net["RF/CancelFishingInputs"],
  Dialogue = r6_0.Net["RF/SpecialDialogueEvent"],
  SellItem = r6_0.Net["RF/SellItem"],
  Done = r6_0.Net["RF/RequestFishingMinigameStarted"],
  AutoEnabled = r6_0.Net["RF/UpdateAutoFishingState"],
}
local r8_0 = {
  Data = r6_0.Replion.Client:WaitReplion("Data"),
  Items = r0_0.RS:WaitForChild("Items"),
  PlayerStat = require(r0_0.RS.Packages._Index:FindFirstChild("ytrev_replion@2.0.0-rc.3").replion),
}
local r9_0 = {
  autoInstant = false,
}
r9_0.selectedEvents = {}
r9_0.autoWeather = false
r9_0.autoSellEnabled = false
r9_0.autoFavEnabled = false
r9_0.autoEventActive = false
r9_0.canFish = true
r9_0.savedCFrame = nil
r9_0.sellMode = "Delay"
r9_0.sellDelay = 60
r9_0.inputSellCount = 50
r9_0.selectedName = {}
r9_0.selectedRarity = {}
r9_0.selectedVariant = {}
r9_0.rodDataList = {}
r9_0.rodDisplayNames = {}
r9_0.baitDataList = {}
r9_0.baitDisplayNames = {}
r9_0.selectedRodId = nil
r9_0.selectedBaitId = nil
r9_0.rods = {}
r9_0.baits = {}
r9_0.weathers = {}
r9_0.lcc = 0
r9_0.player = r1_0
r9_0.stats = r1_0:WaitForChild("leaderstats")
r9_0.caught = r1_0:WaitForChild("leaderstats"):WaitForChild("Caught")
r9_0.char = r1_0.Character or r1_0.CharacterAdded:Wait()
r9_0.vim = r0_0.VIM
r9_0.cam = r0_0.Camera
r9_0.offs = {
  ["Worm Hunt"] = 25,
}
r9_0.curCF = nil
r9_0.origCF = nil
r9_0.flt = false
r9_0.con = nil
r9_0.Instant = false
r9_0.CancelWaitTime = 3
r9_0.ResetTimer = 0.5
r9_0.hasTriggeredBug = false
r9_0.lastFishTime = 0
r9_0.fishConnected = false
r9_0.lastCancelTime = 0
r9_0.hasFishingEffect = false
local r10_0 = {
  selectedPlayer = nil,
  selectedItem = nil,
  tradeAmount = 1,
  targetCoins = 0,
  trading = false,
  awaiting = false,
  lastResult = nil,
  successCount = 0,
  failCount = 0,
  totalToTrade = 0,
  sentCoins = 0,
  successCoins = 0,
  failCoins = 0,
  totalReceived = 0,
}
r10_0.currentGrouped = {}
r10_0.TotemActive = false
r9_0.trade = r10_0
r9_0.ignore = {
  Cloudy = true,
  Day = true,
  ["Increased Luck"] = true,
  Mutated = true,
  Night = true,
  Snow = true,
  ["Sparkling Cove"] = true,
  Storm = true,
  Wind = true,
  UIListLayout = true,
  ["Admin - Shocked"] = true,
  ["Admin - Super Mutated"] = true,
  Radiant = true,
}
r9_0.notifConnections = {}
r9_0.defaultHandlers = {}
r9_0.disabledCons = {}
r9_0.CEvent = true
_G.Celestial = _G.Celestial or {}
_G.Celestial.DetectorCount = _G.Celestial.DetectorCount or 0
_G.Celestial.InstantCount = _G.Celestial.InstantCount or 0
function getFishCount()
  -- line: [0, 0] id: 282
  return tonumber((r9_0.player.PlayerGui:WaitForChild("Inventory"):WaitForChild("Main"):WaitForChild("Top"):WaitForChild("Options"):WaitForChild("Fish"):WaitForChild("Label"):WaitForChild("BagSize").Text or "0/???"):match("(%d+)/")) or 0
end
function clickCenter()
  -- line: [0, 0] id: 115
  local r0_115 = r9_0.cam.ViewportSize
  r9_0.vim:SendMouseButtonEvent(r0_115.X / 2, r0_115.Y / 2, 0, true, nil, 0)
  r9_0.vim:SendMouseButtonEvent(r0_115.X / 2, r0_115.Y / 2, 0, false, nil, 0)
end
r10_0 = {}
for r14_0, r15_0 in ipairs(r8_0.Items:GetChildren()) do
  if r15_0:IsA("ModuleScript") then
    local r16_0, r17_0 = pcall(require, r15_0)
    if r16_0 and r17_0.Data and r17_0.Data.Type == "Fish" then
      table.insert(r10_0, r17_0.Data.Name)
    end
  end
end
table.sort(r10_0)
_G.TierFish = {
  [1] = " ",
  [2] = "Uncommon",
  [3] = "Rare",
  [4] = "Epic",
  [5] = "Legendary",
  [6] = "Mythic",
  [7] = "Secret",
}
_G.WebhookRarities = _G.WebhookRarities or {}
_G.WebhookNames = _G.WebhookNames or {}
_G.Variant = {
  "Galaxy",
  "Corrupt",
  "Gemstone",
  "Ghost",
  "Lightning",
  "Fairy Dust",
  "Gold",
  "Midnight",
  "Radioactive",
  "Stone",
  "Holographic",
  "Albino",
  "Bloodmoon",
  "Sandy",
  "Acidic",
  "Color Burn",
  "Festive",
  "Frozen"
}
function toSet(r0_199)
  -- line: [0, 0] id: 199
  local r1_199 = {}
  if type(r0_199) == "table" then
    for r5_199, r6_199 in ipairs(r0_199) do
      r1_199[r6_199] = true
    end
    for r5_199, r6_199 in pairs(r0_199) do
      if r6_199 then
        r1_199[r5_199] = true
      end
    end
  end
  return r1_199
end
local r11_0 = {}
local r14_0 = "Connect"
function r14_0(r0_144, r1_144)
  -- line: [0, 0] id: 144
  rawset(r11_0, r0_144, r1_144)
end
r7_0.Events.REFavChg.OnClientEvent:[r14_0](r14_0)
function checkAndFavorite(r0_49)
  -- line: [0, 0] id: 49
  if not r9_0.autoFavEnabled then
    return 
  end
  local r1_49 = r6_0.ItemUtility.GetItemDataFromItemType("Items", r0_49.Id)
  if not r1_49 or r1_49.Data.Type ~= "Fish" then
    return 
  end
  local r2_49 = _G.TierFish[r1_49.Data.Tier]
  local r3_49 = r1_49.Data.Name
  local r4_49 = r0_49.Metadata
  if r4_49 then
    r4_49 = r0_49.Metadata.VariantId or "None"
  else
    goto label_32	-- block#7 is visited secondly
  end
  local r5_49 = r9_0.selectedName[r3_49]
  local r6_49 = r9_0.selectedRarity[r2_49]
  local r7_49 = r9_0.selectedVariant[r4_49]
  local r8_49 = rawget(r11_0, r0_49.UUID)
  if r8_49 == nil then
    r8_49 = r0_49.Favorited
  end
  local r9_49 = false
  if next(r9_0.selectedVariant) ~= nil and next(r9_0.selectedName) ~= nil then
    r9_49 = r5_49 and r7_49
  else
    r9_49 = r5_49 or r6_49
  end
  if r9_49 and not r8_49 then
    r7_0.Events.REFav:FireServer(r0_49.UUID)
    rawset(r11_0, r0_49.UUID, true)
  end
end
function scanInventory()
  -- line: [0, 0] id: 165
  if not r9_0.autoFavEnabled then
    return 
  end
  for r3_165, r4_165 in ipairs(r8_0.Data:GetExpect({
    "Inventory",
    "Items"
  })) do
    checkAndFavorite(r4_165)
  end
end
for r15_0, r16_0 in ipairs(r0_0.RS.Items:GetChildren()) do
  local r17_0 = r16_0:IsA("ModuleScript")
  if r17_0 then
    local r19_0 = "match"
    r19_0 = "Rod"
    r17_0 = r16_0.Name:[r19_0](r19_0)
    if r17_0 then
      local r17_0, r18_0 = pcall(require, r16_0)
      if r17_0 then
        r19_0 = typeof(r18_0)
        if r19_0 == "table" then
          r19_0 = r18_0.Data
          if r19_0 then
            r19_0 = r18_0.Data.Name or "Unknown"
            local r21_0 = "Id"
            local r20_0 = r18_0.Data[r21_0] or "Unknown"
            r21_0 = r18_0.Price or 0
            local r24_0 = "gsub"
            r24_0 = "^!!!%s*"
            local r22_0 = r19_0:[r24_0](r24_0, "")
            local r23_0 = r22_0 .. " ($" .. r21_0 .. ")"
            r24_0 = {
              Name = r22_0,
              Id = r20_0,
              Price = r21_0,
              Display = r23_0,
            }
            r9_0.rods[r20_0] = r24_0
            r9_0.rods[r22_0] = r24_0
            table.insert(r9_0.rodDisplayNames, r23_0)
          end
        end
      end
    end
  end
end
BaitsFolder = r0_0.RS:WaitForChild("Baits")
for r15_0, r16_0 in ipairs(BaitsFolder:GetChildren()) do
  local r17_0 = r16_0:IsA("ModuleScript")
  if r17_0 then
    local r17_0, r18_0 = pcall(require, r16_0)
    if r17_0 then
      local r19_0 = typeof(r18_0)
      if r19_0 == "table" then
        r19_0 = r18_0.Data
        if r19_0 then
          r19_0 = r18_0.Data.Name or "Unknown"
          local r21_0 = "Id"
          local r20_0 = r18_0.Data[r21_0] or "Unknown"
          r21_0 = r18_0.Price or 0
          local r22_0 = r19_0 .. " ($" .. r21_0 .. ")"
          local r23_0 = {
            Name = r19_0,
            Id = r20_0,
            Price = r21_0,
            Display = r22_0,
          }
          r9_0.baits[r20_0] = r23_0
          r9_0.baits[r19_0] = r23_0
          table.insert(r9_0.baitDisplayNames, r22_0)
        end
      end
    end
  end
end
function _cleanName(r0_299)
  -- line: [0, 0] id: 299
  if type(r0_299) ~= "string" then
    return tostring(r0_299)
  end
  return r0_299:match("^(.-) %(") or r0_299
end
function SavePosition(r0_18)
  -- line: [0, 0] id: 18
  writefile(r4_0, r0_0.HttpService:JSONEncode({
    r0_18:GetComponents()
  }))
end
function LoadPosition()
  -- line: [0, 0] id: 131
  if isfile(r4_0) then
    local r0_131, r1_131 = pcall(function()
      -- line: [0, 0] id: 132
      return r0_0.HttpService:JSONDecode(readfile(r4_0))
    end)
    if r0_131 and typeof(r1_131) == "table" then
      return CFrame.new(unpack(r1_131))
    end
  end
  return nil
end
function TeleportLastPos(r0_50)
  -- line: [0, 0] id: 50
  task.spawn(function()
    -- line: [0, 0] id: 51
    local r0_51 = r0_50:WaitForChild("HumanoidRootPart")
    local r1_51 = LoadPosition()
    if r1_51 then
      task.wait(2)
      r0_51.CFrame = r1_51
      chloex("Teleported to your last position...")
    end
  end)
end
r14_0 = "Connect"
r14_0 = TeleportLastPos
r1_0.CharacterAdded:[r14_0](r14_0)
if r1_0.Character then
  TeleportLastPos(r1_0.Character)
end
ignore = {
  Cloudy = true,
  Day = true,
  ["Increased Luck"] = true,
  Mutated = true,
  Night = true,
  Snow = true,
  ["Sparkling Cove"] = true,
  Storm = true,
  Wind = true,
  UIListLayout = true,
  ["Admin - Shocked"] = true,
  ["Admin - Super Mutated"] = true,
  Radiant = true,
}
local function r12_0(r0_260)
  -- line: [0, 0] id: 260
  return r0_260 and (r0_260:FindFirstChild("HumanoidRootPart") or r0_260:FindFirstChildWhichIsA("BasePart"))
end
local function r13_0(r0_207, r1_207, r2_207)
  -- line: [0, 0] id: 207
  if r9_0.flt and r9_0.con then
    r9_0.con:Disconnect()
  end
  r9_0.flt = r2_207 or false
  if r2_207 then
    local r3_207 = workspace:FindFirstChild("WW_Part") or Instance.new("Part")
    r3_207.Name = "WW_Part"
    r3_207.Size = Vector3.new(15, 1, 15)
    r3_207.Anchored = true
    r3_207.CanCollide = false
    r3_207.Transparency = 1
    r3_207.Material = Enum.Material.SmoothPlastic
    r3_207.Parent = workspace
    local r4_207 = -1.8
    r9_0.con = r0_0.RunService.Heartbeat:Connect(function()
      -- line: [0, 0] id: 208
      if not r0_207 or not r1_207 or not r3_207 then
        return 
      end
      r3_207.Position = Vector3.new(r1_207.Position.X, r4_207, r1_207.Position.Z)
      r3_207.CanCollide = r4_207 < r1_207.Position.Y
    end)
    -- close: r3_207
  else
    local r3_207 = workspace:FindFirstChild("WW_Part")
    if r3_207 then
      r3_207:Destroy()
    end
  end
end
function r14_0()
  -- line: [0, 0] id: 219
  local r0_219 = {}
  local r1_219 = r9_0.player:WaitForChild("PlayerGui"):FindFirstChild("Events") and r1_219:FindFirstChild("Frame") and r1_219.Frame:FindFirstChild("Events")
  if r1_219 then
    for r5_219, r6_219 in ipairs(r1_219:GetChildren()) do
      local r7_219 = r6_219:IsA("Frame")
      if r7_219 then
        r7_219 = r6_219:FindFirstChild("DisplayName") and (r6_219.DisplayName.Text or r6_219.Name)
      else
        goto label_42	-- block#8 is visited secondly
      end
      if typeof(r7_219) == "string" and r7_219 ~= "" and not r9_0.ignore[r7_219] then
        table.insert(r0_219, r7_219:gsub("^Admin %- ", ""))
      end
    end
  end
  return r0_219
end
local function r15_0(r0_314)
  -- line: [0, 0] id: 314
  if not r0_314 then
    return 
  end
  if r0_314 == "Megalodon Hunt" then
    local r1_314 = workspace:FindFirstChild("!!! MENU RINGS")
    if r1_314 then
      for r5_314, r6_314 in ipairs(r1_314:GetChildren()) do
        local r7_314 = r6_314:FindFirstChild("Megalodon Hunt")
        local r8_314 = r7_314 and r7_314:FindFirstChild("Megalodon Hunt")
        if r8_314 and r8_314:IsA("BasePart") then
          return r8_314
        end
      end
    end
    return 
  end
  local r1_314 = {
    workspace:FindFirstChild("Props")
  }
  local r2_314 = workspace:FindFirstChild("!!! MENU RINGS")
  if r2_314 then
    for r6_314, r7_314 in ipairs(r2_314:GetChildren()) do
      if r7_314.Name:match("^Props") then
        table.insert(r1_314, r7_314)
      end
    end
  end
  for r6_314, r7_314 in ipairs(r1_314) do
    for r11_314, r12_314 in ipairs(r7_314:GetChildren()) do
      for r16_314, r17_314 in ipairs(r12_314:GetDescendants()) do
        if r17_314:IsA("TextLabel") and r17_314.Name == "DisplayName" then
          local r18_314 = r17_314.ContentText
          if r18_314 ~= "" then
            r18_314 = r17_314.ContentText or r17_314.Text
          else
            goto label_93	-- block#24 is visited secondly
          end
          local r19_314 = r18_314:lower()
          local r20_314 = r0_314:lower()
          if r19_314 == r20_314 then
            r19_314 = r17_314:FindFirstAncestorOfClass("Model")
            if r19_314 then
              r20_314 = r19_314:FindFirstChild("Part") or r12_314:FindFirstChild("Part")
            else
              goto label_110	-- block#28 is visited secondly
            end
            if r20_314 and r20_314:IsA("BasePart") then
              return r20_314
            end
          end
        end
      end
    end
  end
end
local function r16_0(r0_78)
  -- line: [0, 0] id: 78
  if r9_0.lastState ~= r0_78 then
    chloex(r0_78)
    r9_0.lastState = r0_78
  end
end
function r9_0.loop()
  -- line: [0, 0] id: 276
  while r9_0.autoEventActive do
    local r0_276 = nil
    local r1_276 = nil
    if r9_0.priorityEvent then
      local r2_276 = r15_0(r9_0.priorityEvent)
      if r2_276 then
        r1_276 = r9_0.priorityEvent
        r0_276 = r2_276
      end
    end
    if not r0_276 and 0 < #r9_0.selectedEvents then
      for r5_276, r6_276 in ipairs(r9_0.selectedEvents) do
        local r7_276 = r15_0(r6_276)
        if r7_276 then
          r1_276 = r6_276
          r0_276 = r7_276
          break
        end
      end
    end
    local r2_276 = r12_0(r9_0.player.Character)
    if r0_276 and r2_276 then
      if not r9_0.origCF then
        r9_0.origCF = r2_276.CFrame
      end
      if (r2_276.Position - r0_276.Position).Magnitude > 40 then
        r9_0.curCF = r0_276.CFrame + Vector3.new(0, (r9_0.offs[r1_276] or 7), 0)
        r9_0.player.Character:PivotTo(r9_0.curCF)
        r13_0(r9_0.player.Character, r2_276, true)
        task.wait(1)
        r16_0("Event! " .. r1_276)
      end
    elseif r0_276 == nil and r9_0.curCF and r2_276 then
      r13_0(r9_0.player.Character, nil, false)
      if r9_0.origCF then
        r9_0.player.Character:PivotTo(r9_0.origCF)
        r16_0("Event end → Back")
        r9_0.origCF = nil
      end
      r9_0.curCF = nil
    elseif not r9_0.curCF then
      r16_0("Idle")
    end
    task.wait(0.2)
  end
  r13_0(r9_0.player.Character, nil, false)
  if r9_0.origCF and r9_0.player.Character then
    r9_0.player.Character:PivotTo(r9_0.origCF)
    r16_0("Auto Event off")
  end
  r9_0.curCF = nil
  r9_0.origCF = nil
end
local r19_0 = "Connect"
function r19_0(r0_111)
  -- line: [0, 0] id: 111
  if r9_0.autoEventActive then
    task.spawn(function()
      -- line: [0, 0] id: 112
      local r0_112 = r0_111:WaitForChild("HumanoidRootPart", 5)
      task.wait(0.3)
      if r0_112 then
        if r9_0.curCF then
          r0_111:PivotTo(r9_0.curCF)
          r13_0(r0_111, r0_112, true)
          task.wait(0.5)
          chloex("Respawn → Back")
        elseif r9_0.origCF then
          r0_111:PivotTo(r9_0.origCF)
          r13_0(r0_111, r0_112, true)
          chloex("Back to farm")
        end
      end
    end)
  end
end
r9_0.player.CharacterAdded:[r19_0](r19_0)
local function r17_0()
  -- line: [0, 0] id: 216
  local r0_216 = {}
  for r4_216, r5_216 in ipairs(r0_0.Players:GetPlayers()) do
    if r5_216 ~= r1_0 then
      table.insert(r0_216, r5_216.Name)
    end
  end
  return r0_216
end
local r18_0 = {
  ["Treasure Room"] = Vector3.new(-3602.01, -266.57, -1577.18),
  ["Sisyphus Statue"] = Vector3.new(-3703.69, -135.57, -1017.17),
  ["Crater Island Top"] = Vector3.new(1011.29, 22.68, 5076.27),
  ["Crater Island Ground"] = Vector3.new(1079.57, 3.64, 5080.35),
  ["Coral Reefs SPOT 1"] = Vector3.new(-3031.88, 2.52, 2276.36),
  ["Coral Reefs SPOT 2"] = Vector3.new(-3270.86, 2.5, 2228.1),
  ["Coral Reefs SPOT 3"] = Vector3.new(-3136.1, 2.61, 2126.11),
  ["Lost Shore"] = Vector3.new(-3737.97, 5.43, -854.68),
  ["Weather Machine"] = Vector3.new(-1524.88, 2.87, 1915.56),
  ["Kohana Volcano"] = Vector3.new(-561.81, 21.24, 156.72),
  ["Kohana SPOT 1"] = Vector3.new(-367.77, 6.75, 521.91),
  ["Kohana SPOT 2"] = Vector3.new(-623.96, 19.25, 419.36),
  ["Stingray Shores"] = Vector3.new(44.41, 28.83, 3048.93),
  ["Tropical Grove"] = Vector3.new(-2018.91, 9.04, 3750.59),
  ["Ice Sea"] = Vector3.new(2164, 7, 3269),
  ["Tropical Grove Cave 1"] = Vector3.new(-2151, 3, 3671),
  ["Tropical Grove Cave 2"] = Vector3.new(-2018, 5, 3756),
  ["Tropical Grove Highground"] = Vector3.new(-2139, 53, 3624),
  ["Fisherman Island Underground"] = Vector3.new(-62, 3, 2846),
  ["Fisherman Island Mid"] = Vector3.new(33, 3, 2764),
  ["Fisherman Island Rift Left"] = Vector3.new(-26, 10, 2686),
  ["Fisherman Island Rift Right"] = Vector3.new(95, 10, 2684),
  ["Secred Temple"] = Vector3.new(1475, -22, -632),
  ["Ancient Jungle Outside"] = Vector3.new(1488, 8, -392),
  ["Ancient Jungle"] = Vector3.new(1274, 8, -184),
  ["Underground Cellar"] = Vector3.new(2136, -91, -699),
  ["Crystaline Pessage"] = Vector3.new(6051, -539, 4386),
  ["Ancient Ruin"] = Vector3.new(6090, -586, 4634),
  ["Esoteric Deep"] = Vector3.new(3181, -1303, 1425),
  ["Classic Event"] = Vector3.new(1173, 4, 2839),
  ["Classic Event River"] = Vector3.new(1439, 46, 2779),
  ["Iron Cavern Right"] = Vector3.new(-8792, -585, 223),
  ["Iron Cavern Left"] = Vector3.new(-8795, -585, 89),
  ["Iron Cafe"] = Vector3.new(-8642, -548, 162),
}
locationNames = {}
for r22_0 in pairs(r18_0) do
  table.insert(locationNames, r22_0)
end
table.sort(locationNames, function(r0_130, r1_130)
  -- line: [0, 0] id: 130
  return r0_130:lower() < r1_130:lower()
end)
function r19_0()
  -- line: [0, 0] id: 113
  for r3_113, r4_113 in ipairs({
    r6_0.Net["RE/ObtainedNewFishNotification"],
    r6_0.Net["RE/TextNotification"],
    r6_0.Net["RE/ClaimNotification"]
  }) do
    for r8_113, r9_113 in ipairs(getconnections(r4_113.OnClientEvent)) do
      r9_113:Disconnect()
      table.insert(r9_0.notifConnections, r9_113)
    end
  end
end
local function r20_0()
  -- line: [0, 0] id: 254
  r9_0.notifConnections = {}
end
local r24_0 = "HttpGet"
r24_0 = "https://raw.githubusercontent.com/TesterX14/XXXX/refs/heads/main/Library"
local r21_0 = loadstring(game:[r24_0](r24_0))()
r24_0 = "Window"
r24_0 = {
  Title = "Chloe X |",
  Footer = "Version 1.0.8",
  Image = "132435516080103",
  Color = Color3.fromRGB(0, 208, 255),
  Theme = 9542022979,
  Version = 4,
}
local r22_0 = r21_0:[r24_0](r24_0)
if r22_0 then
  chloex("Window loaded!")
end
local r23_0 = {}
local r27_0 = "AddTab"
r27_0 = {
  Name = "Info",
  Icon = "player",
}
r23_0.Info = r22_0:[r27_0](r27_0)
local r26_0 = "AddTab"
r26_0 = {
  Name = "Fishing",
  Icon = "rbxassetid://97167558235554",
}
r23_0.Main = r22_0:[r26_0](r26_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Automatically",
  Icon = "next",
}
r23_0.Auto = r22_0:[r27_0](r27_0)
r26_0 = "AddTab"
r26_0 = {
  Name = "Trading",
  Icon = "rbxassetid://114581487428395",
}
r23_0.Trade = r22_0:[r26_0](r26_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Menu",
  Icon = "rbxassetid://140165584241571",
}
r23_0.Farm = r22_0:[r27_0](r27_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Quest",
  Icon = "scroll",
}
r23_0.Quest = r22_0:[r27_0](r27_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Teleport",
  Icon = "rbxassetid://18648122722",
}
r23_0.Tele = r22_0:[r27_0](r27_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Webhook",
  Icon = "rbxassetid://137601480983962",
}
r23_0.Webhook = r22_0:[r27_0](r27_0)
r27_0 = "AddTab"
r27_0 = {
  Name = "Misc",
  Icon = "rbxassetid://6034509993",
}
r23_0.Misc = r22_0:[r27_0](r27_0)
r24_0 = "https://raw.githubusercontent.com/ChloeRewite/test/refs/heads/main/2.lua"
local r25_0, r26_0 = pcall(function()
  -- line: [0, 0] id: 294
  local r1_294, r2_294 = loadstring(game:HttpGet(r24_0))
  if not r1_294 then
    error(r2_294)
  end
  return r1_294()
end)
if r25_0 and type(r26_0) == "function" then
  pcall(r26_0, r22_0, r23_0)
end
local r29_0 = "AddSection"
r29_0 = "Fishing Support"
Fish1 = r23_0.Main:[r29_0](r29_0)
r29_0 = "AddToggle"
r29_0 = {
  Title = "Show Fishing Panel",
  Default = false,
  Callback = function(r0_70)
    -- line: [0, 0] id: 70
    local r1_70 = nil	-- notice: implicit variable refs by block#[4, 5]
    if r0_70 then
      r1_70 = game:GetService("Players").LocalPlayer
      if game.CoreGui:FindFirstChild("ChloeX_FishingPanel") then
        game.CoreGui:FindFirstChild("ChloeX_FishingPanel"):Destroy()
      end
      local r2_70 = Instance.new("ScreenGui")
      r2_70.Name = "ChloeX_FishingPanel"
      r2_70.IgnoreGuiInset = true
      r2_70.ResetOnSpawn = false
      r2_70.ZIndexBehavior = Enum.ZIndexBehavior.Global
      r2_70.Parent = game.CoreGui
      local r3_70 = Instance.new("Frame", r2_70)
      r3_70.Size = UDim2.new(0, 400, 0, 210)
      r3_70.AnchorPoint = Vector2.new(0.5, 0.5)
      r3_70.Position = UDim2.new(0.5, 0, 0.5, 0)
      r3_70.BackgroundColor3 = Color3.fromRGB(20, 22, 35)
      r3_70.BorderSizePixel = 0
      r3_70.BackgroundTransparency = 0.05
      r3_70.Active = true
      r3_70.Draggable = true
      local r4_70 = Instance.new("UIStroke", r3_70)
      r4_70.Thickness = 2
      r4_70.Color = Color3.fromRGB(80, 150, 255)
      r4_70.Transparency = 0.35
      Instance.new("UICorner", r3_70).CornerRadius = UDim.new(0, 14)
      local r6_70 = Instance.new("ImageLabel", r3_70)
      r6_70.Size = UDim2.new(0, 28, 0, 28)
      r6_70.Position = UDim2.new(0, 10, 0, 6)
      r6_70.BackgroundTransparency = 1
      r6_70.Image = "rbxassetid://100076212630732"
      r6_70.ScaleType = Enum.ScaleType.Fit
      local r7_70 = Instance.new("TextLabel", r3_70)
      r7_70.Size = UDim2.new(1, -40, 0, 36)
      r7_70.Position = UDim2.new(0, 45, 0, 5)
      r7_70.BackgroundTransparency = 1
      r7_70.Font = Enum.Font.GothamBold
      r7_70.Text = "CHLOEX PANEL FISHING"
      r7_70.TextSize = 22
      r7_70.TextColor3 = Color3.fromRGB(255, 255, 255)
      r7_70.TextXAlignment = Enum.TextXAlignment.Left
      local r8_70 = Instance.new("UIGradient", r7_70)
      r8_70.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 220, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 220, 255))
      })
      r8_70.Rotation = 45
      local r9_70 = Instance.new("TextLabel", r3_70)
      r9_70.Position = UDim2.new(0, 15, 0, 55)
      r9_70.Size = UDim2.new(1, -30, 0, 22)
      r9_70.Font = Enum.Font.GothamBold
      r9_70.TextSize = 18
      r9_70.BackgroundTransparency = 1
      r9_70.TextColor3 = Color3.fromRGB(140, 200, 255)
      r9_70.Text = "INVENTORY COUNT:"
      local r10_70 = Instance.new("TextLabel", r3_70)
      r10_70.Position = UDim2.new(0, 15, 0, 75)
      r10_70.Size = UDim2.new(1, -30, 0, 22)
      r10_70.Font = Enum.Font.Gotham
      r10_70.TextSize = 18
      r10_70.BackgroundTransparency = 1
      r10_70.TextColor3 = Color3.fromRGB(255, 255, 255)
      r10_70.Text = "Fish: 0/0"
      local r11_70 = Instance.new("TextLabel", r3_70)
      r11_70.Position = UDim2.new(0, 15, 0, 105)
      r11_70.Size = UDim2.new(1, -30, 0, 22)
      r11_70.Font = Enum.Font.GothamBold
      r11_70.TextSize = 18
      r11_70.BackgroundTransparency = 1
      r11_70.TextColor3 = Color3.fromRGB(140, 200, 255)
      r11_70.Text = "TOTAL FISH CAUGHT:"
      local r12_70 = Instance.new("TextLabel", r3_70)
      r12_70.Position = UDim2.new(0, 15, 0, 125)
      r12_70.Size = UDim2.new(1, -30, 0, 22)
      r12_70.Font = Enum.Font.Gotham
      r12_70.TextSize = 18
      r12_70.BackgroundTransparency = 1
      r12_70.TextColor3 = Color3.fromRGB(255, 255, 255)
      r12_70.Text = "Value: 0"
      local r13_70 = Instance.new("TextLabel", r3_70)
      r13_70.Position = UDim2.new(0.5, 0, 0, 165)
      r13_70.AnchorPoint = Vector2.new(0.5, 0)
      r13_70.Size = UDim2.new(0.8, 0, 0, 30)
      r13_70.Font = Enum.Font.GothamBold
      r13_70.TextSize = 22
      r13_70.Text = "FISHING NORMAL"
      r13_70.BackgroundTransparency = 1
      r13_70.TextColor3 = Color3.fromRGB(0, 255, 100)
      local r14_70 = r1_70.leaderstats.Caught.Value
      local r15_70 = tick()
      local r16_70 = false
      r9_0.fishingPanelRunning = true
      task.spawn(function()
        -- line: [0, 0] id: 71
        while r9_0.fishingPanelRunning do
          local r0_71 = task.wait(1)
          if r0_71 then
            r0_71 = ""
            pcall(function()
              -- line: [0, 0] id: 72
              r0_71 = r1_70.PlayerGui.Inventory.Main.Top.Options.Fish.Label.BagSize.Text
            end)
            local r1_71 = r1_70.leaderstats.Caught.Value
            r10_70.Text = "Fish: " .. (r0_71 or "0/0")
            r12_70.Text = "Value: " .. tostring(r1_71)
            if r14_70 < r1_71 then
              r14_70 = r1_71
              r15_70 = tick()
              if r16_70 then
                r16_70 = false
                r13_70.Text = "FISHING NORMAL"
                r13_70.TextColor3 = Color3.fromRGB(0, 255, 100)
              end
            end
            if not r16_70 and 10 <= tick() - r15_70 then
              r16_70 = true
              r13_70.Text = "FISHING STUCK"
              r13_70.TextColor3 = Color3.fromRGB(255, 70, 70)
            end
            -- close: r0_71
          else
            break
          end
        end
      end)
      -- close: r1_70
    else
      r1_70 = r9_0
      r1_70.fishingPanelRunning = false
      r1_70 = game
      r1_70 = r1_70.CoreGui
      r1_70 = r1_70:FindFirstChild("ChloeX_FishingPanel")
      if r1_70 then
        r1_70:Destroy()
      end
    end
  end,
}
Fish1:[r29_0](r29_0)
r29_0 = "AddToggle"
r29_0 = {
  Title = "Auto Equip Rod",
  Content = "Automatically equip your fishing rod",
  Default = false,
  Callback = function(r0_105)
    -- line: [0, 0] id: 105
    r9_0.autoEquipRod = r0_105
    local function r1_105()
      -- line: [0, 0] id: 107
      local r0_107 = r8_0.Data:Get("EquippedId")
      if not r0_107 then
        return false
      end
      local r1_107 = r6_0.PlayerStatsUtility:GetItemFromInventory(r8_0.Data, function(r0_108)
        -- line: [0, 0] id: 108
        return r0_108.UUID == r0_107
      end)
      if not r1_107 then
        return false
      end
      local r2_107 = r6_0.ItemUtility:GetItemData(r1_107.Id)
      return r2_107 and r2_107.Data.Type == "Fishing Rods"
    end
    local function r2_105()
      -- line: [0, 0] id: 106
      if not r1_105() then
        r7_0.Events.REEquip:FireServer(1)
      end
    end
    task.spawn(function()
      -- line: [0, 0] id: 109
      while r9_0.autoEquipRod do
        r2_105()
        task.wait(1)
      end
    end)
  end,
}
Fish1:[r29_0](r29_0)
r29_0 = "AddToggle"
r29_0 = {
  Title = "No Fishing Animations",
  Default = false,
  Callback = function(r0_73)
    -- line: [0, 0] id: 73
    local r3_73 = (r1_0.Character or r1_0.CharacterAdded:Wait()):WaitForChild("Humanoid"):FindFirstChildOfClass("Animator")
    if not r3_73 then
      return 
    end
    if r0_73 then
      r9_0.stopAnimHookEnabled = true
      for r7_73, r8_73 in ipairs(r3_73:GetPlayingAnimationTracks()) do
        r8_73:Stop(0)
      end
      r9_0.stopAnimConn = r3_73.AnimationPlayed:Connect(function(r0_74)
        -- line: [0, 0] id: 74
        if r9_0.stopAnimHookEnabled then
          task.defer(function()
            -- line: [0, 0] id: 75
            pcall(function()
              -- line: [0, 0] id: 76
              r0_74:Stop(0)
            end)
          end)
        end
      end)
    else
      r9_0.stopAnimHookEnabled = false
      if r9_0.stopAnimConn then
        r9_0.stopAnimConn:Disconnect()
        r9_0.stopAnimConn = nil
      end
    end
  end,
}
Fish1:[r29_0](r29_0)
r27_0 = false
local r28_0 = nil
r29_0 = nil
local r30_0 = -1.8
local r33_0 = "AddToggle"
r33_0 = {
  Title = "Walk on Water",
  Default = false,
  Callback = function(r0_2)
    -- line: [0, 0] id: 2
    r27_0 = r0_2
    local r2_2 = (r1_0.Character or r1_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
    if r0_2 then
      r28_0 = Instance.new("Part")
      r28_0.Name = "WW_Part"
      r28_0.Size = Vector3.new(15, 1, 15)
      r28_0.Anchored = true
      r28_0.CanCollide = false
      r28_0.Transparency = 1
      r28_0.Material = Enum.Material.SmoothPlastic
      r28_0.Parent = workspace
      r29_0 = r0_0.RunService.Heartbeat:Connect(function()
        -- line: [0, 0] id: 3
        if not r27_0 or not r28_0 or not r2_2 then
          return 
        end
        r28_0.Position = Vector3.new(r2_2.Position.X, r30_0, r2_2.Position.Z)
        r28_0.CanCollide = r30_0 < r2_2.Position.Y
      end)
    else
      if r29_0 then
        r29_0:Disconnect()
        r29_0 = nil
      end
      if r28_0 then
        r28_0:Destroy()
        r28_0 = nil
      end
    end
  end,
}
Fish1:[r33_0](r33_0)
-- close: r27_0
r27_0 = Fish1
r29_0 = "AddToggle"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Freeze Player"
r30_0 = "Content"
r29_0[r30_0] = "Freeze only if rod is equipped"
r30_0 = "Default"
r29_0[r30_0] = false
r30_0 = "Callback"
r29_0[r30_0] = function(r0_302)
  -- line: [0, 0] id: 302
  r9_0.frozen = r0_302
  local function r2_302()
    -- line: [0, 0] id: 304
    local r0_304 = r8_0.Data:Get("EquippedId")
    if not r0_304 then
      return false
    end
    local r1_304 = r6_0.PlayerStatsUtility:GetItemFromInventory(r8_0.Data, function(r0_305)
      -- line: [0, 0] id: 305
      return r0_305.UUID == r0_304
    end)
    if not r1_304 then
      return false
    end
    local r2_304 = r6_0.ItemUtility:GetItemData(r1_304.Id)
    return r2_304 and r2_304.Data.Type == "Fishing Rods"
  end
  local function r3_302()
    -- line: [0, 0] id: 306
    if not r2_302() then
      r7_0.Events.REEquip:FireServer(1)
      task.wait(0.5)
    end
  end
  local function r4_302(r0_303, r1_303)
    -- line: [0, 0] id: 303
    if not r0_303 then
      return 
    end
    for r5_303, r6_303 in ipairs(r0_303:GetDescendants()) do
      if r6_303:IsA("BasePart") then
        r6_303.Anchored = r1_303
      end
    end
  end
  local function r5_302(r0_308)
    -- line: [0, 0] id: 308
    if r9_0.frozen then
      r3_302()
      if r2_302() then
        r4_302(r0_308, true)
      end
    else
      r4_302(r0_308, false)
    end
  end
  r5_302(r9_0.player.Character)
  r9_0.player.CharacterAdded:Connect(function(r0_307)
    -- line: [0, 0] id: 307
    task.wait(1)
    r5_302(r0_307)
  end)
end
r27_0:[r29_0](r29_0)
r27_0 = r23_0.Main
r29_0 = "AddSection"
r29_0 = "Fishing Features"
r27_0 = r27_0:[r29_0](r29_0)
Fish = r27_0
r27_0 = Fish
r29_0 = "AddParagraph"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Detector Stuck"
r30_0 = "Content"
r29_0[r30_0] = "Status = Idle\nTime = 0.0s\nBag = 0"
r27_0 = r27_0:[r29_0](r29_0)
DetectorParagraph = r27_0
r27_0 = Fish
r29_0 = "AddSlider"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Wait (s)"
r30_0 = "Default"
r29_0[r30_0] = 15
r30_0 = "Min"
r29_0[r30_0] = 10
r30_0 = "Max"
r29_0[r30_0] = 25
r30_0 = "Rounding"
r29_0[r30_0] = 0
r30_0 = "Callback"
r29_0[r30_0] = function(r0_300)
  -- line: [0, 0] id: 300
  r9_0.stuckThreshold = r0_300
end
r27_0:[r29_0](r29_0)
r27_0 = Fish
r29_0 = "AddToggle"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Start Detector"
r30_0 = "Default"
r29_0[r30_0] = false
r30_0 = "Callback"
r29_0[r30_0] = function(r0_16)
  -- line: [0, 0] id: 16
  r9_0.supportEnabled = r0_16
  if r0_16 then
    r9_0.char = r9_0.player.Character or r9_0.player.CharacterAdded:Wait()
    r9_0.savedCFrame = r9_0.char:WaitForChild("HumanoidRootPart").CFrame
    _G.Celestial.DetectorCount = getFishCount()
    r9_0.fishingTimer = 0
    task.spawn(function()
      -- line: [0, 0] id: 17
      local r0_17 = tick()
      while r9_0.supportEnabled do
        task.wait(0.2)
        local r1_17, r2_17 = pcall(getFishCount)
        if not r1_17 or not r2_17 then
          DetectorParagraph:SetContent("<font color=\'rgb(255,69,0)\'>Status = Error Reading Count</font>\nTime = 0.0s\nBag = 0")
          r9_0.fishingTimer = 0
        else
          local r3_17 = tick()
          r0_17 = r3_17
          r9_0.fishingTimer = r9_0.fishingTimer + r3_17 - r0_17
          if not r9_0.char or not r9_0.char.Parent then
            r9_0.char = r9_0.player.Character or r9_0.player.CharacterAdded:Wait()
          end
          if r2_17 ~= _G.Celestial.DetectorCount then
            _G.Celestial.DetectorCount = r2_17
            r9_0.fishingTimer = 0
          end
          if (r9_0.stuckThreshold or 10) <= r9_0.fishingTimer then
            DetectorParagraph:SetContent("<font color=\'rgb(255,69,0)\'>Status = Reset!</font>\nTime = 0.0s\nBag = " .. r2_17)
            local r5_17 = r9_0.char:FindFirstChild("HumanoidRootPart")
            if r5_17 then
              r9_0.savedCFrame = r5_17.CFrame
            end
            r9_0.player.Character:BreakJoints()
            r9_0.char = r9_0.player.CharacterAdded:Wait()
            task.wait(0.3)
            r9_0.char:WaitForChild("HumanoidRootPart").CFrame = r9_0.savedCFrame
            _G.Celestial.DetectorCount = getFishCount()
            r9_0.fishingTimer = 0
          else
            DetectorParagraph:SetContent(string.format("<font color=\'rgb(0,255,127)\'>Status = Running</font>\nTime = %.1fs\nBag = %d", r9_0.fishingTimer, r2_17))
          end
        end
      end
      DetectorParagraph:SetContent("<font color=\'rgb(200,200,200)\'>Status = Detector Offline</font>\nTime = 0.0s\nBag = 0")
    end)
  else
    DetectorParagraph:SetContent("<font color=\'rgb(200,200,200)\'>Status = Detector Offline</font>\nTime = 0.0s\nBag = 0")
  end
end
r27_0:[r29_0](r29_0)
r27_0 = Fish
r29_0 = "AddInput"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Legit Delay"
r30_0 = "Content"
r29_0[r30_0] = "Delay complete fishing!"
r30_0 = "Value"
r29_0[r30_0] = tostring(_G.Delay)
r30_0 = "Callback"
r29_0[r30_0] = function(r0_31)
  -- line: [0, 0] id: 31
  local r1_31 = tonumber(r0_31)
  if r1_31 and 0 < r1_31 then
    _G.Delay = r1_31
    SaveConfig()
    task.spawn(function()
      -- line: [0, 0] id: 32
      -- notice: unreachable block#12
      print("Started")
      while true do
        if r6_0.FishingController then
          local r0_32 = r6_0.FishingController._autoLoop
          if r0_32 then
            r0_32 = r6_0.FishingController
            if r0_32:GetCurrentGUID() then
              print("Waiting", _G.Delay)
              task.wait(_G.Delay)
              while true do
                local r1_32, r2_32 = pcall(function()
                  -- line: [0, 0] id: 33
                  r7_0.Events.REFishDone:FireServer()
                end)
                if r1_32 then
                  print("Successfully")
                else
                  warn("Failed to Fire", r2_32)
                end
                task.wait(0.05)
                if r0_32:GetCurrentGUID() and r0_32._autoLoop then
                  goto label_50	-- block#9 is visited secondly
                else
                  break
                end
              end
              print("loop ended")
            end
          end
        end
        task.wait(0.05)
      end
    end)
  else
    warn("Invalid fishing delay input")
  end
end
r27_0:[r29_0](r29_0)
r27_0 = 0
shakeDelay = r27_0
r27_0 = Fish
r29_0 = "AddInput"
r29_0 = {}
r30_0 = "Title"
r29_0[r30_0] = "Shake Delay"
r30_0 = "Value"
r29_0[r30_0] = tostring(shakeDelay)
r30_0 = "Callback"
r29_0[r30_0] = function(r0_176)
  -- line: [0, 0] id: 176
  local r1_176 = tonumber(r0_176)
  if r1_176 and 0 <= r1_176 then
    shakeDelay = r1_176
  end
end
r27_0:[r29_0](r29_0)
r27_0 = nil
r28_0 = r6_0.InputControl
r29_0 = "RegisterMouseReleased"
r28_0 = r28_0[r29_0]
oldRegister = r28_0
r28_0 = r6_0.InputControl
r29_0 = "RegisterMouseReleased"
function r30_0(r0_247, r1_247, r2_247)
  -- line: [0, 0] id: 247
  r27_0 = r2_247
  return oldRegister(r0_247, r1_247, r2_247)
end
r28_0[r29_0] = r30_0
function r28_0()
  -- line: [0, 0] id: 321
  local r0_321 = r0_0.PG
  local r1_321 = r0_0.Camera
  local r2_321 = Vector2.new(r1_321.ViewportSize.X / 2, r1_321.ViewportSize.Y / 2)
  pcall(function()
    -- line: [0, 0] id: 323
    r7_0.Functions.Cancel:InvokeServer()
  end)
  pcall(function()
    -- line: [0, 0] id: 322
    r6_0.FishingController:RequestChargeFishingRod(r2_321, false)
  end)
  local r3_321 = r0_321:WaitForChild("Charge"):WaitForChild("Main"):WaitForChild("CanvasGroup"):WaitForChild("Bar")
  repeat
    task.wait()
  until r3_321.Size.Y.Scale > 0
  local r4_321 = tick()
  while r3_321:IsDescendantOf(r0_321) do
    local r5_321 = r3_321.Size.Y.Scale
    if r5_321 < 0.93 then
      task.wait()
      r5_321 = tick() - r4_321
      if r5_321 > 2 then
        break
      end
    else
      break
    end
  end
  if r27_0 then
    pcall(r27_0)
  end
end
castWithBarRelease = r28_0
r28_0 = tostring
r29_0 = r0_0.Players
r29_0 = r29_0.LocalPlayer
r30_0 = "UserId"
r29_0 = r29_0[r30_0]
r28_0 = r28_0(r29_0)
userId = r28_0
r28_0 = workspace
r30_0 = "CosmeticFolder"
r28_0 = r28_0:WaitForChild(r30_0)
CosmeticFolder = r28_0
r28_0 = Fish
r30_0 = "AddToggle"
r30_0 = {
  Title = "Legit Fishing",
  Default = false,
  Callback = function(r0_140)
    -- line: [0, 0] id: 140
    r6_0.FishingController._autoLoop = r0_140
    if r0_140 then
      task.spawn(function()
        -- line: [0, 0] id: 141
        while r6_0.FishingController._autoLoop do
          local r0_141 = CosmeticFolder:FindFirstChild(userId)
          if not r0_141 then
            castWithBarRelease()
            task.wait(0.2)
          end
          while true do
            r0_141 = CosmeticFolder:FindFirstChild(userId)
            if r0_141 then
              r0_141 = r6_0.FishingController._autoLoop
              if r0_141 then
                task.wait(0.2)
              else
                break
              end
            else
              break
            end
          end
          task.wait(0.2)
        end
      end)
    end
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = Fish
r30_0 = "AddToggle"
r30_0 = {
  Title = "Auto Shake",
  Content = "Spam click during fishing (only legit)",
  Default = false,
  Callback = function(r0_222)
    -- line: [0, 0] id: 222
    r6_0._autoShake = r0_222
    local r1_222 = r0_0.PG:FindFirstChild("!!! Click Effect")
    if r0_222 then
      if r1_222 then
        r1_222.Enabled = false
      end
      task.spawn(function()
        -- line: [0, 0] id: 223
        while r6_0._autoShake do
          pcall(function()
            -- line: [0, 0] id: 224
            r6_0.FishingController:RequestFishingMinigameClick()
          end)
          task.wait(shakeDelay)
        end
      end)
    elseif r1_222 then
      clickEff11111ect.Enabled = true
    end
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = r23_0.Main
r30_0 = "AddSection"
r30_0 = "Instant Features"
r28_0 = r28_0:[r30_0](r30_0)
Fish0 = r28_0
r28_0 = Fish0
r30_0 = "AddInput"
r30_0 = {
  Title = "Delay Complete",
  Value = tostring(_G.DelayComplete),
  Callback = function(r0_9)
    -- line: [0, 0] id: 9
    local r1_9 = tonumber(r0_9)
    if r1_9 and 0 <= r1_9 then
      _G.DelayComplete = r1_9
      SaveConfig()
    end
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = Fish0
r30_0 = "AddToggle"
r30_0 = {
  Title = "Instant Fishing",
  Content = "Auto instantly catch fish",
  Default = false,
  Callback = function(r0_184)
    -- line: [0, 0] id: 184
    r9_0.autoInstant = r0_184
    if r0_184 then
      _G.Celestial.InstantCount = getFishCount()
      task.spawn(function()
        -- line: [0, 0] id: 185
        while r9_0.autoInstant do
          local r0_185 = r9_0.canFish
          if r0_185 then
            r9_0.canFish = false
            local r0_185, r1_185, r2_185 = pcall(function()
              -- line: [0, 0] id: 189
              return r7_0.Functions.ChargeRod:InvokeServer(workspace:GetServerTimeNow())
            end)
            local r3_185 = nil	-- notice: implicit variable refs by block#[12]
            local r4_185 = nil	-- notice: implicit variable refs by block#[12]
            if r0_185 then
              r3_185 = typeof(r2_185)
              if r3_185 == "number" then
                r3_185 = -1
                r4_185 = 0.999
                task.wait(0.3)
                pcall(function()
                  -- line: [0, 0] id: 186
                  r7_0.Functions.StartMini:InvokeServer(r3_185, r4_185, r2_185)
                end)
                local r5_185 = tick()
                while true do
                  task.wait()
                  if _G.FishMiniData then
                    local r6_185 = _G.FishMiniData.LastShift
                    if not r6_185 then
                      ::label_48::
                      r6_185 = tick() - r5_185
                      if r6_185 > 1 then
                        break
                      end
                    else
                      break
                    end
                  else
                    goto label_48	-- block#7 is visited secondly
                  end
                end
                task.wait(_G.DelayComplete)
                pcall(function()
                  -- line: [0, 0] id: 187
                  r7_0.Events.REFishDone:FireServer()
                end)
                local r6_185 = getFishCount()
                local r7_185 = tick()
                while true do
                  task.wait()
                  if r6_185 >= getFishCount() then
                    local r8_185 = tick() - r7_185
                    if r8_185 > 1 then
                      break
                    end
                  else
                    break
                  end
                end
                -- close: r3_185
              end
            end
            r3_185 = pcall
            function r4_185()
              -- line: [0, 0] id: 188
              r7_0.Functions.Cancel:InvokeServer()
            end
            r3_185(r4_185)
            r3_185 = r9_0
            r3_185.canFish = true
            -- close: r0_185
          end
          task.wait()
        end
      end)
    end
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = MiniEvent
if r28_0 then
  r28_0 = _G
  r29_0 = "_MiniEventConn"
  r28_0 = r28_0[r29_0]
  if r28_0 then
    r28_0 = _G
    r29_0 = "_MiniEventConn"
    r28_0 = r28_0[r29_0]
    r30_0 = "Disconnect"
    r28_0:[r30_0]()
  end
  r28_0 = _G
  r29_0 = "_MiniEventConn"
  r30_0 = MiniEvent
  r30_0 = r30_0.OnClientEvent
  local r32_0 = "Connect"
  function r32_0(r0_77, r1_77)
    -- line: [0, 0] id: 77
    if r0_77 and r1_77 then
      _G.FishMiniData = r1_77
    end
  end
  r30_0 = r30_0:[r32_0](r32_0)
  r28_0[r29_0] = r30_0
end
r28_0 = r23_0.Main
r30_0 = "AddSection"
r30_0 = "Blatant Features"
r28_0 = r28_0:[r30_0](r30_0)
Fish2 = r28_0
function r28_0()
  -- line: [0, 0] id: 235
  task.spawn(function()
    -- line: [0, 0] id: 236
    pcall(function()
      -- line: [0, 0] id: 239
      r7_0.Functions.Cancel:InvokeServer()
    end)
    local r0_236 = workspace:GetServerTimeNow()
    pcall(function()
      -- line: [0, 0] id: 238
      r7_0.Functions.ChargeRod:InvokeServer(r0_236)
    end)
    pcall(function()
      -- line: [0, 0] id: 237
      r7_0.Functions.StartMini:InvokeServer(-1, 0.999)
    end)
    task.wait(_G.FishingDelay)
    pcall(function()
      -- line: [0, 0] id: 240
      r7_0.Events.REFishDone:FireServer()
    end)
  end)
end
Fastest = r28_0
r28_0 = Fish2
r30_0 = "AddInput"
r30_0 = {
  Title = "Delay Reel",
  Value = tostring(_G.Reel),
  Default = "1.9",
  Callback = function(r0_195)
    -- line: [0, 0] id: 195
    local r1_195 = tonumber(r0_195)
    if r1_195 and 0 < r1_195 then
      _G.Reel = r1_195
    end
    SaveConfig()
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = Fish2
r30_0 = "AddInput"
r30_0 = {
  Title = "Delay Fishing",
  Value = tostring(_G.FishingDelay),
  Default = "1.1",
  Callback = function(r0_135)
    -- line: [0, 0] id: 135
    local r1_135 = tonumber(r0_135)
    if r1_135 and 0 < r1_135 then
      _G.FishingDelay = r1_135
    end
    SaveConfig()
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = Fish2
r30_0 = "AddToggle"
r30_0 = {
  Title = "Blatant Fishing",
  Default = _G.FBlatant,
  Callback = function(r0_329)
    -- line: [0, 0] id: 329
    _G.FBlatant = r0_329
    r7_0.Functions.AutoEnabled:InvokeServer(r0_329)
    if r0_329 then
      r1_0:SetAttribute("Loading", nil)
      task.spawn(function()
        -- line: [0, 0] id: 330
        while _G.FBlatant do
          Fastest()
          task.wait(_G.Reel)
        end
      end)
    else
      r1_0:SetAttribute("Loading", false)
    end
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = Fish2
r30_0 = "AddButton"
r30_0 = {
  Title = "Recovery Fishing",
  Callback = function()
    -- line: [0, 0] id: 265
    task.spawn(function()
      -- line: [0, 0] id: 266
      pcall(function()
        -- line: [0, 0] id: 267
        r7_0.Functions.Cancel:InvokeServer()
      end)
      local r0_266 = game:GetService("Players").LocalPlayer
      r0_266:SetAttribute("Loading", nil)
      task.wait(0.05)
      r0_266:SetAttribute("Loading", false)
      chloex("Recovery Successfully!")
    end)
  end,
}
r28_0:[r30_0](r30_0)
r28_0 = r23_0.Main
r30_0 = "AddSection"
r30_0 = "Selling Features"
r28_0 = r28_0:[r30_0](r30_0)
local r31_0 = "AddDropdown"
r31_0 = {}
r31_0.Options = {
  "Delay",
  "Count"
}
r31_0.Default = "Delay"
r31_0.Title = "Select Sell Mode"
function r31_0.Callback(r0_124)
  -- line: [0, 0] id: 124
  r9_0.sellMode = r0_124
  SaveConfig()
end
r28_0:[r31_0](r31_0)
r31_0 = "AddInput"
r31_0 = {
  Default = "1",
  Title = "Set Value",
  Content = "Delay = Minutes | Count = Backpack Count",
  Placeholder = "Input Here",
  Callback = function(r0_160)
    -- line: [0, 0] id: 160
    local r1_160 = tonumber(r0_160) or 1
    if r9_0.sellMode == "Delay" then
      r9_0.sellDelay = r1_160 * 60
    else
      r9_0.inputSellCount = r1_160
    end
    SaveConfig()
  end,
}
r28_0:[r31_0](r31_0)
r31_0 = "AddToggle"
r31_0 = {
  Title = "Start Selling",
  Default = false,
  Callback = function(r0_126)
    -- line: [0, 0] id: 126
    r9_0.autoSellEnabled = r0_126
    if r0_126 then
      task.spawn(function()
        -- line: [0, 0] id: 127
        local r0_127 = r6_0.Net["RF/SellAllItems"]
        while r9_0.autoSellEnabled do
          local r1_127 = r1_0:WaitForChild("PlayerGui")
          r1_127 = r1_127:WaitForChild("Inventory").Main.Top.Options.Fish.Label:FindFirstChild("BagSize")
          local r2_127 = 0
          local r3_127 = 0
          if r1_127 and r1_127:IsA("TextLabel") then
            local r5_127, r6_127 = (r1_127.Text or ""):match("(%d+)%s*/%s*(%d+)")
            local r7_127 = tonumber(r5_127) or 0
            r3_127 = tonumber(r6_127) or 0
            r2_127 = r7_127
          end
          if r9_0.sellMode == "Delay" then
            task.wait(r9_0.sellDelay)
            r0_127:InvokeServer()
          elseif r9_0.sellMode == "Count" then
            if (tonumber(r9_0.inputSellCount) or r3_127) <= r2_127 then
              r0_127:InvokeServer()
            end
            task.wait()
          end
        end
      end)
    end
  end,
}
r28_0:[r31_0](r31_0)
r31_0 = "AddSubSection"
r31_0 = "Auto Sell Enchant Stone"
r28_0:[r31_0](r31_0)
r29_0 = 10
EnchantStoneID = r29_0
r29_0 = 0
TargetLeft = r29_0
r29_0 = false
AutoSellRunning = r29_0
r31_0 = "AddParagraph"
r31_0 = {
  Title = "Enchant Stone Left Status",
  Content = "Counting...",
}
r29_0 = r28_0:[r31_0](r31_0)
EnchantStonePanel = r29_0
r31_0 = "AddInput"
r31_0 = {
  Title = "Target Left",
  Default = "0",
  Callback = function(r0_119)
    -- line: [0, 0] id: 119
    num = tonumber(r0_119)
    if num and 0 <= num then
      TargetLeft = num
    end
  end,
}
r28_0:[r31_0](r31_0)
r31_0 = "AddToggle"
r31_0 = {
  Title = "Start Sell Enchant Stone",
  Default = false,
  Callback = function(r0_120)
    -- line: [0, 0] id: 120
    AutoSellRunning = r0_120
    if not AutoSellRunning then
      return 
    end
    task.spawn(function()
      -- line: [0, 0] id: 121
      while AutoSellRunning do
        local r0_121 = r8_0.Data
        inv = r0_121:GetExpect({
          "Inventory",
          "Items"
        })
        count = 0
        targetUUID = nil
        r0_121 = ipairs
        for r3_121, r4_121 in r0_121(inv) do
          if r4_121.Id == EnchantStoneID then
            count = count + 1
            if not targetUUID then
              targetUUID = r4_121.UUID
            end
          end
        end
        EnchantStonePanel:SetContent("Enchant Stone : " .. count)
        r0_121 = count
        if r0_121 <= TargetLeft then
          r0_121 = false
          AutoSellRunning = r0_121
          break
        else
          r0_121 = targetUUID
          if not r0_121 then
            r0_121 = false
            AutoSellRunning = r0_121
            break
          else
            task.defer(function()
              -- line: [0, 0] id: 122
              r7_0.Functions.SellItem:InvokeServer(targetUUID)
            end)
            task.wait(0.1)
          end
        end
      end
    end)
  end,
}
r28_0:[r31_0](r31_0)
r29_0 = task
r30_0 = "spawn"
r29_0 = r29_0[r30_0]
function r30_0()
  -- line: [0, 0] id: 283
  while task.wait(1) do
    local r0_283 = r8_0.Data
    inv = r0_283:GetExpect({
      "Inventory",
      "Items"
    })
    count = 0
    r0_283 = ipairs
    for r3_283, r4_283 in r0_283(inv) do
      if r4_283.Id == EnchantStoneID then
        count = count + 1
      end
    end
    EnchantStonePanel:SetContent("Enchant Stone : " .. count)
  end
end
r29_0(r30_0)
r29_0 = r23_0.Main
r31_0 = "AddSection"
r31_0 = "Favorite Features"
r29_0 = r29_0:[r31_0](r31_0)
local r32_0 = "AddDropdown"
r32_0 = {}
r33_0 = "Options"
local r34_0 = #r10_0
if r34_0 > 0 then
  r34_0 = r10_0
  if r34_0 then
    ::label_1829::
    r34_0 = {}
    local r35_0 = "No Fish Found"
    -- setlist for #34 failed
  end
else
  goto label_1829	-- block#75 is visited secondly
end
r32_0[r33_0] = r34_0
r32_0.Content = "Favorite By Name Fish (Recommended)"
r32_0.Multi = true
r32_0.Title = "Name"
function r32_0.Callback(r0_104)
  -- line: [0, 0] id: 104
  r9_0.selectedName = toSet(r0_104)
end
r29_0:[r32_0](r32_0)
r32_0 = "AddDropdown"
r32_0 = {}
r32_0.Options = {
  "Common",
  "Uncommon",
  "Rare",
  "Epic",
  "Legendary",
  "Mythic",
  "Secret"
}
r32_0.Content = "Favorite By Rarity (Optional)"
r32_0.Multi = true
r32_0.Title = "Rarity"
function r32_0.Callback(r0_285)
  -- line: [0, 0] id: 285
  r9_0.selectedRarity = toSet(r0_285)
end
r29_0:[r32_0](r32_0)
r32_0 = "AddDropdown"
r32_0 = {
  Options = _G.Variant,
  Content = "Favorite By Variant (Only works with Name)",
  Multi = true,
  Title = "Variant",
  Callback = function(r0_298)
    -- line: [0, 0] id: 298
    if next(r9_0.selectedName) ~= nil then
      r9_0.selectedVariant = toSet(r0_298)
    else
      r9_0.selectedVariant = {}
      warn("Pilih Name dulu sebelum memilih Variant.")
    end
  end,
}
r29_0:[r32_0](r32_0)
r32_0 = "AddToggle"
r32_0 = {
  Title = "Auto Favorite",
  Default = false,
  Callback = function(r0_280)
    -- line: [0, 0] id: 280
    r9_0.autoFavEnabled = r0_280
    if r0_280 then
      scanInventory()
      r8_0.Data:OnChange({
        "Inventory",
        "Items"
      }, scanInventory)
    end
  end,
}
r29_0:[r32_0](r32_0)
r32_0 = "AddButton"
r32_0 = {
  Title = "Unfavorite Fish",
  Callback = function()
    -- line: [0, 0] id: 79
    for r3_79, r4_79 in ipairs(r8_0.Data:GetExpect({
      "Inventory",
      "Items"
    })) do
      local r5_79 = rawget(r11_0, r4_79.UUID)
      if r5_79 == nil then
        r5_79 = r4_79.Favorited
      end
      if r5_79 then
        r7_0.Events.REFav:FireServer(r4_79.UUID)
        rawset(r11_0, r4_79.UUID, false)
      end
    end
  end,
}
r29_0:[r32_0](r32_0)
r30_0 = "Auto"
r30_0 = r23_0[r30_0]
r32_0 = "AddSection"
r32_0 = "Shop Features"
r30_0 = r30_0:[r32_0](r32_0)
r33_0 = "AddParagraph"
r33_0 = {
  Title = "MERCHANT STOCK PANEL",
  Content = "Loading...",
}
ShopParagraph = r30_0:[r33_0](r33_0)
r33_0 = "AddButton"
r33_0 = {
  Title = "Open/Close Merchant",
  Callback = function()
    -- line: [0, 0] id: 204
    local r0_204 = r0_0.PG:FindFirstChild("Merchant")
    if r0_204 then
      r0_204.Enabled = not r0_204.Enabled
    end
  end,
}
r30_0:[r33_0](r33_0)
function UPX()
  -- line: [0, 0] id: 15
  local r0_15 = {}
  for r4_15, r5_15 in ipairs(r5_0.ItemsFrame:GetChildren()) do
    if r5_15:IsA("ImageLabel") and r5_15.Name ~= "Frame" then
      local r6_15 = r5_15:FindFirstChild("Frame")
      if r6_15 and r6_15:FindFirstChild("ItemName") then
        local r7_15 = r6_15.ItemName.Text
        if not string.find(r7_15, "Mystery") then
          table.insert(r0_15, "- " .. r7_15)
        end
      end
    end
  end
  if #r0_15 == 0 then
    ShopParagraph:SetContent("No items found\n" .. r5_0.RefreshMerchant.Text)
  else
    ShopParagraph:SetContent(table.concat(r0_15, "\n") .. "\n\n" .. r5_0.RefreshMerchant.Text)
  end
end
task.spawn(function()
  -- line: [0, 0] id: 34
  while task.wait(1) do
    pcall(UPX)
  end
end)
r33_0 = "AddSubSection"
r33_0 = "Buy Rod"
r30_0:[r33_0](r33_0)
r33_0 = "AddDropdown"
r33_0 = {
  Title = "Select Rod",
  Options = r9_0.rodDisplayNames,
  Callback = function(r0_316)
    -- line: [0, 0] id: 316
    if not r0_316 then
      return 
    end
    local r2_316 = r9_0.rods[_cleanName(r0_316)]
    if r2_316 then
      r9_0.selectedRodId = r2_316.Id
    end
  end,
}
r30_0:[r33_0](r33_0)
r33_0 = "AddButton"
r33_0 = {
  Title = "Buy Selected Rod",
  Callback = function()
    -- line: [0, 0] id: 27
    if not r9_0.selectedRodId then
      return 
    end
    local r0_27 = r9_0.rods[r9_0.selectedRodId] or r9_0.rods[_cleanName(r9_0.selectedRodId)]
    if not r0_27 then
      return 
    end
    pcall(function()
      -- line: [0, 0] id: 28
      r7_0.Functions.BuyRod:InvokeServer(r0_27.Id)
    end)
  end,
}
r30_0:[r33_0](r33_0)
r33_0 = "AddSubSection"
r33_0 = "Buy Baits"
r30_0:[r33_0](r33_0)
r33_0 = "AddDropdown"
r33_0 = {
  Title = "Select Bait",
  Options = r9_0.baitDisplayNames,
  Callback = function(r0_226)
    -- line: [0, 0] id: 226
    if not r0_226 then
      return 
    end
    local r2_226 = r9_0.baits[_cleanName(r0_226)]
    if r2_226 then
      r9_0.selectedBaitId = r2_226.Id
    end
  end,
}
r30_0:[r33_0](r33_0)
r33_0 = "AddButton"
r33_0 = {
  Title = "Buy Selected Bait",
  Callback = function()
    -- line: [0, 0] id: 193
    if not r9_0.selectedBaitId then
      return 
    end
    local r0_193 = r9_0.baits[r9_0.selectedBaitId] or r9_0.baits[_cleanName(r9_0.selectedBaitId)]
    if not r0_193 then
      return 
    end
    pcall(function()
      -- line: [0, 0] id: 194
      r7_0.Functions.BuyBait:InvokeServer(r0_193.Id)
    end)
  end,
}
r30_0:[r33_0](r33_0)
r33_0 = "AddSubSection"
r33_0 = "Buy Weather"
r30_0:[r33_0](r33_0)
r31_0 = {
  "Cloudy ($10000)",
  "Wind ($10000)",
  "Snow ($15000)",
  "Storm ($35000)",
  "Radiant ($50000)",
  "Shark Hunt ($300000)"
}
r34_0 = "AddDropdown"
r34_0 = {
  Title = "Select Weather",
  Multi = true,
  Options = r31_0,
  Callback = function(r0_41)
    -- line: [0, 0] id: 41
    r9_0.selectedEvents = {}
    if type(r0_41) == "table" then
      for r4_41, r5_41 in ipairs(r0_41) do
        table.insert(r9_0.selectedEvents, r5_41:match("^(.-) %(") or r5_41)
      end
    end
    SaveConfig()
  end,
}
r32_0 = r30_0:[r34_0](r34_0)
local r35_0 = "AddToggle"
r35_0 = {
  Title = "Auto Buy Weather",
  Default = false,
  Callback = function(r0_229)
    -- line: [0, 0] id: 229
    r9_0.autoBuyWeather = r0_229
    if not r7_0.Functions.BuyWeather then
      return 
    end
    if r0_229 then
      task.spawn(function()
        -- line: [0, 0] id: 230
        while r9_0.autoBuyWeather do
          local r0_230 = r32_0.Value or r32_0.Selected or {}
          local r1_230 = {}
          if type(r0_230) == "table" then
            for r5_230, r6_230 in ipairs(r0_230) do
              table.insert(r1_230, r6_230:match("^(.-) %(") or r6_230)
            end
          elseif type(r0_230) == "string" then
            table.insert(r1_230, r0_230:match("^(.-) %(") or r0_230)
          end
          if #r1_230 > 0 then
            local r2_230 = {}
            local r3_230 = workspace:FindFirstChild("Weather")
            if r3_230 then
              for r7_230, r8_230 in ipairs(r3_230:GetChildren()) do
                table.insert(r2_230, string.lower(r8_230.Name))
              end
            end
            for r7_230, r8_230 in ipairs(r1_230) do
              if not table.find(r2_230, string.lower(r8_230)) then
                pcall(function()
                  -- line: [0, 0] id: 231
                  r7_0.Functions.BuyWeather:InvokeServer(r8_230)
                end)
                task.wait(0.1)
              end
              -- close: r7_230
            end
          end
          task.wait(0.1)
        end
      end)
    end
  end,
}
r30_0:[r35_0](r35_0)
r35_0 = "AddSection"
r35_0 = "Save position Features"
r33_0 = r23_0.Auto:[r35_0](r35_0)
local r36_0 = "AddParagraph"
r36_0 = {
  Title = "Guide Teleport",
  Content = "\r\n<b><font color=\"rgb(0,162,255)\">AUTO TELEPORT?</font></b>\r\nClick <b><font color=\"rgb(0,162,255)\">Save Position</font></b> to save your current position!\r\n\r\n<b><font color=\"rgb(0,162,255)\">HOW TO LOAD?</font></b>\r\nThis feature will auto-sync your last position when executed, so you will teleport automatically!\r\n\r\n<b><font color=\"rgb(0,162,255)\">HOW TO RESET?</font></b>\r\nClick <b><font color=\"rgb(0,162,255)\">Reset Position</font></b> to clear your saved position.\r\n    ",
}
r33_0:[r36_0](r36_0)
r36_0 = "AddButton"
r36_0 = {
  Title = "Save Position",
  Callback = function()
    -- line: [0, 0] id: 103
    local r0_103 = r1_0.Character
    local r1_103 = r0_103 and r0_103:FindFirstChild("HumanoidRootPart")
    if r1_103 then
      SavePosition(r1_103.CFrame)
      chloex("Position saved successfully!")
    end
  end,
  SubTitle = "Reset Position",
  SubCallback = function()
    -- line: [0, 0] id: 139
    if isfile(r4_0) then
      delfile(r4_0)
    end
    chloex("Last position has been reset.")
  end,
}
r33_0:[r36_0](r36_0)
r36_0 = "AddSection"
r36_0 = "Enchant Features"
r34_0 = r23_0.Auto:[r36_0](r36_0)
function r35_0(r0_6)
  -- line: [0, 0] id: 6
  local r1_6 = "None"
  local r2_6 = "None"
  local r3_6 = 0
  local r4_6 = {}
  local r5_6 = r8_0.Data:Get("EquippedItems") or {}
  local r6_6 = r8_0.Data:Get({
    "Inventory",
    "Fishing Rods"
  }) or {}
  for r10_6, r11_6 in pairs(r5_6) do
    for r15_6, r16_6 in ipairs(r6_6) do
      if r16_6.UUID == r11_6 then
        local r17_6 = r6_0.ItemUtility:GetItemData(r16_6.Id)
        if r17_6 then
          r1_6 = r17_6.Data.Name or r16_6.ItemName or "None"
        else
          goto label_45	-- block#9 is visited secondly
        end
        if r16_6.Metadata and r16_6.Metadata.EnchantId then
          local r18_6 = r6_0.ItemUtility:GetEnchantData(r16_6.Metadata.EnchantId)
          if r18_6 then
            r2_6 = r18_6.Data.Name or "None"
          else
            goto label_68	-- block#15 is visited secondly
          end
        end
      end
    end
  end
  for r10_6, r11_6 in pairs(r8_0.Data:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r12_6 = r6_0.ItemUtility:GetItemData(r11_6.Id)
    if r12_6 and r12_6.Data.Type == "Enchant Stones" and r11_6.Id == r0_6 then
      r3_6 = r3_6 + 1
      table.insert(r4_6, r11_6.UUID)
    end
  end
  return r1_6, r2_6, r3_6, r4_6
end
local r38_0 = "AddParagraph"
r38_0 = {
  Title = "Enchant Status",
  Content = "Current Rod : None\nCurrent Enchant : None\nEnchant Stones Left : 0",
}
r36_0 = r34_0:[r38_0](r38_0)
local r39_0 = "AddButton"
r39_0 = {
  Title = "Click Enchant",
  Callback = function()
    -- line: [0, 0] id: 261
    task.spawn(function()
      -- line: [0, 0] id: 262
      local r0_262, r1_262, r2_262, r3_262 = r35_0(10)
      if r0_262 == "None" or r2_262 <= 0 then
        r36_0:SetContent(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_262, r1_262, r2_262))
        return 
      end
      local r4_262 = nil
      local r5_262 = tick()
      while tick() - r5_262 < 5 do
        local r6_262 = pairs
        for r9_262, r10_262 in r6_262(r8_0.Data:Get("EquippedItems") or {}) do
          if r10_262 == r3_262[1] then
            r4_262 = r9_262
          end
        end
        if not r4_262 then
          r7_0.Events.REEquipItem:FireServer(r3_262[1], "Enchant Stones")
          task.wait(0.3)
        else
          break
        end
      end
      if not r4_262 then
        return 
      end
      r7_0.Events.REEquip:FireServer(r4_262)
      task.wait(0.2)
      r7_0.Events.REAltar:FireServer()
      task.wait(1.5)
      local r6_262, r7_262 = r35_0(10)
      r36_0:SetContent(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_262, r7_262, r2_262 - 1))
    end)
  end,
}
r34_0:[r39_0](r39_0)
r39_0 = "AddButton"
r39_0 = {
  Title = "Teleport Enchant Altar",
  Callback = function()
    -- line: [0, 0] id: 343
    local r0_343 = r9_0.player.Character or r9_0.player.CharacterAdded:Wait()
    local r1_343 = r0_343:FindFirstChild("HumanoidRootPart")
    local r2_343 = r0_343:FindFirstChildOfClass("Humanoid")
    if r1_343 and r2_343 then
      r1_343.CFrame = CFrame.new(Vector3.new(3258, -1301, 1391))
      r2_343:ChangeState(Enum.HumanoidStateType.Physics)
      task.wait(0.1)
      r2_343:ChangeState(Enum.HumanoidStateType.Running)
    end
  end,
}
r34_0:[r39_0](r39_0)
r34_0:AddDivider()
r39_0 = "AddButton"
r39_0 = {
  Title = "Click Double Enchant",
  Content = "Starting Double Enchanting",
  Callback = function()
    -- line: [0, 0] id: 200
    task.spawn(function()
      -- line: [0, 0] id: 201
      local r0_201, r1_201, r2_201, r3_201 = r35_0(246)
      if r0_201 == "None" or r2_201 <= 0 then
        r36_0:SetContent(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_201, r1_201, r2_201))
        return 
      end
      local r4_201 = nil
      local r5_201 = tick()
      while tick() - r5_201 < 5 do
        local r6_201 = pairs
        for r9_201, r10_201 in r6_201(r8_0.Data:Get("EquippedItems") or {}) do
          if r10_201 == r3_201[1] then
            r4_201 = r9_201
          end
        end
        if not r4_201 then
          r7_0.Events.REEquipItem:FireServer(r3_201[1], "Enchant Stones")
          task.wait(0.3)
        else
          break
        end
      end
      if not r4_201 then
        return 
      end
      r7_0.Events.REEquip:FireServer(r4_201)
      task.wait(0.2)
      r7_0.Events.REAltar2:FireServer()
      task.wait(1.5)
      local r6_201, r7_201 = r35_0(246)
      r36_0:SetContent(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_201, r7_201, r2_201 - 1))
    end)
  end,
}
r34_0:[r39_0](r39_0)
r39_0 = "AddButton"
r39_0 = {
  Title = "Teleport Second Enchant Altar",
  Callback = function()
    -- line: [0, 0] id: 54
    local r0_54 = r9_0.player.Character or r9_0.player.CharacterAdded:Wait()
    local r1_54 = r0_54:FindFirstChild("HumanoidRootPart")
    local r2_54 = r0_54:FindFirstChildOfClass("Humanoid")
    if r1_54 and r2_54 then
      r1_54.CFrame = CFrame.new(Vector3.new(1480, 128, -593))
      r2_54:ChangeState(Enum.HumanoidStateType.Physics)
      task.wait(0.1)
      r2_54:ChangeState(Enum.HumanoidStateType.Running)
    end
  end,
}
r34_0:[r39_0](r39_0)
r39_0 = "AddSection"
r39_0 = "Totem Features"
local r37_0 = r23_0.Auto:[r39_0](r39_0)
local r40_0 = "AddParagraph"
r40_0 = {
  Title = "Panel Activated Totem",
  Content = "Scanning Totems...",
}
TotemPanel = r37_0:[r40_0](r40_0)
r40_0 = "AddParagraph"
r40_0 = {
  Title = "Auto Totem Status",
  Content = "Idle.",
}
HeaderPanel = r37_0:[r40_0](r40_0)
function GetTT()
  -- line: [0, 0] id: 30
  local r0_30 = r9_0.char
  if r0_30 then
    r0_30 = r9_0.char:FindFirstChild("HumanoidRootPart") and (r9_0.char.HumanoidRootPart.Position or Vector3.zero)
  else
    goto label_17	-- block#3 is visited secondly
  end
  local r1_30 = {}
  for r5_30, r6_30 in pairs(workspace.Totems:GetChildren()) do
    if r6_30:IsA("Model") then
      local r7_30 = r6_30:FindFirstChild("Handle")
      local r8_30 = r7_30 and r7_30:FindFirstChild("Overhead")
      local r9_30 = r8_30 and r8_30:FindFirstChild("Content")
      local r10_30 = r9_30 and r9_30:FindFirstChild("Header")
      local r11_30 = r9_30 and r9_30:FindFirstChild("TimerLabel")
      local r13_30 = (r0_30 - r6_30:GetPivot().Position).Magnitude
      local r14_30 = nil	-- notice: implicit variable refs by block#[20]
      if r11_30 then
        r14_30 = r11_30.Text
        if not r14_30 then
          ::label_65::
          r14_30 = "??"
        end
      else
        goto label_65	-- block#16 is visited secondly
      end
      local r15_30 = nil	-- notice: implicit variable refs by block#[20]
      if r10_30 then
        r15_30 = r10_30.Text
        if not r15_30 then
          ::label_71::
          r15_30 = "??"
        end
      else
        goto label_71	-- block#19 is visited secondly
      end
      table.insert(r1_30, {
        Name = r15_30,
        Distance = r13_30,
        TimeLeft = r14_30,
      })
    end
  end
  return r1_30
end
function UpdTT()
  -- line: [0, 0] id: 291
  local r0_291 = GetTT()
  if #r0_291 == 0 then
    TotemPanel:SetContent("No active totems detected.")
    return 
  end
  local r1_291 = {}
  for r5_291, r6_291 in ipairs(r0_291) do
    table.insert(r1_291, string.format("%s • %.1f studs • %s", r6_291.Name, r6_291.Distance, r6_291.TimeLeft))
  end
  TotemPanel:SetContent(table.concat(r1_291, "\n"))
end
task.spawn(function()
  -- line: [0, 0] id: 220
  while task.wait(1) do
    pcall(UpdTT)
  end
end)
function GetTTUUID(r0_251)
  -- line: [0, 0] id: 251
  if not Data then
    Data = r6_0.Replion.Client:WaitReplion("Data")
    if not Data then
      return nil
    end
  end
  if not Totems then
    Totems = require(game:GetService("ReplicatedStorage"):WaitForChild("Totems"))
    if not Totems then
      return nil
    end
  end
  for r5_251, r6_251 in ipairs(Data:GetExpect({
    "Inventory",
    "Totems"
  }) or {}) do
    local r7_251 = "Unknown Totem"
    if typeof(Totems) == "table" then
      for r11_251, r12_251 in pairs(Totems) do
        if r12_251.Data and r12_251.Data.Id == r6_251.Id then
          r7_251 = r12_251.Data.Name
          break
        end
      end
    end
    if r7_251 == r0_251 then
      return r6_251.UUID, r7_251
    end
  end
  return nil
end
function r38_0()
  -- line: [0, 0] id: 221
  if RealTotemPanel and RealTotemPanel.Show then
    RealTotemPanel:Show()
  end
end
function r39_0(r0_217)
  -- line: [0, 0] id: 217
  if not r0_217 then
    return 
  end
  local r1_217, r2_217 = pcall(function()
    -- line: [0, 0] id: 218
    r7_0.Events.Totem:FireServer(r0_217)
  end)
  if not r1_217 then
    warn("[Chloe X] Totem spawn failed:", tostring(r2_217))
  end
end
local r42_0 = "AddButton"
r42_0 = {
  Title = "Teleport To Nearest Totem",
  Callback = function()
    -- line: [0, 0] id: 25
    local r0_25 = r9_0.char and r9_0.char:FindFirstChild("HumanoidRootPart")
    if not r0_25 then
      return 
    end
    local r1_25 = GetTT()
    if #r1_25 == 0 then
      return 
    end
    table.sort(r1_25, function(r0_26, r1_26)
      -- line: [0, 0] id: 26
      return r0_26.Distance < r1_26.Distance
    end)
    local r2_25 = r1_25[1]
    for r6_25, r7_25 in pairs(workspace.Totems:GetChildren()) do
      if r7_25:IsA("Model") then
        local r8_25 = r7_25:GetPivot().Position
        if math.abs((r8_25 - r0_25.Position).Magnitude - r2_25.Distance) < 1 then
          r0_25.CFrame = CFrame.new(r8_25 + Vector3.new(0, 3, 0))
          break
        end
      end
    end
  end,
}
r37_0:[r42_0](r42_0)
TotemsFolder = r0_0.RS:WaitForChild("Totems")
r9_0.Totems = r9_0.Totems or {}
r9_0.TotemDisplayName = r9_0.TotemDisplayName or {}
for r43_0, r44_0 in ipairs(TotemsFolder:GetChildren()) do
  if r44_0:IsA("ModuleScript") then
    local r45_0, r46_0 = pcall(require, r44_0)
    if r45_0 and typeof(r46_0) == "table" and r46_0.Data then
      local r47_0 = r46_0.Data.Name or "Unknown"
      local r48_0 = r46_0.Data.Id or "Unknown"
      local r49_0 = {
        Name = r47_0,
        Id = r48_0,
      }
      r9_0.Totems[r48_0] = r49_0
      r9_0.Totems[r47_0] = r49_0
      table.insert(r9_0.TotemDisplayName, r47_0)
    end
  end
end
selectedTotem = nil
r42_0 = "AddDropdown"
r42_0 = {
  Title = "Select Totem to Auto Place",
}
local r43_0 = "Options"
local r44_0 = r9_0.TotemDisplayName
if not r44_0 then
  r44_0 = {}
  local r45_0 = "No Totems Found"
  -- setlist for #44 failed
end
r42_0[r43_0] = r44_0
r43_0 = "Default"
r44_0 = r9_0.TotemDisplayName
if r44_0 then
  r44_0 = r9_0.TotemDisplayName[1] or "No Totems Found"
else
  goto label_2329	-- block#95 is visited secondly
end
r42_0[r43_0] = r44_0
function r42_0.Callback(r0_242)
  -- line: [0, 0] id: 242
  selectedTotem = r0_242
end
TotemDropdown = r37_0:[r42_0](r42_0)
r42_0 = "AddToggle"
r42_0 = {
  Title = "Auto Place Totem (Beta)",
  Content = "Place Totem every 60 minutes automatically.",
  Default = false,
  Callback = function(r0_177)
    -- line: [0, 0] id: 177
    TotemActive = r0_177
    local r1_177 = nil	-- notice: implicit variable refs by block#[6]
    if r0_177 then
      r1_177 = selectedTotem
      if not r1_177 then
        HeaderPanel:SetContent("Please select a Totem first.")
        r1_177 = false
        TotemActive = r1_177
        return 
      end
      local r1_177, r2_177 = GetTTUUID(selectedTotem)
      if not r1_177 then
        HeaderPanel:SetContent("You don\'t own any Totem.")
        TotemActive = false
        return 
      end
      HeaderPanel:SetContent(("Auto Totem Enabled [%s] • Waiting 60m loop..."):format(selectedTotem))
      task.spawn(function()
        -- line: [0, 0] id: 178
        local r0_178 = 0
        while true do
          if TotemActive then
            r39_0(r1_177)
            if r0_178 < 3 then
              HeaderPanel:SetContent(("Totem Used [%s] • Next in 60m"):format(selectedTotem))
              r0_178 = r0_178 + 1
            elseif r0_178 == 3 then
              r0_178 = r0_178 + 1
              task.wait(1)
              HeaderPanel:SetContent("Reverting to Real Totem Panel...")
              task.wait(0.5)
              r38_0()
            end
            for r4_178 = 3600, 1, -1 do
              if not TotemActive then
                break
              else
                task.wait(1)
              end
            end
            r1_177, r2_177 = GetTTUUID(selectedTotem)
            local r1_178 = r1_177
            if not r1_178 then
              break
            end
          end
          HeaderPanel:SetContent("Auto Totem Disabled.")
          return 
        end
        HeaderPanel:SetContent("Totem not found in inventory anymore.")
        TotemActive = false
        goto label_64
      end)
      -- close: r1_177
    else
      r1_177 = HeaderPanel
      r1_177:SetContent("Auto Totem Disabled.")
      r1_177 = r38_0
      r1_177()
    end
  end,
}
r37_0:[r42_0](r42_0)
r42_0 = "AddSection"
r42_0 = "Potions Features"
Potion = r23_0.Auto:[r42_0](r42_0)
PotionsFolder = r0_0.RS:WaitForChild("Potions")
r9_0.Potions = r9_0.Potions or {}
r9_0.PotionDisplayName = r9_0.PotionDisplayName or {}
for r43_0, r44_0 in ipairs(PotionsFolder:GetChildren()) do
  if r44_0:IsA("ModuleScript") then
    local r45_0, r46_0 = pcall(require, r44_0)
    if r45_0 and typeof(r46_0) == "table" and r46_0.Data then
      local r47_0 = r46_0.Data.Name or "Unknown"
      local r48_0 = r46_0.Data.Id or "Unknown"
      if not string.find(string.lower(r47_0), "totem") then
        local r49_0 = {
          Name = r47_0,
          Id = r48_0,
        }
        r9_0.Potions[r48_0] = r49_0
        r9_0.Potions[r47_0] = r49_0
        table.insert(r9_0.PotionDisplayName, r47_0)
      end
    end
  end
end
selectedPotions = {}
r42_0 = "AddDropdown"
r42_0 = {
  Title = "Select Potions",
  Multi = true,
  Options = r9_0.PotionDisplayName,
  Callback = function(r0_263)
    -- line: [0, 0] id: 263
    selectedPotions = r0_263
  end,
}
Potion:[r42_0](r42_0)
r42_0 = "AddToggle"
r42_0 = {
  Title = "Auto Use Potions",
  Default = false,
  Callback = function(r0_269)
    -- line: [0, 0] id: 269
    _G.AutoUsePotions = r0_269
    task.spawn(function()
      -- line: [0, 0] id: 270
      while _G.AutoUsePotions do
        task.wait(1)
        local r0_270 = r8_0.Data
        r0_270 = r0_270:GetExpect({
          "Inventory",
          "Potions"
        })
        if not r0_270 then
          r0_270 = {}
        end
        for r4_270, r5_270 in ipairs(selectedPotions) do
          local r6_270 = r9_0.Potions[r5_270]
          if r6_270 then
            for r10_270, r11_270 in ipairs(r0_270) do
              if r11_270.Id == r6_270.Id then
                pcall(function()
                  -- line: [0, 0] id: 271
                  r6_0.Net["RF/ConsumePotion"]:InvokeServer(r11_270.UUID, 1)
                end)
                -- close: r7_270
                break
              else
                -- close: r10_270
              end
            end
          end
        end
      end
    end)
  end,
}
Potion:[r42_0](r42_0)
r42_0 = "AddSection"
r42_0 = "Event Features"
r40_0 = r23_0.Auto:[r42_0](r42_0)
r43_0 = "AddDropdown"
r43_0 = {}
r43_0.Options = r14_0() or {}
r43_0.Multi = false
r43_0.Title = "Priority Event"
function r43_0.Callback(r0_128)
  -- line: [0, 0] id: 128
  r9_0.priorityEvent = r0_128
end
r40_0:[r43_0](r43_0)
r43_0 = "AddDropdown"
r43_0 = {}
r43_0.Options = r14_0() or {}
r43_0.Multi = true
r43_0.Title = "Select Event"
function r43_0.Callback(r0_212)
  -- line: [0, 0] id: 212
  r9_0.selectedEvents = {}
  for r4_212, r5_212 in pairs(r0_212) do
    table.insert(r9_0.selectedEvents, r5_212)
  end
  r9_0.curCF = nil
  if r9_0.autoEventActive and (0 < #r9_0.selectedEvents or r9_0.priorityEvent) then
    task.spawn(r9_0.loop)
  end
end
r40_0:[r43_0](r43_0)
r43_0 = "AddToggle"
r43_0 = {
  Title = "Auto Event",
  Default = false,
  Callback = function(r0_138)
    -- line: [0, 0] id: 138
    r9_0.autoEventActive = r0_138
    if r0_138 and (0 < #r9_0.selectedEvents or r9_0.priorityEvent) then
      r9_0.origCF = r9_0.origCF or r12_0(r1_0.Character).CFrame
      task.spawn(r9_0.loop)
    else
      if r9_0.origCF then
        r1_0.Character:PivotTo(r9_0.origCF)
        chloex("Auto Event Off")
      end
      r9_0.curCF = nil
      r9_0.origCF = nil
    end
  end,
}
r40_0:[r43_0](r43_0)
function getGroupedByType(r0_315)
  -- line: [0, 0] id: 315
  local r1_315 = r8_0.Data:GetExpect({
    "Inventory",
    "Items"
  })
  local r2_315 = {}
  local r3_315 = {}
  for r7_315, r8_315 in ipairs(r1_315) do
    local r9_315 = r6_0.ItemUtility.GetItemDataFromItemType("Items", r8_315.Id)
    if r9_315 and r9_315.Data.Type == r0_315 and not r8_315.Favorited then
      local r10_315 = r9_315.Data.Name
      local r11_315 = r2_315[r10_315]
      if not r11_315 then
        r11_315 = {}
        r11_315.count = 0
        r11_315.uuids = {}
      end
      r2_315[r10_315] = r11_315
      r2_315[r10_315].count = r2_315[r10_315].count + (r8_315.Quantity or 1)
      table.insert(r2_315[r10_315].uuids, r8_315.UUID)
    end
  end
  for r7_315, r8_315 in pairs(r2_315) do
    table.insert(r3_315, ("%s x%d"):format(r7_315, r8_315.count))
  end
  return r2_315, r3_315
end
r43_0 = "AddSection"
r43_0 = "Trading Fish Features"
local r41_0 = r23_0.Trade:[r43_0](r43_0)
r44_0 = "AddSection"
r44_0 = "Trading Coin Features"
r42_0 = r23_0.Trade:[r44_0](r44_0)
local r45_0 = "AddParagraph"
r45_0 = {
  Title = "Panel Name Trading",
  Content = "\r\nPlayer : ???\r\nItem   : ???\r\nAmount : 0\r\nStatus : Idle\r\nSuccess: 0 / 0\r\n",
}
r43_0 = r41_0:[r45_0](r45_0)
local r46_0 = "AddParagraph"
r46_0 = {
  Title = "Panel Coin Trading",
  Content = "\r\nPlayer   : ???\r\nTarget   : 0\r\nProgress : 0 / 0\r\nStatus   : Idle\r\nResult   : Success : 0 | Received : 0\r\n",
}
r44_0 = r42_0:[r46_0](r46_0)
r45_0 = {}
function _G.safeSetContent(r0_214, r1_214)
  -- line: [0, 0] id: 214
  if not r0_214 then
    return 
  end
  r45_0[r0_214] = r1_214
end
local r48_0 = "Connect"
function r48_0()
  -- line: [0, 0] id: 12
  for r3_12, r4_12 in pairs(r45_0) do
    r3_12:SetContent(r4_12)
    r45_0[r3_12] = nil
  end
end
r0_0.RunService.Heartbeat:[r48_0](r48_0)
function r46_0(r0_161)
  -- line: [0, 0] id: 161
  local r1_161 = r9_0.trade
  local r2_161 = "200,200,200"
  if r0_161 and r0_161:lower():find("send") then
    r2_161 = "51,153,255"
  elseif r0_161 and r0_161:lower():find("complete") then
    r2_161 = "0,204,102"
  elseif r0_161 and r0_161:lower():find("time") then
    r2_161 = "255,69,0"
  end
  local r3_161 = string.format
  local r4_161 = "\r\n<font color=\'rgb(173,216,230)\'>Player : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Item   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Amount : %d</font>\r\n<font color=\'rgb(%s)\'>Status : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Success: %d / %d</font>\r\n"
  local r5_161 = r1_161.selectedPlayer or "???"
  local r6_161 = r1_161.selectedItem or "???"
  local r7_161 = r1_161.tradeAmount or 0
  local r8_161 = r2_161
  local r9_161 = r0_161 or "Idle"
  local r10_161 = r1_161.successCount or 0
  _G.safeSetContent(r43_0, r3_161(r4_161, r5_161, r6_161, r7_161, r8_161, r9_161, r10_161, r1_161.totalToTrade or 0))
end
local function r47_0(r0_180)
  -- line: [0, 0] id: 180
  local r1_180 = r9_0.trade
  local r2_180 = "200,200,200"
  if r0_180 and r0_180:lower():find("send") then
    r2_180 = "51,153,255"
  elseif r0_180 and r0_180:lower():find("progress") then
    r2_180 = "255,215,0"
  elseif r0_180 and r0_180:lower():find("complete") then
    r2_180 = "0,204,102"
  elseif r0_180 and r0_180:lower():find("time") then
    r2_180 = "255,69,0"
  end
  local r3_180 = string.format
  local r4_180 = "\r\n<font color=\'rgb(173,216,230)\'>Player   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Target   : %d</font>\r\n<font color=\'rgb(173,216,230)\'>Progress : %d / %d</font>\r\n<font color=\'rgb(%s)\'>Status   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Result   : Success : %d | Received : %d</font>\r\n"
  local r5_180 = r1_180.selectedPlayer or "???"
  local r6_180 = r1_180.targetCoins or 0
  local r7_180 = r1_180.successCoins or 0
  local r8_180 = r1_180.targetCoins or 0
  local r9_180 = r2_180
  local r10_180 = r0_180 or "Idle"
  local r11_180 = r1_180.successCoins or 0
  _G.safeSetContent(r44_0, r3_180(r4_180, r5_180, r6_180, r7_180, r8_180, r9_180, r10_180, r11_180, r1_180.totalReceived or 0))
end
function r48_0(r0_296)
  -- line: [0, 0] id: 296
  for r4_296, r5_296 in ipairs(r8_0.Data:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r6_296 = r5_296.UUID
    if r6_296 == r0_296 then
      r6_296 = true
      return r6_296
    end
  end
  return false
end
local function r49_0(r0_255, r1_255, r2_255, r3_255)
  -- line: [0, 0] id: 255
  local r4_255 = r9_0.trade
  r4_255.lastResult = nil
  r4_255.awaiting = true
  local r5_255 = false
  local r6_255 = r0_0.Players:FindFirstChild(r0_255)
  if not r6_255 then
    r4_255.trading = false
    r46_0("<font color=\'#ff3333\'>Player not found</font>")
    r47_0("<font color=\'#ff3333\'>Player not found</font>")
    return false
  end
  if r2_255 then
    r46_0("Sending")
    chloex("Sending " .. r2_255)
  else
    r47_0("Sending")
    chloex("Sending fish for coins")
  end
  if not pcall(function()
    -- line: [0, 0] id: 256
    r7_0.Functions.Trade:InvokeServer(r6_255.UserId, r1_255)
  end) then
    return false
  end
  local r8_255 = tick()
  while r4_255.trading and not r5_255 do
    local r9_255 = r48_0(r1_255)
    if not r9_255 then
      r5_255 = true
      if r2_255 then
        r4_255.successCount = r4_255.successCount + 1
        r46_0("Completed")
      else
        r9_255 = r4_255.successCoins
        r4_255.successCoins = r9_255 + (r3_255 or 0)
        r4_255.totalReceived = r4_255.successCoins
        r47_0("Progress")
      end
    else
      r9_255 = tick() - r8_255
      if r9_255 > 10 then
        r9_255 = false
        return r9_255
      end
    end
    task.wait(0.2)
  end
  return r5_255
end
local function r50_0(r0_203, r1_203, r2_203, r3_203)
  -- line: [0, 0] id: 203
  local r4_203 = r9_0.trade
  local r5_203 = 0
  while r5_203 < 3 and r4_203.trading do
    if r49_0(r0_203, r1_203, r2_203, r3_203) then
      task.wait(2.5)
      return true
    end
    r5_203 = r5_203 + 1
    task.wait(1)
  end
  return false
end
function startTradeByName()
  -- line: [0, 0] id: 278
  local r0_278 = r9_0.trade
  if r0_278.trading then
    return 
  end
  if not r0_278.selectedPlayer or not r0_278.selectedItem then
    return chloex("Select player & item first!")
  end
  r0_278.trading = true
  r0_278.successCount = 0
  chloex("Starting trade with " .. r0_278.selectedPlayer)
  local r1_278 = r0_278.currentGrouped[r0_278.selectedItem]
  if not r1_278 then
    r0_278.trading = false
    r46_0("<font color=\'#ff3333\'>Item not found</font>")
    return chloex("Item not found")
  end
  r0_278.totalToTrade = math.min(r0_278.tradeAmount, #r1_278.uuids)
  local r2_278 = 1
  while r0_278.trading do
    local r3_278 = r0_278.successCount
    if r3_278 < r0_278.totalToTrade then
      r50_0(r0_278.selectedPlayer, r1_278.uuids[r2_278], r0_278.selectedItem)
      r2_278 = r2_278 + 1
      r3_278 = #r1_278.uuids
      if r3_278 < r2_278 then
        r2_278 = 1
      end
      task.wait(2)
    else
      break
    end
  end
  r0_278.trading = false
  r46_0("<font color=\'#66ccff\'>All trades finished</font>")
  chloex("All trades finished")
end
function chooseFishesByRange(r0_272, r1_272)
  -- line: [0, 0] id: 272
  table.sort(r0_272, function(r0_273, r1_273)
    -- line: [0, 0] id: 273
    return r1_273.Price < r0_273.Price
  end)
  local r2_272 = {}
  local r3_272 = 0
  for r7_272, r8_272 in ipairs(r0_272) do
    if r3_272 + r8_272.Price <= r1_272 then
      table.insert(r2_272, r8_272)
      r3_272 = r3_272 + r8_272.Price
    end
    if r1_272 <= r3_272 then
      break
    end
  end
  if r3_272 < r1_272 and 0 < #r0_272 then
    table.insert(r2_272, r0_272[#r0_272])
  end
  return r2_272, r3_272
end
function startTradeByCoin()
  -- line: [0, 0] id: 198
  local r0_198 = r9_0.trade
  if r0_198.trading then
    return 
  end
  if not r0_198.selectedPlayer or r0_198.targetCoins <= 0 then
    return chloex("⚠ Select player & coin target first!")
  end
  r0_198.trading = true
  r0_198.totalReceived = 0
  r0_198.successCoins = 0
  r0_198.sentCoins = 0
  r47_0("<font color=\'#ffaa00\'>Starting...</font>")
  chloex("Starting coin trade with " .. r0_198.selectedPlayer)
  local r2_198 = r6_0.PlayerStatsUtility:GetPlayerModifiers(r0_0.Players.LocalPlayer)
  local r3_198 = {}
  local r4_198 = r8_0.Data
  local r6_198 = {
    "Inventory",
    "Items"
  }
  local r13_198 = nil	-- notice: implicit variable refs by block#[16]
  for r8_198, r9_198 in ipairs(r4_198:GetExpect(r6_198)) do
    if not r9_198.Favorited then
      local r10_198 = r6_0.ItemUtility:GetItemData(r9_198.Id)
      if r10_198 and r10_198.Data and r10_198.Data.Type == "Fish" then
        local r11_198 = r6_0.VendorUtility:GetSellPrice(r9_198) or r10_198.SellPrice or 0
        local r12_198 = math.ceil
        if r2_198 then
          r13_198 = r2_198.CoinMultiplier
          if not r13_198 then
            ::label_86::
            r13_198 = 1
          end
        else
          goto label_86	-- block#15 is visited secondly
        end
        r12_198 = r12_198(r11_198 * r13_198)
        if r12_198 > 0 then
          r13_198 = table.insert
          local r14_198 = r3_198
          local r15_198 = {
            UUID = r9_198.UUID,
            Name = r10_198.Data.Name or "Unknown",
            Price = r12_198,
          }
          r13_198(r14_198, r15_198)
        end
      end
    end
  end
  if #r3_198 == 0 then
    r0_198.trading = false
    r47_0("<font color=\'#ff3333\'>No fishes found</font>")
    chloex("⚠ No fishes found in inventory")
    return 
  end
  local r5_198, r6_198 = chooseFishesByRange(r3_198, r0_198.targetCoins)
  if #r5_198 == 0 then
    r0_198.trading = false
    r47_0("<font color=\'#ff3333\'>No valid fishes for target</font>")
    return 
  end
  r0_198.totalToTrade = #r5_198
  r0_198.targetCoins = r6_198
  if not r0_0.Players:FindFirstChild(r0_198.selectedPlayer) then
    r0_198.trading = false
    r47_0("<font color=\'#ff3333\'>Player not found</font>")
    return 
  end
  for r11_198, r12_198 in ipairs(r5_198) do
    r13_198 = r0_198.trading
    if not r13_198 then
      break
    else
      r0_198.sentCoins = r0_198.sentCoins + r12_198.Price
      r47_0(string.format("<font color=\'#ffaa00\'>Progress : %d / %d</font>", r0_198.sentCoins, r0_198.targetCoins))
      r50_0(r0_198.selectedPlayer, r12_198.UUID, nil, r12_198.Price)
      r0_198.successCoins = r0_198.sentCoins
      task.wait(2)
    end
  end
  r0_198.trading = false
  r47_0(string.format("<font color=\'#66ccff\'>Coin trade finished (Target: %d, Received: %d)</font>", r0_198.targetCoins, r0_198.successCoins))
  chloex(string.format("Coin trade finished (Target: %d, Received: %d)", r0_198.targetCoins, r0_198.successCoins))
end
local r53_0 = "AddDropdown"
r53_0 = {}
r53_0.Options = {}
r53_0.Multi = false
r53_0.Title = "Select Item"
function r53_0.Callback(r0_142)
  -- line: [0, 0] id: 142
  local r1_142 = r9_0.trade
  local r2_142 = nil	-- notice: implicit variable refs by block#[3]
  if r0_142 then
    r2_142 = r0_142:match("^(.-) x")
    if not r2_142 then
      ::label_9::
      r2_142 = r0_142
    end
  else
    goto label_9	-- block#2 is visited secondly
  end
  r1_142.selectedItem = r2_142
  r46_0()
end
local r51_0 = r41_0:[r53_0](r53_0)
local r54_0 = "AddButton"
r54_0 = {
  Title = "Refresh Fish",
  Callback = function()
    -- line: [0, 0] id: 67
    local r0_67, r1_67 = getGroupedByType("Fish")
    r9_0.trade.currentGrouped = r0_67
    r51_0:SetValues(r1_67 or {})
  end,
  SubTitle = "Refresh Stone",
  SubCallback = function()
    -- line: [0, 0] id: 192
    local r0_192, r1_192 = getGroupedByType("Enchant Stones")
    r9_0.trade.currentGrouped = r0_192
    r51_0:SetValues(r1_192 or {})
  end,
}
r41_0:[r54_0](r54_0)
r54_0 = "AddInput"
r54_0 = {
  Title = "Amount to Trade",
  Default = "1",
  Callback = function(r0_245)
    -- line: [0, 0] id: 245
    r9_0.trade.tradeAmount = tonumber(r0_245) or 1
    r46_0()
  end,
}
r41_0:[r54_0](r54_0)
r54_0 = "AddDropdown"
r54_0 = {}
r54_0.Options = {}
r54_0.Multi = false
r54_0.Title = "Select Player"
function r54_0.Callback(r0_143)
  -- line: [0, 0] id: 143
  r9_0.trade.selectedPlayer = r0_143
  r46_0()
end
local r52_0 = r41_0:[r54_0](r54_0)
local r55_0 = "AddButton"
r55_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 250
    local r0_250 = {}
    for r4_250, r5_250 in ipairs(r0_0.Players:GetPlayers()) do
      if r5_250 ~= r9_0.player then
        table.insert(r0_250, r5_250.Name)
      end
    end
    r52_0:SetValues(r0_250 or {})
  end,
}
r41_0:[r55_0](r55_0)
r55_0 = "AddToggle"
r55_0 = {
  Title = "Start By Name",
  Default = false,
  Callback = function(r0_43)
    -- line: [0, 0] id: 43
    if r0_43 then
      task.spawn(startTradeByName)
    else
      r9_0.trade.trading = false
      r46_0()
    end
  end,
}
r41_0:[r55_0](r55_0)
r55_0 = "AddDropdown"
r55_0 = {}
r55_0.Options = {}
r55_0.Multi = false
r55_0.Title = "Select Player"
function r55_0.Callback(r0_317)
  -- line: [0, 0] id: 317
  r9_0.trade.selectedPlayer = r0_317
  r47_0()
end
r53_0 = r42_0:[r55_0](r55_0)
local r56_0 = "AddButton"
r56_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 66
    local r0_66 = {}
    for r4_66, r5_66 in ipairs(r0_0.Players:GetPlayers()) do
      if r5_66 ~= r9_0.player then
        table.insert(r0_66, r5_66.Name)
      end
    end
    r53_0:SetValues(r0_66 or {})
  end,
}
r42_0:[r56_0](r56_0)
r56_0 = "AddInput"
r56_0 = {
  Title = "Target Coin",
  Default = "0",
  Callback = function(r0_340)
    -- line: [0, 0] id: 340
    r9_0.trade.targetCoins = tonumber(r0_340) or 0
    r47_0()
  end,
}
r42_0:[r56_0](r56_0)
r56_0 = "AddToggle"
r56_0 = {
  Title = "Start By Coin",
  Default = false,
  Callback = function(r0_134)
    -- line: [0, 0] id: 134
    if r0_134 then
      task.spawn(startTradeByCoin)
    else
      r9_0.trade.trading = false
    end
  end,
}
r42_0:[r56_0](r56_0)
r56_0 = "AddSection"
r56_0 = "Trading Rarity Features"
TradeByRarity = r23_0.Trade:[r56_0](r56_0)
r56_0 = "AddParagraph"
r56_0 = {
  Title = "Panel Rarity Trading",
  Content = "\r\nPlayer  : ???\r\nRarity  : ???\r\nCount   : 0\r\nStatus  : Idle\r\nSuccess : 0 / 0\r\n",
}
Rarity_Monitor = TradeByRarity:[r56_0](r56_0)
function r54_0(r0_241)
  -- line: [0, 0] id: 241
  local r1_241 = r9_0.trade
  local r2_241 = "200,200,200"
  if r0_241 and r0_241:lower():find("send") then
    r2_241 = "51,153,255"
  elseif r0_241 and r0_241:lower():find("complete") then
    r2_241 = "0,204,102"
  elseif r0_241 and r0_241:lower():find("time") then
    r2_241 = "255,69,0"
  end
  local r3_241 = string.format
  local r4_241 = "\r\n<font color=\'rgb(173,216,230)\'>Player  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Rarity  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Count   : %d</font>\r\n<font color=\'rgb(%s)\'>Status  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Success : %d / %d</font>\r\n"
  local r5_241 = r1_241.selectedPlayer or "???"
  local r6_241 = r1_241.selectedRarity or "???"
  local r7_241 = r1_241.totalToTrade or 0
  local r8_241 = r2_241
  local r9_241 = r0_241 or "Idle"
  local r10_241 = r1_241.successCount or 0
  _G.safeSetContent(Rarity_Monitor, r3_241(r4_241, r5_241, r6_241, r7_241, r8_241, r9_241, r10_241, r1_241.totalToTrade or 0))
end
r55_0 = TradeByRarity
local r57_0 = "AddDropdown"
r57_0 = {}
r57_0.Options = {
  "Common",
  "Uncommon",
  "Rare",
  "Epic",
  "Legendary",
  "Mythic",
  "Secret"
}
r57_0.Multi = false
r57_0.Title = "Select Rarity"
function r57_0.Callback(r0_264)
  -- line: [0, 0] id: 264
  r9_0.trade.selectedRarity = r0_264
  r54_0("Selected rarity: " .. (r0_264 or "???"))
end
r55_0:[r57_0](r57_0)
r57_0 = "AddDropdown"
r57_0 = {}
r57_0.Options = {}
r57_0.Multi = false
r57_0.Title = "Select Player"
function r57_0.Callback(r0_281)
  -- line: [0, 0] id: 281
  r9_0.trade.selectedPlayer = r0_281
  r54_0()
end
rarityPlayerDropdown = TradeByRarity:[r57_0](r57_0)
r57_0 = "AddButton"
r57_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 279
    local r0_279 = {}
    for r4_279, r5_279 in ipairs(r0_0.Players:GetPlayers()) do
      if r5_279 ~= r9_0.player then
        table.insert(r0_279, r5_279.Name)
      end
    end
    rarityPlayerDropdown:SetValues(r0_279 or {})
  end,
}
TradeByRarity:[r57_0](r57_0)
r57_0 = "AddInput"
r57_0 = {
  Title = "Amount to Trade",
  Default = "1",
  Callback = function(r0_297)
    -- line: [0, 0] id: 297
    r9_0.trade.rarityAmount = tonumber(r0_297) or 1
    r54_0("Set amount: " .. tostring(r9_0.trade.rarityAmount))
  end,
}
TradeByRarity:[r57_0](r57_0)
function startTradeByRarity()
  -- line: [0, 0] id: 110
  local r0_110 = r9_0.trade
  if r0_110.trading then
    return 
  end
  if not r0_110.selectedPlayer or not r0_110.selectedRarity then
    return chloex("⚠ Select player & rarity first!")
  end
  r0_110.trading = true
  r0_110.successCount = 0
  chloex("Starting rarity trade (" .. r0_110.selectedRarity .. ") with " .. r0_110.selectedPlayer)
  r54_0("<font color=\'#ffaa00\'>Scanning " .. r0_110.selectedRarity .. " fishes...</font>")
  local r1_110 = {}
  for r5_110, r6_110 in ipairs(r8_0.Data:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r7_110 = r6_110.Favorited
    if not r7_110 then
      r7_110 = r6_0.ItemUtility.GetItemDataFromItemType("Items", r6_110.Id)
      if r7_110 and r7_110.Data.Type == "Fish" and _G.TierFish[r7_110.Data.Tier] == r0_110.selectedRarity then
        table.insert(r1_110, {
          UUID = r6_110.UUID,
          Name = r7_110.Data.Name,
        })
      end
    end
  end
  if #r1_110 == 0 then
    r0_110.trading = false
    r54_0("<font color=\'#ff3333\'>No " .. r0_110.selectedRarity .. " fishes found</font>")
    return chloex("No " .. r0_110.selectedRarity .. " fishes found")
  end
  r0_110.totalToTrade = math.min(#r1_110, r0_110.rarityAmount or #r1_110)
  r54_0(string.format("Sending %d %s fishes...", r0_110.totalToTrade, r0_110.selectedRarity))
  local r2_110 = 1
  while r0_110.trading do
    local r3_110 = r0_110.totalToTrade
    if r2_110 <= r3_110 then
      r3_110 = r1_110[r2_110]
      local r4_110 = r50_0(r0_110.selectedPlayer, r3_110.UUID, r3_110.Name)
      if r4_110 then
        r0_110.successCount = r0_110.successCount + 1
        r54_0(string.format("Progress: %d / %d (%s)", r0_110.successCount, r0_110.totalToTrade, r0_110.selectedRarity))
      end
      r2_110 = r2_110 + 1
      task.wait(2.5)
    else
      break
    end
  end
  r0_110.trading = false
  r54_0("<font color=\'#66ccff\'>Rarity trade finished</font>")
  chloex("Rarity trade finished (" .. r0_110.selectedRarity .. ")")
end
r57_0 = "AddToggle"
r57_0 = {
  Title = "Start By Rarity",
  Default = false,
  Callback = function(r0_277)
    -- line: [0, 0] id: 277
    if r0_277 then
      task.spawn(startTradeByRarity)
    else
      r9_0.trade.trading = false
      r54_0("Idle")
    end
  end,
}
TradeByRarity:[r57_0](r57_0)
r57_0 = "AddSection"
r57_0 = "Auto Accept Features"
AcceptTrade = r23_0.Trade:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Auto Accept Trade",
  Default = _G.AutoAccept,
  Callback = function(r0_133)
    -- line: [0, 0] id: 133
    _G.AutoAccept = r0_133
  end,
}
AcceptTrade:[r57_0](r57_0)
spawn(function()
  -- line: [0, 0] id: 257
  -- notice: unreachable block#2
  while true do
    task.wait(1)
    if _G.AutoAccept then
      pcall(function()
        -- line: [0, 0] id: 258
        local r0_258 = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Prompt")
        if r0_258 and r0_258:FindFirstChild("Blackout") then
          local r1_258 = r0_258.Blackout
          if r1_258:FindFirstChild("Options") then
            local r3_258 = r1_258.Options:FindFirstChild("Yes")
            if r3_258 then
              local r4_258 = game:GetService("VirtualInputManager")
              local r5_258 = r3_258.AbsolutePosition
              local r6_258 = r3_258.AbsoluteSize
              local r7_258 = r5_258.X + r6_258.X / 2
              local r8_258 = r5_258.Y + r6_258.Y / 2 + 50
              r4_258:SendMouseButtonEvent(r7_258, r8_258, 0, true, game, 1)
              task.wait(0.03)
              r4_258:SendMouseButtonEvent(r7_258, r8_258, 0, false, game, 1)
            end
          end
        end
      end)
    end
  end
end)
r57_0 = "AddSection"
r57_0 = "Threshold Features"
ThresholdSec = r23_0.Farm:[r57_0](r57_0)
r57_0 = "AddParagraph"
r57_0 = {
  Title = "Farm Threshold Panel",
  Content = "\r\nCurrent : 0\r\nTarget : 0\r\nProgress : 0%\r\n",
}
ThresholdParagraph = ThresholdSec:[r57_0](r57_0)
ThresholdTotalBase = 0
ThresholdBase = 0
ThresholdTarget = 0
ThresholdPos2 = ""
ThresholdPos1 = ""
r57_0 = "AddInput"
r57_0 = {
  Title = "Position 1",
  Callback = function(r0_8)
    -- line: [0, 0] id: 8
    local r1_8 = nil	-- notice: implicit variable refs by block#[3]
    if r0_8 == "" then
      r1_8 = ""
      if not r1_8 then
        ::label_5::
        r1_8 = r0_8
      end
    else
      goto label_5	-- block#2 is visited secondly
    end
    ThresholdPos1 = r1_8
  end,
}
ThresholdSec:[r57_0](r57_0)
r57_0 = "AddInput"
r57_0 = {
  Title = "Position 2",
  Callback = function(r0_326)
    -- line: [0, 0] id: 326
    local r1_326 = nil	-- notice: implicit variable refs by block#[3]
    if r0_326 == "" then
      r1_326 = ""
      if not r1_326 then
        ::label_5::
        r1_326 = r0_326
      end
    else
      goto label_5	-- block#2 is visited secondly
    end
    ThresholdPos2 = r1_326
  end,
}
ThresholdSec:[r57_0](r57_0)
r57_0 = "AddButton"
r57_0 = {
  Title = "Copy Current Position",
  Callback = function()
    -- line: [0, 0] id: 202
    local r0_202 = r0_0.Players.LocalPlayer
    local r2_202 = (r0_202.Character or r0_202.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r2_202 then
      local r3_202 = string.format("%.1f, %.1f, %.1f", r2_202.Position.X, r2_202.Position.Y, r2_202.Position.Z)
      if setclipboard then
        setclipboard(r3_202)
      end
      chloex("Successfully copied your position to clipboard!")
    end
  end,
}
ThresholdSec:[r57_0](r57_0)
r57_0 = "AddInput"
r57_0 = {
  Title = "Target Fish Caught",
  Callback = function(r0_191)
    -- line: [0, 0] id: 191
    ThresholdTarget = tonumber(r0_191) or 0
  end,
}
ThresholdSec:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Enable Threshold Farm",
  Default = false,
  Callback = function(r0_181)
    -- line: [0, 0] id: 181
    _G.ThresholdFarm = r0_181
    if r0_181 then
      ThresholdBase = (r8_0.Data:Get({
        "Statistics"
      }) or {}).FishCaught or 0
      ThresholdTotalBase = ThresholdBase
    end
  end,
}
ThresholdSec:[r57_0](r57_0)
r57_0 = "AddSection"
r57_0 = "Coin Features"
CoinSec = r23_0.Farm:[r57_0](r57_0)
r57_0 = "AddParagraph"
r57_0 = {
  Title = "Coin Farm Panel",
  Content = "\r\nCurrent : 0\r\nTarget : 0\r\nProgress : 0%\r\n",
}
CoinParagraph = CoinSec:[r57_0](r57_0)
CoinBase = 0
CoinTarget = 0
CoinSpotOptions = {
  ["Kohana Volcano"] = Vector3.new(-552, 19, 183),
  ["Tropical Grove"] = Vector3.new(-2084, 3, 3700),
}
r55_0 = CoinSec
r57_0 = "AddDropdown"
r57_0 = {
  Title = "Coin Location",
}
r57_0.Options = {
  "Kohana Volcano",
  "Tropical Grove"
}
r57_0.Multi = false
function r57_0.Callback(r0_225)
  -- line: [0, 0] id: 225
  SelectedCoinSpot = CoinSpotOptions[r0_225]
end
r55_0:[r57_0](r57_0)
r57_0 = "AddInput"
r57_0 = {
  Title = "Target Coin",
  Placeholder = "Enter coin target...",
  Callback = function(r0_342)
    -- line: [0, 0] id: 342
    local r1_342 = tonumber(r0_342)
    if r1_342 then
      CoinTarget = r1_342
    end
  end,
}
CoinSec:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Enable Coin Farm",
  Default = false,
  Callback = function(r0_246)
    -- line: [0, 0] id: 246
    _G.CoinFarm = r0_246
    if r0_246 then
      repeat
        task.wait()
      until r8_0.Data
      CoinBase = r8_0.Data:Get({
        "Coins"
      }) or 0
    end
  end,
}
CoinSec:[r57_0](r57_0)
r57_0 = "AddSection"
r57_0 = "Enchant Stone Features"
EnchantSec = r23_0.Farm:[r57_0](r57_0)
r57_0 = "AddParagraph"
r57_0 = {
  Title = "Enchant Stone Farm Panel",
  Content = "\r\nCurrent : 0\r\nTarget : 0\r\nProgress : 0%\r\n",
}
r36_0 = EnchantSec:[r57_0](r57_0)
EnchantBase = 0
EnchantTarget = 0
EnchantSpotOptions = {
  ["Tropical Grove"] = Vector3.new(-2084, 3, 3700),
  ["Esoteric Depths"] = Vector3.new(3272, -1302, 1404),
}
r55_0 = EnchantSec
r57_0 = "AddDropdown"
r57_0 = {
  Title = "Enchant Stone Location",
}
r57_0.Options = {
  "Tropical Grove",
  "Esoteric Depths"
}
r57_0.Multi = false
function r57_0.Callback(r0_45)
  -- line: [0, 0] id: 45
  SelectedEnchantSpot = EnchantSpotOptions[r0_45]
end
r55_0:[r57_0](r57_0)
r57_0 = "AddInput"
r57_0 = {
  Title = "Target Enchant Stone",
  Placeholder = "Enter enchant stone target...",
  Callback = function(r0_197)
    -- line: [0, 0] id: 197
    local r1_197 = tonumber(r0_197)
    if r1_197 then
      EnchantTarget = r1_197
    end
  end,
}
EnchantSec:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Enable Enchant Farm",
  Default = false,
  Callback = function(r0_58)
    -- line: [0, 0] id: 58
    _G.EnchantFarm = r0_58
    if r0_58 then
      local r2_58 = r8_0.Data:Get({
        "Inventory",
        "Items"
      }) or {}
      local r3_58 = 0
      for r7_58, r8_58 in ipairs(r2_58) do
        if r8_58.Id == 10 then
          r3_58 = r3_58 + r8_58.Amount or 1
        end
      end
      EnchantBase = r3_58
    end
  end,
}
EnchantSec:[r57_0](r57_0)
task.spawn(function()
  -- line: [0, 0] id: 324
  local r0_324 = false
  local r1_324 = nil
  local r2_324 = 0
  while task.wait(1) do
    local r3_324 = r8_0.Data
    if r3_324 then
      local r5_324 = r0_0.Players.LocalPlayer.Character
      local r6_324 = r5_324 and r5_324:FindFirstChild("HumanoidRootPart")
      if r6_324 and not r1_324 then
        r1_324 = r6_324.CFrame
      end
      if _G.ThresholdFarm then
        local r8_324 = (r3_324:Get({
          "Statistics"
        }) or {}).FishCaught or 0
        if r2_324 == 0 then
          r2_324 = ThresholdBase
        end
        local r9_324 = r8_324 - ThresholdBase
        local r10_324 = ThresholdTarget
        if r10_324 > 0 then
          r10_324 = math.min(r9_324 / ThresholdTarget * 100, 100) or 0
        else
          goto label_60	-- block#17 is visited secondly
        end
        ThresholdParagraph:SetContent(string.format("Current : %s\nTarget : %s\nProgress : %.1f%%", r9_324, ThresholdTarget, r10_324))
        if r6_324 and ThresholdPos1 ~= "" and ThresholdPos2 ~= "" and not r0_324 then
          r0_324 = true
          task.spawn(function()
            -- line: [0, 0] id: 325
            local r0_325 = Vector3.new(unpack(string.split(ThresholdPos1, ",")))
            local r1_325 = Vector3.new(unpack(string.split(ThresholdPos2, ",")))
            local r3_325 = r8_324 + ThresholdTarget
            while _G.ThresholdFarm do
              while true do
                task.wait(1)
                local r4_325 = r3_324
                r4_325 = r4_325:Get({
                  "Statistics"
                })
                if not r4_325 then
                  r4_325 = {}
                end
                r8_324 = r4_325.FishCaught or 0
                if r3_325 > r8_324 and _G.ThresholdFarm then
                  goto label_48	-- block#7 is visited secondly
                else
                  break
                end
              end
              local r4_325 = _G.ThresholdFarm
              if not r4_325 then
                break
              end
              r6_324.CFrame = CFrame.new(r1_325 + Vector3.new(0, 3, 0))
              ThresholdBase = r8_324
              local r2_325 = r8_324
              r4_325 = ThresholdTarget
              r3_325 = r2_325 + r4_325
              while true do
                task.wait(1)
                r4_325 = r3_324
                r4_325 = r4_325:Get({
                  "Statistics"
                }) or {}
                local r5_325 = r4_325.FishCaught or 0
                r8_324 = r5_325
                r5_325 = r8_324
                if r3_325 > r5_325 then
                  r5_325 = _G.ThresholdFarm
                  if not r5_325 then
                    break
                  end
                else
                  break
                end
              end
              r4_325 = _G.ThresholdFarm
              if r4_325 then
                r6_324.CFrame = CFrame.new(r0_325 + Vector3.new(0, 3, 0))
                ThresholdBase = r8_324
                r2_325 = r8_324
                r4_325 = ThresholdTarget
                r3_325 = r2_325 + r4_325
              else
                break
              end
            end
            r0_324 = false
          end)
        end
        -- close: r7_324
      end
      if _G.CoinFarm then
        local r8_324 = (r3_324:Get({
          "Coins"
        }) or 0) - CoinBase
        local r9_324 = CoinTarget
        if r9_324 > 0 then
          r9_324 = math.min(r8_324 / CoinTarget * 100, 100) or 0
        else
          goto label_117	-- block#29 is visited secondly
        end
        CoinParagraph:SetContent(string.format("Current : %s\nTarget : %s\nProgress : %.1f%%", r8_324, CoinTarget, r9_324))
        if SelectedCoinSpot and r6_324 then
          if r1_324 then
            r6_324.CFrame = r1_324
          end
          _G.CoinFarm = false
        end
      end
      if _G.EnchantFarm then
        local r7_324 = r3_324:Get({
          "Inventory",
          "Items"
        }) or {}
        local r8_324 = 0
        for r12_324, r13_324 in ipairs(r7_324) do
          if r13_324.Id == 10 then
            r8_324 = r8_324 + r13_324.Amount or 1
          end
        end
        local r9_324 = r8_324 - EnchantBase
        local r10_324 = EnchantTarget
        if r10_324 > 0 then
          r10_324 = math.min(r9_324 / EnchantTarget * 100, 100) or 0
        else
          goto label_202	-- block#48 is visited secondly
        end
        r36_0:SetContent(string.format("Current : %s\nTarget : %s\nProgress : %.1f%%", r9_324, EnchantTarget, r10_324))
        if SelectedEnchantSpot and r6_324 then
          if r1_324 then
            r6_324.CFrame = r1_324
          end
          _G.EnchantFarm = false
        end
      end
      -- close: r4_324
    else
      task.wait(1)
    end
    -- close: r3_324
  end
  -- warn: not visited block [34, 53]
  -- block#34:
  -- r6_324.CFrame = CFrame.new(SelectedCoinSpot + Vector3.new(0, 3, 0))
  -- goto label_160
  -- block#53:
  -- r6_324.CFrame = CFrame.new(SelectedEnchantSpot + Vector3.new(0, 3, 0))
  -- goto label_245
end)
r57_0 = "AddSection"
r57_0 = "Event Features"
XAdm = r23_0.Farm:[r57_0](r57_0)
r57_0 = "AddParagraph"
r57_0 = {
  Title = "Ancient Lochness Monster Countdown",
  Content = "<font color=\'#ff4d4d\'><b>waiting for ... for joined event!</b></font>",
}
countdownParagraph = XAdm:[r57_0](r57_0)
r9_0.FarmPosition = r9_0.FarmPosition or nil
r9_0.autoCountdownUpdate = false
r57_0 = "AddToggle"
r57_0 = {
  Title = "Auto Admin Event",
  Default = false,
  Callback = function(r0_166)
    -- line: [0, 0] id: 166
    local r2_166 = game:GetService("Players").LocalPlayer
    r9_0.autoCountdownUpdate = r0_166
    local function r3_166()
      -- line: [0, 0] id: 170
      local r0_170, r1_170 = pcall(function()
        -- line: [0, 0] id: 171
        return workspace["!!! MENU RINGS"]["Event Tracker"].Main.Gui.Content.Items.Countdown.Label
      end)
      local r2_170 = nil	-- notice: implicit variable refs by block#[3]
      if r0_170 then
        r2_170 = r1_170
        if r2_170 then
          ::label_7::
          r2_170 = nil
        end
      else
        goto label_7	-- block#2 is visited secondly
      end
      return r2_170
    end
    local function r4_166(r0_172)
      -- line: [0, 0] id: 172
      r0_172.CFrame = CFrame.new(Vector3.new(6063, -586, 4715))
    end
    local function r5_166(r0_167)
      -- line: [0, 0] id: 167
      if r9_0.FarmPosition then
        r0_167.CFrame = r9_0.FarmPosition
        countdownParagraph:SetContent("<font color=\'#00ff99\'><b>✅ Returned to saved farm position!</b></font>")
      else
        countdownParagraph:SetContent("<font color=\'#ff4d4d\'><b>❌ No saved farm position found!</b></font>")
      end
    end
    local r8_166 = nil	-- notice: implicit variable refs by block#[11, 12]
    if r0_166 then
      local r7_166 = (r2_166.Character or r2_166.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
      if r7_166 then
        r9_0.FarmPosition = r7_166.CFrame
        countdownParagraph:SetContent(string.format("<font color=\'#00ff99\'><b>Farm position saved!</b></font>"))
      end
      r8_166 = r3_166()
      if not r8_166 then
        countdownParagraph:SetContent("<font color=\'#ff4d4d\'><b>Label not found!</b></font>")
        return 
      end
      task.spawn(function()
        -- line: [0, 0] id: 168
        local r0_168 = false
        while r9_0.autoCountdownUpdate do
          task.wait(1)
          local r1_168 = ""
          pcall(function()
            -- line: [0, 0] id: 169
            r1_168 = r8_166.Text or ""
          end)
          if r1_168 == "" then
            countdownParagraph:SetContent("<font color=\'#ff4d4d\'><b>Waiting for countdown...</b></font>")
          else
            countdownParagraph:SetContent(string.format("<font color=\'#4de3ff\'><b>Timer: %s</b></font>", r1_168))
            local r3_168 = (r2_166.Character or r2_166.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
            if not r3_168 then
              countdownParagraph:SetContent("<font color=\'#ff4d4d\'><b>⚠️ HRP not found, retrying...</b></font>")
            else
              local r4_168, r5_168, r6_168 = r1_168:match("(%d+)H%s*(%d+)M%s*(%d+)S")
              local r7_168 = tonumber(r4_168)
              local r8_168 = tonumber(r5_168)
              r6_168 = tonumber(r6_168)
              r5_168 = r8_168
              r4_168 = r7_168
              if r4_168 == 3 and r5_168 == 59 and r6_168 == 59 and not r0_168 then
                countdownParagraph:SetContent("<font color=\'#00ff99\'><b>Event started! Teleporting...</b></font>")
                r4_166(r3_168)
                r0_168 = true
              elseif r4_168 == 3 and r5_168 == 49 and r6_168 == 59 and r0_168 then
                countdownParagraph:SetContent("<font color=\'#ffaa00\'><b>Event ended! Returning...</b></font>")
                r5_166(r3_168)
                r0_168 = false
              end
            end
          end
          if not r8_166 or not r8_166.Parent then
            r8_166 = r3_166()
            if not r8_166 then
              countdownParagraph:SetContent("<font color=\'#ff4d4d\'><b>Label lost. Reconnecting...</b></font>")
              task.wait(2)
              r8_166 = r3_166()
            end
          end
          -- close: r1_168
        end
      end)
      -- close: r6_166
    else
      local r7_166 = (r2_166.Character or r2_166.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
      if r7_166 then
        r8_166 = r5_166
        r8_166(r7_166)
      end
      r8_166 = countdownParagraph
      r8_166:SetContent("<font color=\'#ff4d4d\'><b>Auto Admin Event disabled.</b></font>")
    end
  end,
}
XAdm:[r57_0](r57_0)
r57_0 = "AddSection"
r57_0 = "Semi Kaitun [BETA]"
Panel = r23_0.Farm:[r57_0](r57_0)
RS = game:GetService("ReplicatedStorage")
ItemsFolder = RS:WaitForChild("Items")
BaitsFolder = RS:WaitForChild("Baits")
r1_0 = r0_0.Players.LocalPlayer
SellEvent = r6_0.Net["RF/SellAllItems"]
_G.SelectedFarmLocation = "Kohana Volcano"
_G.DeepSeaDone = _G.DeepSeaDone or false
_G.ArtifactDone = _G.ArtifactDone or false
_G.LastArtifactTP = _G.LastArtifactTP or 0
function getItemNameFromFolder(r0_179, r1_179, r2_179)
  -- line: [0, 0] id: 179
  for r6_179, r7_179 in ipairs(r0_179:GetChildren()) do
    if r7_179:IsA("ModuleScript") then
      local r8_179, r9_179 = pcall(require, r7_179)
      if r8_179 and r9_179 and r9_179.Data then
        local r10_179 = r9_179.Data
        if r10_179.Id == r1_179 and (not r2_179 or r10_179.Type == r2_179) then
          if r9_179.IsSkin then
            return nil
          end
          return r10_179.Name
        end
      end
    end
  end
  return nil
end
Locations = {
  ["Kohana Volcano"] = Vector3.new(-552, 19, 183),
  ["Tropical Grove"] = Vector3.new(-2084, 3, 3700),
  ["Esoteric Deep"] = CFrame.new(3269, -1302, 1406) * CFrame.Angles(0, math.rad(-180), 0),
  DeepSea_Start = CFrame.new(-3633, -279, -1603) * CFrame.Angles(0, math.rad(-45), 0),
  DeepSea_2 = CFrame.new(-3735, -135, -1011) * CFrame.Angles(0, math.rad(180), 0),
  ["Arrow Artifact"] = CFrame.new(875, 3, -368) * CFrame.Angles(0, math.rad(90), 0),
  ["Crescent Artifact"] = CFrame.new(1403, 3, 123) * CFrame.Angles(0, math.rad(180), 0),
  ["Hourglass Diamond Artifact"] = CFrame.new(1487, 3, -842) * CFrame.Angles(0, math.rad(180), 0),
  ["Diamond Artifact"] = CFrame.new(1844, 3, -287) * CFrame.Angles(0, math.rad(-90), 0),
  Element_Stage1 = CFrame.new(1484, 3, -336) * CFrame.Angles(0, math.rad(180), 0),
  Element_Stage2 = CFrame.new(1453, -22, -636),
  Element_Final = CFrame.new(1480, 128, -593),
}
orderList = {
  "Arrow Artifact",
  "Crescent Artifact",
  "Hourglass Diamond Artifact",
  "Diamond Artifact"
}
function tp(r0_42)
  -- line: [0, 0] id: 42
  local r2_42 = (r1_0.Character or r1_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
  if r2_42 then
    r2_42.CFrame = CFrame.new(r0_42)
  end
end
function hasRod(r0_123)
  -- line: [0, 0] id: 123
  for r5_123, r6_123 in ipairs((r8_0.Data:Get({
    "Inventory"
  }) or {})["Fishing Rods"] or {}) do
    if getItemNameFromFolder(ItemsFolder, r6_123.Id, "Fishing Rods") == r0_123 then
      return true
    end
  end
  return false
end
function hasBait(r0_44)
  -- line: [0, 0] id: 44
  for r5_44, r6_44 in ipairs((r8_0.Data:Get({
    "Inventory"
  }) or {}).Baits or {}) do
    if getItemNameFromFolder(BaitsFolder, r6_44.Id) == r0_44 then
      return true
    end
  end
  return false
end
function hasArtifactWorld(r0_331)
  -- line: [0, 0] id: 331
  local r1_331 = workspace:FindFirstChild("JUNGLE INTERACTIONS")
  if not r1_331 then
    return false
  end
  local r2_331 = r0_331:lower():gsub(" artifact", "")
  for r6_331, r7_331 in ipairs(r1_331:GetDescendants()) do
    if r7_331:IsA("Model") and r7_331.Name == "TempleLever" and tostring((r7_331:GetAttribute("Type") or "")):lower():find(r2_331) then
      return (r7_331:FindFirstChild("RootPart") and r7_331.RootPart:FindFirstChildWhichIsA("ProximityPrompt")) == nil
    end
  end
  return false
end
function readTracker(r0_7)
  -- line: [0, 0] id: 7
  local r1_7 = workspace["!!! MENU RINGS"]:FindFirstChild(r0_7)
  if not r1_7 then
    return ""
  end
  local r2_7 = r1_7:FindFirstChild("Board") and r1_7.Board:FindFirstChild("Gui") and r1_7.Board.Gui:FindFirstChild("Content")
  if not r2_7 then
    return ""
  end
  local r3_7 = {}
  local r4_7 = 1
  for r8_7, r9_7 in ipairs(r2_7:GetChildren()) do
    if r9_7:IsA("TextLabel") and r9_7.Name ~= "Header" then
      table.insert(r3_7, r4_7 .. ". " .. r9_7.Text)
      r4_7 = r4_7 + 1
    end
  end
  return table.concat(r3_7, "\n")
end
function hasArtifactInv(r0_293)
  -- line: [0, 0] id: 293
  local r1_293 = {
    ["Arrow Artifact"] = 265,
    ["Crescent Artifact"] = 266,
    ["Diamond Artifact"] = 267,
    ["Hourglass Diamond Artifact"] = 271,
  }
  local r3_293 = (r8_0.Data:Get({
    "Inventory"
  }) or {}).Items or {}
  local r4_293 = r1_293[r0_293]
  if not r4_293 then
    return false
  end
  for r8_293, r9_293 in ipairs(r3_293) do
    if r9_293.Id == r4_293 then
      return true
    end
  end
  return false
end
function tp(r0_129)
  -- line: [0, 0] id: 129
  local r2_129 = (r1_0.Character or r1_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
  if not r2_129 then
    return 
  end
  if typeof(r0_129) == "Vector3" then
    r2_129.CFrame = CFrame.new(r0_129)
  else
    r2_129.CFrame = r0_129
  end
end
function getLeverStatus()
  -- line: [0, 0] id: 327
  local r0_327 = workspace:FindFirstChild("JUNGLE INTERACTIONS")
  if not r0_327 then
    return {}
  end
  local r1_327 = {}
  local r2_327 = 1
  for r6_327, r7_327 in ipairs(r0_327:GetDescendants()) do
    if r7_327:IsA("Model") and r7_327.Name == "TempleLever" then
      local r8_327 = r7_327:FindFirstChild("RootPart") and r7_327.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      local r9_327 = r7_327:GetAttribute("Type") or "Lever" .. r2_327
      r1_327[r9_327] = r8_327 == nil
      r2_327 = r2_327 + 1
    end
  end
  return r1_327
end
s = getLeverStatus()
function seg(r0_147, r1_147)
  -- line: [0, 0] id: 147
  local r2_147 = nil	-- notice: implicit variable refs by block#[10]
  if r0_147 == "Hourglass Diamond Artifact" then
    r2_147 = "Hourglass Diamond"
    if not r2_147 then
      ::label_5::
      if r0_147 == "Arrow Artifact" then
        r2_147 = "Arrow"
        if not r2_147 then
          ::label_10::
          if r0_147 == "Crescent Artifact" then
            r2_147 = "Crescent"
            if not r2_147 then
              ::label_15::
              r2_147 = "Diamond"
            end
          else
            goto label_15	-- block#6 is visited secondly
          end
        end
      else
        goto label_10	-- block#4 is visited secondly
      end
    end
  else
    goto label_5	-- block#2 is visited secondly
  end
  local r3_147 = nil	-- notice: implicit variable refs by block#[10]
  if r1_147 then
    r3_147 = "0,255,0"
    if not r3_147 then
      ::label_21::
      r3_147 = "255,0,0"
    end
  else
    goto label_21	-- block#9 is visited secondly
  end
  local r4_147 = "%s : <b><font color=\"rgb(%s)\">%s</font></b>"
  local r6_147 = r2_147
  local r7_147 = r3_147
  local r8_147 = nil	-- notice: implicit variable refs by block#[13]
  if r1_147 then
    r8_147 = "ACTIVE"
    if not r8_147 then
      ::label_31::
      r8_147 = "DISABLE"
    end
  else
    goto label_31	-- block#12 is visited secondly
  end
  return r4_147:format(r6_147, r7_147, r8_147)
end
function triggerLever(r0_13)
  -- line: [0, 0] id: 13
  local r1_13 = workspace:FindFirstChild("JUNGLE INTERACTIONS")
  if not r1_13 then
    return 
  end
  local r2_13 = string.match(r0_13, "^(%w+)")
  for r6_13, r7_13 in ipairs(r1_13:GetDescendants()) do
    if r7_13:IsA("Model") and r7_13.Name == "TempleLever" then
      local r8_13 = r7_13:GetAttribute("Type")
      local r9_13 = r7_13:FindFirstChild("RootPart") and r7_13.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      if r8_13 and string.find(r8_13:lower(), r2_13:lower()) and r9_13 then
        print("[AUTO] Triggering lever:", r8_13)
        pcall(function()
          -- line: [0, 0] id: 14
          fireproximityprompt(r9_13)
        end)
        -- close: r3_13
        break
      else
        -- close: r8_13
      end
    end
  end
end
r55_0 = Panel
r57_0 = "AddDropdown"
r57_0 = {
  Title = "Farming Location",
}
r57_0.Options = {
  "Kohana Volcano",
  "Tropical Grove"
}
r57_0.Default = "Kohana Volcano"
function r57_0.Callback(r0_344)
  -- line: [0, 0] id: 344
  _G.SelectedFarmLocation = r0_344
end
r55_0:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Start Kaitun",
  Default = false,
  Callback = function(r0_80)
    -- line: [0, 0] id: 80
    _G.KaitunPanel = r0_80
    if r0_80 then
      if r0_0.CoreGui:FindFirstChild("ChloeX_KaitunPanel") then
        r0_0.CoreGui:FindFirstChild("ChloeX_KaitunPanel"):Destroy()
      end
      local r1_80 = Instance.new("ScreenGui")
      r1_80.Name = "ChloeX_KaitunPanel"
      r1_80.IgnoreGuiInset = true
      r1_80.ResetOnSpawn = false
      r1_80.ZIndexBehavior = Enum.ZIndexBehavior.Global
      r1_80.Parent = r0_0.CoreGui
      local r2_80 = Instance.new("Frame", r1_80)
      r2_80.Size = UDim2.new(0, 500, 0, 250)
      r2_80.AnchorPoint = Vector2.new(0.5, 0.5)
      r2_80.Position = UDim2.new(0.5, 0, 0.5, 0)
      r2_80.BackgroundColor3 = Color3.fromRGB(20, 22, 35)
      r2_80.BorderSizePixel = 0
      r2_80.Active = true
      r2_80.Draggable = true
      local r3_80 = Instance.new("TextLabel", r2_80)
      r3_80.Size = UDim2.new(1, -20, 0, 36)
      r3_80.Position = UDim2.new(0, 10, 0, 8)
      r3_80.BackgroundTransparency = 1
      r3_80.Font = Enum.Font.GothamBold
      r3_80.Text = "CHLOEX KAITUN PANEL"
      r3_80.TextSize = 22
      r3_80.TextColor3 = Color3.fromRGB(255, 255, 255)
      r3_80.TextXAlignment = Enum.TextXAlignment.Center
      local r4_80 = Instance.new("UIGradient", r3_80)
      r4_80.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 90, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
      })
      r4_80.Rotation = 0
      local r5_80 = Instance.new("UIStroke", r2_80)
      r5_80.Thickness = 2
      r5_80.Color = Color3.fromRGB(80, 150, 255)
      r5_80.Transparency = 0.35
      Instance.new("UICorner", r2_80).CornerRadius = UDim.new(0, 14)
      local r7_80 = game:GetService("UserInputService")
      local r8_80 = game:GetService("TweenService")
      local r9_80 = false
      local r10_80 = false
      local r11_80 = nil
      local r12_80 = nil
      local r13_80 = nil
      local r14_80 = Instance.new("ImageButton")
      r14_80.Name = "ResizeHandle"
      r14_80.Parent = r2_80
      r14_80.Size = UDim2.new(0, 24, 0, 24)
      r14_80.AnchorPoint = Vector2.new(1, 1)
      r14_80.Position = UDim2.new(1, -6, 1, -6)
      r14_80.Image = "rbxassetid://6153965696"
      r14_80.BackgroundTransparency = 1
      r14_80.ZIndex = 10
      r14_80.Active = true
      local function r15_80(r0_100)
        -- line: [0, 0] id: 100
        local r1_100 = r0_100.UserInputType
        if r1_100 ~= Enum.UserInputType.MouseButton1 then
          r1_100 = r0_100.UserInputType == Enum.UserInputType.Touch
        else
          goto label_13	-- block#3 is visited secondly
        end
        return r1_100
      end
      local function r16_80(r0_98, r1_98)
        -- line: [0, 0] id: 98
        local r2_98 = nil	-- notice: implicit variable refs by block#[0]
        r2_98 = r7_80.InputChanged:Connect(function(r0_99)
          -- line: [0, 0] id: 99
          if r0_99.UserInputType == Enum.UserInputType.MouseMovement or r0_99.UserInputType == Enum.UserInputType.Touch then
            if r1_98 == "drag" and r9_80 then
              local r1_99 = r0_99.Position - r11_80
              r2_80.Position = UDim2.new(r12_80.X.Scale, r12_80.X.Offset + r1_99.X, r12_80.Y.Scale, r12_80.Y.Offset + r1_99.Y)
            elseif r1_98 == "resize" and r10_80 then
              local r1_99 = r0_99.Position - r11_80
              r8_80:Create(r2_80, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, math.clamp(r13_80.X.Offset + r1_99.X, 350, 700), 0, math.clamp(r13_80.Y.Offset + r1_99.Y, 250, 900)),
              }):Play()
            else
              r2_98:Disconnect()
            end
          end
        end)
      end
      r2_80.InputBegan:Connect(function(r0_81)
        -- line: [0, 0] id: 81
        if r15_80(r0_81) and not r10_80 then
          r9_80 = true
          r11_80 = r0_81.Position
          r12_80 = r2_80.Position
          r16_80(r0_81, "drag")
        end
      end)
      r2_80.InputEnded:Connect(function(r0_101)
        -- line: [0, 0] id: 101
        if r15_80(r0_101) then
          r9_80 = false
        end
      end)
      r14_80.InputBegan:Connect(function(r0_82)
        -- line: [0, 0] id: 82
        if r15_80(r0_82) then
          r10_80 = true
          r13_80 = r2_80.Size
          r11_80 = r0_82.Position
          r16_80(r0_82, "resize")
        end
      end)
      r14_80.InputEnded:Connect(function(r0_85)
        -- line: [0, 0] id: 85
        if r15_80(r0_85) then
          r10_80 = false
        end
      end)
      local r17_80 = Instance.new("ScrollingFrame", r2_80)
      r17_80.Position = UDim2.new(0, 0, 0, 50)
      r17_80.Size = UDim2.new(1, 0, 1, -60)
      r17_80.BackgroundTransparency = 1
      r17_80.ScrollBarThickness = 0
      r17_80.ScrollingDirection = Enum.ScrollingDirection.Y
      r17_80.AutomaticCanvasSize = Enum.AutomaticSize.Y
      r17_80.CanvasSize = UDim2.new(0, 0, 0, 0)
      r17_80.VerticalScrollBarInset = Enum.ScrollBarInset.Always
      local r18_80 = Instance.new("UIListLayout", r17_80)
      r18_80.Padding = UDim.new(0, 10)
      r18_80.SortOrder = Enum.SortOrder.LayoutOrder
      local function r19_80(r0_97, r1_97)
        -- line: [0, 0] id: 97
        local r2_97 = Instance.new("TextLabel", r17_80)
        r2_97.Size = UDim2.new(1, -30, 0, 25)
        r2_97.Font = Enum.Font.GothamBold
        r2_97.TextSize = 18
        r2_97.BackgroundTransparency = 1
        r2_97.TextColor3 = Color3.fromRGB(140, 200, 255)
        r2_97.Text = r0_97
        r2_97.TextXAlignment = Enum.TextXAlignment.Left
        local r3_97 = Instance.new("Frame", r17_80)
        r3_97.Size = UDim2.new(1, -30, 0, r1_97 or 80)
        r3_97.BackgroundTransparency = 1
        local r4_97 = Instance.new("TextLabel", r3_97)
        r4_97.Size = UDim2.new(1, 0, 1, 0)
        r4_97.Font = Enum.Font.Gotham
        r4_97.TextSize = 16
        r4_97.BackgroundTransparency = 1
        r4_97.TextColor3 = Color3.fromRGB(255, 255, 255)
        r4_97.TextXAlignment = Enum.TextXAlignment.Left
        r4_97.TextYAlignment = Enum.TextYAlignment.Top
        r4_97.TextWrapped = true
        r4_97.Text = "Loading..."
        r4_97.RichText = true
        return r4_97
      end
      local r20_80 = r19_80("OWNED RODS", 50)
      local r21_80 = r19_80("OWNED BAITS", 50)
      local r22_80 = r19_80("FARMING PROGRESS", 40)
      local r23_80 = r19_80("COINS", 30)
      local r24_80 = r19_80("DEEP SEA QUEST", 120)
      local r25_80 = r19_80("ARTIFACT QUEST", 120)
      local r26_80 = r19_80("ELEMENT QUEST", 120)
      local r27_80 = r19_80("FLOW STATUS", 50)
      task.spawn(function()
        -- line: [0, 0] id: 83
        while _G.KaitunPanel do
          pcall(function()
            -- line: [0, 0] id: 84
            SellEvent:InvokeServer()
          end)
          task.wait(180)
        end
      end)
      task.spawn(function()
        -- line: [0, 0] id: 86
        while true do
          if _G.KaitunPanel then
            task.wait(1)
            local r0_86 = r8_0.Data
            if not r0_86 then
              task.wait(1)
            else
              local r1_86 = r0_86:Get({
                "Coins"
              }) or 0
              r23_80.Text = "$" .. tostring(r1_86)
              local r2_86 = r0_86:Get({
                "Inventory"
              }) or {}
              local r3_86 = {}
              local r4_86 = {}
              for r8_86, r9_86 in ipairs(r2_86["Fishing Rods"] or {}) do
                local r10_86 = getItemNameFromFolder(ItemsFolder, r9_86.Id, "Fishing Rods")
                if r10_86 then
                  table.insert(r3_86, r10_86)
                end
              end
              for r8_86, r9_86 in ipairs(r2_86.Baits or {}) do
                local r10_86 = getItemNameFromFolder(BaitsFolder, r9_86.Id)
                if r10_86 then
                  table.insert(r4_86, r10_86)
                end
              end
              local r5_86 = r20_80
              local r6_86 = #r3_86
              if r6_86 > 0 then
                r6_86 = table.concat(r3_86, ", ") or "No rods found."
              else
                goto label_94	-- block#21 is visited secondly
              end
              r5_86.Text = r6_86
              r5_86 = r21_80
              r6_86 = #r4_86
              if r6_86 > 0 then
                r6_86 = table.concat(r4_86, ", ") or "No baits found."
              else
                goto label_107	-- block#24 is visited secondly
              end
              r5_86.Text = r6_86
              r24_80.Text = readTracker("Deep Sea Tracker")
              r26_80.Text = readTracker("Element Tracker")
              function seg(r0_91)
                -- line: [0, 0] id: 91
                local r1_91 = hasArtifactWorld(r0_91)
                local r2_91 = nil	-- notice: implicit variable refs by block#[10]
                if r0_91 == "Hourglass Diamond Artifact" then
                  r2_91 = "Hourglass Diamond"
                  if not r2_91 then
                    ::label_8::
                    if r0_91 == "Arrow Artifact" then
                      r2_91 = "Arrow"
                      if not r2_91 then
                        ::label_13::
                        if r0_91 == "Crescent Artifact" then
                          r2_91 = "Crescent"
                          if not r2_91 then
                            ::label_18::
                            r2_91 = "Diamond"
                          end
                        else
                          goto label_18	-- block#6 is visited secondly
                        end
                      end
                    else
                      goto label_13	-- block#4 is visited secondly
                    end
                  end
                else
                  goto label_8	-- block#2 is visited secondly
                end
                local r3_91 = nil	-- notice: implicit variable refs by block#[10]
                if r1_91 then
                  r3_91 = "0,255,0"
                  if not r3_91 then
                    ::label_24::
                    r3_91 = "255,0,0"
                  end
                else
                  goto label_24	-- block#9 is visited secondly
                end
                local r4_91 = string.format
                local r5_91 = "%s : <b><font color=\'rgb(%s)\'>%s</font></b>"
                local r6_91 = r2_91
                local r7_91 = r3_91
                local r8_91 = nil	-- notice: implicit variable refs by block#[13]
                if r1_91 then
                  r8_91 = "ACTIVE"
                  if not r8_91 then
                    ::label_35::
                    r8_91 = "DISABLE"
                  end
                else
                  goto label_35	-- block#12 is visited secondly
                end
                return r4_91(r5_91, r6_91, r7_91, r8_91)
              end
              r25_80.Text = table.concat({
                seg("Arrow Artifact"),
                seg("Crescent Artifact"),
                seg("Hourglass Diamond Artifact"),
                seg("Diamond Artifact")
              }, "\n")
              if not hasRod("Midnight Rod") then
                r27_80.Text = "Status: Buying Midnight Rod"
                if r1_86 >= 53001 then
                  task.spawn(function()
                    -- line: [0, 0] id: 87
                    pcall(function()
                      -- line: [0, 0] id: 88
                      r7_0.Functions.BuyRod:InvokeServer(80)
                    end)
                    task.wait(2)
                    pcall(function()
                      -- line: [0, 0] id: 89
                      r7_0.Functions.BuyBait:InvokeServer(3)
                    end)
                  end)
                else
                  r22_80.Text = "Farming coins... (" .. r1_86 .. "/53000)"
                  r27_80.Text = "Status: Farming"
                  tp(Locations[_G.SelectedFarmLocation or "Kohana Volcano"])
                end
              else
                if hasRod("Midnight Rod") and not hasRod("Astral Rod") and 1000001 <= r1_86 then
                  r27_80.Text = "Status: Buying Astral Rod"
                  task.spawn(function()
                    -- line: [0, 0] id: 92
                    pcall(function()
                      -- line: [0, 0] id: 94
                      r7_0.Functions.BuyRod:InvokeServer(5)
                    end)
                    task.wait(2)
                    pcall(function()
                      -- line: [0, 0] id: 93
                      r7_0.Functions.BuyBait:InvokeServer(15)
                    end)
                  end)
                end
                if hasRod("Astral Rod") and not hasBait("Floral Bait") and 4000001 <= r1_86 then
                  r27_80.Text = "Status: Buying Floral Bait"
                  task.spawn(function()
                    -- line: [0, 0] id: 95
                    pcall(function()
                      -- line: [0, 0] id: 96
                      r7_0.Functions.BuyBait:InvokeServer(20)
                    end)
                  end)
                end
                if hasRod("Midnight Rod") and not _G.DeepSeaDone then
                  r27_80.Text = "Status: Deep Sea Quest"
                  r5_86 = nil
                  _G.DeepSeaDone = false
                  while true do
                    if _G.KaitunPanel then
                      r6_86 = _G.DeepSeaDone
                      if not r6_86 then
                        r24_80.Text = readTracker("Deep Sea Tracker")
                        r6_86 = r24_80.Text:lower()
                        local r7_86 = string.find(r6_86, "catch 1 secret fish at sisyphus statue %- 100%%")
                        local r8_86 = string.find(r6_86, "catch 3 mythic fish at sisyphus statue %- 100%%")
                        local r9_86 = string.find(r6_86, "treasure room %- 100%%")
                        local r10_86 = string.find(r6_86, "earn 1m coins %- 100%%")
                        if r9_86 and r7_86 and r8_86 and r10_86 then
                          _G.DeepSeaDone = true
                        end
                        if not r9_86 and r5_86 ~= "DeepSea_Start" then
                          tp(Locations.DeepSea_Start)
                          r5_86 = "DeepSea_Start"
                        elseif r9_86 and (not r7_86 or not r8_86) and r5_86 ~= "DeepSea_2" then
                          tp(Locations.DeepSea_2)
                          r5_86 = "DeepSea_2"
                        end
                        task.wait(1)
                      end
                    end
                  end
                end
                if _G.DeepSeaDone and not _G.ArtifactDone then
                  r27_80.Text = "Status: Artifact Quest"
                  _G.ArtifactDone = false
                  task.spawn(function()
                    -- line: [0, 0] id: 90
                    while _G.KaitunPanel do
                      local r0_90 = _G.ArtifactDone
                      if not r0_90 then
                        r0_90 = ipairs
                        for r3_90, r4_90 in r0_90(orderList) do
                          if not hasArtifactWorld(r4_90) then
                            r27_80.Text = "Status: Collecting " .. r4_90
                            tp(Locations[r4_90])
                            while true do
                              task.wait(2)
                              if not hasArtifactInv(r4_90) then
                                local r5_90 = hasArtifactWorld(r4_90)
                                if not r5_90 then
                                  r5_90 = _G.KaitunPanel
                                  if not r5_90 then
                                    break
                                  end
                                else
                                  break
                                end
                              else
                                break
                              end
                            end
                            if hasArtifactInv(r4_90) or hasArtifactWorld(r4_90) then
                              r27_80.Text = "Status: Triggering " .. r4_90
                              triggerLever(r4_90)
                              local r5_90 = tick()
                              while true do
                                task.wait(1)
                                if not hasArtifactWorld(r4_90) then
                                  local r6_90 = tick() - r5_90
                                  if r6_90 <= 10 then
                                    r6_90 = _G.KaitunPanel
                                    if not r6_90 then
                                      break
                                    end
                                  else
                                    break
                                  end
                                else
                                  break
                                end
                              end
                            end
                          end
                        end
                        r0_90 = hasArtifactWorld("Arrow Artifact")
                        if r0_90 then
                          r0_90 = hasArtifactWorld("Crescent Artifact")
                          if r0_90 then
                            r0_90 = hasArtifactWorld("Hourglass Diamond Artifact")
                            if r0_90 then
                              r0_90 = hasArtifactWorld("Diamond Artifact")
                              if r0_90 then
                                _G.ArtifactDone = true
                                r0_90 = r27_80
                                r0_90.Text = "Status: Artifact Quest Complete ✅"
                              end
                            end
                          end
                        end
                        task.wait(3)
                      else
                        break
                      end
                    end
                  end)
                end
                if not _G.ElementDone then
                  r27_80.Text = "Status: Element Quest"
                  _G.ElementDone = false
                  r5_86 = nil
                  while true do
                    ::label_332::
                    if _G.KaitunPanel then
                      r6_86 = _G.ElementDone
                      if not r6_86 then
                        r26_80.Text = readTracker("Element Tracker")
                        r6_86 = r26_80.Text:lower()
                        print("[DEBUG Element Text]\n" .. r6_86)
                        local r7_86 = r6_86:find("catch 1 secret fish at sacred temple %- 100%%")
                        local r8_86 = r6_86:find("catch 1 secret fish at ancient jungle %- 100%%")
                        local r9_86 = r6_86:find("create 3 transcended stones %- 100%%")
                        if r7_86 and r8_86 and r9_86 then
                          _G.ElementDone = true
                          local r10_86 = r27_80
                          r10_86.Text = "Status: Element Quest Complete ✅"
                        else
                          break
                        end
                      end
                    end
                  end
                end
              end
            end
          else
            return 
          end
        end
        if not r8_86 and r5_86 ~= "Element_Stage1" then
          tp(Locations.Element_Stage1)
          local r5_86 = "Element_Stage1"
        elseif r8_86 and not r7_86 and r5_86 ~= "Element_Stage2" then
          tp(Locations.Element_Stage2)
          local r5_86 = "Element_Stage2"
        elseif r8_86 and r7_86 and not r9_86 and r5_86 ~= "Element_Final" then
          tp(Locations.Element_Final)
          local r5_86 = "Element_Final"
        end
        task.wait(1)
        goto label_332
      end)
      -- close: r1_80
    else
      _G.KaitunPanel = false
      local r1_80 = r0_0.CoreGui:FindFirstChild("ChloeX_KaitunPanel")
      if r1_80 then
        r1_80:Destroy()
      end
    end
  end,
}
Panel:[r57_0](r57_0)
r57_0 = "AddToggle"
r57_0 = {
  Title = "Hide Kaitun Panel",
  Default = false,
  Callback = function(r0_196)
    -- line: [0, 0] id: 196
    local r1_196 = r0_0.CoreGui:FindFirstChild("ChloeX_KaitunPanel")
    if r1_196 then
      local r2_196 = r1_196:FindFirstChild("MainCard") or r1_196:FindFirstChildWhichIsA("Frame")
      if r2_196 then
        r2_196.Visible = not r0_196
      end
    end
  end,
}
Panel:[r57_0](r57_0)
RodPriority = {
  "Element Rod",
  "Ghostfin Rod",
  "Bambo Rod",
  "Angler Rod",
  "Ares Rod",
  "Hazmat Rod",
  "Astral Rod",
  "Midnight Rod"
}
function equipBestRod()
  -- line: [0, 0] id: 63
  local r0_63 = r8_0.Data
  if not r0_63 then
    return 
  end
  local r2_63 = (r0_63:Get({
    "Inventory"
  }) or {})["Fishing Rods"] or {}
  local r4_63 = (r0_63:Get({
    "EquippedItems"
  }) or {})["Fishing Rods"]
  local r5_63 = math.huge
  local r6_63 = nil
  local r7_63 = nil
  for r11_63, r12_63 in ipairs(r2_63) do
    local r13_63 = getItemNameFromFolder(ItemsFolder, r12_63.Id, "Fishing Rods")
    if r13_63 and r12_63.UUID then
      for r17_63, r18_63 in ipairs(RodPriority) do
        if string.find(r13_63, r18_63) and r17_63 < r5_63 then
          r5_63 = r17_63
          r6_63 = r13_63
          r7_63 = r12_63.UUID
        end
      end
    end
  end
  if not r7_63 or r4_63 == r7_63 then
    return 
  end
  print("[AUTO EQUIP] Equipping best rod:", r6_63)
  pcall(function()
    -- line: [0, 0] id: 64
    r7_0.Functions.Cancel:InvokeServer()
    task.wait(0.3)
    r7_0.Events.REEquipItem:FireServer(r7_63, "Fishing Rods")
  end)
end
r57_0 = "AddToggle"
r57_0 = {
  Title = "Auto Equip Best Rod",
  Default = false,
  Callback = function(r0_136)
    -- line: [0, 0] id: 136
    _G.AutoEquipBestRod = r0_136
    if not r0_136 then
      return 
    end
    local r1_136 = r8_0.Data
    if not r1_136 then
      return 
    end
    local r3_136 = (r1_136:Get({
      "Inventory"
    }) or {})["Fishing Rods"] or {}
    local r5_136 = (r1_136:Get({
      "EquippedItems"
    }) or {})["Fishing Rods"]
    local r6_136 = math.huge
    local r7_136 = nil
    local r8_136 = nil
    for r12_136, r13_136 in ipairs(r3_136) do
      local r14_136 = getItemNameFromFolder(ItemsFolder, r13_136.Id, "Fishing Rods")
      if r14_136 and r13_136.UUID then
        for r18_136, r19_136 in ipairs(RodPriority) do
          if string.find(r14_136, r19_136) and r18_136 < r6_136 then
            r6_136 = r18_136
            r7_136 = r14_136
            r8_136 = r13_136.UUID
          end
        end
      end
    end
    if r8_136 and r5_136 ~= r8_136 then
      print("[AUTO EQUIP] Equipping best rod:", r7_136)
      pcall(function()
        -- line: [0, 0] id: 137
        r7_0.Functions.Cancel:InvokeServer()
        task.wait(0.3)
        r7_0.Events.REEquipItem:FireServer(r8_136, "Fishing Rods")
        task.wait(0.3)
        r7_0.Events.REEquip:FireServer(1)
      end)
    else
      print("[AUTO EQUIP] Already using best rod or none found.")
    end
  end,
}
Panel:[r57_0](r57_0)
r57_0 = "AddSection"
r57_0 = "Artifact Lever Location"
r55_0 = r23_0.Quest:[r57_0](r57_0)
r56_0 = workspace:WaitForChild("JUNGLE INTERACTIONS")
r57_0 = 1
local r58_0 = false
local r59_0 = nil
local r60_0 = "0,255,0"
local r61_0 = "255,0,0"
_G.artifactPositions = {
  ["Arrow Artifact"] = CFrame.new(875, 3, -368) * CFrame.Angles(0, math.rad(90), 0),
  ["Crescent Artifact"] = CFrame.new(1403, 3, 123) * CFrame.Angles(0, math.rad(180), 0),
  ["Hourglass Diamond Artifact"] = CFrame.new(1487, 3, -842) * CFrame.Angles(0, math.rad(180), 0),
  ["Diamond Artifact"] = CFrame.new(1844, 3, -287) * CFrame.Angles(0, math.rad(-90), 0),
}
local r62_0 = {
  "Arrow Artifact",
  "Crescent Artifact",
  "Hourglass Diamond Artifact",
  "Diamond Artifact"
}
local function r63_0()
  -- line: [0, 0] id: 190
  -- notice: unreachable block#5
  local r0_190 = {}
  for r4_190, r5_190 in ipairs(r56_0:GetDescendants()) do
    if r5_190:IsA("Model") and r5_190.Name == "TempleLever" then
      local r6_190 = r5_190:GetAttribute("Type")
      local r7_190 = r5_190:FindFirstChild("RootPart")
      if r7_190 then
        r7_190 = not r5_190.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      else
        r7_190 = true
      end
      r0_190[r6_190] = r7_190
    end
  end
  return r0_190
end
local function r64_0(r0_243)
  -- line: [0, 0] id: 243
  local function r1_243(r0_244, r1_244)
    -- line: [0, 0] id: 244
    local r2_244 = nil	-- notice: implicit variable refs by block#[10]
    if r0_244 == "Hourglass Diamond Artifact" then
      r2_244 = "Hourglass Diamond"
      if not r2_244 then
        ::label_5::
        if r0_244 == "Arrow Artifact" then
          r2_244 = "Arrow"
          if not r2_244 then
            ::label_10::
            if r0_244 == "Crescent Artifact" then
              r2_244 = "Crescent"
              if not r2_244 then
                ::label_15::
                r2_244 = "Diamond"
              end
            else
              goto label_15	-- block#6 is visited secondly
            end
          end
        else
          goto label_10	-- block#4 is visited secondly
        end
      end
    else
      goto label_5	-- block#2 is visited secondly
    end
    local r3_244 = nil	-- notice: implicit variable refs by block#[10]
    if r1_244 then
      r3_244 = r60_0
      if not r3_244 then
        ::label_21::
        r3_244 = r61_0
      end
    else
      goto label_21	-- block#9 is visited secondly
    end
    local r4_244 = "%s : <b><font color=\"rgb(%s)\">%s</font></b>"
    local r6_244 = r2_244
    local r7_244 = r3_244
    local r8_244 = nil	-- notice: implicit variable refs by block#[13]
    if r1_244 then
      r8_244 = "ACTIVE"
      if not r8_244 then
        ::label_31::
        r8_244 = "DISABLE"
      end
    else
      goto label_31	-- block#12 is visited secondly
    end
    return r4_244:format(r6_244, r7_244, r8_244)
  end
  ArtifactParagraph:SetContent(table.concat({
    r1_243("Arrow Artifact", r0_243["Arrow Artifact"]),
    r1_243("Crescent Artifact", r0_243["Crescent Artifact"]),
    r1_243("Hourglass Diamond Artifact", r0_243["Hourglass Diamond Artifact"]),
    r1_243("Diamond Artifact", r0_243["Diamond Artifact"])
  }, "\n"))
end
local function r65_0(r0_125)
  -- line: [0, 0] id: 125
  for r4_125, r5_125 in ipairs(r56_0:GetDescendants()) do
    if r5_125:IsA("Model") and r5_125.Name == "TempleLever" and r5_125:GetAttribute("Type") == r0_125 then
      local r6_125 = r5_125:FindFirstChild("RootPart") and r5_125.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      if r6_125 then
        fireproximityprompt(r6_125)
        break
      else
        break
      end
    end
  end
end
local r68_0 = "AddParagraph"
r68_0 = {
  Title = "Panel Progress Artifact",
  Content = "\r\nArrow : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nCrescent : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nHourglass Diamond : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nDiamond : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\n",
}
ArtifactParagraph = r55_0:[r68_0](r68_0)
r68_0 = "Connect"
function r68_0(r0_274)
  -- line: [0, 0] id: 274
  if not r58_0 or not r59_0 then
    return 
  end
  local r1_274 = string.split(r59_0, " ")[1]
  if r1_274 and string.find(r0_274, r1_274, 1, true) then
    task.wait(0)
    r65_0(r59_0)
    r59_0 = nil
  end
end
r7_0.Events.REFishGot.OnClientEvent:[r68_0](r68_0)
r68_0 = "AddToggle"
r68_0 = {
  Title = "Artifact Progress",
  Default = false,
  Callback = function(r0_52)
    -- line: [0, 0] id: 52
    r58_0 = r0_52
    if r0_52 then
      task.spawn(function()
        -- line: [0, 0] id: 53
        while r58_0 do
          local r0_53 = r63_0()
          local r1_53 = true
          for r5_53, r6_53 in pairs(r0_53) do
            if not r6_53 then
              r1_53 = false
              break
            end
          end
          r64_0(r0_53)
          if r1_53 then
            r58_0 = false
            break
          else
            for r5_53, r6_53 in ipairs(r62_0) do
              if not r0_53[r6_53] then
                r59_0 = r6_53
                local r8_53 = (r1_0.Character or r1_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
                if r8_53 and _G.artifactPositions[r6_53] then
                  r8_53.CFrame = _G.artifactPositions[r6_53]
                end
                while true do
                  task.wait(r57_0)
                  if r59_0 then
                    local r9_53 = r58_0
                    if not r9_53 then
                      goto label_64	-- block#16 is visited secondly
                    end
                  else
                    break
                  end
                end
              end
            end
            task.wait(r57_0)
          end
        end
      end)
    end
  end,
}
r55_0:[r68_0](r68_0)
task.spawn(function()
  -- line: [0, 0] id: 284
  while task.wait(r57_0) do
    r64_0(r63_0())
  end
end)
r68_0 = "AddButton"
r68_0 = {
  Title = "Arrow",
  Callback = function()
    -- line: [0, 0] id: 309
    local r1_309 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_309 then
      r1_309.CFrame = _G.artifactPositions["Arrow Artifact"]
    end
  end,
  SubTitle = "Hourglass Diamond",
  SubCallback = function()
    -- line: [0, 0] id: 1
    local r1_1 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_1 then
      r1_1.CFrame = _G.artifactPositions["Hourglass Diamond Artifact"]
    end
  end,
}
r55_0:[r68_0](r68_0)
r68_0 = "AddButton"
r68_0 = {
  Title = "Crescent",
  Callback = function()
    -- line: [0, 0] id: 5
    local r1_5 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_5 then
      r1_5.CFrame = _G.artifactPositions["Crescent Artifact"]
    end
  end,
  SubTitle = "Diamond",
  SubCallback = function()
    -- line: [0, 0] id: 215
    local r1_215 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_215 then
      r1_215.CFrame = _G.artifactPositions["Diamond Artifact"]
    end
  end,
}
r55_0:[r68_0](r68_0)
r68_0 = "AddSection"
r68_0 = "Sisyphus Statue Quest"
local r66_0 = r23_0.Quest:[r68_0](r68_0)
local r69_0 = "AddParagraph"
r69_0 = {
  Title = "Deep Sea Panel",
  Content = "",
}
local r67_0 = r66_0:[r69_0](r69_0)
r66_0:AddDivider()
local r70_0 = "AddToggle"
r70_0 = {
  Title = "Auto Deep Sea Quest",
  Content = "Automatically complete Deep Sea Quest!",
  Default = false,
  Callback = function(r0_332)
    -- line: [0, 0] id: 332
    r9_0.autoDeepSea = r0_332
    task.spawn(function()
      -- line: [0, 0] id: 333
      while r9_0.autoDeepSea do
        local r0_333 = workspace:FindFirstChild("!!! MENU RINGS")
        local r1_333 = r0_333 and r0_333:FindFirstChild("Deep Sea Tracker")
        if r1_333 then
          local r2_333 = r1_333:FindFirstChild("Board") and r1_333.Board:FindFirstChild("Gui") and r1_333.Board.Gui:FindFirstChild("Content")
          if r2_333 then
            local r3_333 = nil
            for r7_333, r8_333 in ipairs(r2_333:GetChildren()) do
              if r8_333:IsA("TextLabel") and r8_333.Name ~= "Header" then
                r3_333 = r8_333
                break
              end
            end
            if r3_333 then
              local r4_333 = string.lower(r3_333.Text)
              local r5_333 = r9_0.player.Character and r9_0.player.Character:FindFirstChild("HumanoidRootPart")
              if r5_333 then
                if string.find(r4_333, "100%%") then
                  r5_333.CFrame = CFrame.new(-3763, -135, -995) * CFrame.Angles(0, math.rad(180), 0)
                else
                  r5_333.CFrame = CFrame.new(-3599, -276, -1641)
                end
              end
            end
          end
        end
        task.wait(1)
      end
    end)
  end,
}
r66_0:[r70_0](r70_0)
r70_0 = "AddButton"
r70_0 = {
  Title = "Treasure Room",
  Callback = function()
    -- line: [0, 0] id: 62
    local r1_62 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_62 then
      r1_62.CFrame = CFrame.new(-3601, -283, -1611)
    end
  end,
  SubTitle = "Sisyphus Statue",
  SubCallback = function()
    -- line: [0, 0] id: 213
    local r1_213 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_213 then
      r1_213.CFrame = CFrame.new(-3698, -135, -1008)
    end
  end,
}
r66_0:[r70_0](r70_0)
r70_0 = "AddSection"
r70_0 = "Element Quest"
r68_0 = r23_0.Quest:[r70_0](r70_0)
local r71_0 = "AddParagraph"
r71_0 = {
  Title = "Element Panel",
  Content = "",
}
r69_0 = r68_0:[r71_0](r71_0)
r68_0:AddDivider()
local r72_0 = "AddToggle"
r72_0 = {
  Title = "Auto Element Quest",
  Content = "Automatically teleport through Element quest stages.",
  Default = false,
  Callback = function(r0_46)
    -- line: [0, 0] id: 46
    r9_0.autoElement = r0_46
    task.spawn(function()
      -- line: [0, 0] id: 47
      while r9_0.autoElement do
        local r0_47 = r9_0.player.Character and r9_0.player.Character:FindFirstChild("HumanoidRootPart")
        local r1_47 = workspace:FindFirstChild("!!! MENU RINGS")
        local r2_47 = r1_47 and r1_47:FindFirstChild("Element Tracker")
        if r0_47 and r2_47 then
          local r3_47 = r2_47:FindFirstChild("Board")
          local r4_47 = r3_47 and r3_47:FindFirstChild("Gui")
          local r5_47 = r4_47 and r4_47:FindFirstChild("Content")
          if r5_47 then
            local r6_47 = {}
            for r10_47, r11_47 in ipairs(r5_47:GetChildren()) do
              if r11_47:IsA("TextLabel") and r11_47.Name ~= "Header" then
                table.insert(r6_47, string.lower(r11_47.Text))
              end
            end
            if #r6_47 >= 4 then
              local r7_47 = r6_47[2]
              local r8_47 = r6_47[4]
              if not string.find(r8_47, "100%%") then
                local r9_47 = CFrame.new(1484, 3, -336) * CFrame.Angles(0, math.rad(180), 0)
                r0_47.CFrame = r9_47
                autoReturn(r0_47, r9_47, 100)
                goto label_155
              elseif string.find(r8_47, "100%%") and not string.find(r7_47, "100%%") then
                local r9_47 = CFrame.new(1453, -22, -636)
                r0_47.CFrame = r9_47
                autoReturn(r0_47, r9_47, 100)
                goto label_155
              elseif string.find(r7_47, "100%%") then
                local r9_47 = CFrame.new(1480, 128, -593)
                r0_47.CFrame = r9_47
                autoReturn(r0_47, r9_47, 100)
                r9_0.autoElement = false
                r69_0:SetContent("Element Quest Completed!")
                break
              end
            end
          end
        else
          ::label_155::
          ::label_155::
          task.wait(1)
        end
      end
    end)
  end,
}
r68_0:[r72_0](r72_0)
r72_0 = "AddButton"
r72_0 = {
  Title = "Secred Temple",
  Callback = function()
    -- line: [0, 0] id: 268
    local r1_268 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_268 then
      r1_268.CFrame = CFrame.new(1453, -22, -636)
    end
  end,
  SubTitle = "Underground Cellar",
  SubCallback = function()
    -- line: [0, 0] id: 227
    local r1_227 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_227 then
      r1_227.CFrame = CFrame.new(2136, -91, -701)
    end
  end,
}
r68_0:[r72_0](r72_0)
r72_0 = "AddButton"
r72_0 = {
  Title = "Transcended Stones",
  Callback = function()
    -- line: [0, 0] id: 102
    local r1_102 = (r9_0.player.Character or r9_0.player.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r1_102 then
      r1_102.CFrame = CFrame.new(1480, 128, -593)
    end
  end,
}
r68_0:[r72_0](r72_0)
function r70_0(r0_29)
  -- line: [0, 0] id: 29
  local r1_29 = workspace["!!! MENU RINGS"]:FindFirstChild(r0_29)
  if not r1_29 then
    return ""
  end
  local r2_29 = r1_29:FindFirstChild("Board") and r1_29.Board:FindFirstChild("Gui") and r1_29.Board.Gui:FindFirstChild("Content")
  if not r2_29 then
    return ""
  end
  local r3_29 = {}
  local r4_29 = 1
  for r8_29, r9_29 in ipairs(r2_29:GetChildren()) do
    if r9_29:IsA("TextLabel") and r9_29.Name ~= "Header" then
      table.insert(r3_29, r4_29 .. ". " .. r9_29.Text)
      r4_29 = r4_29 + 1
    end
  end
  return table.concat(r3_29, "\n")
end
task.spawn(function()
  -- line: [0, 0] id: 114
  while task.wait(2) do
    r69_0:SetContent(r70_0("Element Tracker"))
    r67_0:SetContent(r70_0("Deep Sea Tracker"))
  end
end)
local r73_0 = "AddSection"
r73_0 = "Auto Progress Quest Features"
QuestSec = r23_0.Quest:[r73_0](r73_0)
r73_0 = "AddParagraph"
r73_0 = {
  Title = "Progress Quest Panel",
  Content = "Waiting for start...",
}
QuestProgress = QuestSec:[r73_0](r73_0)
r73_0 = "AddToggle"
r73_0 = {
  Title = "Auto Teleport Quest",
  Default = false,
  Callback = function(r0_318)
    -- line: [0, 0] id: 318
    r9_0.autoQuestFlow = r0_318
    task.spawn(function()
      -- line: [0, 0] id: 319
      local r0_319 = false
      local r1_319 = false
      local r2_319 = false
      local r3_319 = {
        Deep = false,
        Lever = false,
        Element = false,
      }
      function updateParagraph(r0_320)
        -- line: [0, 0] id: 320
        if QuestProgress and QuestProgress.SetContent then
          QuestProgress:SetContent(r0_320)
        end
      end
      while r9_0.autoQuestFlow and (not r0_319 or not r1_319 or not r2_319) do
        local r10_319 = nil	-- notice: implicit variable refs by block#[23]
        if not r0_319 then
          local r4_319 = workspace:FindFirstChild("!!! MENU RINGS")
          local r5_319 = r4_319 and r4_319:FindFirstChild("Deep Sea Tracker")
          local r6_319 = r5_319 and r5_319:FindFirstChild("Board") and r5_319.Board:FindFirstChild("Gui") and r5_319.Board.Gui:FindFirstChild("Content")
          local r7_319 = true
          local r8_319 = 0
          local r9_319 = 0
          if r6_319 then
            r10_319 = ipairs
            for r13_319, r14_319 in r10_319(r6_319:GetChildren()) do
              if r14_319:IsA("TextLabel") and r14_319.Name ~= "Header" then
                r9_319 = r9_319 + 1
                if string.find(r14_319.Text, "100%%") then
                  r8_319 = r8_319 + 1
                else
                  r7_319 = false
                end
              end
            end
          end
          if r9_319 > 0 then
            r10_319 = math.floor(r8_319 / r9_319 * 100)
            if not r10_319 then
              ::label_88::
              r10_319 = 0
            end
          else
            goto label_88	-- block#22 is visited secondly
          end
          updateParagraph(string.format("Doing objective on Deep Sea Quest...\nProgress now %d%%.", r10_319))
          if not r7_319 and not r3_319.Deep then
            local r11_319 = r1_0.Character and r1_0.Character:FindFirstChild("HumanoidRootPart")
            if r11_319 then
              r11_319.CFrame = CFrame.new(-3599, -276, -1641)
              r3_319.Deep = true
            end
          elseif r7_319 then
            r0_319 = true
            updateParagraph("Deep Sea Quest Completed!\nProceeding to Artifact Lever...")
          end
          task.wait(1)
        end
        if r0_319 and not r1_319 then
          local r4_319 = r9_0.autoQuestFlow
          if r4_319 then
            r4_319 = workspace:FindFirstChild("JUNGLE INTERACTIONS")
            local r5_319 = r63_0()
            local r6_319 = true
            for r10_319, r11_319 in pairs(r5_319) do
              if not r11_319 then
                r6_319 = false
                break
              end
            end
            if not r6_319 and not r3_319.Lever then
              local r7_319 = r1_0.Character and r1_0.Character:FindFirstChild("HumanoidRootPart")
              if r7_319 and _G.artifactPositions["Arrow Artifact"] then
                r7_319.CFrame = _G.artifactPositions["Arrow Artifact"]
                r3_319.Lever = true
              end
              updateParagraph("Doing objective on Artifact Lever...\nProgress now 75%.")
            elseif r6_319 then
              r1_319 = true
              updateParagraph("Artifact Lever Completed!\nProceeding to Element Quest...")
            end
            task.wait(1)
          end
        end
        if r0_319 and r1_319 and not r2_319 then
          local r4_319 = r9_0.autoQuestFlow
          if r4_319 then
            r4_319 = workspace:FindFirstChild("!!! MENU RINGS")
            local r5_319 = r4_319 and r4_319:FindFirstChild("Element Tracker")
            local r6_319 = r5_319 and r5_319:FindFirstChild("Board") and r5_319.Board:FindFirstChild("Gui") and r5_319.Board.Gui:FindFirstChild("Content")
            if r6_319 then
              local r7_319 = {}
              for r11_319, r12_319 in ipairs(r6_319:GetChildren()) do
                if r12_319:IsA("TextLabel") and r12_319.Name ~= "Header" then
                  table.insert(r7_319, r12_319.Text)
                end
              end
              local r8_319 = r7_319[2]
              if r8_319 then
                r8_319 = string.lower(r7_319[2]) or ""
              else
                goto label_265	-- block#68 is visited secondly
              end
              local r9_319 = r7_319[4]
              if r9_319 then
                r9_319 = string.lower(r7_319[4]) or ""
              else
                goto label_275	-- block#71 is visited secondly
              end
              r10_319 = r1_0.Character and r1_0.Character:FindFirstChild("HumanoidRootPart")
              if not string.find(r8_319, "100%%") or not string.find(r9_319, "100%%") then
                if not r3_319.Element and r10_319 then
                  r10_319.CFrame = CFrame.new(1484, 3, -336) * CFrame.Angles(0, math.rad(180), 0)
                  r3_319.Element = true
                end
                if not string.find(r9_319, "100%%") then
                  updateParagraph("Doing objective on Element Quest...\nProgress now 50%.")
                elseif string.find(r9_319, "100%%") and not string.find(r8_319, "100%%") then
                  r10_319.CFrame = CFrame.new(1453, -22, -636)
                  updateParagraph("Doing objective on Element Quest...\nProgress now 75%.")
                end
              else
                r2_319 = true
                updateParagraph("All Quest Completed Successfully! :3")
                r9_0.autoQuestFlow = false
              end
            end
            task.wait(1)
          end
        end
      end
    end)
  end,
}
QuestSec:[r73_0](r73_0)
r73_0 = "AddSection"
r73_0 = "Crystalline Pessage Features"
r71_0 = r23_0.Quest:[r73_0](r73_0)
r72_0 = workspace:FindFirstChild("RUIN INTERACTIONS")
r73_0 = {
  "Rare",
  "Epic",
  "Legendary",
  "Mythic"
}
FishTargetIDs = {
  Rare = 284,
  Epic = 270,
  Legendary = 283,
  Mythic = 263,
}
local r76_0 = "AddParagraph"
r76_0 = {
  Title = "Panel Ancient Ruin",
  Content = "Checking...",
}
PromptParagraph = r71_0:[r76_0](r76_0)
task.spawn(function()
  -- line: [0, 0] id: 328
  while task.wait(1) do
    local r0_328 = r72_0
    if r0_328 then
      r0_328 = r72_0:FindFirstChild("PressurePlates")
      if r0_328 then
        r0_328 = r72_0.PressurePlates
        local r1_328 = r0_328:FindFirstChild("Rare") and r0_328.Rare.Part:FindFirstChild("ProximityPrompt")
        local r2_328 = r0_328:FindFirstChild("Epic") and r0_328.Epic.Part:FindFirstChild("ProximityPrompt")
        local r3_328 = r0_328:FindFirstChild("Legendary") and r0_328.Legendary.Part:FindFirstChild("ProximityPrompt")
        local r4_328 = r0_328:FindFirstChild("Mythic") and r0_328.Mythic.Part:FindFirstChild("ProximityPrompt")
        local r5_328 = PromptParagraph
        local r7_328 = string.format
        local r8_328 = "Rare : %s\nEpic : %s\nLegendary : %s\nMythic : %s"
        local r9_328 = nil	-- notice: implicit variable refs by block#[23]
        if r1_328 then
          r9_328 = "<b>Disable</b>"
          if not r9_328 then
            ::label_67::
            r9_328 = "<b>Active</b>"
          end
        else
          goto label_67	-- block#13 is visited secondly
        end
        local r10_328 = nil	-- notice: implicit variable refs by block#[23]
        if r2_328 then
          r10_328 = "<b>Disable</b>"
          if not r10_328 then
            ::label_73::
            r10_328 = "<b>Active</b>"
          end
        else
          goto label_73	-- block#16 is visited secondly
        end
        local r11_328 = nil	-- notice: implicit variable refs by block#[23]
        if r3_328 then
          r11_328 = "<b>Disable</b>"
          if not r11_328 then
            ::label_79::
            r11_328 = "<b>Active</b>"
          end
        else
          goto label_79	-- block#19 is visited secondly
        end
        local r12_328 = nil	-- notice: implicit variable refs by block#[23]
        if r4_328 then
          r12_328 = "<b>Disable</b>"
          if not r12_328 then
            ::label_85::
            r12_328 = "<b>Active</b>"
          end
        else
          goto label_85	-- block#22 is visited secondly
        end
        r5_328:SetContent(r7_328(r8_328, r9_328, r10_328, r11_328, r12_328))
      end
    end
    PromptParagraph:SetContent("<font color=\'rgb(255,69,0)\'>PressurePlates folder not found!</font>")
  end
end)
r76_0 = "AddToggle"
r76_0 = {
  Title = "Auto Ancient Ruin",
  Default = false,
  Callback = function(r0_338)
    -- line: [0, 0] id: 338
    r9_0.triggerRuin = r0_338
    task.spawn(function()
      -- line: [0, 0] id: 339
      while r9_0.triggerRuin do
        local r0_339 = r8_0.Data
        r0_339 = r0_339:GetExpect({
          "Inventory",
          "Items"
        })
        if r72_0 and r72_0:FindFirstChild("PressurePlates") then
          local r1_339 = r72_0.PressurePlates
          for r5_339, r6_339 in ipairs(r73_0) do
            local r7_339 = FishTargetIDs[r6_339]
            local r8_339 = false
            for r12_339, r13_339 in ipairs(r0_339) do
              if r13_339.Id == r7_339 then
                r8_339 = true
                break
              end
            end
            if r8_339 then
              local r9_339 = r1_339:FindFirstChild(r6_339)
              local r10_339 = r9_339 and r9_339:FindFirstChild("Part")
              local r11_339 = r10_339 and r10_339:FindFirstChild("ProximityPrompt")
              if r11_339 then
                fireproximityprompt(r11_339)
              end
            end
          end
        end
        task.wait(1)
      end
    end)
  end,
}
r71_0:[r76_0](r76_0)
r76_0 = "AddSection"
r76_0 = "Classic Event Features [BETA]"
ClassicX = r23_0.Quest:[r76_0](r76_0)
ReqFish = {
  "Builderman Guppy",
  "Brighteyes Guppy",
  "Shedletsky Guppy",
  "Guest Guppy"
}
FishTargetIDs = {
  ["Builderman Guppy"] = 434,
  ["Brighteyes Guppy"] = 435,
  ["Shedletsky Guppy"] = 415,
  ["Guest Guppy"] = 422,
}
FishRootTargets = {
  ["Brighteyes Guppy"] = CFrame.new(-8865.5, -580.75, 174.225006, -0.00000011920929, 0, -1.00000012, 0, 1, 0, 1.00000012, 0, -0.00000011920929),
  ["Builderman Guppy"] = CFrame.new(-8829.5, -580.75, 138.024994, -0.00000011920929, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -0.00000011920929),
  ["Guest Guppy"] = CFrame.new(-8865.5, -580.75, 138.024994, -0.00000011920929, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -0.00000011920929),
  ["Shedletsky Guppy"] = CFrame.new(-8830.48926, -580.75, 174.635254, 0, 0, -1, 0, 1, 0, 1, 0, 0),
}
Pillars = workspace.ClassicEvent["Fish Pillars"]
function findRoot(r0_292)
  -- line: [0, 0] id: 292
  local r2_292 = math.huge
  local r1_292 = nil	-- notice: implicit variable refs by block#[7]
  for r6_292, r7_292 in ipairs(Pillars:GetChildren()) do
    local r8_292 = r7_292:FindFirstChild("Movement")
    local r9_292 = r8_292 and r8_292:FindFirstChild("Root")
    if r9_292 then
      local r10_292 = (r9_292.CFrame.Position - r0_292.Position).Magnitude
      if r10_292 < r2_292 then
        r2_292 = r10_292
        r1_292 = r9_292
      end
    end
  end
  return r1_292
end
r76_0 = "AddToggle"
r76_0 = {
  Title = "Auto Classic Event",
  Default = false,
  Callback = function(r0_182)
    -- line: [0, 0] id: 182
    r9_0.autoClassicEvent = r0_182
    task.spawn(function()
      -- line: [0, 0] id: 183
      while r9_0.autoClassicEvent do
        local r0_183 = r8_0.Data
        r0_183 = r0_183:GetExpect({
          "Inventory",
          "Items"
        })
        for r4_183, r5_183 in ipairs(ReqFish) do
          local r6_183 = FishTargetIDs[r5_183]
          local r7_183 = false
          for r11_183, r12_183 in ipairs(r0_183) do
            if r12_183.Id == r6_183 then
              r7_183 = true
              break
            end
          end
          if r7_183 then
            local r9_183 = findRoot(FishRootTargets[r5_183])
            if r9_183 then
              local r10_183 = r9_183:FindFirstChild("ProximityPrompt")
              if r10_183 then
                fireproximityprompt(r10_183)
                task.wait(0.3)
              end
            end
          end
        end
        task.wait(0.5)
      end
    end)
  end,
}
ClassicX:[r76_0](r76_0)
r76_0 = "AddSection"
r76_0 = "Teleport To Player"
local r74_0 = r23_0.Tele:[r76_0](r76_0)
local r77_0 = "AddDropdown"
r77_0 = {
  Title = "Select Player to Teleport",
  Content = "Choose target player",
  Options = r17_0(),
}
r77_0.Default = {}
function r77_0.Callback(r0_341)
  -- line: [0, 0] id: 341
  r9_0.trade.teleportTarget = r0_341
end
local r75_0 = r74_0:[r77_0](r77_0)
local r78_0 = "AddButton"
r78_0 = {
  Title = "Refresh Player List",
  Content = "Refresh list!",
  Callback = function()
    -- line: [0, 0] id: 68
    r75_0:SetValues(r17_0())
    chloex("Player list refreshed!")
  end,
}
r74_0:[r78_0](r78_0)
r78_0 = "AddButton"
r78_0 = {
  Title = "Teleport to Player",
  Content = "Teleport to selected player from dropdown",
  Callback = function()
    -- line: [0, 0] id: 19
    local r0_19 = r9_0.trade.teleportTarget
    if not r0_19 then
      chloex("Please select a player first!")
      return 
    end
    local r1_19 = r0_0.Players:FindFirstChild(r0_19)
    if r1_19 and r1_19.Character and r1_19.Character:FindFirstChild("HumanoidRootPart") then
      local r2_19 = r1_0.Character and r1_0.Character:FindFirstChild("HumanoidRootPart")
      if r2_19 then
        r2_19.CFrame = r1_19.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        chloex("Teleported to " .. r1_19.Name)
      else
        chloex("Your HumanoidRootPart not found.")
      end
    else
      chloex("Target not found or not loaded.")
    end
  end,
}
r74_0:[r78_0](r78_0)
r78_0 = "AddSection"
r78_0 = "Location"
r76_0 = r23_0.Tele:[r78_0](r78_0)
local r79_0 = "AddDropdown"
r79_0 = {
  Title = "Select Location",
  Options = locationNames,
  Default = locationNames[1],
  Callback = function(r0_286)
    -- line: [0, 0] id: 286
    r9_0.teleportTarget = r0_286
  end,
}
r76_0:[r79_0](r79_0)
r79_0 = "AddButton"
r79_0 = {
  Title = "Teleport to Location",
  Content = "Teleport to selected location",
  Callback = function()
    -- line: [0, 0] id: 175
    local r0_175 = r9_0.teleportTarget
    if not r0_175 then
      chloex("Please select a location first!")
      return 
    end
    local r1_175 = r18_0[r0_175]
    if r1_175 then
      local r2_175 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
      if r2_175 then
        r2_175.CFrame = CFrame.new(r1_175 + Vector3.new(0, 3, 0))
        chloex("Teleported to " .. r0_175)
      end
    end
  end,
}
r76_0:[r79_0](r79_0)
r79_0 = "AddSection"
r79_0 = "Miscellaneous"
r77_0 = r23_0.Misc:[r79_0](r79_0)
local r80_0 = "AddToggle"
r80_0 = {
  Title = "Anti Staff",
  Content = "Auto kick if staff/developer joins the server.",
  Default = false,
  Callback = function(r0_252)
    -- line: [0, 0] id: 252
    _G.AntiStaff = r0_252
    if r0_252 then
      local r1_252 = 35102746
      local r2_252 = {
        [2] = "OG",
        [3] = "Tester",
        [4] = "Moderator",
        [75] = "Community Staff",
        [79] = "Analytics",
        [145] = "Divers / Artist",
        [250] = "Devs",
        [252] = "Partner",
        [254] = "Talon",
        [255] = "Wildes",
        [55] = "Swimmer",
        [30] = "Contrib",
        [35] = "Contrib 2",
        [100] = "Scuba",
        [76] = "CC",
      }
      task.spawn(function()
        -- line: [0, 0] id: 253
        while _G.AntiStaff do
          local r0_253 = ipairs
          for r3_253, r4_253 in r0_253(game:GetService("Players"):GetPlayers()) do
            if r4_253 ~= game.Players.LocalPlayer and r2_252[r4_253:GetRankInGroup(r1_252)] then
              game.Players.LocalPlayer:Kick("Chloe Detected Staff, Automatically Kicked!")
              return 
            end
          end
          task.wait(1)
        end
      end)
      -- close: r1_252
    end
  end,
}
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {
  Title = "Bypass Radar",
  Default = false,
  Callback = function(r0_145)
    -- line: [0, 0] id: 145
    pcall(function()
      -- line: [0, 0] id: 146
      r7_0.Functions.UpdateRadar:InvokeServer(r0_145)
    end)
  end,
}
r77_0:[r80_0](r80_0)
r80_0 = "AddSubSection"
r80_0 = "Hide Identifier"
r77_0:[r80_0](r80_0)
r78_0 = game:GetService("Players").LocalPlayer
r79_0 = false
r80_0 = nil
local r81_0 = nil
local r82_0 = nil
local r83_0 = nil
local r84_0 = nil
local r85_0 = nil
local r86_0 = nil
local function r87_0()
  -- line: [0, 0] id: 4
  local r1_4 = (r78_0.Character or r78_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
  if not r1_4 then
    return nil
  end
  repeat
    task.wait()
  until r1_4:FindFirstChild("Overhead")
  return r1_4:WaitForChild("Overhead", 5)
end
local function r88_0()
  -- line: [0, 0] id: 259
  local r0_259 = r87_0()
  if not r0_259 then
    warn("[HideIdent] Overhead not found.")
    return 
  end
  local r1_259 = r0_259:FindFirstChild("TitleContainer") and r0_259.TitleContainer:FindFirstChild("Label")
  local r2_259 = r0_259:FindFirstChild("Content") and r0_259.Content:FindFirstChild("Header")
  local r3_259 = r0_259:FindFirstChild("LevelContainer") and r0_259.LevelContainer:FindFirstChild("Label")
  local r4_259 = r1_259 and r1_259:FindFirstChildOfClass("UIGradient")
  if not r1_259 or not r2_259 or not r3_259 then
    warn("[HideIdent] Missing UI components in Overhead.")
    return 
  end
  if not r4_259 then
    r4_259 = Instance.new("UIGradient", r1_259)
  end
  _G.hideident = {
    overhead = r0_259,
    titleLabel = r1_259,
    gradient = r4_259,
    header = r2_259,
    levelLabel = r3_259,
  }
  r82_0 = r1_259.Text
  r83_0 = r2_259.Text
  r84_0 = r3_259.Text
  r85_0 = r4_259.Color
  r86_0 = r4_259.Rotation
  r80_0 = r80_0 or r83_0
  r81_0 = r81_0 or r84_0
end
local function r89_0()
  -- line: [0, 0] id: 249
  local r0_249 = _G.hideident
  if not r0_249 or not r0_249.overhead or not r0_249.titleLabel then
    return 
  end
  r0_249.overhead.TitleContainer.Visible = true
  r0_249.titleLabel.Text = "discord.gg/chloex"
  r0_249.gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(145, 186, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 243, 255))
  })
  r0_249.gradient.Rotation = 0
  local r1_249 = r0_249.header
  local r2_249 = r80_0
  if r2_249 ~= "" then
    r2_249 = r80_0 or "Chloe Rawr"
  else
    goto label_62	-- block#6 is visited secondly
  end
  r1_249.Text = r2_249
  r1_249 = r0_249.levelLabel
  r2_249 = r81_0
  if r2_249 ~= "" then
    r2_249 = r81_0 or ".gg/chloex"
  else
    goto label_71	-- block#9 is visited secondly
  end
  r1_249.Text = r2_249
end
r88_0()
local r92_0 = "Connect"
function r92_0()
  -- line: [0, 0] id: 287
  task.wait(2)
  r88_0()
  if r79_0 then
    task.spawn(function()
      -- line: [0, 0] id: 288
      while r79_0 do
        r89_0()
        task.wait(1)
      end
    end)
  end
end
r78_0.CharacterAdded:[r92_0](r92_0)
r92_0 = "AddInput"
r92_0 = {
  Title = "Name Changer",
  Placeholder = "Enter header text...",
}
r92_0.Default = r83_0 or ""
function r92_0.Callback(r0_36)
  -- line: [0, 0] id: 36
  r80_0 = r0_36
  SaveConfig()
end
r77_0:[r92_0](r92_0)
r92_0 = "AddInput"
r92_0 = {
  Title = "Lvl Changer",
  Placeholder = "Enter level text...",
}
r92_0.Default = r84_0 or ""
function r92_0.Callback(r0_59)
  -- line: [0, 0] id: 59
  r81_0 = r0_59
  SaveConfig()
end
r77_0:[r92_0](r92_0)
r92_0 = "AddToggle"
r92_0 = {
  Title = "Start Hide Identifier",
  Default = false,
  Callback = function(r0_209)
    -- line: [0, 0] id: 209
    r79_0 = r0_209
    if r0_209 then
      task.spawn(function()
        -- line: [0, 0] id: 210
        while r79_0 do
          local r0_210, r1_210 = pcall(r89_0)
          if not r0_210 then
            warn("[HideIdent] Error:", r1_210)
          end
          task.wait(1)
        end
      end)
    else
      local r1_209 = _G.hideident
      if not r1_209 or not r1_209.overhead then
        return 
      end
      r1_209.overhead.TitleContainer.Visible = false
      r1_209.titleLabel.Text = r82_0
      r1_209.header.Text = r83_0
      r1_209.levelLabel.Text = r84_0
      r1_209.gradient.Color = r85_0
      r1_209.gradient.Rotation = r86_0
    end
  end,
}
r77_0:[r92_0](r92_0)
-- close: r78_0
r80_0 = "AddSubSection"
r80_0 = "Classic Event"
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Auto Claim Event"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_310)
  -- line: [0, 0] id: 310
  r9_0.autoSmartClaim = r0_310
  if r0_310 then
    task.spawn(function()
      -- line: [0, 0] id: 311
      local r0_311 = game:GetService("Players").LocalPlayer.PlayerGui.EventUI.Frame.Body.Main.Track.Frame
      while r9_0.autoSmartClaim do
        local r1_311 = true
        for r5_311 = 1, 15, 1 do
          local r6_311 = r0_311[tostring(r5_311)]
          if r6_311 then
            local r7_311 = r6_311.Inside
            local r9_311 = r7_311.Claim.Visible
            local r10_311 = r7_311.Cost.Visible
            if not r7_311.Claimed.Visible then
              r1_311 = false
              if r9_311 then
                pcall(function()
                  -- line: [0, 0] id: 312
                  r7_0.Events.REEvReward:FireServer(r5_311)
                end)
                task.wait(0.3)
                -- close: r2_311
                break
              else
                if r10_311 then
                end
                -- close: r5_311
              end
            end
          else
            goto label_53	-- block#9 is visited secondly
          end
        end
        if r1_311 then
          r9_0.autoSmartClaim = false
          break
        else
          task.wait(0.5)
        end
      end
    end)
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddSubSection"
r80_0 = "Boost Player"
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Disable VFX"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_334)
  -- line: [0, 0] id: 334
  local r1_334 = r6_0.VFX
  if r0_334 then
    r1_334._oldHandle = r1_334._oldHandle or r1_334.Handle
    r1_334._oldRenderAtPoint = r1_334._oldRenderAtPoint or r1_334.RenderAtPoint
    r1_334._oldRenderInstance = r1_334._oldRenderInstance or r1_334.RenderInstance
    function r1_334.Handle()
      -- line: [0, 0] id: 335
    end
    function r1_334.RenderAtPoint()
      -- line: [0, 0] id: 336
    end
    function r1_334.RenderInstance()
      -- line: [0, 0] id: 337
    end
  elseif r1_334._oldHandle then
    r1_334.Handle = r1_334._oldHandle
    r1_334.RenderAtPoint = r1_334._oldRenderAtPoint
    r1_334.RenderInstance = r1_334._oldRenderInstance
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Disable Cutscene"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = true
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_20)
  -- line: [0, 0] id: 20
  local r1_20 = require(r0_0.RS.Controllers.CutsceneController)
  if r0_20 then
    if not r1_20._origPlay then
      r1_20._origPlay = r1_20.Play
      r1_20._origStop = r1_20.Stop
    end
    function r1_20.Play()
      -- line: [0, 0] id: 21
    end
    function r1_20.Stop()
      -- line: [0, 0] id: 23
    end
    local r2_20 = r6_0.Net["RE/ReplicateCutscene"]
    if r2_20 then
      r2_20.OnClientEvent:Connect(function()
        -- line: [0, 0] id: 22
      end)
    end
    local r3_20 = r6_0.Net["RE/StopCutscene"]
    if r3_20 then
      r3_20.OnClientEvent:Connect(function()
        -- line: [0, 0] id: 24
      end)
    end
    local r4_20 = r0_0.RS.Controllers.CutsceneController:FindFirstChild("Cutscenes") or r0_0.RS.Controllers:FindFirstChild("CutsceneController") and r0_0.RS.Controllers.CutsceneController.Cutscenes
    if r4_20 then
      for r8_20, r9_20 in ipairs(r4_20:GetChildren()) do
        if r9_20:IsA("ModuleScript") then
          r9_20.Disabled = true
        end
      end
    end
  else
    if r1_20._origPlay then
      r1_20.Play = r1_20._origPlay
      r1_20.Stop = r1_20._origStop
    end
    warn("[CELESTIAL] Cutscene restored")
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Disable Obtained Fish"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_206)
  -- line: [0, 0] id: 206
  local r2_206 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Small Notification")
  if r2_206 and r2_206:FindFirstChild("Display") then
    r2_206.Display.Visible = not r0_206
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Disable Notification"
r80_0[r81_0] = r82_0
r81_0 = "Content"
r82_0 = "Disable All Notification! Fish/Admin Annoucement/Event Spawned!"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_10)
  -- line: [0, 0] id: 10
  r9_0.disableNotifs = r0_10
  if r0_10 then
    r19_0()
  else
    r20_0()
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Delete Fishing Effects"
r80_0[r81_0] = r82_0
r81_0 = "Content"
r82_0 = "This Feature irivisible! delete any effect on rod"
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_173)
  -- line: [0, 0] id: 173
  r9_0.DelEffects = r0_173
  if r0_173 then
    task.spawn(function()
      -- line: [0, 0] id: 174
      while r9_0.DelEffects do
        local r0_174 = workspace:FindFirstChild("CosmeticFolder")
        if r0_174 then
          r0_174:Destroy()
        end
        task.wait(60)
      end
    end)
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r80_0 = "AddToggle"
r80_0 = {}
r81_0 = "Title"
r82_0 = "Hide Rod On Hand"
r80_0[r81_0] = r82_0
r81_0 = "Content"
r82_0 = "This feature irivisible! and hide other player too."
r80_0[r81_0] = r82_0
r81_0 = "Default"
r82_0 = false
r80_0[r81_0] = r82_0
r81_0 = "Callback"
function r82_0(r0_289)
  -- line: [0, 0] id: 289
  r9_0.IrRod = r0_289
  if r0_289 then
    task.spawn(function()
      -- line: [0, 0] id: 290
      while r9_0.IrRod do
        local r0_290 = ipairs
        for r3_290, r4_290 in r0_290(workspace.Characters:GetChildren()) do
          local r5_290 = r4_290:FindFirstChild("!!!EQUIPPED_TOOL!!!")
          if r5_290 then
            r5_290:Destroy()
          end
        end
        task.wait(1)
      end
    end)
  end
end
r80_0[r81_0] = r82_0
r77_0:[r80_0](r80_0)
r78_0 = _G
r79_0 = "WebhookFlags"
r80_0 = {}
r81_0 = "FishCaught"
r82_0 = {}
r83_0 = "Enabled"
r84_0 = false
r82_0[r83_0] = r84_0
r83_0 = "URL"
r84_0 = "https://discord.com/api/webhooks/1432777124607164418/0aGoA5XSsDCpO82T0bR8UYt1vFDv74qXst6AJQLcl-RSN-ujAp4GmIV7QIzrM3yfoGVV"
r82_0[r83_0] = r84_0
r80_0[r81_0] = r82_0
r81_0 = "Stats"
r82_0 = {}
r83_0 = "Enabled"
r84_0 = false
r82_0[r83_0] = r84_0
r83_0 = "URL"
r84_0 = ""
r82_0[r83_0] = r84_0
r83_0 = 5
r82_0.Delay = r83_0
r80_0[r81_0] = r82_0
r81_0 = "Disconnect"
r82_0 = {}
r83_0 = "Enabled"
r84_0 = false
r82_0[r83_0] = r84_0
r83_0 = "URL"
r84_0 = "https://discord.com/api/webhooks/1428340333510398013/1L4UNrQmJXLgiNjO8PvZVc2TSxX60Xvg8BFpGyz8VANNL95DRfwKBPzyx9-mgZYLKw6_"
r82_0[r83_0] = r84_0
r80_0[r81_0] = r82_0
r78_0[r79_0] = r80_0
r78_0 = _G
r79_0 = "WebhookURLs"
r80_0 = _G
r81_0 = "WebhookURLs"
r80_0 = r80_0[r81_0] or {}
r78_0[r79_0] = r80_0
r78_0 = {}
function r79_0()
  -- line: [0, 0] id: 65
  local r0_65 = r8_0.Items
  if not r0_65 then
    return 
  end
  for r4_65, r5_65 in ipairs(r0_65:GetChildren()) do
    local r6_65, r7_65 = pcall(require, r5_65)
    if r6_65 and type(r7_65) == "table" and r7_65.Data and r7_65.Data.Type == "Fish" then
      local r8_65 = r7_65.Data
      if r8_65.Id and r8_65.Name then
        r78_0[r8_65.Id] = {
          Name = r8_65.Name,
          Tier = r8_65.Tier,
          Icon = r8_65.Icon,
          SellPrice = r7_65.SellPrice,
        }
      end
    end
  end
end
buildFishDatabase = r79_0
function r79_0(r0_56)
  -- line: [0, 0] id: 56
  local r1_56 = r0_56:match("rbxassetid://(%d+)")
  if not r1_56 then
    return nil
  end
  local r2_56 = string.format("https://thumbnails.roblox.com/v1/assets?assetIds=%s&type=Asset&size=420x420&format=Png", r1_56)
  local r3_56, r4_56 = pcall(function()
    -- line: [0, 0] id: 57
    return r0_0.HttpService:JSONDecode(game:HttpGet(r2_56))
  end)
  return r3_56 and r4_56 and r4_56.data and r4_56.data[1] and r4_56.data[1].imageUrl
end
getThumbnailURL = r79_0
function r79_0(r0_116, r1_116)
  -- line: [0, 0] id: 116
  if not _G.httpRequest or not r0_116 or r0_116 == "" then
    return 
  end
  if _G._WebhookLock and _G._WebhookLock[r0_116] then
    return 
  end
  _G._WebhookLock = _G._WebhookLock or {}
  _G._WebhookLock[r0_116] = true
  task.delay(0.25, function()
    -- line: [0, 0] id: 117
    _G._WebhookLock[r0_116] = nil
  end)
  pcall(function()
    -- line: [0, 0] id: 118
    _G.httpRequest({
      Url = r0_116,
      Method = "POST",
      Headers = {
        ["Content-Type"] = "application/json",
      },
      Body = r0_0.HttpService:JSONEncode(r1_116),
    })
  end)
end
sendWebhook = r79_0
function r79_0(r0_313)
  -- line: [0, 0] id: 313
  if not _G.WebhookFlags.FishCaught.Enabled then
    return 
  end
  local r1_313 = _G.WebhookFlags.FishCaught.URL
  if not r1_313 or not r1_313:match("discord.com/api/webhooks") then
    return 
  end
  local r2_313 = r78_0[r0_313.Id]
  if not r2_313 then
    return 
  end
  local r3_313 = _G.TierFish
  if r3_313 then
    r3_313 = _G.TierFish[r2_313.Tier] or "Unknown"
  else
    goto label_35	-- block#9 is visited secondly
  end
  if _G.WebhookRarities and 0 < #_G.WebhookRarities and not table.find(_G.WebhookRarities, r3_313) then
    return 
  end
  if _G.WebhookNames and 0 < #_G.WebhookNames and not table.find(_G.WebhookNames, r2_313.Name) then
    return 
  end
  local r4_313 = r0_313.Metadata
  if r4_313 then
    r4_313 = r0_313.Metadata.Weight and (string.format("%.2f Kg", r0_313.Metadata.Weight) or "N/A")
  else
    goto label_87	-- block#21 is visited secondly
  end
  local r5_313 = r0_313.Metadata
  if r5_313 then
    r5_313 = r0_313.Metadata.VariantId and (tostring(r0_313.Metadata.VariantId) or "None")
  else
    goto label_101	-- block#25 is visited secondly
  end
  local r6_313 = r2_313.SellPrice
  if r6_313 then
    r6_313 = "$" .. string.format("%d", r2_313.SellPrice):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "N/A"
  else
    goto label_126	-- block#28 is visited secondly
  end
  local r7_313 = {
    content = DISCORD_ID2,
  }
  local r8_313 = {}
  local r9_313 = {
    title = "Chloe X Webhook | Fish Caught",
    url = "https://discord.gg/PaPvGUE8UC",
  }
  local r10_313 = string.format
  local r11_313 = "Congratulations!! **%s** You have obtained a new **%s** fish!"
  local r12_313 = _G.WebhookCustomName
  if r12_313 ~= "" then
    r12_313 = _G.WebhookCustomName or game.Players.LocalPlayer.Name
  else
    goto label_145	-- block#31 is visited secondly
  end
  r9_313.description = r10_313(r11_313, r12_313, r3_313)
  r9_313.color = 52221
  r9_313.fields = {
    {
      name = "〢Fish Name :",
      value = "```❯ " .. r2_313.Name .. "```",
    },
    {
      name = "〢Fish Tier :",
      value = "```❯ " .. r3_313 .. "```",
    },
    {
      name = "〢Weight :",
      value = "```❯ " .. r4_313 .. "```",
    },
    {
      name = "〢Mutation :",
      value = "```❯ " .. r5_313 .. "```",
    },
    {
      name = "〢Sell Price :",
      value = "```❯ " .. r6_313 .. "```",
    }
  }
  r10_313 = {}
  r10_313.url = getThumbnailURL(r2_313.Icon) or "https://i.imgur.com/WltO8IG.png"
  r9_313.image = r10_313
  r9_313.footer = {
    text = "Chloe X Webhook",
    icon_url = "https://i.imgur.com/WltO8IG.png",
  }
  r9_313.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
  -- setlist for #8 failed
  r7_313.embeds = r8_313
  r7_313.username = "Chloe X Notification!"
  r7_313.avatar_url = "https://i.imgur.com/9afHGRy.jpeg"
  sendWebhook(r1_313, r7_313)
end
sendNewFishWebhook = r79_0
r79_0 = buildFishDatabase
r79_0()
r79_0 = {}
r80_0 = pairs
r81_0 = r78_0
for r83_0, r84_0 in r80_0(r81_0) do
  r85_0 = table
  r85_0 = r85_0.insert
  r86_0 = r79_0
  r87_0 = r84_0.Name
  r85_0(r86_0, r87_0)
end
r80_0 = table
r80_0 = r80_0.sort
r81_0 = r79_0
r80_0(r81_0)
r80_0 = task
r81_0 = "spawn"
r80_0 = r80_0[r81_0]
function r81_0()
  -- line: [0, 0] id: 60
  repeat
    REObtainedNewFishNotification = r6_0.Net["RE/ObtainedNewFishNotification"]
    task.wait(1)
  until REObtainedNewFishNotification
  if not _G.FishWebhookConnected then
    _G.FishWebhookConnected = true
    REObtainedNewFishNotification.OnClientEvent:Connect(function(r0_61, r1_61)
      -- line: [0, 0] id: 61
      if r9_0.autoWebhook then
        local r2_61 = {
          Id = r0_61,
        }
        local r3_61 = {
          Weight = r1_61 and r1_61.Weight,
          VariantId = r1_61 and r1_61.VariantId,
        }
        r2_61.Metadata = r3_61
        sendNewFishWebhook(r2_61)
      end
    end)
  end
end
r80_0(r81_0)
r80_0 = "Webhook"
r80_0 = r23_0[r80_0]
r82_0 = "AddSection"
r82_0 = "Webhook Fish Caught"
r80_0 = r80_0:[r82_0](r82_0)
webhook = r80_0
r80_0 = webhook
r82_0 = "AddInput"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Input Discord ID"
r82_0[r83_0] = r84_0
r83_0 = "Default"
r84_0 = ""
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_48)
  -- line: [0, 0] id: 48
  if r0_48 and r0_48 ~= "" then
    DISCORD_ID2 = "<@" .. r0_48:gsub("%D", "") .. ">"
  else
    DISCORD_ID2 = ""
  end
  SaveConfig()
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddInput"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Webhook URL"
r82_0[r83_0] = r84_0
r83_0 = "Default"
r84_0 = ""
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_69)
  -- line: [0, 0] id: 69
  _G.WebhookURLs = _G.WebhookURLs or {}
  _G.WebhookURLs.FishCaught = r0_69
  if _G.WebhookFlags and _G.WebhookFlags.FishCaught then
    _G.WebhookFlags.FishCaught.URL = r0_69
  end
  if r0_69 and r0_69:match("discord.com/api/webhooks") then
    SaveConfig()
  end
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddDropdown"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Tier Filter"
r82_0[r83_0] = r84_0
r83_0 = "Multi"
r84_0 = true
r82_0[r83_0] = r84_0
r83_0 = "Options"
r84_0 = {}
r85_0 = "Common"
r86_0 = "Uncommon"
r87_0 = "Rare"
r88_0 = "Epic"
r89_0 = "Legendary"
local r90_0 = "Mythic"
local r91_0 = "Secret"
-- setlist for #84 failed
r82_0[r83_0] = r84_0
r83_0 = "Default"
r84_0 = {}
r85_0 = "Mythic"
r86_0 = "Secret"
-- setlist for #84 failed
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_295)
  -- line: [0, 0] id: 295
  _G.WebhookRarities = r0_295
  SaveConfig()
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddDropdown"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Name Filter"
r82_0[r83_0] = r84_0
r83_0 = "Multi"
r84_0 = true
r82_0[r83_0] = r84_0
r83_0 = "Options"
r82_0[r83_0] = r79_0
r83_0 = "Default"
r84_0 = {}
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_11)
  -- line: [0, 0] id: 11
  _G.WebhookNames = r0_11
  SaveConfig()
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddInput"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Hide Identity"
r82_0[r83_0] = r84_0
r83_0 = "Content"
r84_0 = "Protect your name for sending webhook to discord"
r82_0[r83_0] = r84_0
r83_0 = "Default"
r84_0 = _G
r85_0 = "WebhookCustomName"
r84_0 = r84_0[r85_0] or ""
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_301)
  -- line: [0, 0] id: 301
  _G.WebhookCustomName = r0_301
  SaveConfig()
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddToggle"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Send Fish Webhook"
r82_0[r83_0] = r84_0
r83_0 = "Default"
r84_0 = _G
r85_0 = "WebhookFlags"
r84_0 = r84_0[r85_0]
r85_0 = "FishCaught"
r84_0 = r84_0[r85_0]
r85_0 = "Enabled"
r84_0 = r84_0[r85_0]
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0(r0_248)
  -- line: [0, 0] id: 248
  _G.WebhookFlags.FishCaught.Enabled = r0_248
  r9_0.autoWebhook = r0_248
  SaveConfig()
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = webhook
r82_0 = "AddButton"
r82_0 = {}
r83_0 = "Title"
r84_0 = "Test Webhook Connection"
r82_0[r83_0] = r84_0
r83_0 = "Callback"
function r84_0()
  -- line: [0, 0] id: 232
  local r0_232 = _G.WebhookFlags.FishCaught.URL
  if not r0_232 or not r0_232:match("discord.com/api/webhooks") then
    warn("[Webhook Test] ❌ Invalid or missing webhook URL.")
    return 
  end
  local r1_232 = {
    content = nil,
    embeds = {
      {
        color = 44543,
        author = {
          name = "Ding dongggg! Webhook is connected :3",
        },
        image = {
          url = "https://media.tenor.com/KJDqZ0H6Gb4AAAAC/gawr-gura-gura.gif",
        },
      }
    },
    username = "Chloe X Notification!",
    avatar_url = "https://i.imgur.com/9afHGRy.jpeg",
    attachments = {},
  }
  task.spawn(function()
    -- line: [0, 0] id: 233
    local r0_233, r1_233 = pcall(function()
      -- line: [0, 0] id: 234
      return _G.httpRequest({
        Url = r0_232,
        Method = "POST",
        Headers = {
          ["Content-Type"] = "application/json",
        },
        Body = r0_0.HttpService:JSONEncode(r1_232),
      })
    end)
    if r0_233 then
      chloex("Successfully sent test message!")
    else
      chloex("Failed to send webhook:", r1_233)
    end
  end)
end
r82_0[r83_0] = r84_0
r80_0:[r82_0](r82_0)
r80_0 = "Webhook"
r80_0 = r23_0[r80_0]
r82_0 = "AddSection"
r82_0 = "Webhook Statistic Player"
r80_0 = r80_0:[r82_0](r82_0)
r83_0 = "AddInput"
r83_0 = {}
r84_0 = "Title"
r85_0 = "Statistic Webhook URL"
r83_0[r84_0] = r85_0
r84_0 = "Default"
r85_0 = _G
r86_0 = "WebhookFlags"
r85_0 = r85_0[r86_0]
r86_0 = "Stats"
r85_0 = r85_0[r86_0]
r86_0 = "URL"
r85_0 = r85_0[r86_0]
r83_0[r84_0] = r85_0
r84_0 = "Placeholder"
r85_0 = "Paste your stats webhook here..."
r83_0[r84_0] = r85_0
r84_0 = "Callback"
function r85_0(r0_228)
  -- line: [0, 0] id: 228
  if r0_228 and r0_228:match("discord.com/api/webhooks") then
    _G.WebhookFlags.Stats.URL = r0_228
    SaveConfig()
  end
end
r83_0[r84_0] = r85_0
r80_0:[r83_0](r83_0)
r83_0 = "AddInput"
r83_0 = {}
r84_0 = "Title"
r85_0 = "Delay (Minutes)"
r83_0[r84_0] = r85_0
r84_0 = "Default"
r85_0 = tostring
r86_0 = _G
r87_0 = "WebhookFlags"
r86_0 = r86_0[r87_0]
r87_0 = "Stats"
r86_0 = r86_0[r87_0]
r86_0 = r86_0.Delay
r85_0 = r85_0(r86_0)
r83_0[r84_0] = r85_0
r84_0 = "Placeholder"
r85_0 = "Delay between data sends..."
r83_0[r84_0] = r85_0
r84_0 = "Numeric"
r85_0 = true
r83_0[r84_0] = r85_0
r84_0 = "Callback"
function r85_0(r0_211)
  -- line: [0, 0] id: 211
  local r1_211 = tonumber(r0_211)
  if r1_211 and 1 <= r1_211 then
    _G.WebhookFlags.Stats.Delay = r1_211
    SaveConfig()
  end
end
r83_0[r84_0] = r85_0
r80_0:[r83_0](r83_0)
r83_0 = "AddToggle"
r83_0 = {}
r84_0 = "Title"
r85_0 = "Send Webhook Statistic"
r83_0[r84_0] = r85_0
r84_0 = "Content"
r85_0 = "Automatically send player stats, inventory, utility, and quest info to Discord."
r83_0[r84_0] = r85_0
r84_0 = "Default"
r85_0 = _G
r86_0 = "WebhookFlags"
r85_0 = r85_0[r86_0]
r86_0 = "Stats"
r85_0 = r85_0[r86_0]
r86_0 = "Enabled"
r85_0 = r85_0[r86_0] or false
r83_0[r84_0] = r85_0
r84_0 = "Callback"
function r85_0(r0_148)
  -- line: [0, 0] id: 148
  r9_0.autoWebhookStats = r0_148
  _G.WebhookFlags.Stats.Enabled = r0_148
  SaveConfig()
  if not r0_148 then
    return 
  end
  task.spawn(function()
    -- line: [0, 0] id: 149
    local r0_149 = r0_0.RS
    local r1_149 = r0_0.HttpService
    local r2_149 = r8_0.Data
    local r3_149 = r0_149:WaitForChild("Items")
    local r4_149 = r0_149:WaitForChild("Baits")
    local r5_149 = r0_149:WaitForChild("Totems")
    local r6_149 = {}
    local r7_149 = {}
    r7_149.Fish = {
      folders = {
        r3_149
      },
      expectType = "Fish",
    }
    r7_149["Fishing Rods"] = {
      folders = {
        r3_149
      },
      expectType = "Fishing Rods",
    }
    r7_149.Baits = {
      folders = {
        r4_149
      },
      expectType = "Baits",
    }
    r7_149.Totems = {
      folders = {
        r5_149
      },
      expectType = "Totems",
    }
    r7_149.Items = {
      folders = {
        r3_149
      },
      expectType = nil,
    }
    local function r8_149(r0_156)
      -- line: [0, 0] id: 156
      local r1_156, r2_156 = pcall(require, r0_156)
      if r1_156 and type(r2_156) == "table" and r2_156.Data then
        return r2_156
      end
    end
    local function r9_149(r0_157, r1_157)
      -- line: [0, 0] id: 157
      local r2_157 = (r1_157.expectType or "ANY") .. ":" .. tostring(r0_157)
      if r6_149[r2_157] ~= nil then
        return r6_149[r2_157]
      end
      for r6_157, r7_157 in ipairs(r1_157.folders) do
        for r11_157, r12_157 in ipairs(r7_157:GetDescendants()) do
          if r12_157:IsA("ModuleScript") then
            local r13_157 = r8_149(r12_157)
            if r13_157 and r13_157.Data and r13_157.Data.Id == r0_157 and (not r1_157.expectType or r13_157.Data.Type == r1_157.expectType) then
              r6_149[r2_157] = r13_157
              return r13_157
              r13_157 = r12_157.GetAttribute and r12_157:GetAttribute("Id")
              if r13_157 == r0_157 then
                local r14_157 = r12_157.GetAttribute and r12_157:GetAttribute("Type")
                if not r1_157.expectType or r14_157 == r1_157.expectType then
                  local r15_157 = {
                    Data = {
                      Id = r13_157,
                      Type = r14_157,
                      Name = r12_157:GetAttribute("Name"),
                      Tier = r12_157:GetAttribute("Rarity"),
                    },
                  }
                  r6_149[r2_157] = r15_157
                  return r15_157
                end
              end
            end
          else
            goto label_53	-- block#13 is visited secondly
          end
        end
      end
      r6_149[r2_157] = false
      return nil
    end
    local function r10_149(r0_159)
      -- line: [0, 0] id: 159
      if r0_159 >= 1000000000 then
        return string.format("%.1fB", r0_159 / 1000000000)
      end
      if r0_159 >= 1000000 then
        return string.format("%.1fM", r0_159 / 1000000)
      end
      if r0_159 >= 1000 then
        return string.format("%.1fk", r0_159 / 1000)
      end
      return tostring(r0_159)
    end
    local function r11_149(r0_151)
      -- line: [0, 0] id: 151
      local r1_151 = r0_151 and r0_151.Data and r0_151.Data.Tier
      local r2_151 = _G.TierFish[r1_151]
      if not r2_151 then
        if r1_151 then
          r2_151 = tostring(r1_151) or "Unknown"
        else
          goto label_19	-- block#6 is visited secondly
        end
      end
      return r2_151
    end
    local function r12_149(r0_152, r1_152, r2_152)
      -- line: [0, 0] id: 152
      local r3_152 = {}
      if typeof(r0_152) == "table" then
        for r7_152, r8_152 in ipairs(r0_152) do
          local r9_152 = r9_149
          local r10_152 = r8_152.Id
          r9_152 = r9_152(r10_152, r7_149[r1_152] or r7_149.Items)
          if r9_152 then
            r10_152 = r9_152.Data and (r9_152.Data.Name or "Unknown")
          else
            goto label_28	-- block#7 is visited secondly
          end
          local r11_152 = r3_152[r10_152] or 0
          r3_152[r10_152] = r11_152 + (r8_152.Amount or 1)
        end
      end
      local r4_152 = {}
      local r5_152 = 1
      for r9_152, r10_152 in pairs(r3_152) do
        if r2_152 then
          table.insert(r4_152, string.format("%d. %s | x%s", r5_152, r9_152, r10_152))
        else
          table.insert(r4_152, string.format("%d. %s", r5_152, r9_152))
        end
        r5_152 = r5_152 + 1
      end
      return table.concat(r4_152, "\n")
    end
    local function r13_149()
      -- line: [0, 0] id: 158
      local r0_158 = {
        DeepSea = {},
        Element = {},
      }
      local r1_158 = workspace:FindFirstChild("!!! MENU RINGS")
      if not r1_158 then
        return r0_158
      end
      for r6_158, r7_158 in pairs({
        DeepSea = r1_158:FindFirstChild("Deep Sea Tracker"),
        Element = r1_158:FindFirstChild("Element Tracker"),
      }) do
        local r8_158 = r7_158 and r7_158:FindFirstChild("Board") and r7_158.Board:FindFirstChild("Gui")
        local r9_158 = r8_158 and r8_158:FindFirstChild("Content")
        if r9_158 then
          for r13_158, r14_158 in ipairs(r9_158:GetChildren()) do
            if r14_158:IsA("TextLabel") and r14_158.Name:match("Label") then
              table.insert(r0_158[r6_158], string.format("%d. %s", #r0_158[r6_158] + 1, r14_158.Text))
            end
          end
        end
      end
      return r0_158
    end
    local function r14_149()
      -- line: [0, 0] id: 150
      local r0_150 = r2_149:Get({
        "Statistics"
      }) or {}
      local r1_150 = {
        Coins = r2_149:Get({
          "Coins"
        }) or 0,
        FishCaught = r0_150.FishCaught or 0,
        XP = r2_149:Get({
          "XP"
        }) or 0,
      }
      return r1_150
    end
    local function r15_149(r0_153, r1_153)
      -- line: [0, 0] id: 153
      local r2_153 = _G.WebhookFlags
      if r2_153 then
        r2_153 = _G.WebhookFlags.Stats.URL or ""
      else
        goto label_10	-- block#2 is visited secondly
      end
      if r2_153 == "" then
        warn("[Webhook Stats] ❌ Please set your Webhook URL first!")
        return 
      end
      local r3_153 = game.Players.LocalPlayer
      local r4_153 = nil	-- notice: implicit variable refs by block#[67]
      if r3_153 then
        r4_153 = r3_153.Name
        if not r4_153 then
          ::label_25::
          r4_153 = "Unknown"
        end
      else
        goto label_25	-- block#7 is visited secondly
      end
      local r5_153 = r12_149(r1_153["Fishing Rods"], "Fishing Rods", false)
      local r6_153 = r12_149(r1_153.Baits, "Baits", false)
      local r7_153 = r12_149(r1_153.Totems, "Totems", true)
      local r8_153 = {}
      for r12_153, r13_153 in ipairs(r1_153.Items or {}) do
        if r13_153.Id == 10 then
          local r14_153 = r8_153["Enchant Stone"] or 0
          r8_153["Enchant Stone"] = r14_153 + (r13_153.Amount or 1)
        elseif r13_153.Id == 125 then
          local r14_153 = r8_153["Super Enchant Stone"] or 0
          r8_153["Super Enchant Stone"] = r14_153 + (r13_153.Amount or 1)
        elseif r13_153.Id == 246 then
          local r14_153 = r8_153["Transcended Stone"] or 0
          r8_153["Transcended Stone"] = r14_153 + (r13_153.Amount or 1)
        end
      end
      local r9_153 = {}
      local r10_153 = 1
      for r14_153, r15_153 in pairs(r8_153) do
        table.insert(r9_153, string.format("%d. %s | x%s", r10_153, r14_153, r15_153))
        r10_153 = r10_153 + 1
      end
      local r11_153 = next(r8_153)
      if r11_153 then
        r11_153 = table.concat(r9_153, "\n") or "(None)"
      else
        goto label_124	-- block#35 is visited secondly
      end
      local r12_153 = r13_149()
      local r13_153 = #r12_153.DeepSea
      if r13_153 > 0 then
        r13_153 = table.concat(r12_153.DeepSea, "\n") or "(No Deep Sea Quest Found)"
      else
        goto label_138	-- block#38 is visited secondly
      end
      local r14_153 = #r12_153.Element
      if r14_153 > 0 then
        r14_153 = table.concat(r12_153.Element, "\n") or "(No Element Quest Found)"
      else
        goto label_150	-- block#41 is visited secondly
      end
      local r15_153 = r1_153.Items or {}
      local r16_153 = {}
      for r20_153, r21_153 in ipairs(r15_153) do
        local r22_153 = r9_149(r21_153.Id, r7_149.Fish)
        if r22_153 and r22_153.Data and r22_153.Data.Type == "Fish" then
          local r23_153 = r11_149(r22_153)
          local r24_153 = r22_153.Data.Name or "Unknown"
          r16_153[r23_153] = r16_153[r23_153] or {}
          local r25_153 = r16_153[r23_153]
          local r26_153 = r16_153[r23_153][r24_153] or 0
          r25_153[r24_153] = r26_153 + (r21_153.Amount or 1)
        end
      end
      local r17_153 = {}
      for r21_153, r22_153 in ipairs({
        "Uncommon",
        "Common",
        "Rare",
        "Epic",
        "Legendary",
        "Mythic",
        "Secret"
      }) do
        local r23_153 = r16_153[r22_153]
        if r23_153 then
          table.insert(r17_153, string.format("〢**%s :**", r22_153))
          local r24_153 = 1
          local r25_153 = pairs
          local r26_153 = r23_153
          for r28_153, r29_153 in r25_153(r26_153) do
            table.insert(r17_153, string.format("%d. %s | x%s", r24_153, r28_153, r29_153))
            r24_153 = r24_153 + 1
          end
        end
      end
      local r18_153 = #r17_153
      if r18_153 > 0 then
        r18_153 = table.concat(r17_153, "\n") or "(No Fishes Found)"
      else
        goto label_257	-- block#66 is visited secondly
      end
      local r19_153 = {
        username = "Chloe X Notification!",
        avatar_url = "https://i.imgur.com/9afHGRy.jpeg",
      }
      local r20_153 = {}
      local r21_153 = {
        title = "〢Chloe X Webhook | Player Info",
        color = 52479,
      }
      r21_153.fields = {
        {
          name = "〢Player Data",
          value = string.format("**❯ NAME:** %s\n**❯ COINS:** $%s\n**❯ FISH CAUGHT:** %s", r4_153, r10_149(r0_153.Coins), r0_153.FishCaught),
        },
        {
          name = "〢Inventory",
          value = string.format("**Totems:**\n%s\n**Rods:**\n%s\n**Baits:**\n%s", r7_153, r5_153, r6_153),
        }
      }
      local r22_153 = {
        title = "Utility & Quest Data",
        color = 26367,
      }
      r22_153.fields = {
        {
          name = "〢Utility Data",
          value = string.format("**❯ Fishes:**\n%s\n**❯ Enchant Stones:**\n%s", r18_153, r11_153),
        },
        {
          name = "〢Quest Data",
          value = string.format("**❯ Deep Sea Quest:**\n%s\n**❯ Element Quest:**\n%s", r13_153, r14_153),
        }
      }
      local r23_153 = {}
      r23_153.text = string.format("Chloe X Auto Sync | Every %dm", _G.WebhookFlags.Stats.Delay or 5)
      r23_153.icon_url = "https://i.imgur.com/WltO8IG.png"
      r22_153.footer = r23_153
      r22_153.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
      -- setlist for #20 failed
      r19_153.embeds = r20_153
      task.spawn(function()
        -- line: [0, 0] id: 154
        pcall(function()
          -- line: [0, 0] id: 155
          _G.httpRequest({
            Url = r2_153,
            Method = "POST",
            Headers = {
              ["Content-Type"] = "application/json",
            },
            Body = r1_149:JSONEncode(r19_153),
          })
        end)
      end)
    end
    while r9_0.autoWebhookStats do
      local r16_149 = r14_149()
      r15_149(r16_149, r2_149:Get({
        "Inventory"
      }) or {})
      task.wait((_G.WebhookFlags.Stats.Delay or 5) * 60)
    end
  end)
end
r83_0[r84_0] = r85_0
r80_0:[r83_0](r83_0)
r81_0 = ""
r82_0 = false
r83_0 = false
function r84_0(r0_162)
  -- line: [0, 0] id: 162
  if not r82_0 then
    return 
  end
  local r1_162 = _G.WebhookURLs.Disconnect
  if not r1_162 then
    r1_162 = _G.WebhookFlags
    if r1_162 then
      r1_162 = _G.WebhookFlags.Disconnect.URL or ""
    else
      goto label_19	-- block#5 is visited secondly
    end
  end
  if r1_162 == "" or not r1_162:match("discord") then
    return 
  end
  local r2_162 = game.Players.LocalPlayer
  local r3_162 = "Unknown"
  if _G.DisconnectCustomName and _G.DisconnectCustomName ~= "" then
    r3_162 = _G.DisconnectCustomName
  elseif r2_162 and r2_162.Name then
    r3_162 = r2_162.Name
  end
  local r4_162 = os.date("*t")
  local r5_162 = r4_162.hour
  if r5_162 > 12 then
    r5_162 = r4_162.hour - 12 or r4_162.hour
  else
    goto label_60	-- block#17 is visited secondly
  end
  local r6_162 = r4_162.hour
  if r6_162 >= 12 then
    r6_162 = "PM" or "AM"
  else
    goto label_67	-- block#20 is visited secondly
  end
  local r7_162 = string.format("%02d/%02d/%04d %02d.%02d %s", r4_162.day, r4_162.month, r4_162.year, r5_162, r4_162.min, r6_162)
  local r8_162 = r81_0
  if r8_162 ~= "" then
    r8_162 = r81_0 or "Anonymous"
  else
    goto label_84	-- block#23 is visited secondly
  end
  local r9_162 = nil	-- notice: implicit variable refs by block#[28]
  if r0_162 and r0_162 ~= "" then
    r9_162 = r0_162
    if r9_162 then
      ::label_91::
      r9_162 = "Disconnected from server"
    end
  else
    goto label_91	-- block#27 is visited secondly
  end
  local r10_162 = {
    content = "Ding Dongg Ding Dongggg, Hello! " .. r8_162 .. " your account got disconnected from server!",
    embeds = {
      {
        title = "DETAIL ACCOUNT",
        color = 36863,
        fields = {
          {
            name = "〢Username :",
            value = "> " .. r3_162,
          },
          {
            name = "〢Time got disconnected :",
            value = "> " .. r7_162,
          },
          {
            name = "〢Reason :",
            value = "> " .. r9_162,
          }
        },
        thumbnail = {
          url = "https://media.tenor.com/rx88bhLtmyUAAAAC/gawr-gura.gif",
        },
      }
    },
    username = "Chloe X Notification!",
    avatar_url = "https://i.imgur.com/9afHGRy.jpeg",
  }
  task.spawn(function()
    -- line: [0, 0] id: 163
    pcall(function()
      -- line: [0, 0] id: 164
      _G.httpRequest({
        Url = r1_162,
        Method = "POST",
        Headers = {
          ["Content-Type"] = "application/json",
        },
        Body = r0_0.HttpService:JSONEncode(r10_162),
      })
    end)
  end)
end
SendDisconnectWebhook = r84_0
r84_0 = "Webhook"
r84_0 = r23_0[r84_0]
r86_0 = "AddSection"
r86_0 = "Webhook Alert"
r84_0 = r84_0:[r86_0](r86_0)
r87_0 = "AddInput"
r87_0 = {}
r88_0 = "Title"
r89_0 = "Disconnect Alert Webhook URL"
r87_0[r88_0] = r89_0
r88_0 = "Default"
r89_0 = ""
r87_0[r88_0] = r89_0
r88_0 = "Callback"
function r89_0(r0_55)
  -- line: [0, 0] id: 55
  _G.WebhookURLs = _G.WebhookURLs or {}
  _G.WebhookURLs.Disconnect = r0_55
  if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
    _G.WebhookFlags.Disconnect.URL = r0_55
  end
end
r87_0[r88_0] = r89_0
r84_0:[r87_0](r87_0)
r87_0 = "AddInput"
r87_0 = {}
r88_0 = "Title"
r89_0 = "Discord ID"
r87_0[r88_0] = r89_0
r88_0 = "Default"
r89_0 = ""
r87_0[r88_0] = r89_0
r88_0 = "Callback"
function r89_0(r0_275)
  -- line: [0, 0] id: 275
  if r0_275 and r0_275 ~= "" then
    r81_0 = "<@" .. r0_275:gsub("%D", "") .. ">"
  else
    r81_0 = ""
  end
  SaveConfig()
end
r87_0[r88_0] = r89_0
r84_0:[r87_0](r87_0)
r87_0 = "AddInput"
r87_0 = {}
r88_0 = "Title"
r89_0 = "Hide Identity"
r87_0[r88_0] = r89_0
r88_0 = "Placeholder"
r89_0 = "Enter custom name (leave blank for default)"
r87_0[r88_0] = r89_0
r88_0 = "Default"
r89_0 = _G
r89_0 = r89_0.DisconnectCustomName or ""
r87_0[r88_0] = r89_0
r88_0 = "Callback"
function r89_0(r0_35)
  -- line: [0, 0] id: 35
  _G.DisconnectCustomName = r0_35
  SaveConfig()
end
r87_0[r88_0] = r89_0
r84_0:[r87_0](r87_0)
r87_0 = "AddToggle"
r87_0 = {}
r88_0 = "Title"
r89_0 = "Send Webhook On Disconnect"
r87_0[r88_0] = r89_0
r88_0 = "Content"
r89_0 = "Notify your Discord when account disconnected and auto rejoin."
r87_0[r88_0] = r89_0
r88_0 = "Default"
r89_0 = _G
r89_0 = r89_0.WebhookFlags
r89_0 = r89_0.Disconnect
r89_0 = r89_0.Enabled or false
r87_0[r88_0] = r89_0
r88_0 = "Callback"
function r89_0(r0_37)
  -- line: [0, 0] id: 37
  if r0_37 and (not _G.DisconnectCustomName or _G.DisconnectCustomName == "") then
    chloex("Invalid! Input Hide Identity first.")
    if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
      _G.WebhookFlags.Disconnect.Enabled = false
    end
    r82_0 = false
    return 
  end
  r82_0 = r0_37
  if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
    _G.WebhookFlags.Disconnect.Enabled = r0_37
  end
  SaveConfig()
  if r0_37 then
    r83_0 = false
    local function r1_37(r0_40)
      -- line: [0, 0] id: 40
      if not r83_0 and r82_0 then
        r83_0 = true
        SendDisconnectWebhook(r0_40 or "Disconnected from server")
        task.wait(2)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
      end
    end
    r0_0.GuiService.ErrorMessageChanged:Connect(function(r0_38)
      -- line: [0, 0] id: 38
      if r0_38 and r0_38 ~= "" then
        r1_37(r0_38)
      end
    end)
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(r0_39)
      -- line: [0, 0] id: 39
      if r0_39.Name == "ErrorPrompt" then
        task.wait(1)
        local r1_39 = r0_39:FindFirstChildWhichIsA("TextLabel", true)
        local r2_39 = nil	-- notice: implicit variable refs by block#[4]
        if r1_39 then
          r2_39 = r1_39.Text
          if not r2_39 then
            ::label_16::
            r2_39 = "Disconnected"
          end
        else
          goto label_16	-- block#3 is visited secondly
        end
        r1_37(r2_39)
      end
    end)
    -- close: r1_37
  end
end
r87_0[r88_0] = r89_0
r84_0:[r87_0](r87_0)
r87_0 = "AddButton"
r87_0 = {}
r88_0 = "Title"
r89_0 = "Test Disconnected Player"
r87_0[r88_0] = r89_0
r88_0 = "Content"
r89_0 = "Kick yourself, send webhook, and auto rejoin."
r87_0[r88_0] = r89_0
r88_0 = "Callback"
function r89_0()
  -- line: [0, 0] id: 205
  chloex("Kicking player...")
  task.wait(1)
  SendDisconnectWebhook("Test Successfully :3")
  task.wait(2)
  game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end
r87_0[r88_0] = r89_0
r84_0:[r87_0](r87_0)
-- close: r0_0
