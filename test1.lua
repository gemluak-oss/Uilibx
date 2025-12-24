-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
if game.PlaceId ~= 121864768012064 then
  game:GetService("Players").LocalPlayer:Kick("MengHub only works on Fish It brahhhhh!")
  return 
end
local r1_0 = _G
local r2_0 = syn
if r2_0 then
  r2_0 = syn.request
  if not r2_0 then
    ::label_22::
    r2_0 = http
    if r2_0 then
      r2_0 = http.request
      if not r2_0 then
        ::label_29::
        r2_0 = http_request
        if not r2_0 then
          r2_0 = fluxus
          if r2_0 then
            r2_0 = fluxus.request or request
          else
            goto label_39	-- block#9 is visited secondly
          end
        end
      end
    else
      goto label_29	-- block#6 is visited secondly
    end
  end
else
  goto label_22	-- block#4 is visited secondly
end
r1_0.httpRequest = r2_0
r1_0 = game:GetService("Players")
r2_0 = game:GetService("RunService")
local r3_0 = game:GetService("ReplicatedStorage")
local r4_0 = game:GetService("HttpService")
local r5_0 = game:GetService("VirtualUser")
local r6_0 = r1_0.LocalPlayer
local r7_0 = r3_0:WaitForChild("Controllers")
local r8_0 = workspace.CurrentCamera
local r9_0 = game:GetService("Players").LocalPlayer.PlayerGui
local r10_0 = game:GetService("VirtualInputManager")
local r11_0 = game:GetService("TeleportService")
local r12_0 = game:GetService("UserInputService")
local r13_0 = game:GetService("GuiService")
local r14_0 = game:GetService("TweenService")
local r15_0 = game.PlaceId
local r16_0 = game.JobId
local r17_0 = game.PrivateServerId
local r18_0 = {
  MerchantRoot = r9_0.Merchant.Main.Background,
  ItemsFrame = r9_0.Merchant.Main.Background.Items.ScrollingFrame,
  RefreshMerchant = r9_0.Merchant.Main.Background.RefreshLabel,
}
local r20_0 = (function()
  -- line: [0, 0] id: 211
  local r0_211 = r3_0.Packages._Index["sleitnick_net@0.2.0"].net
  return {
    RE_FishCaught = r0_211:WaitForChild("RE/FishCaught"),
    RE_Fishing = r0_211:WaitForChild("RE/FishingCompleted"),
    RE_FishingStopped = r0_211:WaitForChild("RE/FishingStopped"),
    RF_Charge = r0_211:WaitForChild("RF/ChargeFishingRod"),
    RF_Minigame = r0_211:WaitForChild("RF/RequestFishingMinigameStarted"),
    RF_Cancel = r0_211:WaitForChild("RF/CancelFishingInputs"),
    RF_Sell = r0_211:WaitForChild("RF/SellAllItems"),
    RF_Weather = r0_211:WaitForChild("RF/PurchaseWeatherEvent"),
    RF_Radar = r0_211:WaitForChild("RF/UpdateFishingRadar"),
    RF_EquipDiving = r0_211:WaitForChild("RF/EquipOxygenTank"),
    RF_UnequipDiving = r0_211:WaitForChild("RF/UnequipOxygenTank"),
    RF_PurchaseRod = r0_211:WaitForChild("RF/PurchaseFishingRod"),
    RF_PurchaseBait = r0_211:WaitForChild("RF/PurchaseBait"),
    RF_PurchaseBoat = r0_211:WaitForChild("RF/PurchaseBoat"),
    RE_Cutscene = r0_211:WaitForChild("RE/ReplicateCutscene"),
    RE_StopCutscene = r0_211:WaitForChild("RE/StopCutscene"),
    RF_AutoFishing = r0_211:WaitForChild("RF/UpdateAutoFishingState"),
    RE_EquipItem = r0_211:WaitForChild("RE/EquipItem"),
    RE_Altar = r0_211:WaitForChild("RE/ActivateEnchantingAltar"),
    RE_Altar2 = r0_211:WaitForChild("RE/ActivateSecondEnchantingAltar"),
    RE_Equip = r0_211:WaitForChild("RE/EquipToolFromHotbar"),
    RE_Unequip = r0_211:WaitForChild("RE/UnequipToolFromHotbar"),
    RE_Favorite = r0_211:WaitForChild("RE/FavoriteItem"),
    RE_FavoriteChanged = r0_211:WaitForChild("RE/FavoriteStateChanged"),
    RE_ReplicateTextEffect = r0_211:WaitForChild("RE/ReplicateTextEffect"),
    RE_ObtainedNewFishNotification = r0_211:WaitForChild("RE/ObtainedNewFishNotification"),
    RE_FishingMinigameEvent = r0_211:WaitForChild("RE/FishingMinigameChanged"),
    RF_Trade = r0_211:WaitForChild("RF/InitiateTrade"),
    RE_Totem = r0_211:WaitForChild("RE/SpawnTotem"),
    RF_Potion = r0_211:WaitForChild("RF/ConsumePotion"),
  }
end)()
local r21_0 = require(r3_0.Packages.Replion)
local r22_0 = require(r3_0.Controllers.FishingController)
local r23_0 = require(r3_0.Controllers.ItemTradingController)
local r24_0 = require(r3_0.Shared.ItemUtility)
local r25_0 = require(r3_0.Shared.VendorUtility)
local r26_0 = require(r3_0.Shared.PlayerStatsUtility)
local r27_0 = require(r3_0.Modules.InputControl)
local r28_0 = r21_0.Client:WaitReplion("Data")
local r29_0 = r3_0:WaitForChild("Items")
local r30_0 = r24_0.GetItemDataFromItemType("Gears", "Diving Gear")
local r31_0 = {
  autoSellEnabled = false,
  lastSellTime = 0,
  sellMode = "Delay",
  sellDelay = 60,
  inputSellCount = 0,
}
local r32_0 = {
  selectedPlayerTrade = nil,
  selectedItem = nil,
}
r32_0.selectedTradeRarity = {}
r32_0.tradeAmount = 1
r32_0.targetCoins = 0
r32_0.trading = false
r32_0.awaiting = false
r32_0.lastResult = nil
r32_0.successCount = 0
r32_0.failCount = 0
r32_0.totalToTrade = 0
r32_0.sentCoins = 0
r32_0.successCoins = 0
r32_0.failCoins = 0
r32_0.totalReceived = 0
r32_0.currentGrouped = {}
r32_0.autoAccept = false
r31_0.Trade = r32_0
r32_0 = false
local r33_0 = {}
local r34_0 = false
local r35_0 = 0.2
local r36_0 = false
local r37_0 = 1.9
local r38_0 = 1.1
local r39_0 = false
local r40_0 = true
local r41_0 = 0.1
local r42_0 = 0
local r43_0 = nil
local r44_0 = nil
local function r45_0()
  -- line: [0, 0] id: 208
  return tonumber((game.Players.LocalPlayer.PlayerGui:WaitForChild("Inventory"):WaitForChild("Main"):WaitForChild("Top"):WaitForChild("Options"):WaitForChild("Fish"):WaitForChild("Label"):WaitForChild("BagSize").Text or "0/???"):match("(%d+)/")) or 0
end
local r46_0 = {}
r46_0["Chrome Rod"] = {
  Id = 7,
  Price = 43700,
}
r46_0["Lucky Rod"] = {
  Id = 4,
  Price = 15000,
}
r46_0["Magma Rod"] = {
  Id = 3,
  Price = 0,
}
r46_0["Starter Rod"] = {
  Id = 1,
  Price = 50,
}
r46_0["Steampunk Rod"] = {
  Id = 6,
  Price = 215000,
}
r46_0["Hyper Rod"] = {
  Id = 9,
  Price = 0,
}
r46_0["Gold Rod"] = {
  Id = 8,
  Price = 0,
}
r46_0["Lava Rod"] = {
  Id = 2,
  Price = 0,
}
r46_0["Carbon Rod"] = {
  Id = 76,
  Price = 750,
}
r46_0["Gingerbread Rod"] = {
  Id = 103,
  Price = 0,
}
r46_0["Ice Rod"] = {
  Id = 78,
  Price = 5000,
}
r46_0["Luck Rod"] = {
  Id = 79,
  Price = 325,
}
r46_0["Midnight Rod"] = {
  Id = 80,
  Price = 50000,
}
r46_0["Toy Rod"] = {
  Id = 84,
  Price = 0,
}
r46_0["Grass Rod"] = {
  Id = 85,
  Price = 1500,
}
r46_0["Candy Cane Rod"] = {
  Id = 100,
  Price = 0,
}
r46_0["Christmas Tree Rod"] = {
  Id = 101,
  Price = 0,
}
r46_0["Demascus Rod"] = {
  Id = 77,
  Price = 3000,
}
r46_0["Frozen Rod"] = {
  Id = 102,
  Price = 0,
}
r46_0["Cute Rod"] = {
  Id = 123,
  Price = 0,
}
r46_0["Angelic Rod"] = {
  Id = 124,
  Price = 75000,
}
r46_0["Astral Rod"] = {
  Id = 5,
  Price = 1000000,
}
r46_0["Ares Rod"] = {
  Id = 126,
  Price = 3000000,
}
r46_0["Ghoul Rod"] = {
  Id = 129,
  Price = 0,
}
r46_0["Angler Rod"] = {
  Id = 168,
  Price = 8000000,
}
r46_0["Ghostfinn Rod"] = {
  Id = 169,
  Price = 0,
}
r46_0["Element Rod"] = {
  Id = 257,
  Price = 0,
}
r46_0["Hazmat Rod"] = {
  Id = 256,
  Price = 0,
}
r46_0["Fluorescent Rod"] = {
  Id = 255,
  Price = 715000,
}
r46_0["Bamboo Rod"] = {
  Id = 258,
  Price = 12000000,
}
r46_0["Studded Rod"] = {
  Id = 400,
  Price = 0,
}
local r47_0 = {}
r47_0["Starter Bait"] = {
  Id = 1,
  Price = 0,
}
r47_0["Chroma Bait"] = {
  Id = 6,
  Price = 290000,
}
r47_0["Gold Bait"] = {
  Id = 4,
  Price = 0,
}
r47_0["Hyper Bait"] = {
  Id = 5,
  Price = 0,
}
r47_0["Luck Bait"] = {
  Id = 2,
  Price = 1000,
}
r47_0["Midnight Bait"] = {
  Id = 3,
  Price = 3000,
}
r47_0["Bag-O-Gold Bait"] = {
  Id = 7,
  Price = 0,
}
r47_0["Beach Ball Bait"] = {
  Id = 9,
  Price = 0,
}
r47_0["Topwater Bait"] = {
  Id = 10,
  Price = 100,
}
r47_0["Anchor Bait"] = {
  Id = 11,
  Price = 0,
}
r47_0["Ornament Bait"] = {
  Id = 12,
  Price = 0,
}
r47_0["Jolly Bait"] = {
  Id = 13,
  Price = 0,
}
r47_0["Frozen Bait"] = {
  Id = 14,
  Price = 0,
}
r47_0["Dark Matter Bait"] = {
  Id = 8,
  Price = 630000,
}
r47_0["Nature Bait"] = {
  Id = 17,
  Price = 83500,
}
r47_0["Aether Bait"] = {
  Id = 16,
  Price = 3700000,
}
r47_0["Corrupt Bait"] = {
  Id = 15,
  Price = 1148484,
}
r47_0["Singularity Bait"] = {
  Id = 18,
  Price = 0,
}
r47_0["Royal Bait"] = {
  Id = 19,
  Price = 0,
}
r47_0["Floral Bait"] = {
  Id = 20,
  Price = 4000000,
}
r47_0["Radioactive Bait"] = {
  Id = 21,
  Price = 0,
}
r47_0["Root Bait"] = {
  Id = 22,
  Price = 0,
}
r47_0["Delayed Orb Bait"] = {
  Id = 23,
  Price = 0,
}
r47_0["Pumpkin Bait"] = {
  Id = 24,
  Price = 0,
}
r47_0["Purple Moon Bait"] = {
  Id = 25,
  Price = 0,
}
r47_0["Corruption Crystal"] = {
  Id = 27,
  Price = 0,
}
r47_0["Matrix Hologram"] = {
  Id = 26,
  Price = 0,
}
r47_0["Binary Crystal"] = {
  Id = 28,
  Price = 0,
}
r47_0["Wyvern Artifact"] = {
  Id = 29,
  Price = 0,
}
local r48_0 = {}
r48_0["Small Boat"] = {
  Id = 1,
  Price = 300,
}
r48_0.Kayak = {
  Id = 2,
  Price = 1100,
}
r48_0.Jetski = {
  Id = 3,
  Price = 7500,
}
r48_0["Highfield Boat"] = {
  Id = 4,
  Price = 25000,
}
r48_0["Speed Boat"] = {
  Id = 5,
  Price = 70000,
}
r48_0["Fishing Boat"] = {
  Id = 6,
  Price = 180000,
}
r48_0["Mini Yacht"] = {
  Id = 14,
  Price = 1200000,
}
local r49_0 = {}
local r50_0 = {}
local function r51_0(r0_213)
  -- line: [0, 0] id: 213
  if r0_213 >= 1000000 then
    return string.format("%.1fM", r0_213 / 1000000)
  end
  if r0_213 >= 1000 then
    return string.format("%.0fK", r0_213 / 1000)
  end
  return tostring(r0_213)
end
local function r52_0(r0_299, r1_299)
  -- line: [0, 0] id: 299
  local r2_299 = {}
  local r3_299 = {}
  for r7_299, r8_299 in pairs(r0_299) do
    local r9_299 = string.format("%s (%s)", r7_299, r51_0(r8_299.Price))
    table.insert(r2_299, r9_299)
    r3_299[r9_299] = r8_299.Id
  end
  table.sort(r2_299)
  r49_0[r1_299] = r2_299
  r50_0[r1_299] = r3_299
end
r52_0(r46_0, "Rod")
r52_0(r47_0, "Bait")
r52_0(r48_0, "Boat")
local r53_0 = nil
local r54_0 = nil
local r55_0 = nil
local r56_0 = {}
r1_0.PlayerAdded:Connect(function(r0_82)
  -- line: [0, 0] id: 82
  table.insert(r56_0, r0_82.Name)
end)
r1_0.PlayerRemoving:Connect(function(r0_171)
  -- line: [0, 0] id: 171
  for r4_171, r5_171 in ipairs(r56_0) do
    if r5_171 == r0_171.Name then
      table.remove(r56_0, r4_171)
      break
    end
  end
end)
local function r57_0()
  -- line: [0, 0] id: 225
  local r0_225 = {}
  for r4_225, r5_225 in ipairs(r1_0:GetPlayers()) do
    if r5_225 ~= r6_0 then
      table.insert(r0_225, r5_225.DisplayName)
    end
  end
  return r0_225
end
local r58_0 = {
  ["Esoteric Depths"] = Vector3.new(3258, -1301, 1391),
  ["Treasure Room"] = Vector3.new(-3602.01, -266.57, -1577.18),
  ["Sisyphus Statue"] = Vector3.new(-3703.69, -135.57, -1017.17),
  ["Crater Island Top"] = Vector3.new(1011.29, 22.68, 5076.27),
  ["Crater Island Ground"] = Vector3.new(1079.57, 3.64, 5080.35),
  ["Coral Reefs Spot 1"] = Vector3.new(-3031.88, 2.52, 2276.36),
  ["Coral Reefs Spot 2"] = Vector3.new(-3270.86, 2.5, 2228.1),
  ["Coral Reefs Spot 3"] = Vector3.new(-3136.1, 2.61, 2126.11),
  ["Lost Shore"] = Vector3.new(-3737.97, 5.43, -854.68),
  ["Weather Machine"] = Vector3.new(-1524.88, 2.87, 1915.56),
  ["Kohana Volcano"] = Vector3.new(-561.81, 21.24, 156.72),
  Kohana = Vector3.new(-684.1, 3, 800.8),
  ["Kohana Spot 1"] = Vector3.new(-367.77, 6.75, 521.91),
  ["Kohana Spot 2"] = Vector3.new(-623.96, 19.25, 419.36),
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
  ["Classic Event"] = Vector3.new(1173, 4, 2839),
  ["Classic Event River"] = Vector3.new(1439, 46, 2779),
  ["Iron Cafe"] = Vector3.new(-8642, -547.5, 162),
  ["Iron Cavern Left"] = Vector3.new(-8795, -585, 89),
  ["Iron Cavern Right"] = Vector3.new(-8792, -585, 223),
}
locationNames = {}
for r62_0 in pairs(r58_0) do
  table.insert(locationNames, r62_0)
end
table.sort(locationNames, function(r0_295, r1_295)
  -- line: [0, 0] id: 295
  return r0_295:lower() < r1_295:lower()
end)
local r59_0 = {}
local r60_0 = {
  Enabled = false,
  URL = "",
}
local r61_0 = false
local r62_0 = {}
local r63_0 = {}
local r64_0 = ""
local r65_0 = {}
local r66_0 = {
  [1] = "Common",
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
local r67_0 = getconnections or get_signal_cons
if r67_0 then
  for r71_0, r72_0 in pairs(r67_0(r6_0.Idled)) do
    local r73_0 = r72_0.Disable
    if r73_0 then
      local r75_0 = "Disable"
      r72_0:[r75_0]()
    else
      r73_0 = r72_0.Disconnect
      if r73_0 then
        local r75_0 = "Disconnect"
        r72_0:[r75_0]()
      end
    end
  end
end
local r68_0 = cloneref
if r68_0 then
  r68_0 = cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
else
  goto label_919	-- block#28 is visited secondly
end
r6_0.Idled:Connect(function()
  -- line: [0, 0] id: 303
  r68_0:CaptureController()
  r68_0:ClickButton2(Vector2.new())
end)
local r69_0 = false
local r70_0 = {}
local r71_0 = nil
local r72_0 = nil
local r73_0 = {
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
offs = {
  ["Worm Hunt"] = 25,
}
local function r74_0(r0_275)
  -- line: [0, 0] id: 275
  return r0_275:FindFirstChild("HumanoidRootPart") or r0_275:FindFirstChild("Torso") or r0_275:FindFirstChild("UpperTorso")
end
local function r75_0(r0_221)
  -- line: [0, 0] id: 221
  return r0_221 and (r0_221:FindFirstChild("HumanoidRootPart") or r0_221:FindFirstChildWhichIsA("BasePart"))
end
local function r76_0()
  -- line: [0, 0] id: 108
  local r0_108 = {}
  local r2_108 = r6_0:WaitForChild("PlayerGui"):FindFirstChild("Events")
  if r2_108 and r2_108:FindFirstChild("Frame") then
    local r3_108 = r2_108.Frame:FindFirstChild("Events")
    if r3_108 then
      for r7_108, r8_108 in ipairs(r3_108:GetChildren()) do
        local r9_108 = r8_108:FindFirstChild("DisplayName")
        if r9_108 then
          r9_108 = r8_108.DisplayName.Text or r8_108.Name
        else
          goto label_35	-- block#6 is visited secondly
        end
        if type(r9_108) == "string" and r9_108 ~= "" and not r73_0[r9_108] then
          table.insert(r0_108, r9_108:gsub("^Admin %- ", ""))
        end
      end
    end
  end
  return r0_108
end
local function r77_0(r0_112)
  -- line: [0, 0] id: 112
  if not r0_112 then
    return 
  end
  if r0_112 == "Megalodon Hunt" then
    local r1_112 = workspace:FindFirstChild("!!! MENU RINGS")
    if not r1_112 then
      return 
    end
    for r5_112, r6_112 in ipairs(r1_112:GetChildren()) do
      local r7_112 = r6_112:FindFirstChild("Megalodon Hunt")
      local r8_112 = r7_112 and r7_112:FindFirstChild("Megalodon Hunt")
      if r8_112 and r8_112:IsA("BasePart") then
        return r8_112
      end
    end
    return 
  end
  local r1_112 = {
    workspace:FindFirstChild("Props")
  }
  local r2_112 = workspace:FindFirstChild("!!! MENU RINGS")
  if r2_112 then
    for r6_112, r7_112 in ipairs(r2_112:GetChildren()) do
      if r7_112.Name:match("^Props") then
        table.insert(r1_112, r7_112)
      end
    end
  end
  for r6_112, r7_112 in ipairs(r1_112) do
    for r11_112, r12_112 in ipairs(r7_112:GetChildren()) do
      for r16_112, r17_112 in ipairs(r12_112:GetDescendants()) do
        if r17_112:IsA("TextLabel") and r17_112.Name == "DisplayName" then
          local r18_112 = r17_112.ContentText
          if r18_112 ~= "" then
            r18_112 = r17_112.ContentText or r17_112.Text
          else
            goto label_94	-- block#25 is visited secondly
          end
          local r19_112 = r18_112:lower()
          local r20_112 = r0_112:lower()
          if r19_112 == r20_112 then
            r19_112 = r17_112:FindFirstAncestorOfClass("Model")
            if r19_112 then
              r20_112 = r19_112:FindFirstChild("Part") or r12_112:FindFirstChild("Part")
            else
              goto label_111	-- block#29 is visited secondly
            end
            if r20_112 and r20_112:IsA("BasePart") then
              return r20_112
            end
          end
        end
      end
    end
  end
end
local r78_0 = nil
local function r79_0(r0_32)
  -- line: [0, 0] id: 32
  if r78_0 ~= r0_32 then
    WindUI:Notify({
      Title = r0_32,
      Duration = 2.5,
    })
    r78_0 = r0_32
  end
end
function EventLoop()
  -- line: [0, 0] id: 10
  while r69_0 do
    local r0_10 = nil
    local r1_10 = nil
    if r70_0 then
      r0_10 = r77_0(r70_0)
      if r0_10 then
        r1_10 = r70_0 or nil
      else
        goto label_16	-- block#4 is visited secondly
      end
    end
    local r2_10 = r75_0(r6_0.Character)
    if r0_10 and r2_10 then
      if not r72_0 then
        r72_0 = r2_10.CFrame
      end
      if (r2_10.Position - r0_10.Position).Magnitude > 40 then
        r71_0 = r0_10.CFrame + Vector3.new(0, (offs[r1_10] or 7), 0)
        r6_0.Character:PivotTo(r71_0)
        task.wait(1)
        r79_0("Event! " .. r1_10)
      end
    else
      if r72_0 and r2_10 and r71_0 then
        r6_0.Character:PivotTo(r72_0)
      end
      r71_0 = nil
      r72_0 = nil
      r79_0("Idle")
    end
    task.wait(0.2)
  end
  if r72_0 and r6_0.Character then
    r6_0.Character:PivotTo(r72_0)
  end
  r79_0("Auto Event off")
  r72_0 = nil
  r71_0 = nil
end
r6_0.CharacterAdded:Connect(function(r0_85)
  -- line: [0, 0] id: 85
  if r69_0 then
    task.spawn(function()
      -- line: [0, 0] id: 86
      local r0_86 = r0_85:WaitForChild("HumanoidRootPart", 5)
      task.wait(0.3)
      if r0_86 then
        if r71_0 then
          r0_85:PivotTo(r71_0)
          task.wait(0.5)
        elseif r72_0 then
          r0_85:PivotTo(r72_0)
        end
      end
    end)
  end
end)
local r80_0 = {
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
function toSet(r0_60)
  -- line: [0, 0] id: 60
  local r1_60 = {}
  if type(r0_60) == "table" then
    for r5_60, r6_60 in ipairs(r0_60) do
      r1_60[r6_60] = true
    end
    for r5_60, r6_60 in pairs(r0_60) do
      if r6_60 then
        r1_60[r5_60] = true
      end
    end
  end
  return r1_60
end
local r81_0 = {
  auto = false,
}
r81_0.name = {}
r81_0.rarity = {}
r81_0.variant = {}
local r82_0 = {}
r20_0.RE_FavoriteChanged.OnClientEvent:Connect(function(r0_269, r1_269)
  -- line: [0, 0] id: 269
  rawset(r82_0, r0_269, r1_269)
end)
function checkAndFavorite(r0_288)
  -- line: [0, 0] id: 288
  if not r81_0.auto then
    return 
  end
  local r1_288 = r24_0.GetItemDataFromItemType("Items", r0_288.Id)
  if not r1_288 or r1_288.Data.Type ~= "Fish" then
    return 
  end
  local r2_288 = r66_0[r1_288.Data.Tier]
  local r3_288 = r1_288.Data.Name
  local r4_288 = r0_288.Metadata
  if r4_288 then
    r4_288 = r0_288.Metadata.VariantId or "None"
  else
    goto label_30	-- block#7 is visited secondly
  end
  local r5_288 = r81_0.name[r3_288]
  local r6_288 = r81_0.rarity[r2_288]
  local r7_288 = r81_0.variant[r4_288]
  local r8_288 = rawget(r82_0, r0_288.UUID)
  if r8_288 == nil then
    r8_288 = r0_288.Favorited
  end
  local r9_288 = false
  if next(r81_0.variant) ~= nil and next(r81_0.name) ~= nil then
    r9_288 = r5_288 and r7_288
  else
    r9_288 = r5_288 or r6_288
  end
  if r9_288 and not r8_288 then
    r20_0.RE_Favorite:FireServer(r0_288.UUID)
    rawset(r82_0, r0_288.UUID, true)
  end
end
function scanInventory()
  -- line: [0, 0] id: 11
  if not r81_0.auto then
    return 
  end
  for r3_11, r4_11 in ipairs(r28_0:GetExpect({
    "Inventory",
    "Items"
  })) do
    checkAndFavorite(r4_11)
  end
end
function SavePosition(r0_141)
  -- line: [0, 0] id: 141
  writefile("Meng Hub/FishIt" .. "/Position.json", r4_0:JSONEncode({
    r0_141:GetComponents()
  }))
end
function LoadPosition()
  -- line: [0, 0] id: 134
  if isfile("Meng Hub/FishIt" .. "/Position.json") then
    local r0_134, r1_134 = pcall(function()
      -- line: [0, 0] id: 135
      return r4_0:JSONDecode(readfile("Meng Hub/FishIt" .. "/Position.json"))
    end)
    if r0_134 and typeof(r1_134) == "table" then
      return CFrame.new(unpack(r1_134))
    end
  end
  return nil
end
function TeleportLastPos(r0_241)
  -- line: [0, 0] id: 241
  task.spawn(function()
    -- line: [0, 0] id: 242
    local r0_242 = r6_0.Character:WaitForChild("HumanoidRootPart")
    local r1_242 = LoadPosition()
    if r1_242 then
      task.wait(2)
      r0_242.CFrame = r1_242
      WindUI:Notify({
        Title = "Teleported to your last position...",
      })
    end
  end)
end
r6_0.CharacterAdded:Connect(TeleportLastPos)
if r6_0.Character then
  TeleportLastPos(r6_0.Character)
end
local r86_0 = "HttpGet"
r86_0 = "https://raw.githubusercontent.com/zhidanptrsyh/MengHub/refs/heads/main/main%20(1).lua"
local r83_0 = loadstring(game:[r86_0](r86_0))()
r86_0 = "CreateWindow"
r86_0 = {
  Title = "MengHub - Fish It",
  Icon = "rbxassetid://78018573702743",
  Author = "Freemium",
  Folder = "MengHub",
  Size = UDim2.fromOffset(700, 410),
  MinSize = Vector2.new(560, 350),
  MaxSize = Vector2.new(850, 560),
  Transparent = true,
  Theme = "Dark",
  Resizable = true,
  SideBarWidth = 185,
  BackgroundImageTransparency = 0.42,
  HideSearchBar = true,
  ScrollBarEnabled = false,
}
local r84_0 = r83_0:[r86_0](r86_0)
local r87_0 = "Tag"
r87_0 = {
  Title = "v1.0.3",
  Icon = "triangle-alert",
  Color = Color3.fromHex("#fbbc47"),
  Radius = 12,
}
r84_0:[r87_0](r87_0)
r87_0 = "EditOpenButton"
r87_0 = {
  Title = "Open Example UI",
  OnlyMobile = false,
  Enabled = false,
  Draggable = false,
}
r84_0:[r87_0](r87_0)
local r88_0 = "CreateConfig"
r88_0 = "MengXHubConfig"
r86_0 = r84_0.ConfigManager:[r88_0](r88_0)
({
  ToggleUI = function(r0_199)
    -- line: [0, 0] id: 199
    local r1_199 = Instance.new("ScreenGui")
    r1_199.Parent = game:GetService("CoreGui")
    r1_199.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    r1_199.Name = "ToggleUIButton"
    local r2_199 = Instance.new("ImageLabel")
    r2_199.Parent = r1_199
    r2_199.Size = UDim2.new(0, 40, 0, 40)
    r2_199.Position = UDim2.new(0, 20, 0, 100)
    r2_199.BackgroundTransparency = 1
    r2_199.Image = "rbxassetid://78018573702743"
    r2_199.ScaleType = Enum.ScaleType.Fit
    local r3_199 = Instance.new("UICorner")
    r3_199.CornerRadius = UDim.new(0, 6)
    r3_199.Parent = r2_199
    local r4_199 = Instance.new("TextButton")
    r4_199.Parent = r2_199
    r4_199.Size = UDim2.new(1, 0, 1, 0)
    r4_199.BackgroundTransparency = 1
    r4_199.Text = ""
    r4_199.MouseButton1Click:Connect(function()
      -- line: [0, 0] id: 204
      r84_0:Toggle()
    end)
    local r5_199 = false
    local r6_199 = nil
    local r7_199 = nil
    local function r8_199(r0_200)
      -- line: [0, 0] id: 200
      local r1_200 = r0_200.Position - r6_199
      r2_199.Position = UDim2.new(r7_199.X.Scale, r7_199.X.Offset + r1_200.X, r7_199.Y.Scale, r7_199.Y.Offset + r1_200.Y)
    end
    r4_199.InputBegan:Connect(function(r0_201)
      -- line: [0, 0] id: 201
      if r0_201.UserInputType == Enum.UserInputType.MouseButton1 or r0_201.UserInputType == Enum.UserInputType.Touch then
        r5_199 = true
        r6_199 = r0_201.Position
        r7_199 = r2_199.Position
        r0_201.Changed:Connect(function()
          -- line: [0, 0] id: 202
          if r0_201.UserInputState == Enum.UserInputState.End then
            r5_199 = false
          end
        end)
      end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(r0_203)
      -- line: [0, 0] id: 203
      if r5_199 and (r0_203.UserInputType == Enum.UserInputType.MouseMovement or r0_203.UserInputType == Enum.UserInputType.Touch) then
        r8_199(r0_203)
      end
    end)
  end,
}):ToggleUI()
local r90_0 = "SetToggleKey"
r90_0 = Enum.KeyCode.F3
r84_0:[r90_0](r90_0)
r90_0 = "IsResizable"
r90_0 = true
r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Info",
  Icon = "info",
}
InfoTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Fishing",
  Icon = "rbxassetid://103247953194129",
}
FishingTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Automatic",
  Icon = "play",
}
AutoTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Trade",
  Icon = "arrow-left-right",
}
TradeTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Quest",
  Icon = "rbxassetid://114127804740858",
}
QuestTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Misc",
  Icon = "box",
}
MiscTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Teleport",
  Icon = "map",
}
TeleportTab = r84_0:[r90_0](r90_0)
r90_0 = "Tab"
r90_0 = {
  Title = "Weebhook",
  Icon = "cable",
}
WebhookTab = r84_0:[r90_0](r90_0)
r90_0 = "Paragraph"
r90_0 = {
  Title = "?? Warning",
  Desc = "\r\n?? Development Build  \r\nBeberapa fitur belum stabil dan bisa error kapan aja.  \r\nPakai di server publik dengan resiko sendiri �  \r\nkalau ke-banned  \r\n\r\nFeedback, bug report, atau mau pamer hasil cheat?  \r\n<font color=\"rgb(232,145,234)\">Discord.</font>\r\n",
}
InfoTab:[r90_0](r90_0)
function r88_0(r0_308)
  -- line: [0, 0] id: 308
  local r1_308 = r83_0
  local r3_308 = {
    Title = r0_308 or "",
    Duration = 2.5,
  }
  return r1_308:Notify(r3_308)
end
local r91_0 = "Button"
r91_0 = {
  Title = "Join Discord",
  Desc = "Click This To Copy Discord Link.\nJoin to <font color=\"#FF90E3\">Discord Meng Hub</font>!",
  Icon = "badge-check",
  Callback = function()
    -- line: [0, 0] id: 195
    if setclipboard then
      setclipboard("https ://discord.gg/sYPZPRGgHe")
      r88_0("Successfully copy link!")
    end
  end,
}
InfoTab:[r91_0](r91_0)
InfoTab:Divider()
r91_0 = "Button"
r91_0 = {
  Title = "Rejoin Server",
  Callback = function()
    -- line: [0, 0] id: 298
    r11_0:Teleport(game.PlaceId, r6_0)
  end,
}
InfoTab:[r91_0](r91_0)
InfoTab:Select()
r91_0 = "Section"
r91_0 = {
  Title = "Fishing Support",
}
FishSupTab = FishingTab:[r91_0](r91_0)
r91_0 = "Toggle"
r91_0 = {
  Title = "Auto Equip Rod",
  Content = "Automatically equip ur fishing rods!",
  Value = false,
  Callback = function(r0_68)
    -- line: [0, 0] id: 68
    r31_0.autoEquipRod = r0_68
    local function r1_68()
      -- line: [0, 0] id: 71
      local r0_71 = r28_0:Get("EquippedId")
      if not r0_71 then
        return false
      end
      local r1_71 = r26_0:GetItemFromInventory(r28_0, function(r0_72)
        -- line: [0, 0] id: 72
        return r0_72.UUID == r0_71
      end)
      if not r1_71 then
        return false
      end
      local r2_71 = r24_0:GetItemData(r1_71.Id)
      return r2_71 and r2_71.Data.Type == "Fishing Rods"
    end
    local function r2_68()
      -- line: [0, 0] id: 69
      if not r1_68() then
        r20_0.RE_Equip:FireServer(1)
      end
    end
    task.spawn(function()
      -- line: [0, 0] id: 70
      while r31_0.autoEquipRod do
        r2_68()
        task.wait(1)
      end
    end)
  end,
}
EquipRodToggle = FishSupTab:[r91_0](r91_0)
r91_0 = "Register"
r91_0 = "EquipRodToggle"
r86_0:[r91_0](r91_0, EquipRodToggle)
r91_0 = "Toggle"
r91_0 = {
  Title = "No Fishing Animations",
  Value = false,
  Callback = function(r0_264)
    -- line: [0, 0] id: 264
    local r1_264 = (r6_0.Character or r6_0.CharacterAdded:Wait()):WaitForChild("Humanoid"):FindFirstChildOfClass("Animator")
    if not r1_264 then
      return 
    end
    if r0_264 then
      r31_0.stopAnimHookEnabled = true
      for r5_264, r6_264 in ipairs(r1_264:GetPlayingAnimationTracks()) do
        r6_264:Stop(0)
      end
      r31_0.stopAnimConn = r1_264.AnimationPlayed:Connect(function(r0_265)
        -- line: [0, 0] id: 265
        if r31_0.stopAnimHookEnabled then
          task.defer(function()
            -- line: [0, 0] id: 266
            pcall(function()
              -- line: [0, 0] id: 267
              r0_265:Stop(0)
            end)
          end)
        end
      end)
    else
      r31_0.stopAnimHookEnabled = false
      if r31_0.stopAnimConn then
        r31_0.stopAnimConn:Disconnect()
        r31_0.stopAnimConn = nil
      end
    end
  end,
}
NoAnimToggle = FishSupTab:[r91_0](r91_0)
r91_0 = "Register"
r91_0 = "NoAnimToggle"
r86_0:[r91_0](r91_0, NoAnimToggle)
function SetWalkOnWater(r0_276)
  -- line: [0, 0] id: 276
  if type(_G.__WALKFN) == "function" then
    _G.__WALKFN(r0_276)
  end
end
local r89_0 = false
r90_0 = nil
r91_0 = nil
function _G.__WALKFN(r0_4)
  -- line: [0, 0] id: 4
  r89_0 = r0_4
  if r0_4 then
    r90_0 = Instance.new("Part")
    r90_0.Name = "WW_Part"
    r90_0.Size = Vector3.new(20, 1, 20)
    r90_0.Transparency = 1
    r90_0.Anchored = true
    r90_0.CanCollide = true
    r90_0.Parent = Workspace
    r91_0 = r2_0.Heartbeat:Connect(function()
      -- line: [0, 0] id: 5
      if not r89_0 or not r90_0 then
        return 
      end
      local r0_5 = r74_0(r6_0.Character)
      if not r0_5 then
        return 
      end
      r90_0.CFrame = CFrame.new(r0_5.Position.X, -1.8, r0_5.Position.Z)
    end)
  else
    if r91_0 then
      r91_0:Disconnect()
      r91_0 = nil
    end
    if r90_0 then
      r90_0:Destroy()
      r90_0 = nil
    end
  end
end
local r94_0 = "Toggle"
r94_0 = {
  Title = "Walk On Water",
  Value = false,
  Callback = function(r0_250)
    -- line: [0, 0] id: 250
    SetWalkOnWater(r0_250)
  end,
}
FishSupTab:[r94_0](r94_0)
-- close: r89_0
r89_0 = FishSupTab
r91_0 = "Toggle"
r91_0 = {
  Title = "Freeze Player",
  Value = false,
  Callback = function(r0_175)
    -- line: [0, 0] id: 175
    r31_0.frozen = r0_175
    local function r2_175()
      -- line: [0, 0] id: 178
      local r0_178 = r28_0:Get("EquippedId")
      if not r0_178 then
        return false
      end
      local r1_178 = r26_0:GetItemFromInventory(r28_0, function(r0_179)
        -- line: [0, 0] id: 179
        return r0_179.UUID == r0_178
      end)
      if not r1_178 then
        return false
      end
      local r2_178 = r24_0:GetItemData(r1_178.Id)
      return r2_178 and r2_178.Data.Type == "Fishing Rods"
    end
    local function r3_175()
      -- line: [0, 0] id: 181
      if not r2_175() then
        r20_0.RE_Equip:FireServer(1)
        task.wait(0.5)
      end
    end
    local function r4_175(r0_180, r1_180)
      -- line: [0, 0] id: 180
      if not r0_180 then
        return 
      end
      for r5_180, r6_180 in ipairs(r0_180:GetDescendants()) do
        if r6_180:IsA("BasePart") then
          r6_180.Anchored = r1_180
        end
      end
    end
    local function r5_175(r0_176)
      -- line: [0, 0] id: 176
      if r31_0.frozen then
        r3_175()
        if r2_175() then
          r4_175(r0_176, true)
        end
      else
        r4_175(r0_176, false)
      end
    end
    r5_175(r6_0.Character)
    r6_0.CharacterAdded:Connect(function(r0_177)
      -- line: [0, 0] id: 177
      task.wait(1)
      r5_175(r0_177)
    end)
  end,
}
r89_0 = r89_0:[r91_0](r91_0)
FreezeToggle = r89_0
r89_0 = FishingTab
r91_0 = "Section"
r91_0 = {
  Title = "Fishing Features",
}
r89_0 = r89_0:[r91_0](r91_0)
FishTab = r89_0
r89_0 = FishTab
r91_0 = "Input"
r91_0 = {
  Title = "Legit Delay",
  Desc = "Delay complete fishing!",
  Placeholder = "Input Here",
  Callback = function(r0_34)
    -- line: [0, 0] id: 34
    local r1_34 = tonumber(r0_34)
    if r1_34 and 0 < r1_34 then
      r35_0 = r1_34
      task.spawn(function()
        -- line: [0, 0] id: 35
        -- notice: unreachable block#14
        print("Started")
        while true do
          if r22_0 then
            local r0_35 = r22_0._autoLoop
            if r0_35 then
              r0_35 = r22_0:GetCurrentGUID()
              if r0_35 then
                print("Waiting", r35_0)
                task.wait(r35_0)
                while true do
                  local r0_35, r1_35 = pcall(function()
                    -- line: [0, 0] id: 36
                    r20_0.RE_Fishing:FireServer()
                  end)
                  if r0_35 then
                    print("Successfully")
                  else
                    print("Failed to fire", r1_35)
                  end
                  task.wait(0.05)
                  if r22_0:GetCurrentGUID() then
                    if not r22_0._autoLoop then
                      goto label_50	-- block#10 is visited secondly
                    end
                  else
                    break
                  end
                end
                print("Loop ended")
              end
            end
          end
          task.wait(0.05)
        end
      end)
    else
      warn("Invalid fishing delay input")
    end
  end,
}
r89_0 = r89_0:[r91_0](r91_0)
LegitInput = r89_0
r91_0 = "Register"
r91_0 = "LegitInput"
r86_0:[r91_0](r91_0, LegitInput)
r89_0 = 0
shakeDelay = r89_0
r89_0 = FishTab
r91_0 = "Input"
r91_0 = {
  Title = "Shake Delay",
  Placeholder = "Input Here",
  Callback = function(r0_59)
    -- line: [0, 0] id: 59
    local r1_59 = tonumber(r0_59)
    if r1_59 and 0 <= r1_59 then
      shakeDelay = r1_59
    end
  end,
}
r89_0 = r89_0:[r91_0](r91_0)
ShakeInput = r89_0
r91_0 = "Register"
r91_0 = "ShakeInput"
r86_0:[r91_0](r91_0, ShakeInput)
r89_0 = tostring
r90_0 = "UserId"
r90_0 = r6_0[r90_0]
r89_0 = r89_0(r90_0)
userId = r89_0
r89_0 = workspace
r91_0 = "CosmeticFolder"
r89_0 = r89_0:WaitForChild(r91_0)
CosmeticFolder = r89_0
r89_0 = nil
r90_0 = "RegisterMouseReleased"
r90_0 = r27_0[r90_0]
function r91_0(r0_287, r1_287, r2_287)
  -- line: [0, 0] id: 287
  r89_0 = r2_287
  return r90_0(r0_287, r1_287, r2_287)
end
registerMouseReleasedHook = r91_0
r91_0 = "RegisterMouseReleased"
r27_0[r91_0] = registerMouseReleasedHook
function r91_0()
  -- line: [0, 0] id: 159
  local r0_159 = r9_0
  local r1_159 = r8_0
  local r2_159 = Vector2.new(r1_159.ViewportSize.X / 2, r1_159.ViewportSize.Y / 2)
  pcall(function()
    -- line: [0, 0] id: 160
    r20_0.RF_Cancel:InvokeServer()
  end)
  pcall(function()
    -- line: [0, 0] id: 161
    r22_0:RequestChargeFishingRod(r2_159, false)
  end)
  local r3_159 = r0_159:WaitForChild("Charge"):WaitForChild("Main"):WaitForChild("CanvasGroup"):WaitForChild("Bar")
  repeat
    task.wait()
  until r3_159.Size.Y.Scale > 0
  local r4_159 = tick()
  while r3_159:IsDescendantOf(r0_159) do
    local r5_159 = r3_159.Size.Y.Scale
    if r5_159 < 0.93 then
      task.wait()
      if tick() - r4_159 > 2 then
        break
      end
    else
      break
    end
  end
  if r89_0 then
    pcall(r89_0)
  end
end
castWithBarRelease = r91_0
r91_0 = FishTab
local r93_0 = "Toggle"
r93_0 = {
  Title = "Legit Fishing",
  Desc = "Auto fishing with animation",
  Value = false,
  Callback = function(r0_300)
    -- line: [0, 0] id: 300
    r22_0._autoLoop = r0_300
    if r0_300 then
      task.spawn(function()
        -- line: [0, 0] id: 301
        while r22_0._autoLoop do
          local r0_301 = CosmeticFolder:FindFirstChild(userId)
          if not r0_301 then
            castWithBarRelease()
            task.wait(0.2)
          end
          while true do
            task.wait(0.2)
            if CosmeticFolder:FindFirstChild(userId) then
              local r1_301 = r22_0._autoLoop
              if not r1_301 then
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
r91_0 = r91_0:[r93_0](r93_0)
LegitFishingToggle = r91_0
r93_0 = "Register"
r93_0 = "LegitFishingToggle"
r86_0:[r93_0](r93_0, LegitFishingToggle)
r91_0 = FishTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Auto Shake",
  Desc = "Spam click during fishing (only legit)",
  Value = false,
  Callback = function(r0_182)
    -- line: [0, 0] id: 182
    r31_0.autoShake = r0_182
    local r1_182 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("!!! Click Effect")
    if r1_182 then
      r1_182.Enabled = not r0_182
    end
    if r0_182 then
      task.spawn(function()
        -- line: [0, 0] id: 183
        while r31_0.autoShake do
          pcall(function()
            -- line: [0, 0] id: 184
            r22_0:RequestFishingMinigameClick()
          end)
          task.wait(shakeDelay)
        end
      end)
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
AutoShakeToggle = r91_0
r93_0 = "Register"
r93_0 = "AutoShakeToggle"
r86_0:[r93_0](r93_0, AutoShakeToggle)
r91_0 = FishingTab
r93_0 = "Section"
r93_0 = {
  Title = "Instant Features",
}
r91_0 = r91_0:[r93_0](r93_0)
InstantTab = r91_0
r91_0 = InstantTab
r93_0 = "Input"
r93_0 = {
  Title = "Delay Complete",
  Placeholder = "Input Here",
  Callback = function(r0_79)
    -- line: [0, 0] id: 79
    local r1_79 = tonumber(r0_79)
    if r1_79 and 0 <= r1_79 then
      r41_0 = r1_79
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
InstantInput = r91_0
r93_0 = "Register"
r93_0 = "InstantInput"
r86_0:[r93_0](r93_0, InstantInput)
r91_0 = InstantTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Stable Result",
  Desc = "Make u always get Good/Perfection",
  Value = false,
  Callback = function(r0_122)
    -- line: [0, 0] id: 122
    r20_0.RF_AutoFishing:InvokeServer(r0_122)
    if r0_122 then
      r6_0:SetAttribute("Loading", nil)
    else
      r6_0:SetAttribute("Loading", false)
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
StableInstantToggle = r91_0
r93_0 = "Register"
r93_0 = "StableInstantToggle"
r86_0:[r93_0](r93_0, StableInstantToggle)
r91_0 = InstantTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Instant Fishing",
  Desc = "Auto instantly catch fish",
  Value = false,
  Callback = function(r0_290)
    -- line: [0, 0] id: 290
    r39_0 = r0_290
    if r0_290 then
      r42_0 = r45_0()
      task.spawn(function()
        -- line: [0, 0] id: 291
        while r39_0 do
          local r0_291 = r40_0
          if r0_291 then
            r40_0 = false
            local r0_291, r1_291, r2_291 = pcall(function()
              -- line: [0, 0] id: 292
              return r20_0.RF_Charge:InvokeServer(workspace:GetServerTimeNow())
            end)
            if r0_291 and typeof(r2_291) == "number" then
              task.wait(0.3)
              pcall(function()
                -- line: [0, 0] id: 294
                r20_0.RF_Minigame:InvokeServer(-1, 0.999, r2_291)
              end)
              local r3_291 = tick()
              while true do
                task.wait(0.05)
                if r43_0 then
                  local r4_291 = r43_0.LastShift
                  if not r4_291 then
                    ::label_41::
                    r4_291 = tick() - r3_291
                    if r4_291 > 1 then
                      break
                    end
                  else
                    break
                  end
                else
                  goto label_41	-- block#7 is visited secondly
                end
              end
              task.wait(delayComplete)
              pcall(function()
                -- line: [0, 0] id: 293
                r20_0.RE_Fishing:FireServer()
              end)
              local r4_291 = r45_0()
              local r5_291 = tick()
              while true do
                task.wait(0.05)
                if r4_291 >= r45_0() then
                  local r6_291 = tick() - r5_291
                  if r6_291 > 1 then
                    break
                  end
                else
                  break
                end
              end
            end
            r40_0 = true
            -- close: r0_291
          end
          task.wait(0.05)
        end
      end)
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
InstantToggle = r91_0
r93_0 = "Register"
r93_0 = "InstantToggle"
r86_0:[r93_0](r93_0, InstantToggle)
r91_0 = InstantTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Talon Fishing",
  Desc = "Auto Fishing in game + Auto Shake!",
  Value = false,
  Callback = function(r0_118)
    -- line: [0, 0] id: 118
    r31_0.autoShake = r0_118
    r20_0.RF_AutoFishing:InvokeServer(r0_118)
    local r1_118 = r9_0:FindFirstChild("!!! Click Effect")
    if r1_118 then
      r1_118.Enabled = not r0_118
    end
    if r0_118 then
      task.spawn(function()
        -- line: [0, 0] id: 119
        while r31_0.autoShake do
          pcall(function()
            -- line: [0, 0] id: 120
            r22_0:RequestFishingMinigameClick()
          end)
          task.wait(0.15)
        end
      end)
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
TalonToggle = r91_0
r91_0 = RE_FishingMinigameEvent
if r91_0 then
  if r44_0 then
    r44_0:Disconnect()
  end
  r91_0 = RE_FishingMinigameEvent
  r91_0 = r91_0.OnClientEvent
  r91_0 = r91_0:Connect(function(r0_37, r1_37)
    -- line: [0, 0] id: 37
    if r1_37 then
      r43_0 = r1_37
    end
  end)
  r44_0 = r91_0
end
function r91_0()
  -- line: [0, 0] id: 235
  task.spawn(function()
    -- line: [0, 0] id: 236
    pcall(function()
      -- line: [0, 0] id: 240
      r20_0.RF_Cancel:InvokeServer()
    end)
    local r0_236 = workspace:GetServerTimeNow()
    pcall(function()
      -- line: [0, 0] id: 237
      r20_0.RF_Charge:InvokeServer(r0_236)
    end)
    pcall(function()
      -- line: [0, 0] id: 238
      r20_0.RF_Minigame:InvokeServer(-1, 0.999)
    end)
    task.wait(r38_0)
    pcall(function()
      -- line: [0, 0] id: 239
      r20_0.RE_Fishing:FireServer()
    end)
  end)
end
Fastest = r91_0
r91_0 = FishingTab
r93_0 = "Section"
r93_0 = {
  Title = "Blatant Features",
}
r91_0 = r91_0:[r93_0](r93_0)
BlatantTab = r91_0
r91_0 = BlatantTab
r93_0 = "Input"
r93_0 = {
  Title = "Delay Reel",
  Desc = "Reel timing (e.g. 1.9)",
  Placeholder = "Default 1.9",
  Callback = function(r0_248)
    -- line: [0, 0] id: 248
    local r1_248 = tonumber(r0_248)
    if r1_248 and 0 <= r1_248 then
      r37_0 = r1_248
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
ReelInput = r91_0
r93_0 = "Register"
r93_0 = "ReelInput"
r86_0:[r93_0](r93_0, ReelInput)
r91_0 = BlatantTab
r93_0 = "Input"
r93_0 = {
  Title = "Delay Fishing",
  Desc = "Fishing Timing (e.g. 1.1)",
  Placeholder = "Default 1.1",
  Callback = function(r0_104)
    -- line: [0, 0] id: 104
    local r1_104 = tonumber(r0_104)
    if r1_104 and 0 <= r1_104 then
      r38_0 = r1_104
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
FishInput = r91_0
r93_0 = "Register"
r93_0 = "FishInput"
r86_0:[r93_0](r93_0, FishInput)
r91_0 = BlatantTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Blatant Fishing",
}
r93_0.Value = r36_0 or false
function r93_0.Callback(r0_162)
  -- line: [0, 0] id: 162
  r36_0 = r0_162
  r20_0.RF_AutoFishing:InvokeServer(r0_162)
  if r0_162 then
    r6_0:SetAttribute("Loading", nil)
    task.spawn(function()
      -- line: [0, 0] id: 163
      while r36_0 do
        Fastest()
        task.wait(r37_0)
      end
    end)
  else
    r6_0:SetAttribute("Loading", false)
  end
end
r91_0 = r91_0:[r93_0](r93_0)
BlatantToggle = r91_0
r93_0 = "Register"
r93_0 = "BlatantToggle"
r86_0:[r93_0](r93_0, BlatantToggle)
r91_0 = BlatantTab
r93_0 = "Button"
r93_0 = {
  Title = "Recovery Fishing",
  Callback = function()
    -- line: [0, 0] id: 102
    pcall(function()
      -- line: [0, 0] id: 103
      r20_0.RF_Cancel:InvokeServer()
    end)
    r88_0("Successfully recovery fishing!")
  end,
}
r91_0:[r93_0](r93_0)
r91_0 = FishingTab
r93_0 = "Section"
r93_0 = {
  Title = "Sell Features",
}
r91_0 = r91_0:[r93_0](r93_0)
SellTab = r91_0
r91_0 = SellTab
r93_0 = "Dropdown"
r93_0 = {
  Title = "Select Sell Mode",
}
r93_0.Values = {
  "Delay",
  "Count"
}
r93_0.Value = "Delay"
function r93_0.Callback(r0_53)
  -- line: [0, 0] id: 53
  r31_0.sellMode = r0_53
end
r91_0:[r93_0](r93_0)
r91_0 = SellTab
r93_0 = "Input"
r93_0 = {
  Title = "Set Value",
  Desc = "Delay = Time Count | Count = Backpack Count",
  Value = "60",
  Placeholder = "Input Here",
  Callback = function(r0_216)
    -- line: [0, 0] id: 216
    local r1_216 = tonumber(r0_216)
    if r1_216 and 0 < r1_216 then
      if r31_0.sellMode == "Delay" then
        r31_0.sellDelay = r1_216
      else
        r31_0.inputSellCount = r1_216
      end
    end
  end,
}
r91_0:[r93_0](r93_0)
r91_0 = SellTab
r93_0 = "Toggle"
r93_0 = {
  Title = "Start Sell",
  Value = false,
  Callback = function(r0_44)
    -- line: [0, 0] id: 44
    r31_0.autoSellEnabled = r0_44
    if r0_44 then
      task.spawn(function()
        -- line: [0, 0] id: 45
        while r31_0.autoSellEnabled do
          local r0_45 = r6_0:WaitForChild("PlayerGui")
          r0_45 = r0_45:WaitForChild("Inventory").Main.Top.Options.Fish.Label:FindFirstChild("BagSize")
          local r1_45 = 0
          local r2_45 = 0
          if r0_45 and r0_45:IsA("TextLabel") then
            local r3_45, r4_45 = (r0_45.Text or ""):match("(%d+)%s*/%s*(%d+)")
            local r5_45 = tonumber(r3_45) or 0
            r2_45 = tonumber(r4_45) or 0
            r1_45 = r5_45
          end
          if r31_0.sellMode == "Delay" then
            if r31_0.sellDelay <= tick() - r31_0.lastSellTime then
              r20_0.RF_Sell:InvokeServer()
              r31_0.lastSellTime = tick()
            end
            task.wait(1)
          elseif r31_0.sellMode == "Count" then
            if (tonumber(r31_0.inputSellCount) or r2_45) <= r1_45 then
              r20_0.RF_Sell:InvokeServer()
              task.wait(0)
            else
              task.wait(0)
            end
          end
        end
      end)
    end
  end,
}
r91_0:[r93_0](r93_0)
r91_0 = FishingTab
r93_0 = "Section"
r93_0 = {
  Title = "Favorite Features",
}
r91_0 = r91_0:[r93_0](r93_0)
FavoriteTab = r91_0
r91_0 = FavoriteTab
r93_0 = "Dropdown"
r93_0 = {
  Title = "Name",
  Desc = "Favorite By Name Fish (Recommended)",
}
r93_0.Values = {
  "Refresh Fish!"
}
r93_0.Multi = true
r93_0.AllowNone = true
function r93_0.Callback(r0_84)
  -- line: [0, 0] id: 84
  r81_0.name = toSet(r0_84)
end
r91_0 = r91_0:[r93_0](r93_0)
FavFishDropdown = r91_0
r91_0 = FavoriteTab
r93_0 = "Dropdown"
r93_0 = {
  Title = "Rarity",
  Desc = "Favorite By Rarity (Optional)",
}
r93_0.Values = {
  "Common",
  "Uncommon",
  "Rare",
  "Epic",
  "Legendary",
  "Mythic",
  "Secret"
}
r93_0.Multi = true
r93_0.AllowNone = true
function r93_0.Callback(r0_57)
  -- line: [0, 0] id: 57
  r81_0.rarity = toSet(r0_57)
end
r91_0 = r91_0:[r93_0](r93_0)
FavRarityDropdown = r91_0
r93_0 = "Register"
r93_0 = "FavRarityDropdown"
r86_0:[r93_0](r93_0, FavRarityDropdown)
r91_0 = FavoriteTab
r93_0 = "Dropdown"
r93_0 = {
  Title = "Variant",
  Desc = "Favorite By Variant (Only works with Name)",
  Values = r80_0,
  Multi = true,
  AllowNone = true,
  Callback = function(r0_253)
    -- line: [0, 0] id: 253
    if next(r81_0.name) ~= nil then
      r81_0.variant = toSet(r0_253)
    else
      r81_0.variant = {}
      warn("Pilih Name Dulu Sebelum Variant!")
    end
  end,
}
r91_0 = r91_0:[r93_0](r93_0)
FavVariantDropdown = r91_0
r93_0 = "Register"
r93_0 = "FavVariantDropdown"
r86_0:[r93_0](r93_0, FavVariantDropdown)
r91_0 = {}
for r95_0, r96_0 in ipairs(r29_0:GetChildren()) do
  local r99_0 = "IsA"
  r99_0 = "ModuleScript"
  local r97_0 = r96_0:[r99_0](r99_0)
  if r97_0 then
    local r97_0, r98_0 = pcall(require, r96_0)
    if r97_0 then
      r99_0 = r98_0.Data
      if r99_0 then
        r99_0 = r98_0.Data.Type
        local r100_0 = "Fish"
        if r99_0 == r100_0 then
          local r102_0 = "Name"
          table.insert(r91_0, r98_0.Data[r102_0])
        end
      end
    end
  end
end
table.sort(r91_0)
r94_0 = "Button"
r94_0 = {
  Title = "Refresh Fish",
  Callback = function()
    -- line: [0, 0] id: 169
    FavFishDropdown:Refresh(r91_0)
  end,
}
FavoriteTab:[r94_0](r94_0)
r94_0 = "Toggle"
r94_0 = {
  Title = "Auto Favorite",
  Value = false,
  Callback = function(r0_3)
    -- line: [0, 0] id: 3
    r81_0.auto = r0_3
    if r0_3 then
      scanInventory()
      r28_0:OnChange({
        "Inventory",
        "Items"
      }, scanInventory)
    end
  end,
}
FavoriteTab:[r94_0](r94_0)
r94_0 = "Button"
r94_0 = {
  Title = "Unfavorite All",
  Callback = function()
    -- line: [0, 0] id: 56
    for r3_56, r4_56 in ipairs(r28_0:GetExpect({
      "Inventory",
      "Items"
    })) do
      local r5_56 = rawget(r82_0, r4_56.UUID)
      if r5_56 == nil then
        r5_56 = r4_56.Favorited
      end
      if r5_56 then
        r20_0.RE_Favorite:FireServer(r4_56.UUID)
        rawset(r82_0, r4_56.UUID, false)
      end
    end
  end,
}
FavoriteTab:[r94_0](r94_0)
r94_0 = "Section"
r94_0 = {
  Title = "Shop Features",
}
AutomaticTab = AutoTab:[r94_0](r94_0)
r94_0 = "Paragraph"
r94_0 = {
  Title = "MERCHANT STOCK PANEL",
  Desc = "Loading...",
}
ShopParagraph = AutomaticTab:[r94_0](r94_0)
r94_0 = "Button"
r94_0 = {
  Title = "Open/Close Merchant",
  Callback = function()
    -- line: [0, 0] id: 215
    local r0_215 = r9_0:FindFirstChild("Merchant")
    if r0_215 then
      r0_215.Enabled = not r0_215.Enabled
    end
  end,
}
AutomaticTab:[r94_0](r94_0)
function UPX()
  -- line: [0, 0] id: 306
  local r0_306 = {}
  for r4_306, r5_306 in ipairs(r18_0.ItemsFrame:GetChildren()) do
    if r5_306:IsA("ImageLabel") and r5_306.Name ~= "Frame" then
      local r6_306 = r5_306:FindFirstChild("Frame")
      if r6_306 and r6_306:FindFirstChild("ItemName") then
        local r7_306 = r6_306.ItemName.Text
        if not string.find(r7_306, "Mystery") then
          table.insert(r0_306, "- " .. r7_306)
        end
      end
    end
  end
  if #r0_306 == 0 then
    ShopParagraph:SetDesc("No items found\n" .. r18_0.RefreshMerchant.Text)
  else
    ShopParagraph:SetDesc(table.concat(r0_306, "\n") .. "\n\n" .. r18_0.RefreshMerchant.Text)
  end
end
task.spawn(function()
  -- line: [0, 0] id: 61
  while task.wait(1) do
    pcall(UPX)
  end
end)
AutomaticTab:Divider()
local r92_0 = AutomaticTab
r94_0 = "Dropdown"
r94_0 = {
  Title = "Select Rod",
}
r94_0.Values = r49_0.Rod or {}
function r94_0.Callback(r0_73)
  -- line: [0, 0] id: 73
  r53_0 = r0_73
end
r92_0:[r94_0](r94_0)
r94_0 = "Button"
r94_0 = {
  Title = "Buy Selected Rod",
  Callback = function()
    -- line: [0, 0] id: 148
    if not r53_0 then
      return r88_0("Select rod first!")
    end
    local r0_148 = RodLookupList[r53_0]
    if not r0_148 then
      return r88_0("Rod ID not found!")
    end
    pcall(function()
      -- line: [0, 0] id: 149
      r20_0.RF_PurchaseRod:InvokeServer(r0_148)
    end)
  end,
}
AutomaticTab:[r94_0](r94_0)
AutomaticTab:Divider()
r92_0 = AutomaticTab
r94_0 = "Dropdown"
r94_0 = {
  Title = "Select Bait",
}
r94_0.Values = r49_0.Bait or {}
function r94_0.Callback(r0_124)
  -- line: [0, 0] id: 124
  r54_0 = r0_124
end
r92_0:[r94_0](r94_0)
r94_0 = "Button"
r94_0 = {
  Title = "Buy Selected Bait",
  Callback = function()
    -- line: [0, 0] id: 38
    if not r54_0 then
      return r88_0("Select bait first!")
    end
    local r0_38 = BaitLookupList[r54_0]
    if not r0_38 then
      return r88_0("Bait ID not found!")
    end
    pcall(function()
      -- line: [0, 0] id: 39
      r20_0.RF_PurchaseBait:InvokeServer(r0_38)
    end)
  end,
}
AutomaticTab:[r94_0](r94_0)
AutomaticTab:Divider()
r92_0 = AutomaticTab
r94_0 = "Dropdown"
r94_0 = {
  Title = "Select Bait",
}
r94_0.Values = r49_0.Bait or {}
function r94_0.Callback(r0_146)
  -- line: [0, 0] id: 146
  r54_0 = r0_146
end
r92_0:[r94_0](r94_0)
r94_0 = "Button"
r94_0 = {
  Title = "Buy Selected Bait",
  Callback = function()
    -- line: [0, 0] id: 40
    if not r54_0 then
      return r88_0("Select bait first!")
    end
    local r0_40 = BaitLookupList[r54_0]
    if not r0_40 then
      return r88_0("Bait ID not found!")
    end
    pcall(function()
      -- line: [0, 0] id: 41
      r20_0.RF_PurchaseBait:InvokeServer(r0_40)
    end)
  end,
}
AutomaticTab:[r94_0](r94_0)
AutomaticTab:Divider()
r92_0 = AutomaticTab
r94_0 = "Dropdown"
r94_0 = {
  Title = "Select Weather",
}
r94_0.Values = {
  "Cloudy ($10,000)",
  "Wind ($10,000)",
  "Snow ($15,000)",
  "Storm ($35,000)",
  "Radiant ($50,000)",
  "Shark Hunt ($300,000)"
}
r94_0.Multi = true
r94_0.AllowNone = true
function r94_0.Callback(r0_80)
  -- line: [0, 0] id: 80
  r31_0.selectedEvents = {}
  if type(r0_80) == "table" then
    for r4_80, r5_80 in ipairs(r0_80) do
      table.insert(r31_0.selectedEvents, r5_80:match("^(.-) %(") or r5_80)
    end
  end
end
WeatherDropdown = r92_0:[r94_0](r94_0)
r94_0 = "Register"
r94_0 = "WeatherDropdown"
r86_0:[r94_0](r94_0, WeatherDropdown)
r94_0 = "Toggle"
r94_0 = {
  Title = "Auto Buy Weather",
  Value = false,
  Callback = function(r0_254)
    -- line: [0, 0] id: 254
    r31_0.autoBuyWeather = r0_254
    if not r20_0.RF_Weather then
      return 
    end
    if r0_254 then
      task.spawn(function()
        -- line: [0, 0] id: 255
        while r31_0.autoBuyWeather do
          local r0_255 = WeatherDropdown.Value or WeatherDropdown.Selected or {}
          local r1_255 = {}
          if type(r0_255) == "table" then
            for r5_255, r6_255 in ipairs(r0_255) do
              table.insert(r1_255, r6_255:match("^(.-) %(") or r6_255)
            end
          elseif type(r0_255) == "string" then
            table.insert(r1_255, r0_255:match("^(.-) %(") or r0_255)
          end
          if #r1_255 > 0 then
            local r2_255 = {}
            local r3_255 = workspace:FindFirstChild("Weather")
            if r3_255 then
              for r7_255, r8_255 in ipairs(r3_255:GetChildren()) do
                table.insert(r2_255, string.lower(r8_255.Name))
              end
            end
            for r7_255, r8_255 in ipairs(r1_255) do
              local r9_255 = string.lower(r8_255)
              local r10_255 = r8_255
              if not table.find(r2_255, r9_255) then
                pcall(function()
                  -- line: [0, 0] id: 256
                  r20_0.RF_Weather:InvokeServer(r10_255)
                end)
                task.wait(0.05)
              end
              -- close: r10_255
            end
          end
          task.wait(0.1)
        end
      end)
    end
  end,
}
WeatherToggle = AutomaticTab:[r94_0](r94_0)
r94_0 = "Register"
r94_0 = "WeatherToggle"
r86_0:[r94_0](r94_0, WeatherToggle)
r94_0 = "Section"
r94_0 = {
  Title = "Enchant Features",
}
EnchantSection = AutoTab:[r94_0](r94_0)
r31_0.TargetEnchant = "Big Hunter I"
r31_0.EnchantRunning = false
function r92_0(r0_247)
  -- line: [0, 0] id: 247
  local r1_247 = false
  local r2_247 = "None"
  local r3_247 = "None"
  local r4_247 = 0
  local r5_247 = {}
  local r6_247 = r28_0:Get("EquippedItems") or {}
  local r7_247 = r28_0:Get({
    "Inventory",
    "Fishing Rods"
  }) or {}
  for r11_247, r12_247 in pairs(r6_247) do
    for r16_247, r17_247 in ipairs(r7_247) do
      if r17_247.UUID == r12_247 then
        local r18_247 = r24_0:GetItemData(r17_247.Id)
        if r18_247 then
          r2_247 = r18_247.Data.Name or r17_247.ItemName or "None"
        else
          goto label_43	-- block#9 is visited secondly
        end
        if r17_247.Metadata and r17_247.Metadata.EnchantId then
          local r19_247 = r24_0:GetEnchantData(r17_247.Metadata.EnchantId)
          if r19_247 then
            local r20_247 = r19_247.Data.Name
            if r20_247 then
              r3_247 = r20_247
              r1_247 = true
            end
          end
          if not r1_247 then
            r3_247 = "None"
          end
        end
      end
      r1_247 = false
    end
  end
  for r11_247, r12_247 in pairs(r28_0:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r13_247 = r24_0:GetItemData(r12_247.Id)
    if r13_247 and r13_247.Data.Type == "Enchant Stones" and r12_247.Id == r0_247 then
      r4_247 = r4_247 + 1
      table.insert(r5_247, r12_247.UUID)
    end
  end
  return r2_247, r3_247, r4_247, r5_247
end
local r95_0 = "Paragraph"
r95_0 = {
  Title = "Enchant Status",
  Desc = "Current Rod : None\nCurrent Enchant : None\nEnchant Stones Left : 0",
}
EnchantParagraph = EnchantSection:[r95_0](r95_0)
r93_0 = EnchantSection
r95_0 = "Dropdown"
r95_0 = {
  Title = "Select Enchant Target",
  Desc = "THis will repeat until u get the selected enchant!",
}
r95_0.Values = {
  "Big Hunter I",
  "Cursed I",
  "Empowered I",
  "Glistening I",
  "Gold Digger I",
  "Leprechaun I",
  "Leprechaun II",
  "Mutation Hunter I",
  "Mutation Hunter II",
  "Prismatic I",
  "Reeler I",
  "Stargazer I",
  "Stormhunter I",
  "XPerienced I"
}
r95_0.Value = "Big Hunter I"
function r95_0.Callback(r0_129)
  -- line: [0, 0] id: 129
  r31_0.TargetEnchant = r0_129
end
r93_0:[r95_0](r95_0)
r95_0 = "Toggle"
r95_0 = {
  Title = "Auto Enchant",
  Desc = "Automatically enchants until it reaches ur selected enchant target!",
  Value = false,
  Callback = function(r0_66)
    -- line: [0, 0] id: 66
    r31_0.EnchantRunning = r0_66
    task.spawn(function()
      -- line: [0, 0] id: 67
      while r31_0.EnchantRunning do
        local r0_67, r1_67, r2_67, r3_67 = r92_0(10)
        EnchantParagraph:SetDesc(("Current Rod : %s\nCurrent Enchant : %s\nEnchant Stones Left : %d"):format(r0_67, r1_67, r2_67))
        if tostring(r1_67):gsub("%s", "") == tostring(r31_0.TargetEnchant):gsub("%s", "") then
          EnchantParagraph:SetDesc("<font color=\'rgb(0,255,0)\'>SUCCESS: " .. r31_0.TargetEnchant .. " Acquired!</font>")
          r31_0.EnchantRunning = false
          break
        elseif r2_67 <= 0 then
          EnchantParagraph:SetDesc("<font color=\'rgb(255,0,0)\'>Stopped: No enchant stones left.</font>")
          r31_0.EnchantRunning = false
          break
        else
          local r4_67 = nil
          local r5_67 = tick()
          while tick() - r5_67 < 5 do
            local r6_67 = r31_0.EnchantRunning
            if r6_67 then
              r6_67 = pairs
              for r9_67, r10_67 in r6_67(r28_0:Get("EquippedItems") or {}) do
                if r10_67 == r3_67[1] then
                  r4_67 = r9_67
                  break
                end
              end
              if not r4_67 then
                r20_0.RE_EquipItem:FireServer(r3_67[1], "Enchant Stones")
                task.wait(0.3)
              else
                break
              end
            else
              break
            end
          end
          if not r4_67 then
            task.wait(1)
          else
            r20_0.RE_Equip:FireServer(r4_67)
            task.wait(0.2)
            r20_0.RE_Altar:FireServer()
            task.wait(1.5)
          end
        end
      end
    end)
  end,
}
EnchantSection:[r95_0](r95_0)
r95_0 = "Button"
r95_0 = {
  Title = "Teleport Enchant Altar",
  Callback = function()
    -- line: [0, 0] id: 55
    local r0_55 = r6_0.Character or r6_0.CharacterAdded:Wait()
    local r1_55 = r0_55:FindFirstChild("HumanoidRootPart")
    local r2_55 = r0_55:FindFirstChildOfClass("Humanoid")
    if r1_55 and r2_55 then
      r1_55.CFrame = CFrame.new(Vector3.new(3258, -1301, 1391))
      r2_55:ChangeState(Enum.HumanoidStateType.Physics)
      task.wait(0.1)
      r2_55:ChangeState(Enum.HumanoidStateType.Running)
    end
  end,
}
EnchantSection:[r95_0](r95_0)
EnchantSection:Divider()
r95_0 = "Button"
r95_0 = {
  Title = "Click Double Enchant",
  Desc = "Starting Double Enchanting",
  Callback = function()
    -- line: [0, 0] id: 8
    task.spawn(function()
      -- line: [0, 0] id: 9
      local r0_9, r1_9, r2_9, r3_9 = r92_0(246)
      if r0_9 == "None" or r2_9 <= 0 then
        EnchantParagraph:SetDesc(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_9, r1_9, r2_9))
        return 
      end
      local r4_9 = nil
      local r5_9 = tick()
      while tick() - r5_9 < 5 do
        local r6_9 = pairs
        for r11_9, r12_9 in r6_9(r28_0:Get("EquippedItems") or {}) do
          if r12_9 == r3_9[1] then
            r4_9 = r11_9
          end
        end
        if not r4_9 then
          r20_0.RE_EquipItem:FireServer(r3_9[1], "Enchant Stones")
          task.wait(0.3)
        else
          break
        end
      end
      if not r4_9 then
        return 
      end
      r20_0.RE_Equip:FireServer(r4_9)
      task.wait(0.2)
      r20_0.RE_Altar2:FireServer()
      task.wait(1.5)
      local r6_9, r7_9 = r92_0(246)
      EnchantParagraph:SetDesc(("Current Rod : <font color=\'rgb(0,170,255)\'>%s</font>\nCurrent Enchant : <font color=\'rgb(0,170,255)\'>%s</font>\nEnchant Stones Left : <font color=\'rgb(0,170,255)\'>%d</font>"):format(r0_9, r7_9, r2_9 - 1))
    end)
  end,
}
EnchantSection:[r95_0](r95_0)
r95_0 = "Button"
r95_0 = {
  Title = "Teleport Second Enchant Altar",
  Callback = function()
    -- line: [0, 0] id: 121
    local r0_121 = r6_0.Character or r6_0.CharacterAdded:Wait()
    local r1_121 = r0_121:FindFirstChild("HumanoidRootPart")
    local r2_121 = r0_121:FindFirstChildOfClass("Humanoid")
    if r1_121 and r2_121 then
      r1_121.CFrame = CFrame.new(Vector3.new(1480, 128, -593))
      r2_121:ChangeState(Enum.HumanoidStateType.Physics)
      task.wait(0.1)
      r2_121:ChangeState(Enum.HumanoidStateType.Running)
    end
  end,
}
EnchantSection:[r95_0](r95_0)
r95_0 = "Section"
r95_0 = {
  Title = "Totem Features",
}
TotemSection = AutoTab:[r95_0](r95_0)
r95_0 = "Paragraph"
r95_0 = {
  Title = "Panel Activated Totem",
  Desc = "Scanning Totems...",
}
TotemPanel = TotemSection:[r95_0](r95_0)
r95_0 = "Paragraph"
r95_0 = {
  Title = "Auto Totem Status",
  Desc = "Idle",
}
HeaderPanel = TotemSection:[r95_0](r95_0)
function GetTT()
  -- line: [0, 0] id: 270
  local r0_270 = r6_0.Character
  if r0_270 then
    r0_270 = r6_0.Character:FindFirstChild("HumanoidRootPart") and (r6_0.Character.HumanoidRootPart.Position or Vector3.zero)
  else
    goto label_17	-- block#3 is visited secondly
  end
  local r1_270 = {}
  for r5_270, r6_270 in pairs(workspace.Totems:GetChildren()) do
    if r6_270:IsA("Model") then
      local r7_270 = r6_270:FindFirstChild("Handle")
      local r8_270 = r7_270 and r7_270:FindFirstChild("Overhead")
      local r9_270 = r8_270 and r8_270:FindFirstChild("Content")
      local r10_270 = r9_270 and r9_270:FindFirstChild("Header")
      local r11_270 = r9_270 and r9_270:FindFirstChild("TimerLabel")
      local r12_270 = (r0_270 - r6_270:GetPivot().Position).Magnitude
      local r13_270 = nil	-- notice: implicit variable refs by block#[20]
      if r11_270 then
        r13_270 = r11_270.Text
        if not r13_270 then
          ::label_65::
          r13_270 = "??"
        end
      else
        goto label_65	-- block#16 is visited secondly
      end
      local r14_270 = nil	-- notice: implicit variable refs by block#[20]
      if r10_270 then
        r14_270 = r10_270.Text
        if not r14_270 then
          ::label_71::
          r14_270 = "??"
        end
      else
        goto label_71	-- block#19 is visited secondly
      end
      table.insert(r1_270, {
        Name = r14_270,
        Distance = r12_270,
        TimeLeft = r13_270,
      })
    end
  end
  return r1_270
end
function UpdTT()
  -- line: [0, 0] id: 196
  local r0_196 = GetTT()
  if #r0_196 == 0 then
    TotemPanel:SetDesc("No active totems detected")
    return 
  end
  local r1_196 = {}
  for r5_196, r6_196 in ipairs(r0_196) do
    table.insert(r1_196, string.format("%s • %.1f studs • %s", r6_196.Name, r6_196.Distance, r6_196.TimeLeft))
  end
  TotemPanel:SetDesc(table.concat(r1_196, "\n"))
end
task.spawn(function()
  -- line: [0, 0] id: 132
  while task.wait(1) do
    pcall(UpdTT)
  end
end)
function GetTTUUID(r0_12)
  -- line: [0, 0] id: 12
  if not Data then
    Data = r21_0.Client:WaitReplion("Data")
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
  for r5_12, r6_12 in ipairs(Data:GetExpect({
    "Inventory",
    "Totems"
  }) or {}) do
    local r7_12 = "Unknown Totem"
    if typeof(Totems) == "table" then
      for r11_12, r12_12 in pairs(Totems) do
        if r12_12.Data and r12_12.Data.Id == r6_12.Id then
          r7_12 = r12_12.Data.Name
          break
        end
      end
    end
    if r7_12 == r0_12 then
      return r6_12.UUID, r7_12
    end
  end
  return nil
end
function r93_0()
  -- line: [0, 0] id: 168
  if RealTotemPanel and RealTotemPanel.Show then
    RealTotemPanel:Show()
  end
end
local r96_0 = "Button"
r96_0 = {
  Title = "Teleport To Nearest Totem",
  Callback = function()
    -- line: [0, 0] id: 285
    local r0_285 = r6_0.Character and r6_0.Character:FindFirstChild("HumanoidRootPart")
    if not r0_285 then
      return 
    end
    local r1_285 = GetTT()
    if #r1_285 == 0 then
      return 
    end
    table.sort(r1_285, function(r0_286, r1_286)
      -- line: [0, 0] id: 286
      return r0_286.Distance < r1_286.Distance
    end)
    local r2_285 = r1_285[1]
    for r6_285, r7_285 in pairs(workspace.Totems:GetChildren()) do
      if r7_285:IsA("Model") then
        local r8_285 = r7_285:GetPivot().Position
        if math.abs((r8_285 - r0_285.Position).Magnitude - r2_285.Distance) < 1 then
          r0_285.CFrame = CFrame.new(r8_285 + Vector3.new(0, 3, 0))
          break
        end
      end
    end
  end,
}
TotemSection:[r96_0](r96_0)
TotemsFolder = r3_0:WaitForChild("Totems")
r31_0.Totems = r31_0.Totems or {}
r31_0.TotemDisplayName = r31_0.TotemDisplayName or {}
for r97_0, r98_0 in ipairs(TotemsFolder:GetChildren()) do
  local r101_0 = "IsA"
  r101_0 = "ModuleScript"
  local r99_0 = r98_0:[r101_0](r101_0)
  if r99_0 then
    local r99_0, r100_0 = pcall(require, r98_0)
    if r99_0 then
      r101_0 = typeof(r100_0)
      local r102_0 = "table"
      if r101_0 == r102_0 then
        r101_0 = r100_0.Data
        if r101_0 then
          r102_0 = "Name"
          r101_0 = r100_0.Data[r102_0] or "Unknown"
          r102_0 = r100_0.Data.Id or "Unknown"
          local r103_0 = {
            Name = r101_0,
            Id = r102_0,
          }
          r31_0.Totems[r102_0] = r103_0
          r31_0.Totems[r101_0] = r103_0
          table.insert(r31_0.TotemDisplayName, r101_0)
        end
      end
    end
  end
end
selectedTotem = nil
r94_0 = TotemSection
r96_0 = "Dropdown"
r96_0 = {
  Title = "Select Totem to Auto Place",
}
local r97_0 = "Values"
local r98_0 = r31_0.TotemDisplayName
if not r98_0 then
  r98_0 = {}
  local r99_0 = "No Totems Found"
  -- setlist for #98 failed
end
r96_0[r97_0] = r98_0
r97_0 = "Value"
r98_0 = r31_0.TotemDisplayName
if r98_0 then
  r98_0 = r31_0.TotemDisplayName[1] or "No Totems Found"
else
  goto label_2573	-- block#69 is visited secondly
end
r96_0[r97_0] = r98_0
function r96_0.Callback(r0_226)
  -- line: [0, 0] id: 226
  selectedTotem = r0_226
end
r94_0:[r96_0](r96_0)
r96_0 = "Toggle"
r96_0 = {
  Title = "Auto Place Totem",
  Desc = "Place Totem every 60 minutes automatically",
  Value = false,
  Callback = function(r0_218)
    -- line: [0, 0] id: 218
    r31_0.TotemActive = r0_218
    if not r0_218 then
      HeaderPanel:SetDesc("Auto Totem Disabled")
      r93_0()
      return 
    end
    if not selectedTotem then
      HeaderPanel:SetDesc("Please select a Totem first!")
      r31_0.TotemActive = false
      return 
    end
    task.spawn(function()
      -- line: [0, 0] id: 219
      HeaderPanel:SetDesc(("Auto Totem Enabled [%s]"):format(selectedTotem))
      local r0_219 = 0
      while true do
        local r1_219 = r31_0.TotemActive
        if r1_219 then
          r1_219 = nil
          local r2_219 = 0
          while true do
            r1_219 = select(1, GetTTUUID(selectedTotem))
            r2_219 = r2_219 + 1
            if r31_0.TotemActive then
              if not r1_219 then
                HeaderPanel:SetDesc(("Looking for Totem... (Try %s)"):format(r2_219))
                task.wait(2)
              end
              if not r1_219 and 15 > r2_219 then
                goto label_41	-- block#7 is visited secondly
              else
                break
              end
            else
              break
            end
          end
          if r31_0.TotemActive then
            if not r1_219 then
              HeaderPanel:SetDesc("No usable Totem found. Waiting 20s and retrying...")
              task.wait(20)
              break
            else
              pcall(function()
                -- line: [0, 0] id: 220
                r20_0.RE_Totem:FireServer(r1_219)
              end)
              r0_219 = r0_219 + 1
              HeaderPanel:SetDesc(("Totem Placed [%s] | Next in 60m"):format(selectedTotem))
              for r6_219 = 3600, 1, -1 do
                if not r31_0.TotemActive then
                  break
                else
                  task.wait(1)
                end
              end
              -- close: r1_219
            end
          else
            break
          end
        else
          break
        end
      end
      local r1_219 = HeaderPanel
      r1_219:SetDesc("Auto Totem Disabled")
      r1_219 = r93_0
      r1_219()
    end)
  end,
}
TotemSection:[r96_0](r96_0)
r96_0 = "Section"
r96_0 = {
  Title = "Potions Features",
}
PotionSection = AutoTab:[r96_0](r96_0)
PotionsFolder = r3_0:WaitForChild("Potions")
r31_0.Potions = r31_0.Potions or {}
r31_0.PotionDisplayName = r31_0.PotionDisplayName or {}
for r97_0, r98_0 in ipairs(PotionsFolder:GetChildren()) do
  local r101_0 = "IsA"
  r101_0 = "ModuleScript"
  local r99_0 = r98_0:[r101_0](r101_0)
  if r99_0 then
    local r99_0, r100_0 = pcall(require, r98_0)
    if r99_0 then
      r101_0 = typeof(r100_0)
      local r102_0 = "table"
      if r101_0 == r102_0 then
        r101_0 = r100_0.Data
        if r101_0 then
          r102_0 = "Name"
          r101_0 = r100_0.Data[r102_0] or "Unknown"
          r102_0 = r100_0.Data.Id or "Unknown"
          local r104_0 = string.lower(r101_0)
          local r103_0 = string.find(r104_0, "totem")
          if not r103_0 then
            r103_0 = {}
            r103_0.Name = r101_0
            r103_0.Id = r102_0
            r31_0.Potions[r102_0] = r103_0
            r31_0.Potions[r101_0] = r103_0
            table.insert(r31_0.PotionDisplayName, r101_0)
          end
        end
      end
    end
  end
end
r94_0 = {}
r97_0 = "Dropdown"
r97_0 = {
  Title = "Select Potions",
  Values = r31_0.PotionDisplayName,
  Multi = true,
  AllowNone = true,
  Callback = function(r0_42)
    -- line: [0, 0] id: 42
    if typeof(r0_42) == "table" then
      r94_0 = r0_42
    else
      r94_0 = {
        r0_42
      }
    end
  end,
}
PotionSection:[r97_0](r97_0)
r97_0 = "Toggle"
r97_0 = {
  Title = "Auto Use Potions",
  Value = false,
  Callback = function(r0_105)
    -- line: [0, 0] id: 105
    r31_0.AutoUsePotions = r0_105
    task.spawn(function()
      -- line: [0, 0] id: 106
      task.wait(1)
      local r0_106 = r28_0:GetExpect({
        "Inventory",
        "Potions"
      }) or {}
      for r4_106, r5_106 in ipairs(r94_0) do
        local r6_106 = r31_0.Potions[r5_106]
        if r6_106 then
          for r10_106, r11_106 in ipairs(r0_106) do
            if tostring(r11_106.Id) == tostring(r6_106.Id) then
              pcall(function()
                -- line: [0, 0] id: 107
                r20_0.RF_Potion:InvokeServer(r11_106, 1)
              end)
              -- close: r7_106
              break
            else
              -- close: r10_106
            end
          end
        end
      end
    end)
  end,
}
PotionSection:[r97_0](r97_0)
r97_0 = "Section"
r97_0 = {
  Title = "Event Features",
}
EventSection = AutoTab:[r97_0](r97_0)
r95_0 = EventSection
r97_0 = "Dropdown"
r97_0 = {
  Title = "Select Event",
}
r97_0.Values = r76_0() or {}
function r97_0.Callback(r0_268)
  -- line: [0, 0] id: 268
  r70_0 = r0_268
end
r95_0:[r97_0](r97_0)
r97_0 = "Toggle"
r97_0 = {
  Title = "Auto Event",
  Value = false,
  Callback = function(r0_207)
    -- line: [0, 0] id: 207
    r69_0 = r0_207
    SetWalkOnWater(r0_207)
    if r0_207 and r70_0 then
      r72_0 = r72_0 and r75_0(r6_0.Character).CFrame
      task.spawn(EventLoop)
    else
      if r72_0 then
        r6_0.Character:PivotTo(r72_0)
        r88_0("Auto Event Off")
      end
      r71_0 = nil
      r72_0 = nil
    end
  end,
}
EventSection:[r97_0](r97_0)
EventSection:Divider()
r97_0 = "Paragraph"
r97_0 = {
  Title = "Ancient Lochness Monster Countdown",
  Desc = "<font color=\'#FF4D4D\'><b>waiting for ... for joined event!</b></font>",
}
countdownParagraph = EventSection:[r97_0](r97_0)
r31_0.FarmPosition = r31_0.FarmPosition or nil
r31_0.autoCountdownUpdate = false
r97_0 = "Toggle"
r97_0 = {
  Title = "Auto Admin Event",
  Value = false,
  Callback = function(r0_278)
    -- line: [0, 0] id: 278
    r31_0.autoCountdownUpdate = r0_278
    function getLabel()
      -- line: [0, 0] id: 281
      local r0_281, r1_281 = pcall(function()
        -- line: [0, 0] id: 282
        return workspace["!!! MENU RINGS"]["Event Tracker"].Main.Gui.Content.Items.Countdown.Label
      end)
      local r2_281 = nil	-- notice: implicit variable refs by block#[3]
      if r0_281 then
        r2_281 = r1_281
        if r2_281 then
          ::label_7::
          r2_281 = nil
        end
      else
        goto label_7	-- block#2 is visited secondly
      end
      return r2_281
    end
    function toEvent(r0_284)
      -- line: [0, 0] id: 284
      r0_284.CFrame = CFrame.new(Vector3.new(6063, -586, 4715))
    end
    function backEvent(r0_283)
      -- line: [0, 0] id: 283
      if r31_0.FarmPosition then
        r0_283.CFrame = r31_0.FarmPosition
        countdownParagraph:SetDesc("<font color=\'#00FF99\'><b> Returned to saved farm position!</b></font>")
      else
        countdownParagraph:SetDesc("<font color=\'#FF4D4D\'><b> No saved farm position found!</b></font>")
      end
    end
    local r3_278 = nil	-- notice: implicit variable refs by block#[10, 11]
    if r0_278 then
      local r1_278 = (r6_0.Character or r6_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
      if r1_278 then
        r31_0.FarmPosition = r1_278.CFrame
        countdownParagraph:SetDesc(string.format("<font color=\'#00ff99\'><b>Farm position saved!</b></font>"))
      end
      local r2_278 = getLabel()
      if not r2_278 then
        countdownParagraph:SetDesc("<font color=\'#ff4d4d\'><b>Label not found!</b></font>")
        return 
      end
      r3_278 = r2_278
      task.spawn(function()
        -- line: [0, 0] id: 279
        local r0_279 = false
        while r31_0.autoCountdownUpdate do
          task.wait(1)
          local r1_279 = ""
          local r2_279 = r1_279
          pcall(function()
            -- line: [0, 0] id: 280
            r2_279 = r3_278.Text or ""
          end)
          if r2_279 == "" then
            countdownParagraph:SetDesc("<font color=\'#ff4d4d\'><b>Waiting for countdown...</b></font>")
          else
            countdownParagraph:SetDesc(string.format("<font color=\'#4AFFE7\'><b>Timer: %s</b></font>", r2_279))
            local r3_279 = (r6_0.Character or r6_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
            if not r3_279 then
              countdownParagraph:SetDesc("<font color=\'#ff4d4d\'><b>⚠️ HRP not found, retrying...</b></font>")
            else
              local r4_279, r5_279, r6_279 = r2_279:match("(%d+)H%s*(%d+)M%s*(%d+)S")
              local r7_279 = tonumber(r4_279)
              local r8_279 = tonumber(r5_279)
              r6_279 = tonumber(r6_279)
              r5_279 = r8_279
              r4_279 = r7_279
              if r4_279 == 3 and r5_279 == 59 and r6_279 == 59 and not r0_279 then
                countdownParagraph:SetDesc("<font color=\'#00ff99\'><b>Event started! Teleporting...</b></font>")
                toEvent(r3_279)
                r0_279 = true
              elseif r4_279 == 3 and r5_279 == 49 and r6_279 == 59 and r0_279 then
                countdownParagraph:SetDesc("<font color=\'#ffaa00\'><b>Event ended! Returning...</b></font>")
                backEvent(r3_279)
                r0_279 = false
              end
            end
          end
          if not r3_278 or not r3_278.Parent then
            r3_278 = getLabel()
            if not r3_278 then
              countdownParagraph:SetDesc("<font color=\'#ff4d4d\'><b>Label lost. Reconnecting...</b></font>")
              task.wait(2)
              r3_278 = getLabel()
            end
          end
          -- close: r2_279
        end
      end)
      -- close: r3_278
    else
      local r1_278 = r6_0.Character or r6_0.CharacterAdded:Wait()
      r3_278 = "HumanoidRootPart"
      r1_278 = r1_278:WaitForChild(r3_278, 5)
      if r1_278 then
        r3_278 = r1_278
        backEvent(r3_278)
      end
      countdownParagraph:SetDesc("<font color=\'#ff4d4d\'><b>Auto Admin Event disabled.</b></font>")
    end
  end,
}
EventSection:[r97_0](r97_0)
r97_0 = "Section"
r97_0 = {
  Title = "Save Position",
}
SavePosSection = AutoTab:[r97_0](r97_0)
r97_0 = "Paragraph"
r97_0 = {
  Title = "Tutorial Teleport",
  Desc = "\r\n<b><font color=\"rgb(252, 119, 216)\">AUTO TELEPORT?</font></b>\r\nClick <b><font color=\"rgb(252, 119, 216)\">Save Position</font></b> to save your current position!\r\n\r\n<b><font color=\"rgb(252, 119, 216)\">HOW TO LOAD?</font></b>\r\nThis feature will auto-sync your last position when executed, so you will teleport automatically!\r\n\r\n<b><font color=\"rgb(252, 119, 216)\">HOW TO RESET?</font></b>\r\nClick <b><font color=\"rgb(252, 119, 216)\">Reset Position</font></b> to clear your saved position.\r\n    ",
}
SavePosSection:[r97_0](r97_0)
r97_0 = "Button"
r97_0 = {
  Title = "Save Position",
  Callback = function()
    -- line: [0, 0] id: 166
    local r0_166 = r6_0.Character and r6_0.Character:FindFirstChild("HumanoidRootPart")
    if r0_166 then
      SavePosition(r0_166.CFrame)
      r88_0("Successfully saved position")
    end
  end,
}
SavePosSection:[r97_0](r97_0)
r97_0 = "Button"
r97_0 = {
  Title = "Reset Position",
  Callback = function()
    -- line: [0, 0] id: 21
    if isfile("Meng Hub/FishIt" .. "/Position.json") then
      delfile("Meng Hub/FishIt" .. "/Position.json")
    end
    r88_0("Successfully reset last position")
  end,
}
SavePosSection:[r97_0](r97_0)
function getGroupedByType(r0_65)
  -- line: [0, 0] id: 65
  local r1_65 = r28_0:GetExpect({
    "Inventory",
    "Items"
  })
  local r2_65 = {}
  local r3_65 = {}
  for r7_65, r8_65 in ipairs(r1_65) do
    local r9_65 = r24_0.GetItemDataFromItemType("Items", r8_65.Id)
    if r9_65 and r9_65.Data.Type == r0_65 and not r8_65.Favorited then
      local r10_65 = r9_65.Data.Name
      local r11_65 = r2_65[r10_65]
      if not r11_65 then
        r11_65 = {}
        r11_65.count = 0
        r11_65.uuids = {}
      end
      r2_65[r10_65] = r11_65
      r2_65[r10_65].count = r2_65[r10_65].count + (r8_65.Quantity or 1)
      table.insert(r2_65[r10_65].uuids, r8_65.UUID)
    end
  end
  for r7_65, r8_65 in pairs(r2_65) do
    table.insert(r3_65, ("%s x%d"):format(r7_65, r8_65.count))
  end
  return r2_65, r3_65
end
r97_0 = "Section"
r97_0 = {
  Title = "Trading Fish Features",
}
TradeFishSection = TradeTab:[r97_0](r97_0)
r97_0 = "Section"
r97_0 = {
  Title = "Trading Coin Features",
}
TradeCoinSection = TradeTab:[r97_0](r97_0)
r97_0 = "Paragraph"
r97_0 = {
  Title = "Panel Fish Trading",
  Content = "\r\nPlayer : ???\r\nItem   : ???\r\nAmount : 0\r\nStatus : Idle\r\nSuccess: 0 / 0\r\n",
}
TradePanel = TradeFishSection:[r97_0](r97_0)
r97_0 = "Paragraph"
r97_0 = {
  Title = "Panel Coin Trading",
  Content = "\r\nPlayer   : ???\r\nTarget   : 0\r\nProgress : 0 / 0\r\nStatus   : Idle\r\nResult   : Success : 0 | Received : 0\r\n",
}
TradeCoinPanel = TradeCoinSection:[r97_0](r97_0)
function _G.safeSetContent(r0_137, r1_137)
  -- line: [0, 0] id: 137
  r2_0.Heartbeat:Once(function()
    -- line: [0, 0] id: 138
    if r0_137 then
      r0_137:SetDesc(r1_137)
    end
  end)
end
function r95_0(r0_164)
  -- line: [0, 0] id: 164
  local r1_164 = r31_0.Trade
  local r2_164 = "200,200,200"
  if r0_164 and r0_164:lower():find("send") then
    r2_164 = "51,153,255"
  elseif r0_164 and r0_164:lower():find("complete") then
    r2_164 = "0,204,102"
  elseif r0_164 and r0_164:lower():find("time") then
    r2_164 = "255,69,0"
  end
  local r3_164 = string.format
  local r4_164 = "\r\n<font color=\'rgb(173,216,230)\'>Player : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Item   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Amount : %d</font>\r\n<font color=\'rgb(%s)\'>Status : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Success: %d / %d</font>\r\n"
  local r5_164 = r1_164.selectedPlayerTrade or "???"
  local r6_164 = r1_164.selectedItem or "???"
  local r7_164 = r1_164.tradeAmount or 0
  local r8_164 = r2_164
  local r9_164 = r0_164 or "Idle"
  local r10_164 = r1_164.successCount or 0
  _G.safeSetContent(TradePanel, r3_164(r4_164, r5_164, r6_164, r7_164, r8_164, r9_164, r10_164, r1_164.totalToTrade or 0))
end
function r96_0(r0_2)
  -- line: [0, 0] id: 2
  local r1_2 = r31_0.Trade
  local r2_2 = "200,200,200"
  if r0_2 and r0_2:lower():find("send") then
    r2_2 = "51,153,255"
  elseif r0_2 and r0_2:lower():find("progress") then
    r2_2 = "255,215,0"
  elseif r0_2 and r0_2:lower():find("complete") then
    r2_2 = "0,204,102"
  elseif r0_2 and r0_2:lower():find("time") then
    r2_2 = "255,69,0"
  end
  local r3_2 = string.format
  local r4_2 = "\r\n<font color=\'rgb(173,216,230)\'>Player   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Target   : %d</font>\r\n<font color=\'rgb(173,216,230)\'>Progress : %d / %d</font>\r\n<font color=\'rgb(%s)\'>Status   : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Result   : Success : %d | Received : %d</font>\r\n"
  local r5_2 = r1_2.selectedPlayerTrade or "???"
  local r6_2 = r1_2.targetCoins or 0
  local r7_2 = r1_2.successCoins or 0
  local r8_2 = r1_2.targetCoins or 0
  local r9_2 = r2_2
  local r10_2 = r0_2 or "Idle"
  local r11_2 = r1_2.successCoins or 0
  _G.safeSetContent(TradeCoinPanel, r3_2(r4_2, r5_2, r6_2, r7_2, r8_2, r9_2, r10_2, r11_2, r1_2.totalReceived or 0))
end
function r97_0(r0_165)
  -- line: [0, 0] id: 165
  for r4_165, r5_165 in ipairs(r28_0:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r6_165 = r5_165.UUID
    if r6_165 == r0_165 then
      r6_165 = true
      return r6_165
    end
  end
  return false
end
function r98_0(r0_109, r1_109, r2_109, r3_109)
  -- line: [0, 0] id: 109
  local r4_109 = r31_0.Trade
  r4_109.lastResult = nil
  r4_109.awaiting = true
  local r5_109 = false
  local r6_109 = r1_0:FindFirstChild(r0_109)
  if not r6_109 then
    r4_109.trading = false
    r95_0("<font color=\'#ff3333\'>Player not found</font>")
    r96_0("<font color=\'#ff3333\'>Player not found</font>")
    return false
  end
  if r2_109 then
    r95_0("Sending")
    r88_0("Sending " .. r2_109)
  else
    r96_0("Sending")
    r88_0("Sending fish for coins")
  end
  if not pcall(function()
    -- line: [0, 0] id: 110
    r20_0.RF_Trade:InvokeServer(r6_109.UserId, r1_109)
  end) then
    return false
  end
  local r7_109 = tick()
  while r4_109.trading and not r5_109 do
    local r8_109 = r97_0(r1_109)
    if not r8_109 then
      r5_109 = true
      if r2_109 then
        r8_109 = r4_109.rarityMode
        if not r8_109 then
          r8_109 = r4_109.successCount + 1
          r4_109.successCount = r8_109
        end
        r95_0("Completed")
      else
        r8_109 = r4_109.successCoins
        r4_109.successCoins = r8_109 + (r3_109 or 0)
        r4_109.totalReceived = r4_109.successCoins
        r96_0("Progress")
      end
    else
      r8_109 = tick() - r7_109
      if r8_109 > 10 then
        r8_109 = false
        return r8_109
      end
    end
    task.wait(0.2)
  end
  return r5_109
end
local function r99_0(r0_139, r1_139, r2_139, r3_139)
  -- line: [0, 0] id: 139
  local r4_139 = r31_0.Trade
  local r5_139 = 0
  while r5_139 < 3 and r4_139.trading do
    if r98_0(r0_139, r1_139, r2_139, r3_139) then
      task.wait(2.5)
      return true
    end
    r5_139 = r5_139 + 1
    task.wait(1)
  end
  return false
end
function startTradeByName()
  -- line: [0, 0] id: 127
  local r0_127 = r31_0.Trade
  if r0_127.trading then
    return 
  end
  if not r0_127.selectedPlayerTrade or not r0_127.selectedItem then
    return r88_0("Select player and item first!")
  end
  r0_127.trading = true
  r0_127.successCount = 0
  r88_0("Starting trade with " .. r0_127.selectedPlayerTrade)
  local r1_127 = r0_127.currentGrouped[r0_127.selectedItem]
  if not r1_127 then
    r0_127.trading = false
    r95_0("<font color=\'#ff3333\'>Item not found</font>")
    return r88_0("Item not found")
  end
  r0_127.totalToTrade = math.min(r0_127.tradeAmount, #r1_127.uuids)
  local r2_127 = 1
  while r0_127.trading do
    local r3_127 = r0_127.successCount
    if r3_127 < r0_127.totalToTrade then
      r99_0(r0_127.selectedPlayerTrade, r1_127.uuids[r2_127], r0_127.selectedItem)
      r2_127 = r2_127 + 1
      r3_127 = #r1_127.uuids
      if r3_127 < r2_127 then
        r2_127 = 1
      end
      task.wait(2)
    else
      break
    end
  end
  r0_127.trading = false
  r95_0("<font color=\'#66ccff\'>All trades finished</font>")
  r88_0("All trades finished")
end
function chooseFishesByRange(r0_23, r1_23)
  -- line: [0, 0] id: 23
  table.sort(r0_23, function(r0_24, r1_24)
    -- line: [0, 0] id: 24
    return r1_24.Price < r0_24.Price
  end)
  local r2_23 = {}
  local r3_23 = 0
  for r7_23, r8_23 in ipairs(r0_23) do
    if r3_23 + r8_23.Price <= r1_23 then
      table.insert(r2_23, r8_23)
      r3_23 = r3_23 + r8_23.Price
    end
    if r1_23 <= r3_23 then
      break
    end
  end
  if r3_23 < r1_23 and 0 < #r0_23 then
    table.insert(r2_23, r0_23[#r0_23])
  end
  return r2_23, r3_23
end
function startTradeByCoin()
  -- line: [0, 0] id: 302
  local r0_302 = r31_0.Trade
  if r0_302.trading then
    return 
  end
  if not r0_302.selectedPlayerTrade or r0_302.targetCoins <= 0 then
    return r88_0("�� Select player and coin target first!")
  end
  r0_302.trading = true
  r0_302.totalReceived = 0
  r0_302.successCoins = 0
  r0_302.sentCoins = 0
  r96_0("<font color=\'#ffaa00\'>Starting...</font>")
  r88_0("Starting coin trade with " .. r0_302.selectedPlayerTrade)
  local r2_302 = r26_0:GetPlayerModifiers(r1_0.LocalPlayer)
  local r3_302 = {}
  for r8_302, r9_302 in ipairs(r28_0:GetExpect({
    "Inventory",
    "Items"
  })) do
    if not r9_302.Favorited then
      local r10_302 = r24_0:GetItemData(r9_302.Id)
      if r10_302 and r10_302.Data and r10_302.Data.Type == "Fish" then
        local r11_302 = r25_0:GetSellPrice(r9_302) or r10_302.SellPrice or 0
        local r12_302 = math.ceil
        local r13_302 = nil	-- notice: implicit variable refs by block#[16]
        if r2_302 then
          r13_302 = r2_302.CoinMultiplier
          if not r13_302 then
            ::label_82::
            r13_302 = 1
          end
        else
          goto label_82	-- block#15 is visited secondly
        end
        r12_302 = r12_302(r11_302 * r13_302)
        if r12_302 > 0 then
          r13_302 = table.insert
          local r14_302 = r3_302
          local r15_302 = {
            UUID = r9_302.UUID,
            Name = r10_302.Data.Name or "Unknown",
            Price = r12_302,
          }
          r13_302(r14_302, r15_302)
        end
      end
    end
  end
  if #r3_302 == 0 then
    r0_302.trading = false
    r96_0("<font color=\'#ff3333\'>No fishes found</font>")
    r88_0("�� No fishes found in inventory")
    return 
  end
  local r5_302, r6_302 = chooseFishesByRange(r3_302, r0_302.targetCoins)
  if #r5_302 == 0 then
    r0_302.trading = false
    r96_0("<font color=\'#ff3333\'>No valid fishes for target</font>")
    return 
  end
  r0_302.totalToTrade = #r5_302
  r0_302.targetCoins = r6_302
  if not r1_0:FindFirstChild(r0_302.selectedPlayerTrade) then
    r0_302.trading = false
    r96_0("<font color=\'#ff3333\'>Player not found</font>")
    return 
  end
  for r10_302, r11_302 in ipairs(r5_302) do
    if r0_302.trading then
      r0_302.sentCoins = r0_302.sentCoins + r11_302.Price
      r96_0(string.format("<font color=\'#ffaa00\'>Progress : %d / %d</font>", r0_302.sentCoins, r0_302.targetCoins))
      r99_0(r0_302.selectedPlayerTrade, r11_302.UUID, nil, r11_302.Price)
      r0_302.successCoins = r0_302.sentCoins
      task.wait(2)
    else
      break
    end
  end
  r0_302.trading = false
  r96_0(string.format("<font color=\'#66ccff\'>Coin trade finished (Target: %d, Received: %d)</font>", r0_302.targetCoins, r0_302.successCoins))
  r88_0(string.format("Coin trade finished (Target: %d, Received: %d)", r0_302.targetCoins, r0_302.successCoins))
end
local r102_0 = "Dropdown"
r102_0 = {
  Title = "Select Item",
}
r102_0.Values = {}
function r102_0.Callback(r0_30)
  -- line: [0, 0] id: 30
  local r1_30 = r31_0.Trade
  local r2_30 = nil	-- notice: implicit variable refs by block#[3]
  if r0_30 then
    r2_30 = r0_30:match("^(.-) x")
    if not r2_30 then
      ::label_9::
      r2_30 = r0_30
    end
  else
    goto label_9	-- block#2 is visited secondly
  end
  r1_30.selectedItem = r2_30
  r95_0()
end
local r100_0 = TradeFishSection:[r102_0](r102_0)
local r103_0 = "Button"
r103_0 = {
  Title = "Refresh Fish",
  Callback = function()
    -- line: [0, 0] id: 262
    local r0_262, r1_262 = getGroupedByType("Fish")
    r31_0.Trade.currentGrouped = r0_262
    r100_0:Refresh(r1_262 or {})
  end,
}
TradeFishSection:[r103_0](r103_0)
r103_0 = "Button"
r103_0 = {
  Title = "Refresh Stones",
  Callback = function()
    -- line: [0, 0] id: 170
    local r0_170, r1_170 = getGroupedByType("Enchant Stones")
    r31_0.Trade.currentGrouped = r0_170
    r100_0:Refresh(r1_170 or {})
  end,
}
TradeFishSection:[r103_0](r103_0)
TradeFishSection:Divider()
r103_0 = "Input"
r103_0 = {
  Title = "Amount to Trade",
  Value = "1",
  Callback = function(r0_128)
    -- line: [0, 0] id: 128
    r31_0.Trade.tradeAmount = tonumber(r0_128) or 1
  end,
}
TradeFishSection:[r103_0](r103_0)
r103_0 = "Dropdown"
r103_0 = {
  Title = "Select Player",
  Values = r57_0(),
  Callback = function(r0_54)
    -- line: [0, 0] id: 54
    r31_0.Trade.selectedPlayerTrade = r0_54
  end,
}
local r101_0 = TradeFishSection:[r103_0](r103_0)
local r104_0 = "Button"
r104_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 222
    local r0_222 = {}
    for r4_222, r5_222 in ipairs(r1_0:GetPlayers()) do
      if r5_222 ~= r6_0 then
        table.insert(r0_222, r5_222.Name)
      end
    end
    r101_0:Refresh(r0_222)
  end,
}
TradeFishSection:[r104_0](r104_0)
r104_0 = "Toggle"
r104_0 = {
  Title = "Start Fish Trade",
  Value = false,
  Callback = function(r0_46)
    -- line: [0, 0] id: 46
    local r1_46 = r31_0.Trade
    if r0_46 then
      task.spawn(startTradeByName)
    else
      r1_46.trading = false
      r95_0()
    end
  end,
}
TradeFishSection:[r104_0](r104_0)
r104_0 = "Dropdown"
r104_0 = {
  Title = "Select Player",
  Values = r57_0(),
  Callback = function(r0_92)
    -- line: [0, 0] id: 92
    r31_0.Trade.selectedPlayerTrade = r0_92
    r96_0()
  end,
}
r102_0 = TradeCoinSection:[r104_0](r104_0)
local r105_0 = "Button"
r105_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 209
    local r0_209 = {}
    for r4_209, r5_209 in ipairs(r1_0:GetPlayers()) do
      if r5_209 ~= r6_0 then
        table.insert(r0_209, r5_209.Name)
      end
    end
    r102_0:Refresh(r0_209)
  end,
}
TradeCoinSection:[r105_0](r105_0)
r105_0 = "Input"
r105_0 = {
  Title = "Target Coin",
  Value = "0",
  Callback = function(r0_307)
    -- line: [0, 0] id: 307
    r31_0.Trade.targetCoins = tonumber(r0_307) or 0
    r96_0()
  end,
}
TradeCoinSection:[r105_0](r105_0)
r105_0 = "Toggle"
r105_0 = {
  Title = "Start Trade Coin",
  Value = false,
  Callback = function(r0_74)
    -- line: [0, 0] id: 74
    if r0_74 then
      task.spawn(startTradeByCoin)
    else
      Trade.trading = false
    end
  end,
}
TradeCoinSection:[r105_0](r105_0)
r105_0 = "Section"
r105_0 = {
  Title = "Trading Rarity Features",
}
TradeByRarity = TradeTab:[r105_0](r105_0)
r105_0 = "Paragraph"
r105_0 = {
  Title = "Panel Rarity Trading",
  Desc = "\r\nPlayer  : ???\r\nRarity  : ???\r\nCount   : 0\r\nStatus  : Idle\r\nSuccess : 0 / 0\r\n",
}
Rarity_Monitor = TradeByRarity:[r105_0](r105_0)
function r103_0(r0_231)
  -- line: [0, 0] id: 231
  local r1_231 = r31_0.Trade
  local r2_231 = "200,200,200"
  if r0_231 and r0_231:lower():find("send") then
    r2_231 = "51,153,255"
  elseif r0_231 and r0_231:lower():find("complete") then
    r2_231 = "0,204,102"
  elseif r0_231 and r0_231:lower():find("time") then
    r2_231 = "255,69,0"
  end
  local r3_231 = string.format
  local r4_231 = "\r\n<font color=\'rgb(173,216,230)\'>Player  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Rarity  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Count   : %d</font>\r\n<font color=\'rgb(%s)\'>Status  : %s</font>\r\n<font color=\'rgb(173,216,230)\'>Success : %d / %d</font>\r\n"
  local r5_231 = r1_231.selectedPlayerTrade or "???"
  local r6_231 = r1_231.selectedTradeRarity or "???"
  local r7_231 = r1_231.totalToTrade or 0
  local r8_231 = r2_231
  local r9_231 = r0_231 or "Idle"
  local r10_231 = r1_231.successCount or 0
  _G.safeSetContent(Rarity_Monitor, r3_231(r4_231, r5_231, r6_231, r7_231, r8_231, r9_231, r10_231, r1_231.totalToTrade or 0))
end
r104_0 = TradeByRarity
local r106_0 = "Dropdown"
r106_0 = {}
r106_0.Values = {
  "Common",
  "Uncommon",
  "Rare",
  "Epic",
  "Legendary",
  "Mythic",
  "Secret"
}
r106_0.Title = "Select Rarity"
function r106_0.Callback(r0_305)
  -- line: [0, 0] id: 305
  r31_0.Trade.selectedTradeRarity = r0_305
  r103_0("Selected rarity: " .. (r0_305 or "???"))
end
r104_0:[r106_0](r106_0)
r106_0 = "Dropdown"
r106_0 = {
  Values = r57_0(),
  Title = "Select Player",
  Callback = function(r0_22)
    -- line: [0, 0] id: 22
    r31_0.Trade.selectedPlayerTrade = r0_22
    r103_0()
  end,
}
RarityPlayerDropdown = TradeByRarity:[r106_0](r106_0)
r106_0 = "Button"
r106_0 = {
  Title = "Refresh Player",
  Callback = function()
    -- line: [0, 0] id: 191
    local r0_191 = {}
    for r4_191, r5_191 in ipairs(r1_0:GetPlayers()) do
      if r5_191 ~= r6_0 then
        table.insert(r0_191, r5_191.Name)
      end
    end
    RarityPlayerDropdown:Refresh(r0_191 or {})
  end,
}
TradeByRarity:[r106_0](r106_0)
r106_0 = "Input"
r106_0 = {
  Title = "Amount to Trade",
  Value = "1",
  Callback = function(r0_113)
    -- line: [0, 0] id: 113
    r31_0.Trade.rarityAmount = tonumber(r0_113) or 1
    r103_0("Set amount: " .. tostring(r31_0.Trade.rarityAmount))
  end,
}
TradeByRarity:[r106_0](r106_0)
function startTradeByRarity()
  -- line: [0, 0] id: 142
  local r0_142 = r31_0.Trade
  if r0_142.trading then
    return 
  end
  if not r0_142.selectedPlayerTrade or not r0_142.selectedTradeRarity then
    return r88_0("�� Select player & rarity first!")
  end
  r0_142.trading = true
  r0_142.rarityMode = true
  r0_142.successCount = 0
  r88_0("Starting rarity trade (" .. r0_142.selectedTradeRarity .. ") with " .. r0_142.selectedPlayerTrade)
  r103_0("<font color=\'#ffaa00\'>Scanning " .. r0_142.selectedTradeRarity .. " fishes...</font>")
  local r1_142 = {}
  for r5_142, r6_142 in ipairs(r28_0:GetExpect({
    "Inventory",
    "Items"
  })) do
    local r7_142 = r6_142.Favorited
    if not r7_142 then
      r7_142 = r24_0.GetItemDataFromItemType("Items", r6_142.Id)
      if r7_142 and r7_142.Data.Type == "Fish" and r66_0[r7_142.Data.Tier] == r0_142.selectedTradeRarity then
        table.insert(r1_142, {
          UUID = r6_142.UUID,
          Name = r7_142.Data.Name,
        })
      end
    end
  end
  if #r1_142 == 0 then
    r0_142.trading = false
    r103_0("<font color=\'#ff3333\'>No " .. r0_142.selectedTradeRarity .. " fishes found</font>")
    return r88_0("No " .. r0_142.selectedTradeRarity .. " fishes found")
  end
  r0_142.totalToTrade = math.min(#r1_142, r0_142.rarityAmount or #r1_142)
  r103_0(string.format("Sending %d %s fishes...", r0_142.totalToTrade, r0_142.selectedTradeRarity))
  local r2_142 = 1
  while r0_142.trading do
    local r3_142 = r0_142.totalToTrade
    if r2_142 <= r3_142 then
      r3_142 = r1_142[r2_142]
      local r4_142 = r99_0(r0_142.selectedPlayerTrade, r3_142.UUID, r3_142.Name)
      if r4_142 then
        r0_142.successCount = r0_142.successCount + 1
        r103_0(string.format("Progress: %d / %d (%s)", r0_142.successCount, r0_142.totalToTrade, r0_142.selectedTradeRarity))
      end
      r2_142 = r2_142 + 1
      task.wait(2.5)
    else
      break
    end
  end
  r0_142.trading = false
  r0_142.rarityMode = false
  r103_0("<font color=\'#66ccff\'>Rarity trade finished</font>")
  r88_0("Rarity trade finished (" .. r0_142.selectedTradeRarity .. ")")
end
r106_0 = "Toggle"
r106_0 = {
  Title = "Start By Rarity",
  Value = false,
  Callback = function(r0_188)
    -- line: [0, 0] id: 188
    if r0_188 then
      task.spawn(startTradeByRarity)
    else
      r31_0.Trade.trading = false
      r103_0("Idle")
    end
  end,
}
TradeByRarity:[r106_0](r106_0)
r106_0 = "Section"
r106_0 = {
  Title = "Auto Accept Trade",
}
AcceptTradeSection = TradeTab:[r106_0](r106_0)
r104_0 = AcceptTradeSection
r106_0 = "Toggle"
r106_0 = {
  Title = "Auto Accept Trade",
}
r106_0.Value = r31_0.Trade.autoAccept or false
function r106_0.Callback(r0_58)
  -- line: [0, 0] id: 58
  r31_0.Trade.autoAccept = r0_58
end
r104_0:[r106_0](r106_0)
spawn(function()
  -- line: [0, 0] id: 51
  -- notice: unreachable block#2
  while true do
    task.wait(1)
    if r31_0.Trade.autoAccept then
      pcall(function()
        -- line: [0, 0] id: 52
        local r0_52 = r6_0.PlayerGui:FindFirstChild("Prompt")
        if r0_52 and r0_52:FindFirstChild("Blackout") then
          local r1_52 = r0_52.Blackout
          if r1_52:FindFirstChild("Options") then
            local r2_52 = r1_52.Options:FindFirstChild("Yes")
            if r2_52 then
              local r3_52 = r2_52.AbsolutePosition
              local r4_52 = r2_52.AbsoluteSize
              local r5_52 = r3_52.X + r4_52.X / 2
              local r6_52 = r3_52.Y + r4_52.Y / 2 + 50
              r10_0:SendMouseButtonEvent(r5_52, r6_52, 0, true, game, 1)
              task.wait(0.03)
              r10_0:SendMouseButtonEvent(r5_52, r6_52, 0, false, game, 1)
            end
          end
        end
      end)
    end
  end
end)
r104_0 = ""
r105_0 = ""
r106_0 = 0
local r107_0 = 0
local r110_0 = "Section"
r110_0 = {
  Title = "Artifact Lever Location",
}
ArtifactSection = QuestTab:[r110_0](r110_0)
r105_0 = workspace:WaitForChild("JUNGLE INTERACTIONS")
r106_0 = 1
r107_0 = false
local r108_0 = nil
local r109_0 = "0,255,0"
r110_0 = "255,0,0"
artifactPositions = {
  ["Arrow Artifact"] = CFrame.new(875, 3, -368) * CFrame.Angles(0, math.rad(90), 0),
  ["Crescent Artifact"] = CFrame.new(1403, 3, 123) * CFrame.Angles(0, math.rad(180), 0),
  ["Hourglass Diamond Artifact"] = CFrame.new(1487, 3, -842) * CFrame.Angles(0, math.rad(180), 0),
  ["Diamond Artifact"] = CFrame.new(1844, 3, -287) * CFrame.Angles(0, math.rad(-90), 0),
}
local r111_0 = {
  "Arrow Artifact",
  "Crescent Artifact",
  "Hourglass Diamond Artifact",
  "Diamond Artifact"
}
local function r112_0()
  -- line: [0, 0] id: 206
  -- notice: unreachable block#5
  local r0_206 = {}
  for r4_206, r5_206 in ipairs(r105_0:GetDescendants()) do
    if r5_206:IsA("Model") and r5_206.Name == "TempleLever" then
      local r6_206 = r5_206:GetAttribute("Type")
      local r7_206 = r5_206:FindFirstChild("RootPart")
      if r7_206 then
        r7_206 = not r5_206.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      else
        r7_206 = true
      end
      r0_206[r6_206] = r7_206
    end
  end
  return r0_206
end
local function r113_0(r0_6)
  -- line: [0, 0] id: 6
  local function r1_6(r0_7, r1_7)
    -- line: [0, 0] id: 7
    local r2_7 = "%s : <b><font color=\"rgb(%s)\">%s</font></b>"
    local r4_7 = nil	-- notice: implicit variable refs by block#[13]
    if r0_7 == "Hourglass Diamond Artifact" then
      r4_7 = "Hourglass Diamond"
      if not r4_7 then
        ::label_7::
        if r0_7 == "Arrow Artifact" then
          r4_7 = "Arrow"
          if not r4_7 then
            ::label_12::
            if r0_7 == "Crescent Artifact" then
              r4_7 = "Crescent"
              if not r4_7 then
                ::label_17::
                r4_7 = "Diamond"
              end
            else
              goto label_17	-- block#6 is visited secondly
            end
          end
        else
          goto label_12	-- block#4 is visited secondly
        end
      end
    else
      goto label_7	-- block#2 is visited secondly
    end
    local r5_7 = nil	-- notice: implicit variable refs by block#[13]
    if r1_7 then
      r5_7 = r109_0
      if not r5_7 then
        ::label_23::
        r5_7 = r110_0
      end
    else
      goto label_23	-- block#9 is visited secondly
    end
    local r6_7 = nil	-- notice: implicit variable refs by block#[13]
    if r1_7 then
      r6_7 = "ACTIVE"
      if not r6_7 then
        ::label_29::
        r6_7 = "DISABLE"
      end
    else
      goto label_29	-- block#12 is visited secondly
    end
    return r2_7:format(r4_7, r5_7, r6_7)
  end
  ArtifactParagraph:SetDesc(table.concat({
    r1_6("Arrow Artifact", r0_6["Arrow Artifact"]),
    r1_6("Crescent Artifact", r0_6["Crescent Artifact"]),
    r1_6("Hourglass Diamond Artifact", r0_6["Hourglass Diamond Artifact"]),
    r1_6("Diamond Artifact", r0_6["Diamond Artifact"])
  }, "\n"))
end
local function r114_0(r0_140)
  -- line: [0, 0] id: 140
  for r4_140, r5_140 in ipairs(r105_0:GetDescendants()) do
    if r5_140:IsA("Model") and r5_140.Name == "TempleLever" and r5_140:GetAttribute("Type") == r0_140 then
      local r6_140 = r5_140:FindFirstChild("RootPart") and r5_140.RootPart:FindFirstChildWhichIsA("ProximityPrompt")
      if r6_140 then
        fireproximityprompt(r6_140)
        break
      else
        break
      end
    end
  end
end
local r117_0 = "Paragraph"
r117_0 = {
  Title = "Panel Progress Artifact",
  Desc = "\r\nArrow : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nCrescent : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nHourglass Diamond : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\nDiamond : <b><font color=\"rgb(255,0,0)\">DISABLE</font></b>\r\n",
}
ArtifactParagraph = ArtifactSection:[r117_0](r117_0)
r20_0.RE_FishCaught.OnClientEvent:Connect(function(r0_91)
  -- line: [0, 0] id: 91
  if not r107_0 or not r108_0 then
    return 
  end
  local r1_91 = string.split(r108_0, " ")[1]
  if r1_91 and string.find(r0_91, r1_91, 1, true) then
    task.wait(0)
    r114_0(r108_0)
    r108_0 = nil
  end
end)
r117_0 = "Toggle"
r117_0 = {
  Title = "Artifact Progress",
  Value = false,
  Callback = function(r0_75)
    -- line: [0, 0] id: 75
    r107_0 = r0_75
    if r0_75 then
      task.spawn(function()
        -- line: [0, 0] id: 76
        -- notice: unreachable block#18
        local r0_76 = false
        while r107_0 do
          local r1_76 = r112_0()
          local r2_76 = true
          for r6_76, r7_76 in pairs(r1_76) do
            if not r7_76 then
              r2_76 = false
              break
            end
          end
          r113_0(r1_76)
          if r2_76 then
            r107_0 = false
            break
          else
            for r6_76, r7_76 in ipairs(r111_0) do
              if not r1_76[r7_76] then
                r108_0 = r7_76
                local r8_76 = (r6_0.Character or r6_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
                if r8_76 and artifactPositions[r7_76] then
                  r8_76.CFrame = artifactPositions[r7_76]
                end
                repeat
                  task.wait(r106_0)
                  if r108_0 then
                    local r9_76 = r107_0
                    r0_76 = not r9_76
                  else
                    r0_76 = true
                  end
                until r0_76
              end
              if r0_76 then
                break
              end
            end
            r0_76 = false
            task.wait(r106_0)
          end
        end
      end)
    end
  end,
}
ArtifactSection:[r117_0](r117_0)
task.spawn(function()
  -- line: [0, 0] id: 101
  while task.wait(r106_0) do
    r113_0(r112_0())
  end
end)
r117_0 = "Button"
r117_0 = {
  Title = "Arrow",
  Callback = function()
    -- line: [0, 0] id: 33
    local r0_33 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_33 then
      r0_33.CFrame = artifactPositions["Arrow Artifact"]
    end
  end,
}
ArtifactSection:[r117_0](r117_0)
r117_0 = "Button"
r117_0 = {
  Title = "Hourglass Diamond",
  Callback = function()
    -- line: [0, 0] id: 205
    local r0_205 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_205 then
      r0_205.CFrame = artifactPositions["Hourglass Diamond Artifact"]
    end
  end,
}
ArtifactSection:[r117_0](r117_0)
r117_0 = "Button"
r117_0 = {
  Title = "Crescent",
  Callback = function()
    -- line: [0, 0] id: 111
    local r0_111 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_111 then
      r0_111.CFrame = artifactPositions["Crescent Artifact"]
    end
  end,
}
ArtifactSection:[r117_0](r117_0)
r117_0 = "Button"
r117_0 = {
  Title = "Diamond",
  Callback = function()
    -- line: [0, 0] id: 257
    local r0_257 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_257 then
      r0_257.CFrame = artifactPositions["Diamond Artifact"]
    end
  end,
}
ArtifactSection:[r117_0](r117_0)
r117_0 = "Section"
r117_0 = {
  Title = "Sisyphus Statue Quest",
}
SisyphusSection = QuestTab:[r117_0](r117_0)
r117_0 = "Paragraph"
r117_0 = {
  Title = "Deep Sea Panel",
  Desc = "",
}
local r115_0 = SisyphusSection:[r117_0](r117_0)
SisyphusSection:Divider()
local r118_0 = "Toggle"
r118_0 = {
  Title = "Auto Deep Sea Quest [Ghostfinn]",
  Desc = "Automatically complete Deep Sea Quest",
  Value = false,
  Callback = function(r0_243)
    -- line: [0, 0] id: 243
    r31_0.autoDeepSea = r0_243
    task.spawn(function()
      -- line: [0, 0] id: 244
      while r31_0.autoDeepSea do
        local r0_244 = workspace:FindFirstChild("!!! MENU RINGS")
        local r1_244 = r0_244 and r0_244:FindFirstChild("Deep Sea Tracker")
        if r1_244 then
          local r2_244 = r1_244:FindFirstChild("Board") and r1_244.Board:FindFirstChild("Gui") and r1_244.Board.Gui:FindFirstChild("Content")
          if r2_244 then
            local r3_244 = nil
            for r7_244, r8_244 in ipairs(r2_244:GetChildren()) do
              if r8_244:IsA("TextLabel") and r8_244.Name ~= "Header" then
                r3_244 = r8_244
                break
              end
            end
            if r3_244 then
              local r4_244 = string.lower(r3_244.Text)
              local r5_244 = r6_0.Character and r6_0.Character:FindFirstChild("HumanoidRootPart")
              if r5_244 then
                if string.find(r4_244, "100%%") then
                  r5_244.CFrame = CFrame.new(-3763, -135, -995) * CFrame.Angles(0, math.rad(180), 0)
                else
                  r5_244.CFrame = CFrame.new(-3599, -276, -1641)
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
SisyphusSection:[r118_0](r118_0)
r118_0 = "Button"
r118_0 = {
  Title = "Treasure Room",
  Callback = function()
    -- line: [0, 0] id: 83
    local r0_83 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_83 then
      r0_83.CFrame = CFrame.new(-3601, -283, -1611)
    end
  end,
}
SisyphusSection:[r118_0](r118_0)
r118_0 = "Button"
r118_0 = {
  Title = "Sisyphus Statue",
  Callback = function()
    -- line: [0, 0] id: 94
    local r0_94 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_94 then
      r0_94.CFrame = CFrame.new(-3698, -135, -1008)
    end
  end,
}
SisyphusSection:[r118_0](r118_0)
r118_0 = "Section"
r118_0 = {
  Title = "Element Quest",
}
ElementSection = QuestTab:[r118_0](r118_0)
r118_0 = "Paragraph"
r118_0 = {
  Title = "Element Panel",
  Desc = "",
}
local r116_0 = ElementSection:[r118_0](r118_0)
ElementSection:Divider()
local r119_0 = "Toggle"
r119_0 = {
  Title = "Auto Element Quest",
  Desc = "Automatically complete Element Rod Quest!",
  Value = false,
  Callback = function(r0_99)
    -- line: [0, 0] id: 99
    r31_0.autoElement = r0_99
    task.spawn(function()
      -- line: [0, 0] id: 100
      local r0_100 = false
      while r31_0.autoElement and not r0_100 do
        local r1_100 = workspace:FindFirstChild("!!! MENU RINGS")
        local r2_100 = r1_100 and r1_100:FindFirstChild("Element Tracker")
        if r2_100 then
          local r3_100 = r2_100:FindFirstChild("Board") and r2_100.Board:FindFirstChild("Gui") and r2_100.Board.Gui:FindFirstChild("Content")
          if r3_100 then
            local r4_100 = {}
            for r8_100, r9_100 in ipairs(r3_100:GetChildren()) do
              if r9_100:IsA("TextLabel") and r9_100.Name ~= "Header" then
                table.insert(r4_100, string.lower(r9_100.Text))
              end
            end
            local r5_100 = r6_0.Character and r6_0.Character:FindFirstChild("HumanoidRootPart")
            if r5_100 and 4 <= #r4_100 then
              local r6_100 = r4_100[2]
              local r7_100 = r4_100[4]
              if not string.find(r7_100, "100%%") then
                r5_100.CFrame = CFrame.new(1484, 3, -336) * CFrame.Angles(0, math.rad(180), 0)
              elseif string.find(r7_100, "100%%") and not string.find(r6_100, "100%%") then
                r5_100.CFrame = CFrame.new(1453, -22, -636)
              elseif string.find(r6_100, "100%%") then
                r5_100.CFrame = CFrame.new(1480, 128, -593)
                r0_100 = true
                r31_0.autoElement = false
                if r116_0 and r116_0.SetDesc then
                  r116_0:SetDesc("Element Quest Completed!")
                end
              end
            end
          end
        end
        task.wait(2)
      end
    end)
  end,
}
ElementSection:[r119_0](r119_0)
r119_0 = "Button"
r119_0 = {
  Title = "Secred Temple",
  Callback = function()
    -- line: [0, 0] id: 214
    local r0_214 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_214 then
      r0_214.CFrame = CFrame.new(1453, -22, -636)
    end
  end,
}
ElementSection:[r119_0](r119_0)
r119_0 = "Button"
r119_0 = {
  Title = "Underground Cellar",
  Callback = function()
    -- line: [0, 0] id: 87
    local r0_87 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_87 then
      r0_87.CFrame = CFrame.new(2136, -91, -701)
    end
  end,
}
ElementSection:[r119_0](r119_0)
r119_0 = "Button"
r119_0 = {
  Title = "Transcended Stones",
  Callback = function()
    -- line: [0, 0] id: 297
    local r0_297 = (r6_0.Character or r6_0.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")
    if r0_297 then
      r0_297.CFrame = CFrame.new(1480, 128, -593)
    end
  end,
}
ElementSection:[r119_0](r119_0)
function r117_0(r0_133)
  -- line: [0, 0] id: 133
  local r1_133 = workspace["!!! MENU RINGS"]:FindFirstChild(r0_133)
  if not r1_133 then
    return ""
  end
  local r2_133 = r1_133:FindFirstChild("Board") and r1_133.Board:FindFirstChild("Gui") and r1_133.Board.Gui:FindFirstChild("Content")
  if not r2_133 then
    return ""
  end
  local r3_133 = {}
  local r4_133 = 1
  for r8_133, r9_133 in ipairs(r2_133:GetChildren()) do
    if r9_133:IsA("TextLabel") and r9_133.Name ~= "Header" then
      table.insert(r3_133, r4_133 .. ". " .. r9_133.Text)
      r4_133 = r4_133 + 1
    end
  end
  return table.concat(r3_133, "\n")
end
task.spawn(function()
  -- line: [0, 0] id: 249
  while task.wait(2) do
    r116_0:SetDesc(r117_0("Element Tracker"))
    r115_0:SetDesc(r117_0("Deep Sea Tracker"))
  end
end)
local r120_0 = "Section"
r120_0 = {
  Title = "Booster FPS",
}
MiscBooster = MiscTab:[r120_0](r120_0)
r120_0 = "Toggle"
r120_0 = {
  Title = "Disable 3D Render",
  Desc = "Will make white screen and no render map!",
  Value = false,
  Callback = function(r0_26)
    -- line: [0, 0] id: 26
    if typeof(r2_0.Set3dRenderingEnabled) == "function" then
      r2_0:Set3dRenderingEnabled(not r0_26)
    end
  end,
}
MiscBooster:[r120_0](r120_0)
r31_0.Reducing = false
r120_0 = "Toggle"
r120_0 = {
  Title = "Reduce Map",
  Desc = "Dont turn on this with Disable 3D Render!",
  Value = false,
  Callback = function(r0_172)
    -- line: [0, 0] id: 172
    r31_0.Reducing = r0_172
    if r0_172 then
      local function r1_172(r0_173)
        -- line: [0, 0] id: 173
        if r0_173:IsDescendantOf(r6_0.Character) then
          return 
        end
        if r0_173:IsA("BasePart") then
          r0_173.Material = Enum.Material.Plastic
          r0_173.CastShadow = false
          r0_173.Reflectance = 0
        elseif r0_173:IsA("Decal") or r0_173:IsA("Texture") then
          r0_173.Transparency = 1
        elseif r0_173:IsA("ParticleEmitter") or r0_173:IsA("Trail") or r0_173:IsA("Beam") or r0_173:IsA("Smoke") or r0_173:IsA("Fire") or r0_173:IsA("Sparkles") then
          r0_173.Enabled = false
        elseif r0_173:IsA("Highlight") then
          r0_173:Destroy()
        elseif r0_173:IsA("MeshPart") then
          r0_173.MeshId = ""
          r0_173.TextureID = ""
        elseif r0_173:IsA("SpecialMesh") then
          r0_173.MeshId = ""
          r0_173.TextureId = ""
        end
      end
      for r5_172, r6_172 in ipairs(workspace:GetDescendants()) do
        r1_172(r6_172)
      end
      workspace.DescendantAdded:Connect(function(r0_174)
        -- line: [0, 0] id: 174
        if r31_0.Reducing then
          task.wait(0.05)
          r1_172(r0_174)
        end
      end)
      local r2_172 = game:GetService("Lighting")
      r2_172.GlobalShadows = false
      r2_172.FogStart = 9999999
      r2_172.FogEnd = 9999999
      r2_172.Brightness = 1
      for r6_172, r7_172 in ipairs(r2_172:GetChildren()) do
        if r7_172:IsA("BloomEffect") or r7_172:IsA("DepthOfFieldEffect") or r7_172:IsA("ColorCorrectionEffect") or r7_172:IsA("SunRaysEffect") then
          r7_172.Enabled = false
        end
      end
      local r3_172 = workspace:FindFirstChild("Terrain")
      if r3_172 then
        r3_172.WaterWaveSize = 0
        r3_172.WaterWaveSpeed = 0
        r3_172.WaterReflectance = 0
        r3_172.WaterTransparency = 1
      end
      -- close: r1_172
    end
  end,
}
ReduceToggle = MiscBooster:[r120_0](r120_0)
r120_0 = "Toggle"
r120_0 = {
  Title = "Black Screen",
  Desc = "Make ur screen fully black!",
  Value = false,
  Callback = function(r0_186)
    -- line: [0, 0] id: 186
    local r1_186 = game:GetService("CoreGui")
    local r2_186 = r1_186:FindFirstChild("WindUI")
    local r3_186 = r1_186:FindFirstChild("ToggleUIButton")
    if r0_186 then
      if not r1_186:FindFirstChild("BlackScreen") then
        local r4_186 = Instance.new("ScreenGui")
        r4_186.Name = "BlackScreen"
        r4_186.IgnoreGuiInset = true
        r4_186.ResetOnSpawn = false
        r4_186.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        r4_186.DisplayOrder = 0
        r4_186.Parent = r1_186
        local r5_186 = Instance.new("Frame")
        r5_186.Size = UDim2.new(1, 0, 1, 0)
        r5_186.BackgroundColor3 = Color3.new(0, 0, 0)
        r5_186.ZIndex = 0
        r5_186.Parent = r4_186
      end
      if r2_186 then
        r2_186.DisplayOrder = 10
      end
      if r3_186 then
        r3_186.DisplayOrder = 11
      end
      r2_0:Set3dRenderingEnabled(false)
    else
      local r4_186 = r1_186:FindFirstChild("BlackScreen")
      if r4_186 then
        r4_186:Destroy()
      end
      r2_0:Set3dRenderingEnabled(true)
    end
  end,
}
MiscBooster:[r120_0](r120_0)
r120_0 = "Section"
r120_0 = {
  Title = "Utility Player",
}
MiscSection = MiscTab:[r120_0](r120_0)
r118_0 = false
r119_0 = false
r120_0 = false
local r121_0 = 16
local r124_0 = "Toggle"
r124_0 = {
  Title = "Noclip",
  Desc = "Walk through objects",
  Value = false,
  Callback = function(r0_1)
    -- line: [0, 0] id: 1
    r118_0 = r0_1
    local r1_1 = r6_0.Character
    if r1_1 then
      for r5_1, r6_1 in pairs(r1_1:GetDescendants()) do
        if r6_1:IsA("BasePart") then
          r6_1.CanCollide = true
        end
      end
    end
  end,
}
MiscSection:[r124_0](r124_0)
r2_0.Stepped:Connect(function()
  -- line: [0, 0] id: 147
  if r118_0 and r6_0.Character then
    for r3_147, r4_147 in pairs(r6_0.Character:GetDescendants()) do
      if r4_147:IsA("BasePart") and r4_147.CanCollide then
        r4_147.CanCollide = false
      end
    end
  end
end)
r124_0 = "Slider"
r124_0 = {
  Title = "Walkspeed",
  Step = 1,
}
r124_0.Value = {
  Min = 16,
  Max = 200,
  Default = 16,
}
function r124_0.Callback(r0_130)
  -- line: [0, 0] id: 130
  r121_0 = r0_130
  local r1_130 = r6_0.Character and r6_0.Character:FindFirstChild("Humanoid")
  if r119_0 and r1_130 then
    r1_130.WalkSpeed = r0_130
  end
end
WalkspeedSlider = MiscSection:[r124_0](r124_0)
r124_0 = "Register"
r124_0 = "WalkspeedSlider"
r86_0:[r124_0](r124_0, WalkspeedSlider)
r124_0 = "Toggle"
r124_0 = {
  Title = "Enable Walkspeed",
  Value = false,
  Callback = function(r0_81)
    -- line: [0, 0] id: 81
    r119_0 = r0_81
    local r1_81 = r6_0.Character and r6_0.Character:FindFirstChild("Humanoid")
    if r1_81 then
      local r2_81 = nil	-- notice: implicit variable refs by block#[6]
      if r0_81 then
        r2_81 = r121_0
        if not r2_81 then
          ::label_17::
          r2_81 = 16
        end
      else
        goto label_17	-- block#5 is visited secondly
      end
      r1_81.WalkSpeed = r2_81
    end
  end,
}
MiscSection:[r124_0](r124_0)
r124_0 = "Toggle"
r124_0 = {
  Title = "Infinite Jump",
  Value = false,
  Callback = function(r0_217)
    -- line: [0, 0] id: 217
    r120_0 = r0_217
  end,
}
MiscSection:[r124_0](r124_0)
r12_0.JumpRequest:Connect(function()
  -- line: [0, 0] id: 296
  if r120_0 and r6_0.Character and r6_0.Character:FindFirstChild("Humanoid") then
    r6_0.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
  end
end)
local r122_0 = 128
local r123_0 = nil
local r126_0 = "Toggle"
r126_0 = {
  Title = "Max Zoom 1000",
  Content = "Increase max camera distance",
  Default = false,
  Callback = function(r0_95)
    -- line: [0, 0] id: 95
    local r1_95 = r1_0.LocalPlayer
    if r123_0 then
      r123_0:Disconnect()
      r123_0 = nil
    end
    if r0_95 then
      r1_95.CameraMaxZoomDistance = 1000
      r1_95.CameraMinZoomDistance = 0.5
      r123_0 = r1_95.CharacterAdded:Connect(function()
        -- line: [0, 0] id: 96
        task.wait(0.3)
        r1_95.CameraMaxZoomDistance = 1000
        r1_95.CameraMinZoomDistance = 0.5
      end)
    else
      r1_95.CameraMaxZoomDistance = r122_0
      r1_95.CameraMinZoomDistance = 0.5
    end
  end,
}
MaxZoomToggle = MiscSection:[r126_0](r126_0)
r126_0 = "Register"
r126_0 = "MaxZoomToggle"
r86_0:[r126_0](r126_0, MaxZoomToggle)
r124_0 = r9_0:WaitForChild("Events"):WaitForChild("Frame"):WaitForChild("Location"):WaitForChild("Label")
local r125_0 = r9_0:WaitForChild("Events"):WaitForChild("Frame"):WaitForChild("CurrencyCounter"):WaitForChild("Counter")
r126_0 = {
  CurrencyCounter = r125_0.Text,
  Location = r124_0.Text,
}
local r127_0 = {}
for r131_0, r132_0 in ipairs(r6_0.Character:GetDescendants()) do
  local r135_0 = "IsA"
  r135_0 = "BasePart"
  if r132_0:[r135_0](r135_0) then
    r127_0[r132_0] = r132_0.Transparency
  end
end
local r128_0 = {}
local function r129_0()
  -- line: [0, 0] id: 192
  r128_0.location = r124_0:GetPropertyChangedSignal("Text"):Connect(function()
    -- line: [0, 0] id: 193
    if StreamerToggle.Value then
      r124_0.Text = "CENSORED"
    end
  end)
  r128_0.currency = r125_0:GetPropertyChangedSignal("Text"):Connect(function()
    -- line: [0, 0] id: 194
    if StreamerToggle.Value then
      r125_0.Text = "CENSORED"
    end
  end)
end
local function r130_0()
  -- line: [0, 0] id: 123
  for r3_123, r4_123 in pairs(r128_0) do
    if r4_123 then
      r4_123:Disconnect()
    end
  end
  r128_0 = {}
end
local r133_0 = "Toggle"
r133_0 = {
  Title = "Streamer Mode",
  Desc = "This feature will sensored ur location, coins, and hide character!",
  Value = false,
  Callback = function(r0_227)
    -- line: [0, 0] id: 227
    if r0_227 then
      r129_0()
      r124_0.Text = "CENSORED"
      r125_0.Text = "CENSORED"
      for r4_227, r5_227 in pairs(r127_0) do
        r4_227.Transparency = 1
      end
    else
      r130_0()
      r124_0.Text = r126_0.Location
      r125_0.Text = r126_0.CurrencyCounter
      for r4_227, r5_227 in pairs(r127_0) do
        r4_227.Transparency = r5_227
      end
    end
  end,
}
StreamerToggle = MiscSection:[r133_0](r133_0)
r133_0 = "Register"
r133_0 = "StreamerToggle"
r86_0:[r133_0](r133_0, StreamerToggle)
MiscSection:Divider()
local r131_0 = false
local r132_0 = true
r133_0 = 1
local r134_0 = nil
local r135_0 = nil
local function r136_0()
  -- line: [0, 0] id: 251
  r131_0 = false
  local r0_251 = r6_0.Character
  if r0_251 then
    local r1_251 = r0_251:FindFirstChildOfClass("Humanoid")
    if r1_251 then
      r1_251.PlatformStand = false
    end
    local r2_251 = r0_251:FindFirstChild("HumanoidRootPart")
    if r2_251 then
      for r6_251, r7_251 in pairs(r2_251:GetChildren()) do
        if r7_251:IsA("BodyGyro") or r7_251:IsA("BodyVelocity") then
          r7_251:Destroy()
        end
      end
    end
  end
end
local function r137_0(r0_16)
  -- line: [0, 0] id: 16
  local r1_16 = r6_0
  local r2_16 = r1_16.Character or r1_16.CharacterAdded:Wait()
  local r3_16 = r2_16:FindFirstChildOfClass("Humanoid") or r2_16:WaitForChild("Humanoid")
  local r4_16 = r74_0(r2_16)
  local r5_16 = {
    F = 0,
    B = 0,
    L = 0,
    R = 0,
    Q = 0,
    E = 0,
  }
  local r6_16 = {
    F = 0,
    B = 0,
    L = 0,
    R = 0,
    Q = 0,
    E = 0,
  }
  local r7_16 = 0
  if r134_0 then
    r134_0:Disconnect()
  end
  if r135_0 then
    r135_0:Disconnect()
  end
  r134_0 = r12_0.InputBegan:Connect(function(r0_19)
    -- line: [0, 0] id: 19
    local r1_19 = r0_19.KeyCode
    if r1_19 == Enum.KeyCode.W then
      r5_16.F = 1
    elseif r1_19 == Enum.KeyCode.S then
      r5_16.B = -1
    elseif r1_19 == Enum.KeyCode.A then
      r5_16.L = -1
    elseif r1_19 == Enum.KeyCode.D then
      r5_16.R = 1
    elseif r1_19 == Enum.KeyCode.E and r132_0 then
      r5_16.Q = 1
    elseif r1_19 == Enum.KeyCode.Q and r132_0 then
      r5_16.E = -1
    end
  end)
  r135_0 = r12_0.InputEnded:Connect(function(r0_20)
    -- line: [0, 0] id: 20
    local r1_20 = r0_20.KeyCode
    if r1_20 == Enum.KeyCode.W then
      r5_16.F = 0
    elseif r1_20 == Enum.KeyCode.S then
      r5_16.B = 0
    elseif r1_20 == Enum.KeyCode.A then
      r5_16.L = 0
    elseif r1_20 == Enum.KeyCode.D then
      r5_16.R = 0
    elseif r1_20 == Enum.KeyCode.E then
      r5_16.Q = 0
    elseif r1_20 == Enum.KeyCode.Q then
      r5_16.E = 0
    end
  end)
  (function()
    -- line: [0, 0] id: 17
    r131_0 = true
    local r0_17 = Instance.new("BodyGyro")
    local r1_17 = Instance.new("BodyVelocity")
    r0_17.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
    r0_17.P = 90000
    r1_17.Parent = r4_16
    r0_17.Parent = r4_16
    r0_17.CFrame = r4_16.CFrame
    r1_17.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    task.spawn(function()
      -- line: [0, 0] id: 18
      repeat
        task.wait()
        local r0_18 = workspace.CurrentCamera
        if not r0_16 then
          local r1_18 = r3_16
          r1_18.PlatformStand = true
        end
        local r1_18 = r5_16.L + r5_16.R
        if r1_18 == 0 then
          r1_18 = r5_16.F + r5_16.B
          if r1_18 == 0 then
            r1_18 = r5_16.Q + r5_16.E
            if r1_18 ~= 0 then
              ::label_31::
              r1_18 = r133_0 * 50 or 0
            else
              goto label_35	-- block#6 is visited secondly
            end
          end
        else
          goto label_31	-- block#5 is visited secondly
        end
        r7_16 = r1_18
        r1_18 = r7_16
        if r1_18 ~= 0 then
          r1_17.Velocity = (r0_18.CFrame.LookVector * (r5_16.F + r5_16.B) + r0_18.CFrame * CFrame.new((r5_16.L + r5_16.R), (r5_16.F + r5_16.B + r5_16.Q + r5_16.E) * 0.2, 0).p - r0_18.CFrame.p) * r7_16
          r1_18 = {}
          r1_18.F = r5_16.F
          r1_18.B = r5_16.B
          r1_18.L = r5_16.L
          r1_18.R = r5_16.R
          r6_16 = r1_18
        else
          r1_18 = r1_17
          r1_18.Velocity = Vector3.zero
        end
        r0_17.CFrame = r0_18.CFrame
        r1_18 = r131_0
      until not r1_18
      r0_17:Destroy()
      r1_17:Destroy()
      r3_16.PlatformStand = false
    end)
  end)()
end
local function r138_0(r0_310)
  -- line: [0, 0] id: 310
  r131_0 = true
  local r1_310 = r0_310.Character or r0_310.CharacterAdded:Wait()
  local r2_310 = r1_310:WaitForChild("HumanoidRootPart")
  local r3_310 = r1_310:FindFirstChildOfClass("Humanoid")
  local r4_310 = workspace.CurrentCamera
  local r5_310 = require(r0_310:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
  local r6_310 = Instance.new("BodyVelocity")
  local r7_310 = Instance.new("BodyGyro")
  r6_310.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
  local r8_310 = Vector3.new(9000000000, 9000000000, 9000000000)
  r7_310.D = 50
  r7_310.P = 1000
  r7_310.MaxTorque = r8_310
  r7_310.Parent = r2_310
  r6_310.Parent = r2_310
  r3_310.PlatformStand = true
  task.spawn(function()
    -- line: [0, 0] id: 311
    while r131_0 do
      local r0_311 = task.wait()
      if r0_311 then
        r0_311 = r5_310:GetMoveVector()
        r7_310.CFrame = r4_310.CFrame
        r6_310.Velocity = (r4_310.CFrame.RightVector * r0_311.X + r4_310.CFrame.LookVector * -r0_311.Z) * r133_0 * 50
      else
        break
      end
    end
    r3_310.PlatformStand = false
    r6_310:Destroy()
    r7_310:Destroy()
  end)
end
local r141_0 = "Slider"
r141_0 = {
  Title = "Fly Speed",
  Step = 1,
}
r141_0.Value = {
  Min = 1,
  Max = 10,
  Default = 1,
}
function r141_0.Callback(r0_50)
  -- line: [0, 0] id: 50
  r133_0 = r0_50
end
FlySlider = MiscSection:[r141_0](r141_0)
r141_0 = "Register"
r141_0 = "FlySlider"
r86_0:[r141_0](r141_0, FlySlider)
r141_0 = "Toggle"
r141_0 = {
  Title = "Enable Fly",
  Value = false,
  Callback = function(r0_131)
    -- line: [0, 0] id: 131
    if r0_131 then
      if r12_0.TouchEnabled then
        r138_0(r6_0)
      else
        r137_0()
      end
    else
      r136_0()
    end
  end,
}
FlyToggle = MiscSection:[r141_0](r141_0)
r141_0 = "Section"
r141_0 = {
  Title = "Server Features",
}
SvSection = MiscTab:[r141_0](r141_0)
local r139_0 = false
local r140_0 = nil
local r143_0 = "Toggle"
r143_0 = {
  Title = "Auto Reconnect",
  Value = true,
  Callback = function(r0_258)
    -- line: [0, 0] id: 258
    r139_0 = r0_258
    if r140_0 and r140_0.Connected then
      r140_0:Disconnect()
      r140_0 = nil
    end
    if r0_258 then
      r140_0 = r13_0.ErrorMessageChanged:Connect(function(r0_259)
        -- line: [0, 0] id: 259
        if not r139_0 or r0_259 == "" then
          return 
        end
        task.wait(0.5)
        if not pcall(function()
          -- line: [0, 0] id: 260
          if r17_0 and r17_0 ~= "" then
            r11_0:TeleportToPrivateServer(r15_0, r17_0, {
              r6_0
            })
          else
            r11_0:TeleportToPlaceInstance(r15_0, r16_0, r6_0)
          end
        end) then
          task.wait(2)
          pcall(function()
            -- line: [0, 0] id: 261
            r11_0:Teleport(r15_0, r6_0)
          end)
        end
      end)
    end
  end,
}
ReconnectToggle = SvSection:[r143_0](r143_0)
r143_0 = "Register"
r143_0 = "ReconnectToggle"
r86_0:[r143_0](r143_0, ReconnectToggle)
r143_0 = "Toggle"
r143_0 = {
  Title = "Auto Execute",
  Value = false,
  Callback = function(r0_47)
    -- line: [0, 0] id: 47
    if queue_on_teleport then
      local r1_47 = queue_on_teleport
      local r2_47 = nil	-- notice: implicit variable refs by block#[4]
      if r0_47 then
        r2_47 = "\r\n                loadstring(game:HttpGet(\"https://raw.githubusercontent.com/zhidanptrsyh/MengHub/refs/heads/main/library\"))()\r\n            "
        if not r2_47 then
          ::label_9::
          r2_47 = ""
        end
      else
        goto label_9	-- block#3 is visited secondly
      end
      r1_47(r2_47)
    end
  end,
}
AutoExecuteToggle = SvSection:[r143_0](r143_0)
r143_0 = "Register"
r143_0 = "AutoExecuteToggle"
r86_0:[r143_0](r143_0, AutoExecuteToggle)
r143_0 = "Section"
r143_0 = {
  Title = "Miscellaneous",
}
MiscellaneousSection = MiscTab:[r143_0](r143_0)
r143_0 = "Toggle"
r143_0 = {
  Title = "Anti Staff",
  Desc = "Auto kick if staff/developer join the server!",
  Value = false,
  Callback = function(r0_13)
    -- line: [0, 0] id: 13
    r34_0 = r0_13
    if r0_13 then
      local r2_13 = {
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
      local r3_13 = 35102746
      local r4_13 = r2_13
      task.spawn(function()
        -- line: [0, 0] id: 14
        while r34_0 do
          local r0_14 = ipairs
          for r3_14, r4_14 in r0_14(game:GetService("Players"):GetPlayers()) do
            if r4_14 ~= game.Players.LocalPlayer and r4_13[r4_14:GetRankInGroup(r3_13)] then
              game.Players.LocalPlayer:Kick("MengHub Detected Staff, Automatically Kicked\nSalim Dulu Udah Gua Selametin!")
              return 
            end
          end
          task.wait(1)
        end
      end)
      -- close: r3_13
    end
  end,
}
AntiStaffToggle = MiscellaneousSection:[r143_0](r143_0)
r143_0 = "Register"
r143_0 = "AntiStaffToggle"
r86_0:[r143_0](r143_0, AntiStaffToggle)
r143_0 = "Toggle"
r143_0 = {
  Title = "Enable Radar",
  Value = false,
  Callback = function(r0_223)
    -- line: [0, 0] id: 223
    pcall(function()
      -- line: [0, 0] id: 224
      r20_0.RF_Radar:InvokeServer(r0_223)
    end)
  end,
}
RadarToggle = MiscellaneousSection:[r143_0](r143_0)
r143_0 = "Register"
r143_0 = "RadarToggle"
r86_0:[r143_0](r143_0, RadarToggle)
r143_0 = "Toggle"
r143_0 = {
  Title = "Enable Diving",
  Value = false,
  Callback = function(r0_187)
    -- line: [0, 0] id: 187
    if not r0_187 then
      print("Diving Gear Disabled (manual unequip)")
      r20_0.RF_UnequipDiving:InvokeServer()
      return 
    end
    local r1_187 = r21_0.Client:GetReplion("Data")
    if not r1_187 then
      warn("Data Replion tidak ditemukan")
      return 
    end
    if r1_187:Get("EquippedOxygenTankId") == r30_0.Data.Id then
      r20_0.RF_UnequipDiving:InvokeServer()
      print("Diving Gear: OFF")
    else
      r20_0.RF_EquipDiving:InvokeServer(r30_0.Data.Id)
      print("Diving Gear: ON")
    end
  end,
}
MiscellaneousSection:[r143_0](r143_0)
MiscellaneousSection:Divider()
local r144_0 = nil
local r145_0 = nil
local r149_0 = nil
local r150_0 = game:GetService("Players").LocalPlayer
local r151_0 = false
local r152_0 = nil
local r153_0 = r144_0
local r154_0 = r145_0
local r155_0 = nil
local r156_0 = nil
local r157_0 = nil
local r158_0 = r149_0
local function r159_0()
  -- line: [0, 0] id: 29
  local r0_29 = (r150_0.Character or r150_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
  if not r0_29 then
    return nil
  end
  repeat
    task.wait()
  until r0_29:FindFirstChild("Overhead")
  return r0_29:WaitForChild("Overhead", 5)
end
local function r160_0(r0_197)
  -- line: [0, 0] id: 197
  if r0_197 == r150_0 then
    return 
  end
  task.spawn(function()
    -- line: [0, 0] id: 198
    local r1_198 = (r0_197.Character or r0_197.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)
    if not r1_198 then
      return 
    end
    repeat
      task.wait()
    until r1_198:FindFirstChild("Overhead")
    local r2_198 = r1_198:WaitForChild("Overhead", 5)
    if not r2_198 then
      return 
    end
    local r3_198 = r2_198:FindFirstChild("TitleContainer") and r2_198.TitleContainer:FindFirstChild("Label")
    local r4_198 = r2_198:FindFirstChild("Content") and r2_198.Content:FindFirstChild("Header")
    local r5_198 = r2_198:FindFirstChild("LevelContainer") and r2_198.LevelContainer:FindFirstChild("Label")
    local r6_198 = r3_198 and r3_198:FindFirstChildOfClass("UIGradient")
    if not r3_198 or not r4_198 or not r5_198 then
      return 
    end
    if not r0_197:FindFirstChild("OVERHEAD_ORIGINAL") then
      local r7_198 = Instance.new("Folder", r0_197)
      r7_198.Name = "OVERHEAD_ORIGINAL"
      local r8_198 = Instance.new("StringValue", r7_198)
      r8_198.Name = "Title"
      local r9_198 = Instance.new("StringValue", r7_198)
      r9_198.Name = "Header"
      local r10_198 = Instance.new("StringValue", r7_198)
      r10_198.Name = "Level"
      r8_198.Value = r3_198.Text
      r9_198.Value = r4_198.Text
      r10_198.Value = r5_198.Text
    end
    r3_198.Text = "Meng Hub"
    local r7_198 = r152_0
    if r7_198 ~= "" then
      r7_198 = r152_0 or "Meng Gacor"
    else
      goto label_112	-- block#23 is visited secondly
    end
    r4_198.Text = r7_198
    r7_198 = r153_0
    if r7_198 ~= "" then
      r7_198 = r153_0 or "Lvl: GTW"
    else
      goto label_120	-- block#26 is visited secondly
    end
    r5_198.Text = r7_198
    if r6_198 then
      r6_198.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(145, 186, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 243, 255))
      })
    end
  end)
end
local function r161_0(r0_98)
  -- line: [0, 0] id: 98
  if r0_98 == r150_0 then
    return 
  end
  local r1_98 = r0_98.Character
  if not r1_98 then
    return 
  end
  local r2_98 = r1_98:FindFirstChild("HumanoidRootPart")
  if not r2_98 then
    return 
  end
  local r3_98 = r2_98:FindFirstChild("Overhead")
  if not r3_98 then
    return 
  end
  local r4_98 = r3_98:FindFirstChild("TitleContainer") and r3_98.TitleContainer:FindFirstChild("Label")
  local r5_98 = r3_98:FindFirstChild("Content") and r3_98.Content:FindFirstChild("Header")
  local r6_98 = r3_98:FindFirstChild("LevelContainer") and r3_98.LevelContainer:FindFirstChild("Label")
  local r7_98 = r0_98:FindFirstChild("OVERHEAD_ORIGINAL")
  if r7_98 and r4_98 and r5_98 and r6_98 then
    r4_98.Text = r7_98.Title.Value
    r5_98.Text = r7_98.Header.Value
    r6_98.Text = r7_98.Level.Value
  end
end
local function r162_0()
  -- line: [0, 0] id: 304
  local r0_304 = r159_0()
  if not r0_304 then
    warn("[FakeIdentity] Overhead not found.")
    return 
  end
  local r1_304 = r0_304:FindFirstChild("TitleContainer") and r0_304.TitleContainer:FindFirstChild("Label")
  local r2_304 = r0_304:FindFirstChild("Content") and r0_304.Content:FindFirstChild("Header")
  local r3_304 = r0_304:FindFirstChild("LevelContainer") and r0_304.LevelContainer:FindFirstChild("Label")
  local r4_304 = r1_304 and r1_304:FindFirstChildOfClass("UIGradient")
  if not r1_304 or not r2_304 or not r3_304 then
    warn("[FakeIdentity] Missing UI components in Overhead.")
    return 
  end
  if not r4_304 then
    r4_304 = Instance.new("UIGradient", r1_304)
  end
  _G.hideident = {
    overhead = r0_304,
    titleLabel = r1_304,
    gradient = r4_304,
    header = r2_304,
    levelLabel = r3_304,
  }
  r154_0 = r1_304.Text
  r155_0 = r2_304.Text
  r156_0 = r3_304.Text
  r157_0 = r4_304.Color
  r158_0 = r4_304.Rotation
  r152_0 = r152_0 or r155_0
  r153_0 = r153_0 or r156_0
end
local function r163_0()
  -- line: [0, 0] id: 125
  local r0_125 = _G.hideident
  if not r0_125 or not r0_125.overhead or not r0_125.titleLabel then
    return 
  end
  r0_125.overhead.TitleContainer.Visible = true
  r0_125.titleLabel.Text = "Meng Hub"
  r0_125.gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(145, 186, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 243, 255))
  })
  r0_125.gradient.Rotation = 0
  local r1_125 = r0_125.header
  local r2_125 = r152_0
  if r2_125 ~= "" then
    r2_125 = r152_0 or "Meng Gacor"
  else
    goto label_62	-- block#6 is visited secondly
  end
  r1_125.Text = r2_125
  r1_125 = r0_125.levelLabel
  r2_125 = r153_0
  if r2_125 ~= "" then
    r2_125 = r153_0 or "Lvl: GTW"
  else
    goto label_71	-- block#9 is visited secondly
  end
  r1_125.Text = r2_125
  for r4_125, r5_125 in pairs(r1_0:GetPlayers()) do
    r160_0(r5_125)
  end
  pcall(function()
    -- line: [0, 0] id: 126
    for r3_126, r4_126 in pairs(game:GetService("CoreGui"):GetDescendants()) do
      if (r4_126:IsA("TextLabel") or r4_126:IsA("TextButton")) and (r4_126.Text == r150_0.Name or r4_126.Text == r150_0.DisplayName) then
        local r5_126 = r152_0
        if r5_126 ~= "" then
          r5_126 = r152_0 or "MengHub"
        else
          goto label_35	-- block#7 is visited secondly
        end
        r4_126.Text = r5_126
      end
    end
  end)
end
r162_0()
r150_0.CharacterAdded:Connect(function()
  -- line: [0, 0] id: 48
  task.wait(0.05)
  r162_0()
  if r151_0 then
    task.spawn(function()
      -- line: [0, 0] id: 49
      while r151_0 do
        r163_0()
        task.wait(1)
      end
    end)
  end
end)
local r164_0 = MiscellaneousSection
local r166_0 = "Input"
r166_0 = {
  Title = "Name Changer",
  Placeholder = "Enter header text...",
}
r166_0.Value = r155_0 or ""
function r166_0.Callback(r0_31)
  -- line: [0, 0] id: 31
  r152_0 = r0_31
end
FakeNameInput = r164_0:[r166_0](r166_0)
r166_0 = "Register"
r166_0 = "FakeNameInput"
r86_0:[r166_0](r166_0, FakeNameInput)
r164_0 = MiscellaneousSection
r166_0 = "Input"
r166_0 = {
  Title = "Lvl Changer",
  Placeholder = "Enter level text...",
}
r166_0.Value = r156_0 or ""
function r166_0.Callback(r0_15)
  -- line: [0, 0] id: 15
  r153_0 = r0_15
end
FakeLevelInput = r164_0:[r166_0](r166_0)
r166_0 = "Register"
r166_0 = "FakeLevelInput"
r86_0:[r166_0](r166_0, FakeLevelInput)
r166_0 = "Toggle"
r166_0 = {
  Title = "Start Fake Identity",
  Value = false,
  Callback = function(r0_156)
    -- line: [0, 0] id: 156
    r151_0 = r0_156
    if r0_156 then
      task.spawn(function()
        -- line: [0, 0] id: 157
        r163_0()
        while r151_0 do
          pcall(r163_0)
          task.wait(1)
        end
        while r151_0 do
          pcall(function()
            -- line: [0, 0] id: 158
            for r3_158, r4_158 in pairs(game:GetService("CoreGui"):GetDescendants()) do
              if (r4_158:IsA("TextLabel") or r4_158:IsA("TextButton")) and (r4_158.Text == r150_0.Name or r4_158.Text == r150_0.DisplayName) then
                local r5_158 = r152_0
                if r5_158 ~= "" then
                  r5_158 = r152_0 or "MengHub"
                else
                  goto label_35	-- block#7 is visited secondly
                end
                r4_158.Text = r5_158
              end
            end
          end)
          task.wait(0.1)
        end
      end)
    else
      local r1_156 = _G.hideident
      if not r1_156 or not r1_156.overhead then
        return 
      end
      r1_156.overhead.TitleContainer.Visible = false
      r1_156.titleLabel.Text = r154_0
      r1_156.header.Text = r155_0
      r1_156.levelLabel.Text = r156_0
      r1_156.gradient.Color = r157_0
      r1_156.gradient.Rotation = r158_0
      for r5_156, r6_156 in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if r6_156:IsA("TextLabel") or r6_156:IsA("TextButton") then
          local r7_156 = r6_156.Text
          local r8_156 = r152_0
          if r8_156 ~= "" then
            r8_156 = r152_0 or "MengHub"
          else
            goto label_64	-- block#10 is visited secondly
          end
          if r7_156 == r8_156 then
            r6_156.Text = r150_0.DisplayName
          end
        end
      end
      for r5_156, r6_156 in pairs(game:GetService("Players"):GetPlayers()) do
        r161_0(r6_156)
      end
    end
  end,
}
FakeIdentityToggle = MiscellaneousSection:[r166_0](r166_0)
r166_0 = "Register"
r166_0 = "FakeIdentityToggle"
r86_0:[r166_0](r166_0, FakeIdentityToggle)
-- close: r150_0
r150_0 = MiscellaneousSection
r152_0 = "Divider"
r150_0:[r152_0]()
function r150_0(r0_232)
  -- line: [0, 0] id: 232
  r32_0 = r0_232
  local r1_232, r2_232 = pcall(function()
    -- line: [0, 0] id: 233
    return require(r3_0.Controllers:WaitForChild("VFXController"))
  end)
  if r1_232 and r2_232 then
    for r6_232, r7_232 in pairs(r2_232) do
      if typeof(r7_232) == "function" then
        if r0_232 then
          if not r33_0[r6_232] then
            r33_0[r6_232] = r7_232
          end
          r2_232[r6_232] = function()
            -- line: [0, 0] id: 234
          end
        elseif r33_0[r6_232] then
          r2_232[r6_232] = r33_0[r6_232]
        end
      end
    end
    print("[MengXHub] Rod VFX Disabled:", r0_232)
  end
end
r151_0 = MiscellaneousSection
r153_0 = "Toggle"
r153_0 = {}
r154_0 = "Title"
r155_0 = "Disable VFX"
r153_0[r154_0] = r155_0
r154_0 = "Value"
r155_0 = false
r153_0[r154_0] = r155_0
r154_0 = "Callback"
function r155_0(r0_212)
  -- line: [0, 0] id: 212
  r150_0(r0_212)
end
r153_0[r154_0] = r155_0
r151_0 = r151_0:[r153_0](r153_0)
VFXToggle = r151_0
r141_0 = nil
local r142_0 = nil
r143_0 = nil
r151_0 = pcall
function r152_0()
  -- line: [0, 0] id: 167
  return require(r3_0.Controllers.CutsceneController)
end
r144_0, r145_0 = r151_0(r152_0)
if r144_0 and r145_0 then
  r141_0 = r145_0
  r151_0 = "Play"
  r142_0 = r141_0[r151_0]
  r151_0 = "Stop"
  r143_0 = r141_0[r151_0]
end
function r151_0()
  -- line: [0, 0] id: 150
  if r20_0.RE_Cutscene then
    r20_0.RE_Cutscene.OnClientEvent:Connect(function(...)
      -- line: [0, 0] id: 153
      warn("[CELESTIAL] Cutscene blocked (ReplicateCutscene)", ...)
    end)
  end
  if r20_0.RE_StopCutscene then
    r20_0.RE_StopCutscene.OnClientEvent:Connect(function()
      -- line: [0, 0] id: 151
      warn("[CELESTIAL] Cutscene blocked (stopCutscene)")
    end)
  end
  if r141_0 then
    r141_0.Play = function()
      -- line: [0, 0] id: 154
      warn("[CELESTIAL] Cutscene skipped!")
    end
    r141_0.Stop = function()
      -- line: [0, 0] id: 152
      warn("[CELESTIAL] Cutscene stop skipped!")
    end
  end
end
function r152_0()
  -- line: [0, 0] id: 185
  if r141_0 and r142_0 and r143_0 then
    r141_0.Play = r142_0
    r141_0.Stop = r143_0
    warn("[CELESTIAL] Cutscene restored to default")
  end
end
r153_0 = MiscellaneousSection
r155_0 = "Toggle"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Disable Cutscene"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = false
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_210)
  -- line: [0, 0] id: 210
  if r0_210 then
    r151_0()
  else
    r152_0()
  end
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
CutsceneToggle = r153_0
r155_0 = "Register"
r155_0 = "CutsceneToggle"
r156_0 = CutsceneToggle
r86_0:[r155_0](r155_0, r156_0)
r153_0 = MiscellaneousSection
r155_0 = "Toggle"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Disable Obtained Fish"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = false
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_309)
  -- line: [0, 0] id: 309
  local r1_309 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Small Notification")
  if r1_309 and r1_309:FindFirstChild("Display") then
    r1_309.Display.Visible = not r0_309
  end
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
ObtainedToggle = r153_0
r155_0 = "Register"
r155_0 = "ObtainedToggle"
r156_0 = ObtainedToggle
r86_0:[r155_0](r155_0, r156_0)
r153_0 = MiscellaneousSection
r155_0 = "Toggle"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Hide Rod On Hand"
r155_0[r156_0] = r157_0
r156_0 = "Desc"
r157_0 = "This feature irivisible! and hide other player too!"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = false
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_245)
  -- line: [0, 0] id: 245
  r31_0.IrRod = r0_245
  if r0_245 then
    task.spawn(function()
      -- line: [0, 0] id: 246
      while r31_0.IrRod do
        local r0_246 = ipairs
        for r3_246, r4_246 in r0_246(workspace.Characters:GetChildren()) do
          local r5_246 = r4_246:FindFirstChild("!!!EQUIPPED_TOOL!!!")
          if r5_246 then
            r5_246:Destroy()
          end
        end
        task.wait(1)
      end
    end)
  end
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = TeleportTab
r155_0 = "Section"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Location"
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
TeleLocation = r153_0
r153_0 = TeleLocation
r155_0 = "Dropdown"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Select Location"
r155_0[r156_0] = r157_0
r156_0 = "Values"
r157_0 = locationNames
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = locationNames
r158_0 = 1
r157_0 = r157_0[r158_0]
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_77)
  -- line: [0, 0] id: 77
  r31_0.teleportTarget = r0_77
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = TeleLocation
r155_0 = "Button"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Teleport To Location"
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0()
  -- line: [0, 0] id: 25
  local r0_25 = r31_0.teleportTarget
  if not r0_25 then
    r88_0("Please select a location first!")
    return 
  end
  local r1_25 = r58_0[r0_25]
  if r1_25 then
    local r2_25 = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if r2_25 then
      r2_25.CFrame = CFrame.new(r1_25 + Vector3.new(0, 3, 0))
      r88_0("Teleported to " .. r0_25)
    end
  end
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = TeleportTab
r155_0 = "Section"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Teleport To Player"
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
TelePlayer = r153_0
r153_0 = TelePlayer
r155_0 = "Dropdown"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Select Player"
r155_0[r156_0] = r157_0
r156_0 = "Values"
r157_0 = r57_0
r157_0 = r157_0()
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_190)
  -- line: [0, 0] id: 190
  r31_0.Trade.teleportTarget = r0_190
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
TelePlayerDropdown = r153_0
r153_0 = TelePlayer
r155_0 = "Button"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Refresh Player"
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0()
  -- line: [0, 0] id: 97
  local r0_97 = {}
  for r4_97, r5_97 in ipairs(r1_0:GetPlayers()) do
    if r5_97 ~= r6_0 then
      table.insert(r0_97, r5_97.Name)
    end
  end
  TelePlayerDropdown:Refresh(r0_97 or {})
  r88_0("Successfully refresh!")
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = TelePlayer
r155_0 = "Button"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Teleport To Player"
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0()
  -- line: [0, 0] id: 277
  local r0_277 = r31_0.Trade.teleportTarget
  if not r0_277 then
    r88_0("Please select a player first!")
    return 
  end
  local r1_277 = r1_0:FindFirstChild(r0_277)
  if r1_277 and r1_277.Character and r1_277.Character:FindFirstChild("HumanoidRootPart") then
    local r2_277 = r6_0.Character and r6_0.Character:FindFirstChild("HumanoidRootPart")
    if r2_277 then
      r2_277.CFrame = r1_277.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    else
      r88_0("Your HumanoidRootPart not found.")
    end
  else
    r88_0("Target not found or not loaded.")
  end
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = _G
r154_0 = "WebhookFlags"
r155_0 = {}
r156_0 = "FishCaught"
r157_0 = {}
r158_0 = "Enabled"
r159_0 = false
r157_0[r158_0] = r159_0
r158_0 = "URL"
r159_0 = "https://discord.com/api/webhooks/1447736942149243083/eMd0LSuUrKslVu3lndvnoKTTEzmryJ-lPpDOb3AR5TeL58Jy10g5Qf05m1qYAVK4D9w0"
r157_0[r158_0] = r159_0
r155_0[r156_0] = r157_0
r156_0 = "Stats"
r157_0 = {}
r158_0 = "Enabled"
r159_0 = false
r157_0[r158_0] = r159_0
r158_0 = "URL"
r159_0 = ""
r157_0[r158_0] = r159_0
r158_0 = 5
r157_0.Delay = r158_0
r155_0[r156_0] = r157_0
r156_0 = "Disconnect"
r157_0 = {}
r158_0 = "Enabled"
r159_0 = false
r157_0[r158_0] = r159_0
r158_0 = "URL"
r159_0 = "https://discord.com/api/webhooks/1447737110252748953/B2lPvuO8YuDpgX_3NhI5JFB5PgFUhlz-Owa-1JeboCr9VUtj4yf53b6HVI9M8afjSxdU"
r157_0[r158_0] = r159_0
r155_0[r156_0] = r157_0
r153_0[r154_0] = r155_0
r153_0 = _G
r154_0 = "WebhookURLs"
r155_0 = _G
r156_0 = "WebhookURLs"
r155_0 = r155_0[r156_0] or {}
r153_0[r154_0] = r155_0
r153_0 = {}
local r146_0 = r153_0
function r153_0()
  -- line: [0, 0] id: 136
  local r1_136 = r3_0:WaitForChild("Items")
  if not r1_136 then
    return 
  end
  for r5_136, r6_136 in ipairs(r1_136:GetChildren()) do
    local r7_136, r8_136 = pcall(require, r6_136)
    if r7_136 and type(r8_136) == "table" and r8_136.Data and r8_136.Data.Type == "Fish" then
      local r9_136 = r8_136.Data
      if r9_136.Id and r9_136.Name then
        r146_0[r9_136.Id] = {
          Name = r9_136.Name,
          Tier = r9_136.Tier,
          Icon = r9_136.Icon,
          SellPrice = r8_136.SellPrice,
        }
      end
    end
  end
end
buildFishDatabase = r153_0
function r153_0(r0_27)
  -- line: [0, 0] id: 27
  local r1_27 = r0_27:match("rbxassetid://(%d+)")
  if not r1_27 then
    return nil
  end
  local r2_27 = string.format("https://thumbnails.roblox.com/v1/assets?assetIds=%s&type=Asset&size=420x420&format=Png", r1_27)
  local r3_27, r4_27 = pcall(function()
    -- line: [0, 0] id: 28
    return r4_0:JSONDecode(game:HttpGet(r2_27))
  end)
  return r3_27 and r4_27 and r4_27.data and r4_27.data[1] and r4_27.data[1].imageUrl
end
getThumbnailURL = r153_0
function r153_0(r0_62, r1_62)
  -- line: [0, 0] id: 62
  if not _G.httpRequest or not r0_62 or r0_62 == "" then
    return 
  end
  if _G._WebhookLock and _G._WebhookLock[r0_62] then
    return 
  end
  _G._WebhookLock = _G._WebhookLock or {}
  _G._WebhookLock[r0_62] = true
  task.delay(0.25, function()
    -- line: [0, 0] id: 64
    _G._WebhookLock[r0_62] = nil
  end)
  pcall(function()
    -- line: [0, 0] id: 63
    _G.httpRequest({
      Url = r0_62,
      Method = "POST",
      Headers = {
        ["Content-Type"] = "application/json",
      },
      Body = r4_0:JSONEncode(r1_62),
    })
  end)
end
sendWebhook = r153_0
function r153_0(r0_252)
  -- line: [0, 0] id: 252
  if not _G.WebhookFlags.FishCaught.Enabled then
    return 
  end
  local r1_252 = _G.WebhookFlags.FishCaught.URL
  if not r1_252 or not r1_252:match("discord.com/api/webhooks") then
    return 
  end
  local r2_252 = r146_0[r0_252.Id]
  if not r2_252 then
    return 
  end
  local r3_252 = r66_0[r2_252.Tier] or "Unknown"
  if _G.WebhookRarities and 0 < #_G.WebhookRarities and not table.find(_G.WebhookRarities, r3_252) then
    return 
  end
  if _G.WebhookNames and 0 < #_G.WebhookNames and not table.find(_G.WebhookNames, r2_252.Name) then
    return 
  end
  local r4_252 = r0_252.Metadata
  if r4_252 then
    r4_252 = r0_252.Metadata.Weight and (string.format("%.2f Kg", r0_252.Metadata.Weight) or "N/A")
  else
    goto label_82	-- block#20 is visited secondly
  end
  local r5_252 = r0_252.Metadata
  if r5_252 then
    r5_252 = r0_252.Metadata.VariantId and (tostring(r0_252.Metadata.VariantId) or "None")
  else
    goto label_96	-- block#24 is visited secondly
  end
  local r6_252 = r2_252.SellPrice
  if r6_252 then
    r6_252 = "$" .. string.format("%d", r2_252.SellPrice):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "N/A"
  else
    goto label_121	-- block#27 is visited secondly
  end
  local r7_252 = {}
  local r8_252 = {}
  local r9_252 = {
    title = "Meng Hub Webhook | Fish Caught",
    url = "https://discord.gg/sYPZPRGgHe",
  }
  local r10_252 = string.format
  local r11_252 = "��︎ Congratulations!! **%s** You have obtained a new **%s** fish!"
  local r12_252 = _G.WebhookCustomName
  if r12_252 ~= "" then
    r12_252 = _G.WebhookCustomName or game.Players.LocalPlayer.Name
  else
    goto label_138	-- block#30 is visited secondly
  end
  r9_252.description = r10_252(r11_252, r12_252, r3_252)
  r9_252.color = 52221
  r9_252.fields = {
    {
      name = "��Fish Name :",
      value = "```❯ " .. r2_252.Name .. "```",
    },
    {
      name = "��Fish Tier :",
      value = "```❯ " .. r3_252 .. "```",
    },
    {
      name = "��Weight :",
      value = "```❯ " .. r4_252 .. "```",
    },
    {
      name = "��Mutation :",
      value = "```❯ " .. r5_252 .. "```",
    },
    {
      name = "��Sell Price :",
      value = "```❯ " .. r6_252 .. "```",
    }
  }
  r10_252 = {}
  r10_252.url = getThumbnailURL(r2_252.Icon) or "https://i.imgur.com/ly3iUKn.jpeg"
  r9_252.image = r10_252
  r9_252.footer = {
    text = "Meng Hub Webhook",
    icon_url = "https://i.imgur.com/ly3iUKn.jpeg",
  }
  r9_252.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
  -- setlist for #8 failed
  r7_252.embeds = r8_252
  r7_252.username = "Meng Hub Notification!"
  r7_252.avatar_url = "https://i.imgur.com/ly3iUKn.jpeg"
  sendWebhook(r1_252, r7_252)
end
sendNewFishWebhook = r153_0
r153_0 = buildFishDatabase
r153_0()
r153_0 = {}
local r147_0 = r153_0
r153_0 = pairs
r154_0 = r146_0
for r156_0, r157_0 in r153_0(r154_0) do
  r158_0 = table
  r159_0 = "insert"
  r158_0 = r158_0[r159_0]
  r159_0 = r147_0
  r160_0 = "Name"
  r160_0 = r157_0[r160_0]
  r158_0(r159_0, r160_0)
end
r153_0 = table
r154_0 = "sort"
r153_0 = r153_0[r154_0]
r154_0 = r147_0
r153_0(r154_0)
r153_0 = task
r154_0 = "spawn"
r153_0 = r153_0[r154_0]
function r154_0()
  -- line: [0, 0] id: 272
  repeat
    task.wait(1)
  until r20_0.RE_ObtainedNewFishNotification
  if not FishWebhookConnected then
    FishWebhookConnected = true
    r20_0.RE_ObtainedNewFishNotification.OnClientEvent:Connect(function(r0_273, r1_273)
      -- line: [0, 0] id: 273
      if r31_0.autoWebhook then
        local r2_273 = {
          Id = r0_273,
        }
        local r3_273 = {
          Weight = r1_273 and r1_273.Weight,
          VariantId = r1_273 and r1_273.VariantId,
        }
        r2_273.Metadata = r3_273
        sendNewFishWebhook(r2_273)
      end
    end)
  end
end
r153_0(r154_0)
r153_0 = WebhookTab
r155_0 = "Section"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Webhook Fish Caught"
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishSection = r153_0
r153_0 = WebFishSection
r155_0 = "Input"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Webhook URL"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = ""
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_93)
  -- line: [0, 0] id: 93
  _G.WebhookURLs = _G.WebhookURLs or {}
  _G.WebhookURLs.FishCaught = r0_93
  if _G.WebhookFlags and _G.WebhookFlags.FishCaught then
    _G.WebhookFlags.FishCaught.URL = r0_93
  end
  if nil and not nil then
    goto label_25	-- block#6 is visited secondly
  end
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishURLInput = r153_0
r155_0 = "Register"
r155_0 = "WebFishURLInput"
r156_0 = WebFishURLInput
r86_0:[r155_0](r155_0, r156_0)
r153_0 = WebFishSection
r155_0 = "Dropdown"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Tier Filter"
r155_0[r156_0] = r157_0
r156_0 = "Multi"
r157_0 = true
r155_0[r156_0] = r157_0
r156_0 = "AllowNone"
r157_0 = true
r155_0[r156_0] = r157_0
r156_0 = "Values"
r157_0 = {}
r158_0 = "Common"
r159_0 = "Uncommon"
r160_0 = "Rare"
r161_0 = "Epic"
r162_0 = "Legendary"
r163_0 = "Mythic"
r164_0 = "Secret"
-- setlist for #157 failed
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = {}
r158_0 = "Legendary"
r159_0 = "Mythic"
r160_0 = "Secret"
-- setlist for #157 failed
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_230)
  -- line: [0, 0] id: 230
  _G.WebhookRarities = r0_230
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishTierDropdown = r153_0
r155_0 = "Register"
r155_0 = "WebFishTierDropdown"
r156_0 = WebFishTierDropdown
r86_0:[r155_0](r155_0, r156_0)
r153_0 = WebFishSection
r155_0 = "Dropdown"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Name Filter"
r155_0[r156_0] = r157_0
r156_0 = "Multi"
r157_0 = true
r155_0[r156_0] = r157_0
r156_0 = "AllowNone"
r157_0 = true
r155_0[r156_0] = r157_0
r156_0 = "Values"
r157_0 = {}
r158_0 = "Refresh Fish!"
-- setlist for #157 failed
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = {}
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_228)
  -- line: [0, 0] id: 228
  _G.WebhookNames = r0_228
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishDropdown = r153_0
r153_0 = WebFishSection
r155_0 = "Button"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Refresh Fish"
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0()
  -- line: [0, 0] id: 229
  WebFishDropdown:Refresh(r147_0)
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = WebFishSection
r155_0 = "Input"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Hide Identity"
r155_0[r156_0] = r157_0
r156_0 = "Desc"
r157_0 = "Protect your name for sending webhook to discord"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = _G
r158_0 = "WebhookCustomName"
r157_0 = r157_0[r158_0] or ""
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_263)
  -- line: [0, 0] id: 263
  _G.WebhookCustomName = r0_263
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishIdentityInput = r153_0
r155_0 = "Register"
r155_0 = "WebFishIdentityInput"
r156_0 = WebFishIdentityInput
r86_0:[r155_0](r155_0, r156_0)
r153_0 = WebFishSection
r155_0 = "Toggle"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Send Fish Webhook"
r155_0[r156_0] = r157_0
r156_0 = "Value"
r157_0 = _G
r158_0 = "WebhookFlags"
r157_0 = r157_0[r158_0]
r158_0 = "FishCaught"
r157_0 = r157_0[r158_0]
r158_0 = "Enabled"
r157_0 = r157_0[r158_0]
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0(r0_271)
  -- line: [0, 0] id: 271
  _G.WebhookFlags.FishCaught.Enabled = r0_271
  r31_0.autoWebhook = r0_271
end
r155_0[r156_0] = r157_0
r153_0 = r153_0:[r155_0](r155_0)
WebFishToggle = r153_0
r155_0 = "Register"
r155_0 = "WebFishToggle"
r156_0 = WebFishToggle
r86_0:[r155_0](r155_0, r156_0)
r153_0 = WebFishSection
r155_0 = "Button"
r155_0 = {}
r156_0 = "Title"
r157_0 = "Test Webhook Connection"
r155_0[r156_0] = r157_0
r156_0 = "Callback"
function r157_0()
  -- line: [0, 0] id: 88
  local r0_88 = _G.WebhookFlags.FishCaught.URL
  if not r0_88 or not r0_88:match("discord.com/api/webhooks") then
    warn("[Webhook Test] ❌ Invalid or missing webhook URL.")
    return 
  end
  local r1_88 = {
    content = nil,
    embeds = {
      {
        color = 16738740,
        author = {
          name = "DuaaaAarrr Memeeeeew! Webhook connected coii...",
        },
        image = {
          url = "https://i.imgur.com/xl9yLMN.gif",
        },
      }
    },
    username = "Meng Hub Notification!",
    avatar_url = "https://i.imgur.com/ly3iUKn.jpeg",
    attachments = {},
  }
  task.spawn(function()
    -- line: [0, 0] id: 89
    local r0_89, r1_89 = pcall(function()
      -- line: [0, 0] id: 90
      return _G.httpRequest({
        Url = r0_88,
        Method = "POST",
        Headers = {
          ["Content-Type"] = "application/json",
        },
        Body = r4_0:JSONEncode(r1_88),
      })
    end)
    if r0_89 then
      r88_0("Successfully sent test message!")
    else
      r88_0("Failed to send webhook:", r1_89)
    end
  end)
end
r155_0[r156_0] = r157_0
r153_0:[r155_0](r155_0)
r153_0 = false
r154_0 = false
function r155_0(r0_143)
  -- line: [0, 0] id: 143
  if not r153_0 then
    return 
  end
  local r1_143 = _G.WebhookURLs.Disconnect
  if not r1_143 then
    r1_143 = _G.WebhookFlags
    if r1_143 then
      r1_143 = _G.WebhookFlags.Disconnect.URL or ""
    else
      goto label_19	-- block#5 is visited secondly
    end
  end
  if r1_143 == "" or not r1_143:match("discord") then
    return 
  end
  local r2_143 = game.Players.LocalPlayer
  local r3_143 = "Unknown"
  if _G.DisconnectCustomName and _G.DisconnectCustomName ~= "" then
    r3_143 = _G.DisconnectCustomName
  elseif r2_143 and r2_143.Name then
    r3_143 = r2_143.Name
  end
  local r4_143 = os.date("*t")
  local r5_143 = r4_143.hour
  if r5_143 > 12 then
    r5_143 = r4_143.hour - 12 or r4_143.hour
  else
    goto label_60	-- block#17 is visited secondly
  end
  local r6_143 = r4_143.hour
  if r6_143 >= 12 then
    r6_143 = "PM" or "AM"
  else
    goto label_67	-- block#20 is visited secondly
  end
  local r7_143 = string.format("%02d/%02d/%04d %02d.%02d %s", r4_143.day, r4_143.month, r4_143.year, r5_143, r4_143.min, r6_143)
  local r8_143 = r149_0
  if r8_143 ~= "" then
    r8_143 = r149_0 or "Anonymous"
  else
    goto label_84	-- block#23 is visited secondly
  end
  local r9_143 = nil	-- notice: implicit variable refs by block#[28]
  if r0_143 and r0_143 ~= "" then
    r9_143 = r0_143
    if r9_143 then
      ::label_91::
      r9_143 = "Disconnected from server"
    end
  else
    goto label_91	-- block#27 is visited secondly
  end
  local r10_143 = {
    content = "DuaaaAArrrr Memeeeeew, Hello! " .. r8_143 .. " akun lu keluar tuh dari server (disconnect)!",
    embeds = {
      {
        title = "DETAIL ACCOUNT",
        color = 36863,
        fields = {
          {
            name = "��Username :",
            value = "> " .. r3_143,
          },
          {
            name = "��Time got disconnected :",
            value = "> " .. r7_143,
          },
          {
            name = "��Reason :",
            value = "> " .. r9_143,
          }
        },
        thumbnail = {
          url = "https://i.imgur.com/xl9yLMN.gif",
        },
      }
    },
    username = "Meng Hub Notification!",
    avatar_url = "https://i.imgur.com/ly3iUKn.jpeg",
  }
  task.spawn(function()
    -- line: [0, 0] id: 144
    pcall(function()
      -- line: [0, 0] id: 145
      _G.httpRequest({
        Url = r1_143,
        Method = "POST",
        Headers = {
          ["Content-Type"] = "application/json",
        },
        Body = r4_0:JSONEncode(r10_143),
      })
    end)
  end)
end
SendDisconnectWebhook = r155_0
r155_0 = WebhookTab
r157_0 = "Section"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Webhook Alert/Disconnect"
r157_0[r158_0] = r159_0
r155_0 = r155_0:[r157_0](r157_0)
WebDisconnectSection = r155_0
r155_0 = WebDisconnectSection
r157_0 = "Input"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Disconnect Alert Webhook URL"
r157_0[r158_0] = r159_0
r158_0 = "Value"
r159_0 = ""
r157_0[r158_0] = r159_0
r158_0 = "Placeholder"
r159_0 = "Input URL here..."
r157_0[r158_0] = r159_0
r158_0 = "Callback"
function r159_0(r0_43)
  -- line: [0, 0] id: 43
  _G.WebhookURLs = _G.WebhookURLs or {}
  _G.WebhookURLs.Disconnect = r0_43
  if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
    _G.WebhookFlags.Disconnect.URL = r0_43
  end
end
r157_0[r158_0] = r159_0
r155_0 = r155_0:[r157_0](r157_0)
WebDisconnectURL = r155_0
r157_0 = "Register"
r157_0 = "WebDisconnectURL"
r158_0 = WebDisconnectURL
r86_0:[r157_0](r157_0, r158_0)
r155_0 = WebDisconnectSection
r157_0 = "Input"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Discord ID"
r157_0[r158_0] = r159_0
r158_0 = "Value"
r159_0 = ""
r157_0[r158_0] = r159_0
r158_0 = "Placeholder"
r159_0 = "Input ur Discord Id here..."
r157_0[r158_0] = r159_0
r158_0 = "Callback"
function r159_0(r0_78)
  -- line: [0, 0] id: 78
  if r0_78 and r0_78 ~= "" then
    r149_0 = "<@" .. r0_78:gsub("%D", "") .. ">"
  else
    r149_0 = ""
  end
end
r157_0[r158_0] = r159_0
r155_0 = r155_0:[r157_0](r157_0)
WebDiscordID = r155_0
r157_0 = "Register"
r157_0 = "WebDiscordID"
r158_0 = WebDiscordID
r86_0:[r157_0](r157_0, r158_0)
r155_0 = WebDisconnectSection
r157_0 = "Input"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Hide Identity"
r157_0[r158_0] = r159_0
r158_0 = "Placeholder"
r159_0 = "Enter custom name (leave blank for default)"
r157_0[r158_0] = r159_0
r158_0 = "Default"
r159_0 = _G
r160_0 = "DisconnectCustomName"
r159_0 = r159_0[r160_0] or ""
r157_0[r158_0] = r159_0
r158_0 = "Callback"
function r159_0(r0_289)
  -- line: [0, 0] id: 289
  _G.DisconnectCustomName = r0_289
end
r157_0[r158_0] = r159_0
r155_0 = r155_0:[r157_0](r157_0)
WebDisconnectName = r155_0
r157_0 = "Register"
r157_0 = "WebDisconnectName"
r158_0 = WebDisconnectName
r86_0:[r157_0](r157_0, r158_0)
r155_0 = WebDisconnectSection
r157_0 = "Toggle"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Send Webhook On Disconnect"
r157_0[r158_0] = r159_0
r158_0 = "Desc"
r159_0 = "Notify your Discord when account disconnected and auto rejoin."
r157_0[r158_0] = r159_0
r158_0 = "Value"
r159_0 = _G
r160_0 = "WebhookFlags"
r159_0 = r159_0[r160_0]
r160_0 = "Disconnect"
r159_0 = r159_0[r160_0]
r160_0 = "Enabled"
r159_0 = r159_0[r160_0] or false
r157_0[r158_0] = r159_0
r158_0 = "Callback"
function r159_0(r0_114)
  -- line: [0, 0] id: 114
  if r0_114 and (not _G.DisconnectCustomName or _G.DisconnectCustomName == "") then
    r88_0("Invalid! Input Hide Identity first.")
    if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
      _G.WebhookFlags.Disconnect.Enabled = false
    end
    r153_0 = false
    return 
  end
  r153_0 = r0_114
  if _G.WebhookFlags and _G.WebhookFlags.Disconnect then
    _G.WebhookFlags.Disconnect.Enabled = r0_114
  end
  if r0_114 then
    r154_0 = false
    local function r2_114(r0_115)
      -- line: [0, 0] id: 115
      if not r154_0 and r153_0 then
        r154_0 = true
        SendDisconnectWebhook(r0_115 or "Disconnected from server")
        task.wait(2)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
      end
    end
    r13_0.ErrorMessageChanged:Connect(function(r0_117)
      -- line: [0, 0] id: 117
      if r0_117 and r0_117 ~= "" then
        r2_114(r0_117)
      end
    end)
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(r0_116)
      -- line: [0, 0] id: 116
      if r0_116.Name == "ErrorPrompt" then
        task.wait(1)
        local r1_116 = r0_116:FindFirstChildWhichIsA("TextLabel", true)
        local r2_116 = nil	-- notice: implicit variable refs by block#[4]
        if r1_116 then
          r2_116 = r1_116.Text
          if not r2_116 then
            ::label_16::
            r2_116 = "Disconnected"
          end
        else
          goto label_16	-- block#3 is visited secondly
        end
        r2_114(r2_116)
      end
    end)
    -- close: r2_114
  end
end
r157_0[r158_0] = r159_0
r155_0 = r155_0:[r157_0](r157_0)
WebDisconnectToggle = r155_0
r157_0 = "Register"
r157_0 = "WebDisconnectToggle"
r158_0 = WebDisconnectToggle
r86_0:[r157_0](r157_0, r158_0)
r155_0 = WebDisconnectSection
r157_0 = "Button"
r157_0 = {}
r158_0 = "Title"
r159_0 = "Test Disconnected Player"
r157_0[r158_0] = r159_0
r158_0 = "Desc"
r159_0 = "Kick ur self, send webhook, and auto rejoin."
r157_0[r158_0] = r159_0
r158_0 = "Callback"
function r159_0()
  -- line: [0, 0] id: 155
  r88_0("Kicking player...")
  task.wait(1)
  SendDisconnectWebhook("Successfully")
  task.wait(2)
  game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end
r157_0[r158_0] = r159_0
r155_0:[r157_0](r157_0)
function r155_0()
  -- line: [0, 0] id: 274
  r86_0:Save()
  for r4_274, r5_274 in ipairs({
    EquipRodToggle,
    NoAnimToggle,
    LegitFishingToggle,
    AutoShakeToggle,
    StableInstantToggle,
    InstantToggle,
    BlatantToggle,
    WeatherToggle,
    MaxZoomToggle,
    AntiStaffToggle,
    RadarToggle,
    FakeIdentityToggle,
    CutsceneToggle,
    ObtainedToggle,
    WebFishToggle,
    WebDisconnectToggle,
    StreamerToggle,
    FreezeToggle,
    FlyToggle,
    ReduceToggle,
    TalonToggle,
    VFXToggle
  }) do
    if r5_274 then
      r5_274:Set(false)
    end
  end
  SetWalkOnWater(false)
  if game.CoreGui:FindFirstChild("ToggleUIButton") then
    game.CoreGui.ToggleUIButton:Destroy()
  end
end
r158_0 = "OnDestroy"
function r158_0()
  -- line: [0, 0] id: 189
  r155_0()
end
r84_0:[r158_0](r158_0)
r158_0 = "Load"
r86_0:[r158_0]()
