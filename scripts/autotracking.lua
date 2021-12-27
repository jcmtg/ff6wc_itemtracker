-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
-------------------------------------------------------

--print("		")
--print("		Active Auto-Tracker Configuration")
--print("		---------------------------------------------------------------------")
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    --print("		Enable Debug Logging:        ", "true")
end
--print("		---------------------------------------------------------------------")
--print("		")

--
-- Script variables
--

--
-- Invoked when the auto-tracker is activated/connected
--
function autotracker_started()
    
end

 
BATTLE_COUNTER = 0x7E3A44
gBattleCounter1 = 0x00
gBattleCounter2 = 0x00
BATTLE_PARTY_SLOTS_BITMASK = 0x7E201D
gBattlePartySlotsActive = {}
gBattlePartySlotsActive[0] = false
gBattlePartySlotsActive[1] = false
gBattlePartySlotsActive[2] = false
gBattlePartySlotsActive[3] = false
gNewbattleEquipScan = false
gNewbattleInventoryScan = false
gBattleEquipScanInitialized = false
gBattleEquipIsValid = false
gBattleInventoryIsValid = false
gBattleItemsToSkip_table = {}

gCharacterNames = {}
gCharactersActiveStatus = {}
gCharacterInitialEquipment_2d = {}
gIsInitCharRecruitEquip = false

gItemNames = {}

gInventoryItems = {}
gPrevInventoryItems = {}
gInventoryQuantities = {}
gPrevInventoryQuantities = {}
gPrevInventoryItemsChangeCount = 0

gBattleInventoryItems = {}
gBattleInventoryQuantities = {}
gPrevBattleInventoryItems = {}
gPrevBattleInventoryQuantities = {}



gBattleEquipItems = {}
gPrevBattleEquipItems = {}
--gBattleEquipItemsQuantities = {}
gBattleEquipItemsNeedsInit = true

gBattleItemsToSkip_table = {}
gTemp_DepletedItemID = -1
BATTLE_NUM_ALIVE_MONSTERS = 0x7E3ECA
gBattleNumAliveMonsters = -1

CURRENT_AREA = 0x7e0082
gCurrentArea = -1

NUM_OF_PLAYER_CHARACTERS = 14

START_CHARACTER_EQUIP = 0x7E161F

START_INVENTORY_ITEMS = 0x7E1869
START_INVENTORY_QUANTITIES = 0x7E1969

START_BATTLE_INVENTORY = 0x7E2686
BATTLE_INVENTORY_INIT_1 = {}
BATTLE_INVENTORY_INIT_1[0] = 0x1F
BATTLE_INVENTORY_INIT_1[1] = 0x00
BATTLE_INVENTORY_INIT_1[2] = 0x00
BATTLE_INVENTORY_INIT_1[3] = 0x00

BATTLE_INVENTORY_INIT_2 = {}
BATTLE_INVENTORY_INIT_2[0] = 0x54
BATTLE_INVENTORY_INIT_2[1] = 0x55
BATTLE_INVENTORY_INIT_2[2] = 0x54
BATTLE_INVENTORY_INIT_2[3] = 0x55 
 

-- ARMOR_OR_HELM_BATTLE_INVENTORY = 0x80
-- SHIELD_BATTLE_INVENTORY = 0xB0
-- ELE_SHIELD__BATTLE_INVENTORY = 0x08
-- THROWABLE_WEAPON_BATTLE_INVENTORY = 0xB0
-- NONTHROWABLE_WEAPON_BATTLE_INVENTORY = 0x90
-- ROD_BATTLE_INVENTORY = 0x10

START_BATTLE_RIGHT_HAND_EQUIPPED = 0x7E2B86

BATTLE_EQUIP_INIT_1 = {}
BATTLE_EQUIP_INIT_1[0] = 0x28
BATTLE_EQUIP_INIT_1[1] = 0x08
BATTLE_EQUIP_INIT_1[2] = 0xC0
BATTLE_EQUIP_INIT_1[3] = 0x00
BATTLE_EQUIP_INIT_1[4] = 0x74
BATTLE_EQUIP_INIT_1[5] = 0x60
BATTLE_EQUIP_INIT_1[6] = 0x20
BATTLE_EQUIP_INIT_1[7] = 0x30

BATTLE_EQUIP_INIT_2 = {}
BATTLE_EQUIP_INIT_2[0] = 0xFF
BATTLE_EQUIP_INIT_2[1] = 0xCC
BATTLE_EQUIP_INIT_2[2] = 0xFF
BATTLE_EQUIP_INIT_2[3] = 0xFF
BATTLE_EQUIP_INIT_2[4] = 0x83
BATTLE_EQUIP_INIT_2[5] = 0x01
BATTLE_EQUIP_INIT_2[6] = 0xFF
BATTLE_EQUIP_INIT_2[7] = 0x7F

BATTLE_EQUIP_INIT_3 = {}
BATTLE_EQUIP_INIT_3[0] = 0x54
BATTLE_EQUIP_INIT_3[1] = 0x55
BATTLE_EQUIP_INIT_3[2] = 0x54
BATTLE_EQUIP_INIT_3[3] = 0x55
BATTLE_EQUIP_INIT_3[4] = 0x54
BATTLE_EQUIP_INIT_3[5] = 0x55
BATTLE_EQUIP_INIT_3[6] = 0x54
BATTLE_EQUIP_INIT_3[7] = 0x55

COLOSSEUM_WAGER_ITEM = 0x7E0205
gLastColosseumWager = -1
gNewWagerFlag = false
gLastColosseumFightIsAGo = false

START_CONTEXT_ADDRESS = 0x7e1501
START_CONTEXT_MENU_SUB_ADDRESS = 0x7E0026 --player-menu-items sub types
--END_CONTEXT_ADDRESS = 0x7e1503
CONTEXT_MENU_1 = 0x87 --shops or player-menu
CONTEXT_MENU_2 = 0x13
CONTEXT_MENU_3 = 0xC3


--sub contexts
NUM_SUB_CONTEXTS_TO_CARE_ABOUT = 15
--significants:
CONTEXT_MENU_LOAD_SAVE = 0x23

CONTEXT_MENU_SUB_ITEMS_USE_ITEM_PARTY_VISIBLE = 0x70

CONTEXT_MENU_SUB_SHOP_START = 0x25

CONTEXT_MENU_SUB_SHOP_BUY_1 = 0x26
CONTEXT_MENU_SUB_SHOP_BUY_2 = 0x27
CONTEXT_MENU_SUB_SHOP_BUY_3 = 0x28

CONTEXT_MENU_SUB_SHOP_BUY_UNKNOWN = 0x5F

CONTEXT_MENU_SUB_SHOP_SELL_1 = 0x29
CONTEXT_MENU_SUB_SHOP_SELL_2 = 0x2A
CONTEXT_MENU_SUB_SHOP_SELL_3 = 0x2B


CONTEXT_MENU_SUB_COLI_1 = 0x72
CONTEXT_MENU_SUB_COLI_2 = 0x76

CONTEXT_TRANSITION = 0x02


--insignificants:
CONTEXT_MENU_SUB_ITEMS_BROWSE = 0x08
CONTEXT_MENU_SUB_ITEMS_MANUALLY_REARRANGE = 0x19
CONTEXT_MENU_SUB_ARRANGE_CAN_BE_PRESSED = 0x17 --the top menu is "items, arrange, rare"

CONTEXT_MENU_SUB_EQUIP_OPTIMUM_CAN_BE_PRESSED = 0x36 --the top menu is "equip,optimum,rmove,empty"
CONTEXT_MENU_SUB_EQUIP = 0x57
CONTEXT_MENU_SUB_EQUIP_REMOVE = 0x56

CONTEXT_MENU_SUB_RELIC_EQUIP = 0x5A
CONTEXT_MENU_SUB_RELIC_REMOVE = 0x5C



START_ADDRESS_PARTY_EQUIP = 0x7e0000


--
CONTEXT_CAVE_1 = 0x82 --non-overworld areas
CONTEXT_CAVE_2 = 0x01
CONTEXT_CAVE_3 = 0xC0

CONTEXT_BATTLE_1 = 0xA7
CONTEXT_BATTLE_2 = 0x0B
CONTEXT_BATTLE_3 = 0xC1

CONTEXT_OVERWORLD_1 = 0x28

gInBattle = false
gInCave = false
gInMenu_Significant = false -- "significant" means: we care when item quantity changes
gInMenu_SubType = 0
gPrevInMenu_SubType = -1
gInMenu = false --shops and party-menu

CURRENT_SHOP = 0x7E0201
CURRENT_SHOP_INVENTORY_START = 0x7E9D89
gCurrentShop = -1
gPrevShop = -3
gShopList_table = {}

gPrevSubMenuContexts_table = {}
  

function debugGlobals()
    return "gInBattle: "..tostring(gInBattle).." gInCave:"..tostring(gInCave).." gInMenu_Significant:"..tostring(gInMenu_Significant).." gInMenu:"..tostring(gInMenu)
end

function resetCurrentMode()
    gInBattle = false
	gBattleEquipScanInitialized = false
	gBattleItemsToSkip_table = {}
		--print("reset skiplist 3")
    gInCave = false
    gInMenu_Significant = false -- "significant" means: we care when item quantity changes
    gInMenu = false
end

function isSignificantChange()
    --print("START isSignificantChange()->"..debugGlobals())
    if gInBattle == true or gInCave == true or gInMenu_Significant == true then
        if gInBattle == true or gInCave == true or gInMenu_Significant == true then
			return true
		end
    end
	--print("END isSignificantChange()")
    return false
end

 
function updatePlayerModeContext(segment)

    local readVal = segment:ReadUInt8(START_CONTEXT_ADDRESS)
    --print("START updatePlayerModeContext() -> "..readVal)
    if readVal ~= CONTEXT_MENU_1 and readVal ~= CONTEXT_CAVE_1 and readVal ~= CONTEXT_BATTLE_1  then --check for shop/player-menu, chest-hunting, or in battle
        gInBattle = false
		gBattleEquipScanInitialized = false
		gBattleItemsToSkip_table = {}
		--print("reset skiplist 4")
		gInCave = false
		return
    end
    ----print("		updatePlayerModeContext...1")
    --are we in party-menu/shop?
    if readVal == CONTEXT_MENU_1 then 
        local readVal2 = segment:ReadUInt8(START_CONTEXT_ADDRESS+1)
        if readVal2 == CONTEXT_MENU_2 then 
            ----print("		updatePlayerModeContext...2")
            local readVal3 = segment:ReadUInt8(START_CONTEXT_ADDRESS+2)
            if readVal3 == CONTEXT_MENU_3 then 
                ----print("		updatePlayerModeContext...3")
                resetCurrentMode()
                gInMenu = true
				table.insert(gPrevSubMenuContexts_table, CONTEXT_MENU_3) --push
            end
        end
    end

    -- --are we in battle?
    -- if readVal == CONTEXT_BATTLE_1 then 
    --     local readVal2 = segment:ReadUInt8(START_CONTEXT_ADDRESS+1)
    --     if readVal2 == CONTEXT_BATTLE_2 then 
    --         local readVal3 = segment:ReadUInt8(START_CONTEXT_ADDRESS+2)
    --         if readVal3 == CONTEXT_BATTLE_3 then 
    --             resetCurrentMode()
    --             gInBattle = true
	-- 			gInCave = false


    --             --print("		battle now!")
    --         end
    --     end
    -- end

    --are we in non-overworld/cave?
    if readVal == CONTEXT_CAVE_1 then 
        local readVal2 = segment:ReadUInt8(START_CONTEXT_ADDRESS+1)
        if readVal2 == CONTEXT_CAVE_2 then 
            local readVal3 = segment:ReadUInt8(START_CONTEXT_ADDRESS+2)
            if readVal3 == CONTEXT_CAVE_3 then 
                resetCurrentMode()
                gInCave = true
				gInBattle = false
				gBattleEquipScanInitialized = false
				gBattleItemsToSkip_table = {}
		--print("reset skiplist 5")
            end
        end
    end
     
    --are we in Shop? are we in Item->using item on party? see: function updatePlayerModeMenuSubContext()
	--print("END updatePlayerModeContext() ")
end

 


function updatePlayerModeMenuSubContext(segment)
    --print("START updatePlayerModeMenuSubContext()")
	gInMenu_Significant = false

    if gInMenu ~= true then
        return
    end

    local readVal = segment:ReadUInt8(START_CONTEXT_MENU_SUB_ADDRESS)
	gInMenu_SubType = readVal

	local lengthOfgPrevSubMenuContexts_table = 0
    for _ in pairs(gPrevSubMenuContexts_table) do lengthOfgPrevSubMenuContexts_table = lengthOfgPrevSubMenuContexts_table + 1 end
    
	if lengthOfgPrevSubMenuContexts_table > NUM_SUB_CONTEXTS_TO_CARE_ABOUT then
		table.remove(gPrevSubMenuContexts_table, 1) --pop
	end
	table.insert(gPrevSubMenuContexts_table, readVal) --push
	--print("		 updatePlayerModeMenuSubContext() ----------------->push"..readVal.." <----------------------")

	 

    --print("		current sub context: "..readVal)
	 
	



	
	if readVal == CONTEXT_MENU_LOAD_SAVE then
		return
	end

	if isInPrevSubMenuContexts(CONTEXT_MENU_SUB_ITEMS_USE_ITEM_PARTY_VISIBLE) or isInPrevSubMenuContexts(CONTEXT_MENU_3) then
		--print("		isInPrevSubMenuContexts(CONTEXT_MENU_SUB_ITEMS_USE_ITEM_PARTY_VISIBLE)")
		gInMenu_Significant = true

		return
	end

	if isInPrevSubMenuContexts(CONTEXT_MENU_SUB_SHOP_BUY_1) then
		--print("		isInPrevSubMenuContexts(CONTEXT_MENU_SUB_ITEMS_USE_ITEM_PARTY_VISIBLE)")
		gInMenu_Significant = true

		return
	end

	if isInPrevSubMenuContexts(CONTEXT_MENU_SUB_SHOP_SELL_1) then
		--print("		isInPrevSubMenuContexts(CONTEXT_MENU_SUB_ITEMS_USE_ITEM_PARTY_VISIBLE)")
		gInMenu_Significant = true

		return
	end

 
 

    if readVal == CONTEXT_MENU_SUB_SHOP_BUY_1 or readVal == CONTEXT_MENU_SUB_SHOP_BUY_2 or readVal == CONTEXT_MENU_SUB_SHOP_BUY_3 or readVal == CONTEXT_MENU_SUB_SHOP_SELL_1 or readVal == CONTEXT_MENU_SUB_SHOP_SELL_2 or readVal == CONTEXT_MENU_SUB_SHOP_SELL_3 then
		--print("		top, long, case: SHOP BUY_SELL")
        gInMenu_Significant = true

		if isShopListLoaded() then
			loadShopList()
		end
 
	elseif readVal == CONTEXT_MENU_SUB_COLI_1 or readVal == CONTEXT_MENU_SUB_COLI_2 then
		--print("		CONTEXT_MENU_SUB_COLI_1 == 0x72 or CONTEXT_MENU_SUB_COLI_2 == 0x76")
		gInMenu_Significant = true
    elseif readVal == CONTEXT_MENU_SUB_EQUIP_OPTIMUM_CAN_BE_PRESSED or readVal == CONTEXT_MENU_SUB_EQUIP or readVal == CONTEXT_MENU_SUB_EQUIP_REMOVE then
		--print("		readVal == CONTEXT_MENU_SUB_EQUIP_OPTIMUM_CAN_BE_PRESSED or readVal == CONTEXT_MENU_SUB_EQUIP or readVal == CONTEXT_MENU_SUB_EQUIP_REMOVE")
		gInMenu_Significant = false
	elseif readVal == CONTEXT_MENU_SUB_RELIC_EQUIP or readVal == CONTEXT_MENU_SUB_RELIC_REMOVE then
		--print("		readVal == CONTEXT_MENU_SUB_RELIC_EQUIP or readVal == CONTEXT_MENU_SUB_RELIC_REMOVE")
		gInMenu_Significant = false
	else
		--print("		else")
        gInMenu_Significant = false
    end
	--print("END updatePlayerModeMenuSubContext()")
end
 
function initCharNameArray()
    gCharacterNames[0] = "TERRA"
    gCharacterNames[1] = "LOCKE"
    gCharacterNames[2] = "CYAN"
    gCharacterNames[3] = "SHADOW"
    gCharacterNames[4] = "EDGAR"
    gCharacterNames[5] = "SABIN"
    gCharacterNames[6] = "CELES"
    gCharacterNames[7] = "STRAGO"
    gCharacterNames[8] = "RELM"
    gCharacterNames[9] = "SETZER"
    gCharacterNames[10] = "MOG"
    gCharacterNames[11] = "GAU"
    gCharacterNames[12] = "GOGO"
    gCharacterNames[13] = "UMARO"
end

function initCharactersActiveStatus()
    gCharactersActiveStatus[0] = false
    gCharactersActiveStatus[1] = false
    gCharactersActiveStatus[2] = false
    gCharactersActiveStatus[3] = false
    gCharactersActiveStatus[4] = false
    gCharactersActiveStatus[5] = false
    gCharactersActiveStatus[6] = false
    gCharactersActiveStatus[7] = false
    gCharactersActiveStatus[8] = false
    gCharactersActiveStatus[9] = false
    gCharactersActiveStatus[10] = false
    gCharactersActiveStatus[11] = false
    gCharactersActiveStatus[12] = false
    gCharactersActiveStatus[13] = false
end


 


function initBattleInventoryItems()
    for i=0, 255 do
        gBattleInventoryItems[i] = 0
    end
end

function initBattleInventoryQuantities()
    for i=0, 255 do
        gBattleInventoryQuantities[i] = 0
    end
end

 

function initgCharacterInitialEquipment_2d()
    for i=0,NUM_OF_PLAYER_CHARACTERS-1 do
        gCharacterInitialEquipment_2d[i] = {}
    end
end

function initShopList_table()
    gShopList_table = {}
end

function gPrevSubMenuContexts_table()
	gPrevSubMenuContexts_table = {}
end
 
function grabAllCharacterRecruitmentEquipment(segment)
	--print("START grabAllCharacterRecruitmentEquipment()")
    if gIsInitCharRecruitEquip == true then
        return
    end

    if segment:ReadUInt8(START_CHARACTER_EQUIP) == 0x00 then
        return
    end


    for i=0, (NUM_OF_PLAYER_CHARACTERS-1)*37, 37 do
        gCharacterInitialEquipment_2d[i/37][0] = segment:ReadUInt8(START_CHARACTER_EQUIP+i) -- weapon
        gCharacterInitialEquipment_2d[i/37][1] = segment:ReadUInt8(START_CHARACTER_EQUIP+i+1) -- shield
        gCharacterInitialEquipment_2d[i/37][2] = segment:ReadUInt8(START_CHARACTER_EQUIP+i+2) -- helmet
        gCharacterInitialEquipment_2d[i/37][3] = segment:ReadUInt8(START_CHARACTER_EQUIP+i+3) -- armor
        gCharacterInitialEquipment_2d[i/37][4] = segment:ReadUInt8(START_CHARACTER_EQUIP+i+4) -- relic1
        gCharacterInitialEquipment_2d[i/37][5] = segment:ReadUInt8(START_CHARACTER_EQUIP+i+5) -- relic2
    end

    ----print("		grab all complete")
    
    gIsInitCharRecruitEquip = true
    
    for i=0, NUM_OF_PLAYER_CHARACTERS-1 do --can get out of sync at ROM start. search this comment for other section.
        if gCharactersActiveStatus[i] == true then
            trackNewlyRecruitedCharacterEquipment(i)
        end
    end

    --print("END grabAllCharacterRecruitmentEquipment()")
end


function isInPrevSubMenuContexts(contextid)
    local lengthOfTable = 0
    for _ in pairs(gPrevSubMenuContexts_table) do lengthOfTable = lengthOfTable + 1 end
    
    if lengthOfTable == 0 then
        return false
    end

    for index, value in ipairs(gPrevSubMenuContexts_table) do
        
        if value == contextid then
            --print("		prevContext: "..value.." *")
            return true
		else
			--print("		prevContext: "..value)
        end
    end

	----print("START	 isItemInSkipList")
    return false

end

function isItemInSkipList(itemid)
    ----print("START	 isItemInSkipList")

    local lengthOfTable = 0
    for _ in pairs(gBattleItemsToSkip_table) do lengthOfTable = lengthOfTable + 1 end
    
    if lengthOfTable == 0 then
        ----print("		skip list is empty!")
        return false
    end

    ----print("		skip list len: "..lengthOfTable)

    for index, value in ipairs(gBattleItemsToSkip_table) do
        ----print("		scanning skip list....i: "..index.." item: "..gItemNames[value])
        if value == itemid then
            ----print("		))) found in skip list")
            return true
        end
    end

	----print("START	 isItemInSkipList")
    return false

end


function trackNewlyRecruitedCharacterEquipment(characterIndex)
	--print("START	 trackNewlyRecruitedCharacterEquipment() -> [x] ")
    if gIsInitCharRecruitEquip == false then
        return
    end

    for i=0, 5 do
        
        if gCharacterInitialEquipment_2d[characterIndex][i] == 0xFF then

        else
			--print("		8")
			updateTrackerItem(gCharacterInitialEquipment_2d[characterIndex][i], 1)
        end

        
         
         
    end
	--print("END	 trackNewlyRecruitedCharacterEquipment() -> [x] ")
end


function initHardCodedItemNames()
    
    for i=0, 256 do
      gItemNames[i] = 0
    end
  gItemNames[0] = "Dirk"
  gItemNames[1] = "MithrilKnife"
  gItemNames[2] = "Guardian"
  gItemNames[3] = "Air Lancet"
  gItemNames[4] = "ThiefKnife"
  gItemNames[5] = "Assassin"
  gItemNames[6] = "Man Eater"
  gItemNames[7] = "SwordBreaker"
  gItemNames[8] = "Graedus"
  gItemNames[9] = "ValiantKnife"
  gItemNames[10] = "MithrilBlade"
  gItemNames[11] = "RegalCutlass"
  gItemNames[12] = "Rune Edge"
  gItemNames[13] = "Flame Sabre"
  gItemNames[14] = "Blizzard"
  gItemNames[15] = "ThunderBlade"
  gItemNames[16] = "Epee"
  gItemNames[17] = "Break Blade"
  gItemNames[18] = "Drainer"
  gItemNames[19] = "Enhancer"
  gItemNames[20] = "Crystal"
  gItemNames[21] = "Falchion"
  gItemNames[22] = "Soul Sabre"
  gItemNames[23] = "Ogre Nix"
  gItemNames[24] = "Excalibur"
  gItemNames[25] = "Scimitar"
  gItemNames[26] = "Illumina"
  gItemNames[27] = "Ragnarok"
  gItemNames[28] = "Atma Weapon"
  gItemNames[29] = "Mithril Pike"
  gItemNames[30] = "Trident"
  gItemNames[31] = "Stout Spear"
  gItemNames[32] = "Partisan"
  gItemNames[33] = "Pearl Lance"
  gItemNames[34] = "Gold Lance"
  gItemNames[35] = "Aura Lance"
  gItemNames[36] = "Imp Halberd"
  gItemNames[37] = "Imperial"
  gItemNames[38] = "Kodachi"
  gItemNames[39] = "Blossom"
  gItemNames[40] = "Hardened"
  gItemNames[41] = "Striker"
  gItemNames[42] = "Stunner"
  gItemNames[43] = "Ashura"
  gItemNames[44] = "Kotetsu"
  gItemNames[45] = "Forged"
  gItemNames[46] = "Tempest"
  gItemNames[47] = "Murasame"
  gItemNames[48] = "Aura"
  gItemNames[49] = "Strato"
  gItemNames[50] = "Sky Render"
  gItemNames[51] = "Heal Rod"
  gItemNames[52] = "Mithril Rod"
  gItemNames[53] = "Fire Rod"
  gItemNames[54] = "Ice Rod"
  gItemNames[55] = "Thunder Rod"
  gItemNames[56] = "Poison Rod"
  gItemNames[57] = "Pearl Rod"
  gItemNames[58] = "Gravity Rod"
  gItemNames[59] = "Punisher"
  gItemNames[60] = "Magus Rod"
  gItemNames[61] = "Chocobo Brsh"
  gItemNames[62] = "DaVinci Brsh"
  gItemNames[63] = "Magical Brsh"
  gItemNames[64] = "Rainbow Brsh"
  gItemNames[65] = "Shuriken"
  gItemNames[66] = "Ninja Star"
  gItemNames[67] = "Tack Star"
  gItemNames[68] = "Flail"
  gItemNames[69] = "Full Moon"
  gItemNames[70] = "Morning Star"
  gItemNames[71] = "Boomerang"
  gItemNames[72] = "Rising Sun"
  gItemNames[73] = "Hawk Eye"
  gItemNames[74] = "Bone Club"
  gItemNames[75] = "Sniper"
  gItemNames[76] = "Wing Edge"
  gItemNames[77] = "Cards"
  gItemNames[78] = "Darts"
  gItemNames[79] = "Doom Darts"
  gItemNames[80] = "Trump"
  gItemNames[81] = "Dice"
  gItemNames[82] = "Fixed Dice"
  gItemNames[83] = "MetalKnuckle"
  gItemNames[84] = "Mithril Claw"
  gItemNames[85] = "Kaiser"
  gItemNames[86] = "Poison Claw"
  gItemNames[87] = "Fire Knuckle"
  gItemNames[88] = "Dragon Claw"
  gItemNames[89] = "Tiger Fangs"
  gItemNames[90] = "Buckler"
  gItemNames[91] = "Heavy Shld"
  gItemNames[92] = "Mithril Shld"
  gItemNames[93] = "Gold Shld"
  gItemNames[94] = "Aegis Shld"
  gItemNames[95] = "Diamond Shld"
  gItemNames[96] = "Flame Shld"
  gItemNames[97] = "Ice Shld"
  gItemNames[98] = "Thunder Shld"
  gItemNames[99] = "Crystal Shld"
  gItemNames[100] = "Genji Shld"
  gItemNames[101] = "TortoiseShld"
  gItemNames[102] = "Cursed Shld"
  gItemNames[103] = "Paladin Shld"
  gItemNames[104] = "Force Shld"
  gItemNames[105] = "Leather Hat"
  gItemNames[106] = "Hair Band"
  gItemNames[107] = "Plumed Hat"
  gItemNames[108] = "Beret"
  gItemNames[109] = "Magus Hat"
  gItemNames[110] = "Bandana"
  gItemNames[111] = "Iron Helmet"
  gItemNames[112] = "Coronet"
  gItemNames[113] = "Bards Hat"
  gItemNames[114] = "Green Beret"
  gItemNames[115] = "Head Band"
  gItemNames[116] = "Mithril Helm"
  gItemNames[117] = "Tiara"
  gItemNames[118] = "Gold Helmet"
  gItemNames[119] = "Tiger Mask"
  gItemNames[120] = "Red Cap"
  gItemNames[121] = "Mystery Veil"
  gItemNames[122] = "Circlet"
  gItemNames[123] = "Regal Crown"
  gItemNames[124] = "Diamond Helm"
  gItemNames[125] = "Dark Hood"
  gItemNames[126] = "Crystal Helm"
  gItemNames[127] = "Oath Veil"
  gItemNames[128] = "Cat Hood"
  gItemNames[129] = "Genji Helmet"
  gItemNames[130] = "Thornlet"
  gItemNames[131] = "Titanium"
  gItemNames[132] = "LeatherArmor"
  gItemNames[133] = "Cotton Robe"
  gItemNames[134] = "Kung Fu Suit"
  gItemNames[135] = "Iron Armor"
  gItemNames[136] = "Silk Robe"
  gItemNames[137] = "Mithril Vest"
  gItemNames[138] = "Ninja Gear"
  gItemNames[139] = "White Dress"
  gItemNames[140] = "Mithril Mail"
  gItemNames[141] = "Gaia Gear"
  gItemNames[142] = "Mirage Vest"
  gItemNames[143] = "Gold Armor"
  gItemNames[144] = "Power Sash"
  gItemNames[145] = "Light Robe"
  gItemNames[146] = "Diamond Vest"
  gItemNames[147] = "Red Jacket"
  gItemNames[148] = "Force Armor"
  gItemNames[149] = "DiamondArmor"
  gItemNames[150] = "Dark Gear"
  gItemNames[151] = "Tao Robe"
  gItemNames[152] = "Crystal Mail"
  gItemNames[153] = "Czarina Gown"
  gItemNames[154] = "Genji Armor"
  gItemNames[155] = "Imps Armor"
  gItemNames[156] = "Minerva"
  gItemNames[157] = "Tabby Suit"
  gItemNames[158] = "Chocobo Suit"
  gItemNames[159] = "Moogle Suit"
  gItemNames[160] = "Nutkin Suit"
  gItemNames[161] = "BehemothSuit"
  gItemNames[162] = "Snow Muffler"
  gItemNames[163] = "NoiseBlaster"
  gItemNames[164] = "Bio Blaster"
  gItemNames[165] = "Flash"
  gItemNames[166] = "Chain Saw"
  gItemNames[167] = "Debilitator"
  gItemNames[168] = "Drill"
  gItemNames[169] = "Air Anchor"
  gItemNames[170] = "AutoCrossbow"
  gItemNames[171] = "Fire Skean"
  gItemNames[172] = "Water Edge"
  gItemNames[173] = "Bolt Edge"
  gItemNames[174] = "Inviz Edge"
  gItemNames[175] = "Shadow Edge"
  gItemNames[176] = "Goggles"
  gItemNames[177] = "Star Pendant"
  gItemNames[178] = "Peace Ring"
  gItemNames[179] = "Amulet"
  gItemNames[180] = "White Cape"
  gItemNames[181] = "Jewel Ring"
  gItemNames[182] = "Fairy Ring"
  gItemNames[183] = "Barrier Ring"
  gItemNames[184] = "MithrilGlove"
  gItemNames[185] = "Guard Ring"
  gItemNames[186] = "RunningShoes"
  gItemNames[187] = "Wall Ring"
  gItemNames[188] = "Cherub Down"
  gItemNames[189] = "Cure Ring"
  gItemNames[190] = "True Knight"
  gItemNames[191] = "DragoonBoots"
  gItemNames[192] = "Zephyr Cape"
  gItemNames[193] = "Czarina Ring"
  gItemNames[194] = "Cursed Ring"
  gItemNames[195] = "Earrings"
  gItemNames[196] = "Atlas Armlet"
  gItemNames[197] = "Blizzard Orb"
  gItemNames[198] = "Rage Ring"
  gItemNames[199] = "Sneak Ring"
  gItemNames[200] = "Pod Bracelet"
  gItemNames[201] = "Hero Ring"
  gItemNames[202] = "Ribbon"
  gItemNames[203] = "Muscle Belt"
  gItemNames[204] = "Crystal Orb"
  gItemNames[205] = "Gold Hairpin"
  gItemNames[206] = "Economizer"
  gItemNames[207] = "Thief Glove"
  gItemNames[208] = "Gauntlet"
  gItemNames[209] = "Genji Glove"
  gItemNames[210] = "Hyper Wrist"
  gItemNames[211] = "Offering"
  gItemNames[212] = "Beads"
  gItemNames[213] = "Black Belt"
  gItemNames[214] = "Coin Toss"
  gItemNames[215] = "FakeMustache"
  gItemNames[216] = "Gem Box"
  gItemNames[217] = "Dragon Horn"
  gItemNames[218] = "Merit Award"
  gItemNames[219] = "Memento Ring"
  gItemNames[220] = "Safety Bit"
  gItemNames[221] = "Relic Ring"
  gItemNames[222] = "Moogle Charm"
  gItemNames[223] = "Charm Bangle"
  gItemNames[224] = "Marvel Shoes"
  gItemNames[225] = "Back Guard"
  gItemNames[226] = "Gale Hairpin"
  gItemNames[227] = "Sniper Sight"
  gItemNames[228] = "Exp. Egg"
  gItemNames[229] = "Tintinabar"
  gItemNames[230] = "S--print Shoes"
  gItemNames[231] = "Rename Card"
  gItemNames[232] = "Tonic"
  gItemNames[233] = "Potion"
  gItemNames[234] = "X-Potion"
  gItemNames[235] = "Tincture"
  gItemNames[236] = "Ether"
  gItemNames[237] = "X-Ether"
  gItemNames[238] = "Elixir"
  gItemNames[239] = "Megalixir"
  gItemNames[240] = "Fenix Down"
  gItemNames[241] = "Revivify"
  gItemNames[242] = "Antidote"
  gItemNames[243] = "Eyedrop"
  gItemNames[244] = "Soft"
  gItemNames[245] = "Remedy"
  gItemNames[246] = "Sleeping Bag"
  gItemNames[247] = "Tent"
  gItemNames[248] = "Green Cherry"
  gItemNames[249] = "Magicite"
  gItemNames[250] = "Super Ball"
  gItemNames[251] = "Echo Screen"
  gItemNames[252] = "Smoke Bomb"
  gItemNames[253] = "Warp Stone"
  gItemNames[254] = "Dried Meat"
  gItemNames[255] = "Empty"

end


--
-- --print a debug message if debug logging is enabled
-- Debug messages will be --printed to the developer console.
--
function printDebug(message)

  if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    ----print(message)
  end

end

--
-- Check if the tracker is in items only mode
--
-- Returns: True if the tracker is in items only mode
--          False if the tracker is in any other mode
--
function itemsOnlyTracking()

  return string.find(Tracker.ActiveVariantUID, "items_only")

end

--
-- Check if the tracker is in Gated mode
--
-- Returns: True if tracker is in Character Gate mode
--          False if in an open world mode
--
function isGatedMode()

  local isMapTracker = string.find(Tracker.ActiveVariantUID, "map_tracker")
  
  if isMapTracker then
    -- If the tracker is in map tracker mode, check if the
    -- config option for game mode is set to "Character Gated"
    local gameMode = Tracker:FindObjectForCode("gamemode")
    return gameMode.CurrentStage == 0
  else
    -- Non-map tracker mode.  There is a chance that the player is in 
    -- the item tracking mode and is playing an open world seed, but
    -- character gated mode seems far more common.  Without a way to
    -- toggle modes, character gating is a safer default.
    return true
  end

end

--
-- Update an event based on whether or not a bit is set
--
--  Params:
--    name - Name of the tracker item to be set
--    segment - Memory segment to read from
--    address - Memory address of the check
--    flag - Bit flag used for this check
--
function checkBitSet(name, segment, address, flag)

  local trackerItem = Tracker:FindObjectForCode(name)
  if trackerItem then
    local value = segment:ReadUInt8(address)
    trackerItem.Active = ((value & flag) ~= 0)
  else
    --printDebug("checkBitSet: Unable to find tracker item: " .. name)  
  end
  
end

--
-- Update an event based on whether or not a bit is cleared
-- 
-- Params:
--   name - Name of the tracker item to be set
--   segment - Memory segment to read from
--   address - Memory address of the check
--   flag - Bit flag used for this check
--
function checkBitCleared(name, segment, address, flag)

  local trackerItem = Tracker:FindObjectForCode(name)
  if trackerItem then
    local value = segment:ReadUInt8(address)
    trackerItem.Active = ((value & flag) == 0)
  else
    --printDebug("checkBitCleared: Unable to find tracker item: " .. name)  
  end
  
end

--
-- Manually unset a tracker item by name.
--
-- Params:
--   name - Name of the tracker item to unset
--
function unsetTrackerItem(name)

  local trackerItem = Tracker:FindObjectForCode(name)
  if trackerItem then
    trackerItem.Active = false
  else
    --printDebug("unsetTrackerItem: Unable to find tracker item: " .. name)  
  end

end

--
-- Count the number of bits set in a byte.
--
-- Params:
--   value - Byte value to count
--
-- Returns: Number of high bits in the given byte
--
function countSetBits(value)

  local bitsSet = 0
  for i = 0, 8 do
    if (value & (1 << i)) > 0 then
      bitsSet = bitsSet + 1
    end
  end
  
  return bitsSet

end

--
-- Toggle a character based on whether or not he/she was found in the party.
--
-- Params:
--   byteValue - Byte value containing character information 
--   flag - Flag used to see if the character was acquired
--   name - Name of the character's tracker object
--
function toggleCharacter(byteValue, flag, name)
	--print("START toggleCharacter() -> START ")
  local active = false
  character = Tracker:FindObjectForCode(name)
  if character then
    active = (byteValue & flag) ~= 0
    character.Active = active
    if active == true then
        
        for i=0, NUM_OF_PLAYER_CHARACTERS-1 do
            
            if string.upper(name) == gCharacterNames[i] then
                if gCharactersActiveStatus[i] == false then
                    gCharactersActiveStatus[i] = true
                    --print("		newly added char: "..string.upper(name))
                    if gIsInitCharRecruitEquip == true then
                        trackNewlyRecruitedCharacterEquipment(i) --can get out of sync at ROM start. search this comment for other section.
                    end
                    
                end

                
            end

        end
    end

  else
    --printDebug("Unable to find character: " .. name)
  end
	--print("END toggleCharacter()")
end

--
-- Read party data and determine which characters have been found
--
-- Params:
--   segment - Memory segment to read from
--
function updateParty(segment)
    --print("START updateParty")
  local charsByte1 = segment:ReadUInt8(0x7E1EDE)
  -- Top 2 bits of the second character byte aren't used.
  local charsByte2 = segment:ReadUInt8(0x7E1EDF) & 0x3F
  
  -- Don't track individual characters in items only mode
  --if not itemsOnlyTracking() then
    -- Toggle tracker icons based on what characters were found
    toggleCharacter(charsByte1, 0x01, "Terra")
    toggleCharacter(charsByte1, 0x02, "Locke")
    toggleCharacter(charsByte1, 0x04, "Cyan")
    toggleCharacter(charsByte1, 0x08, "Shadow")
    toggleCharacter(charsByte1, 0x10, "Edgar")
    toggleCharacter(charsByte1, 0x20, "Sabin")
    toggleCharacter(charsByte1, 0x40, "Celes")
    toggleCharacter(charsByte1, 0x80, "Strago")
    toggleCharacter(charsByte2, 0x01, "Relm")
    toggleCharacter(charsByte2, 0x02, "Setzer")
    toggleCharacter(charsByte2, 0x04, "Mog")
    toggleCharacter(charsByte2, 0x08, "Gau")
    toggleCharacter(charsByte2, 0x10, "Gogo")
    toggleCharacter(charsByte2, 0x20, "Umaro")
  --end
  
  local charactersAcquired = 
      math.max(countSetBits(charsByte1) + countSetBits(charsByte2), 1)
  
  -- Set the progressive character counter
  local characters = Tracker:FindObjectForCode("Char")
  characters.CurrentStage = (charactersAcquired - 1)

	--print("END updateParty")
end

--
-- Callback function to handle updating the number of espers collected.
--
-- Params:
--   segment - Memory segment to read from
--
function updateEspers(segment)
	--print("START updateEspers() -> START ")
  local espersAcquired = 0
  for i = 0, 3 do
    local byteValue = segment:ReadUInt8(0x7E1A69 + i)
    if i == 3 then
      -- The last byte only tracks 3 espers.
      -- Mask off the rest of the byte.
      byteValue = byteValue & 0x07
    end
    espersAcquired = espersAcquired + countSetBits(byteValue)
  end
  
  -- Set the progressive esper counter
  --
  -- NOTE: There are 27 espers in game, but the tracker only
  --       defines 24 progressive steps for the esper item.
  --       Clamp the value to a max of 24 since setting a 
  --       progressive item to a non-existent stage causes 
  --       it to uncheck entirely.
  --
  local espers = Tracker:FindObjectForCode("Esper")
  espers.CurrentStage = math.min(espersAcquired, 24)
	--print("END updateEspers() -> END ")
end

--
-- Handle the Jidoor Auction House items.
--
-- Params:
--   segment - Memory segment to read from
--
function handleAuctionHouse(segment)

  -- Bought esper 1 from the auction house: 0x7E1EAD 0x20
  -- Bought esper 2 from the auction house: 0x7E1EAD 0x10
  local value = segment:ReadUInt8(0x7E1EAD)
  local stage = ((value & 0x20) >> 5) + 
                ((value & 0x10) >> 4)
  local object = Tracker:FindObjectForCode("Auctioneer")
  object.CurrentStage = stage
  
end

--
-- Handle the Floating Continent progressive item checks.
--
-- Params:
--   segment - Memory segment to read from
--
function handleFloatingContinent(segment)

  local currentStage = 0
  
  -- Pick up Shadow at the beginning (check 1)
  local value = segment:ReadUInt8(0x7E1E85)
  if (value & 0x04) ~= 0 then
    currentStage = currentStage + 1
  end
  
  -- This bit clears after killing Atma (check 2)  
  value = segment:ReadUInt8(0x7E1EEB)
  if (value & 0x80) == 0 then
    currentStage = currentStage + 1
  end
  
  -- Completion of the floating Continent (check 3)
  value = segment:ReadUInt8(0x7E1EEF)
  if (value & 0x20) ~= 0 then
    currentStage = currentStage + 1
  end
  
  -- Finally, set the current stage of the floating continent progressive item
  local object = Tracker:FindObjectForCode("Float")
  object.CurrentStage = currentStage

end

--
-- Handle the Magitek Factory progressive item checks.
--
-- Params:
--   segment - Memory segment to read from
--
function handleMagitekFactory(segment)

  local currentStage = 0
  
  -- Beat Ifrit/Shiva (check 1)
  local value = segment:ReadUInt8(0x7E1E8C)
  if (value & 0x01) ~= 0 then
    currentStage = currentStage + 1
  end
  
  -- This bit clears after killing #042 (check 2)  
  value = segment:ReadUInt8(0x7E1F49)
  if (value & 0x02) == 0 then
    currentStage = currentStage + 1
  end
  
  -- Award before the final boss fight (check 3)
  value = segment:ReadUInt8(0x7E1E8D)
  if (value & 0x08) ~= 0 then
    currentStage = currentStage + 1
  end
  
  -- Finally, set the current stage of the Magitek Factory progressive item
  local object = Tracker:FindObjectForCode("Magitek")
  object.CurrentStage = currentStage

end

--
-- Handle the Cyan's Dream progressive item checks.
--
-- Params:
--   segment - Memory segment to read from
--
function handleCyansDream(segment)

  local currentStage = 0
  
  local dreamPossible = segment:ReadUInt8(0x7E1EDC)
  if (dreamPossible & 0x04) ~= 0 then 
    -- Beat The Stooges (check 1)
    local value = segment:ReadUInt8(0x7E1EAF)
    if (value & 0x02) ~= 0 then
      currentStage = 1
    end
    
    value = segment:ReadUInt8(0x7E1E9B)
    if (value & 0x04) ~= 0 then
      -- Wrexsoul has been defeated
      currentStage = 2
      
      -- This bit is set after Wrexsoul dies, so don't check it
      -- unless Wrexsoul is already defeated.
      value = segment:ReadUInt8(0x7E1F29)
      if (value & 0x02) == 0 then
        currentStage = 3
      end
    end

  end
  
  -- Finally, set the current stage of the Cyan's Dream progressive item
  local object = Tracker:FindObjectForCode("WoRDoma")
  object.CurrentStage = currentStage

end


--
-- Count the number of defeated dragons and set the
-- current stage counter on the dragons progressive item.
--
-- The "Dragons Remaining" byte won't work for this since 
-- the randomizer changes it to match the number of dragons
-- required to beat the sead.
--
function handleDragonIndicator()

  local dragonStage = 0;
  
  if Tracker:FindObjectForCode("IceDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("StormDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("RedDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("BlueDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("WhiteDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("DirtDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("GoldDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  if Tracker:FindObjectForCode("SkullDragon").Active then
    dragonStage = dragonStage + 1
  end
  
  Tracker:FindObjectForCode("Dragon").CurrentStage = dragonStage
  
end

--
-- Main callback function to handle updating events and bosses.
-- This is registered with the tracker and triggered on memory updates.
--
-- Params:
--   segment - Memory segment to read from
--
function updateEventsAndBosses(segment)
  
  --
  -- This is a bit of a sanity check.  If we don't have any characters
  -- then assume we are not in game.  This is used to disable some of 
  -- the checks during the starting menu screen while still allowing
  -- the tracker to track things on a selected save slot.  It's a bit of
  -- a hack, but it seems to work rather well.
  --
  local inGame = (AutoTracker:ReadU16(0x7E1EDE) & 0x3FFF) ~= 0
  
  -- Open Checks
  checkBitSet("Tritoch", segment, 0x7E1ED3, 0x40)
  handleAuctionHouse(segment)
  checkBitSet("TzenThief", segment, 0x7E1ECF, 0x10)
  
  --
  -- Kefka At Narshe:
  -- 0x7E1F45 0x10 is the bit that controls whether or
  -- not the NPC is present to start the event.
  --
  -- When the battle starts, 0x7E1F45 0x10 is set low and
  -- 0x7E1F45 0x01 is set high.  0x7E1F45 0x01 is cleared
  -- after the battle with Kefka is finished.
  --
  local narsheBattleStarted = segment:ReadUInt8(0x7E1F45)
  if (narsheBattleStarted & 0x10) == 0 and inGame then
    checkBitCleared("Kefka", segment, 0x7E1F45, 0x01)
  else 
    unsetTrackerItem("Kefka")
  end
  
  -- Terra Checks
  checkBitSet("Whelk", segment, 0x7E1EA6, 0x20)
  checkBitSet("LeteRiver", segment, 0x7E1ECA, 0x80)
  checkBitSet("sealCave", segment, 0x7E1F0E, 0x02)
  checkBitSet("Phunbaba", segment, 0x7E1E97, 0x80)
  
  --
  -- The Ramuh check has 2 different flags depending on whether the
  -- reward is a character or an esper.
  --    0x7E1EE3 0x40 
  --    0x7E1EE3 0x80
  --  
  -- NOTE:
  -- The bit is set high when Terra is recruited (or in open world)
  -- and set low when Ramuh has been completed.  Because there is no
  -- other flag to determine if this check is done, we have to rely on
  -- the game mode and characters collected in order to know if it
  -- should be checked.
  --
  local terra = (segment:ReadUInt8(0x7E1EDE) & 0x01) ~= 0
  if (terra or (not isGatedMode())) and inGame then
    checkBitCleared("ZozoRamuh", segment, 0x7E1EE3, 0xC0)
  else 
    unsetTrackerItem("ZozoRamuh")
  end
  
  -- Locke Checks
  checkBitSet("NarsheWpn", segment, 0x7E1E96, 0x40)
  checkBitSet("PhoenixCave", segment, 0x7E1E9A, 0x80)
  checkBitSet("tunnelArmor", segment, 0x7E1E96, 0x02)
  
  -- Setzer Checks
  checkBitSet("KohlingenDoge", segment, 0x7E1EB1, 0x40)
  checkBitSet("DarillTomb", segment, 0x7E1ED6, 0x04)
  
  -- Sabin Checks
  checkBitSet("BarenFalls", segment, 0x7E1E87, 0x40)
  checkBitSet("ImperialCamp", segment, 0x7E1E86, 0x80)
  checkBitSet("Vargas", segment, 0x7E1E82, 0x01)
  checkBitSet("PhantomTrain", segment, 0x7E1E87, 0x08)
  checkBitSet("TzenHouse", segment, 0x7E1ED1, 0x04)
  
  -- Celes Checks
  handleMagitekFactory(segment)
  checkBitSet("OperaHouse", segment, 0x7E1E8B, 0x08)
  local chainedCelesAvailable = segment:ReadUInt8(0x7E1EDC)
  if (chainedCelesAvailable & 0x40) ~= 0 then
    checkBitCleared("ChainedCeles", segment, 0x7E1EE2, 0x80)
  else
    unsetTrackerItem("ChainedCeles")    
  end  

  -- Shadow Checks
  checkBitSet("GauManor", segment, 0x7E1EAC, 0x04)
  checkBitCleared("WoRVeldt", segment, 0x7E1F2A, 0x20)
  handleFloatingContinent(segment)
  
  -- Cyan
  checkBitSet("WoBDoma", segment, 0x7E1E88, 0x01)
  checkBitSet("MtZozo", segment, 0x7E1E9A, 0x04)
  handleCyansDream(segment)
  
  -- Relm Checks
  checkBitSet("EsperMtn", segment, 0x7E1E92, 0x20)
  checkBitSet("Owzer", segment, 0x7E1EC8, 0x01)
  
  -- Strago Checks
  checkBitSet("WoBThamasa", segment, 0x7E1E92, 0x01)
  checkBitSet("EbotsRock", segment, 0x7E1EB3, 0x10)
  --checkBitSet("FanaticsTower", segment, 0x7E1EDB, 0x08) -- Boss killed
  checkBitSet("FanaticsTower", segment, 0x7E1E97, 0x04) -- Reward collected
  
  
  -- Mog Checks
  checkBitSet("LoneWolf", segment, 0x7E1ED3, 0x80)
  
  -- Edgar Checks
  checkBitCleared("FigThrone", segment, 0x7E1EE1, 0x01)
  checkBitSet("FigCave", segment, 0x7E1E98, 0x40)
  checkBitSet("AncientCastle", segment, 0x7E1EDB, 0x20)
  
  -- Gogo Checks
  checkBitSet("ZoneEater", segment, 0x7E1E9A, 0x10)
  
  -- Umaro Checks
  checkBitSet("UmaroNrsh", segment, 0x7E1E8F, 0x40)
  
  -- Gau Checks
  checkBitSet("SerpentTrench", segment, 0x7E1E8A, 0x01)
  -- See updateSpecial function for Gau Veldt check.
  
  -- Kefka's Tower
  checkBitCleared("AtmaWpn", segment, 0x7E1F57, 0x20)
  
  -- Dragons:
  -- Dragon bits are set based on location, not actual dragon.
  checkBitCleared("IceDragon", segment, 0x7E1F52, 0x20)
  checkBitSet("StormDragon", segment, 0x7E1ED3, 0x04)
  checkBitCleared("WhiteDragon", segment, 0x7E1F52, 0x10)
  checkBitCleared("BlueDragon", segment, 0x7E1F54, 0x02)
  checkBitCleared("GoldDragon", segment, 0x7E1F56, 0x08)
  checkBitCleared("SkullDragon", segment, 0x7E1F56, 0x10)
  checkBitSet("DirtDragon", segment, 0x7E1E8C, 0x02)

  -- 
  -- Don't try to track the Red Dragon until the lava room
  -- in the Phoenix Cave has been flooded.  The Red Dragon Bit
  -- is set when the room is flooded and then cleared when the
  -- Red Dragon is defeated.  
  --
  local isLavaRoomFlooded = (segment:ReadUInt8(0x7E1EDA) & 0x01) ~= 0
  if isLavaRoomFlooded then
    checkBitCleared("RedDragon", segment, 0x7E1F53, 0x10)
  else
    unsetTrackerItem("RedDragon")
  end
  
  -- Set the indicator for number of dragons killed.
  handleDragonIndicator()  
    
end

--
-- There are a couple of events that are tracked outside of the
-- normal event memory block.  These are:
--
--  - Doom Gaze defeated
--  - Gau Obtained
--
-- Params:
--   segment - Memory segment to read from
--
function updateSpecial(segment)

  checkBitSet("DoomGaze", segment, 0x7E1DD2, 0x01)
  checkBitSet("VeldtJerky", segment, 0x7E1DD2, 0x02)
  
end
 
function updateTrackerItem(itemid_input, qty)
	print("/////////////////////////////////////////////////////////////////////////////////////START updateTrackerItem()... itemid_input: 0x"..string.format("%x",itemid_input).." qty: "..qty)
	local itemid
	 
	itemid = itemid_input
	 


	activateItemLabel(gItemNames[itemid])
	--print("		updateTrackerItem() gInMenu_SubType == "..gInMenu_SubType.."...gInMenu_Significant: "..tostring(gInMenu_Significant).."....item: "..gItemNames[itemid].." qty: "..qty)
	----print("		qty"..qty)

	
	if gInMenu == true and (gInMenu_SubType >= CONTEXT_MENU_SUB_SHOP_BUY_1 and gInMenu_SubType <= CONTEXT_MENU_SUB_SHOP_BUY_3) and qty > 0 then --buy
		--print("		d")
		incrementItem("buy", itemid, qty)
	elseif gInMenu == true and (gInMenu_SubType >= CONTEXT_MENU_SUB_SHOP_SELL_1 and gInMenu_SubType <= CONTEXT_MENU_SUB_SHOP_SELL_3) and qty < 0  then --sell
		--print("		e")
		incrementItem("sell", itemid, qty)
	elseif gInMenu == true and gInMenu_Significant == true and qty < 0 then --menu use
		--print("		AA")
		incrementItem("use", itemid, qty)
	elseif gInCave == true then 
		--print("		f")
		if gLastColosseumFightIsAGo == true then
			--print("		gLastColosseumFightIsAGo")
			gLastColosseumFightIsAGo = false
			incrementItem("use", itemid, qty)
		else
			incrementItem("chest", itemid, qty) 
		end
	elseif gInBattle == true and qty > 0 then 
		--print("		g")
		incrementItem("chest", itemid, qty) --battle reward/steal
	elseif gInBattle == true and qty < 0 then 
		--print("		h")
		incrementItem("use", itemid, qty) --battle used
	elseif gInMenu == true and gInMenu_Significant == true then 
		--print("		i")
		incrementItem("chest", itemid, qty)
	end
	
	--print("END updateTrackerItem()")
end

function incrementItem(stringType, itemid, qty)
	--print("START incrementItem()")
	--print("		UI update -> Looking up: "..stringType.."_"..gItemNames[itemid])
	local mainLabel = Tracker:FindObjectForCode(stringType.."_"..gItemNames[itemid])
	if mainLabel.Active == false then
		mainLabel.Active = true
	end

	local tens_label = Tracker:FindObjectForCode("Tens_"..stringType.."_"..gItemNames[itemid])
	if tens_label.Active == false then
		tens_label.Active = true
	end

	local ones_label = Tracker:FindObjectForCode("Ones_"..stringType.."_"..gItemNames[itemid])
	if ones_label.Active == false then
		ones_label.Active = true
	end
	
	calcAndSetQty(tens_label,ones_label, qty)
	--print("END incrementItem()")
end

function calcAndSetQty(tens_label, ones_label, qty)
	--currentStage 0 is transparent image (aka blank)
	--currentStage 1 is "0", 2 is "1", etc...

	--print("START	 calcAndSetQty() -> tens_label.CurrentStage: "..tens_label.CurrentStage)
	--print("		calcAndSetQty() -> ones_label.CurrentStage: "..ones_label.CurrentStage)


	local tensDigit
	if tens_label.CurrentStage <= 1 then
		tensDigit = 0
	else
		tensDigit = (tens_label.CurrentStage - 1)
	end

	local onesDigit
	if ones_label.CurrentStage <= 1 then
		onesDigit = 0
	else
		onesDigit = (ones_label.CurrentStage - 1)
	end


	local newQty = (10*tensDigit) + onesDigit + math.abs(qty)
	--print("		calcAndSetQty() -> newQty: "..newQty)

	local newTensDigit = math.floor(newQty/ 10) % 10
	local newOnesDigit = newQty % 10 
	--print("		calcAndSetQty() -> newTensDigit: "..newTensDigit)
	--print("		calcAndSetQty() -> newOnesDigit: "..newOnesDigit)
	tens_label.CurrentStage = newTensDigit + 1
	ones_label.CurrentStage = newOnesDigit + 1
	--print("		calcAndSetQty() -> tens_label.CurrentStage: "..(newTensDigit + 1))
	--print("END calcAndSetQty() -> ones_label.CurrentStage: "..(newOnesDigit + 1))
end

function activateItemLabel(itemname)
	--print("START activateItemLabel("..itemname..")")
	local item = Tracker:FindObjectForCode(itemname)
	if item.Active == false then
		item.Active = true
	end
	--print("END activateItemLabel("..itemname..")")
end

function updateColosseumWager(segment)
	--print("START updateColosseumWager() ")
	--default state of colosseum memory:
	--address COLOSSEUM_WAGER_ITEM is 	0x00 at ROM start
	--									0xFF during Select an Item
	--									0x XY after selection, during char selection, during battle AND AFTER battle (win or lose)
	--
	 
	local readVal = segment:ReadUInt8(COLOSSEUM_WAGER_ITEM)
	local isNewWager = 2 --0 no, 1 yes, 2 unknown
	if readVal == 0x00 then
		return --unit
	end
	if readVal == 0xFF then
		gNewWagerFlag = true
		return --betting, choosing --never chose an item this run
	end

	if readVal ~= gLastColosseumWager then
		gLastColosseumWager = readVal
		isNewWager = 1
	end

	if gNewWagerFlag == true and readVal ~= 0xFF then
		gNewWagerFlag = false

		gLastColosseumFightIsAGo = true
	end

	--print("END updateColosseumWager() ")

end

function updateCurrentShop(segment)
	--print("START updateCurrentShop() ")
	local readVal = segment:ReadUInt8(CURRENT_SHOP)
	if readVal > 0x55 or readVal <= 0x03 then
		return
	end
	gCurrentShop = readVal
	--print("		UPDATE CURRENT_SHOP: "..readVal)
	----print("		Current Shop Updated! $$$$$$$$$$$$$")
	--print("END updateCurrentShop() ")
end

function updateShopItemList(segment)
	--print("START Updating Shop List...")

	if isShopListLoaded() == false then
		if gCurrentShop ~= gPrevShop then
			loadShopList(segment)

			gPrevShop = gCurrentShop

			--print("		Updating Shop List...Complete.")
		else
			--print("		...nevermind! b")
		end
	else
		--print("		...nevermind! a")
	end
	--print("END Updating Shop List...")
end


function updateSeenItemForShop(itemid, shopid)
	--print("START updateSeenItemForShop()")
	if shopid == 0x00 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 0)
	elseif shopid == 0x01 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 1)
	elseif shopid == 0x02 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 2)
	elseif shopid == 0x03 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 3)
	elseif shopid == 0x04 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 4)
	elseif shopid == 0x05 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 5)
	elseif shopid == 0x06 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 6)
	elseif shopid == 0x07 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 7)
	elseif shopid == 0x08 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 8)
	elseif shopid == 0x09 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 9)
	elseif shopid == 0x10 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 10)
	elseif shopid == 0x11 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 11)
	elseif shopid == 0x12 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 12)
	elseif shopid == 0x13 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 13)
	elseif shopid == 0x14 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 14)
	elseif shopid == 0x15 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 15)
	elseif shopid == 0x16 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 16)
	elseif shopid == 0x17 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 17)
	elseif shopid == 0x18 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 18)
	elseif shopid == 0x19 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 19)
	elseif shopid == 0x20 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 20)
	elseif shopid == 0x21 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 21)
	elseif shopid == 0x22 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 22)
	elseif shopid == 0x23 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 23)
	elseif shopid == 0x24 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 24)
	elseif shopid == 0x25 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 25)
	elseif shopid == 0x26 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 26)
	elseif shopid == 0x27 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 27)
	elseif shopid == 0x28 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 28)
	elseif shopid == 0x29 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 29)
	elseif shopid == 0x30 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 30)
	elseif shopid == 0x31 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 31)
	elseif shopid == 0x32 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 32)
	elseif shopid == 0x33 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 33)
	elseif shopid == 0x34 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 34)
	elseif shopid == 0x35 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 35)
	elseif shopid == 0x36 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 36)
	elseif shopid == 0x37 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 37)
	elseif shopid == 0x38 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 38)
	elseif shopid == 0x39 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 39)
	elseif shopid == 0x40 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 40)
	elseif shopid == 0x41 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 41)
	elseif shopid == 0x42 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 42)
	elseif shopid == 0x43 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 43)
	elseif shopid == 0x44 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 44)
	elseif shopid == 0x45 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 45)
	elseif shopid == 0x46 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 46)
	elseif shopid == 0x47 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 47)
	elseif shopid == 0x48 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 48)
	elseif shopid == 0x49 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 49)
	elseif shopid == 0x50 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 50)
	elseif shopid == 0x51 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 51)
	elseif shopid == 0x52 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 52)
	elseif shopid == 0x53 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 53)
	elseif shopid == 0x54 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 54)
	elseif shopid == 0x55 then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 55)
	elseif shopid == 0x0A then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 56)
	elseif shopid == 0x0B then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 57)
	elseif shopid == 0x0C then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 58)
	elseif shopid == 0x0D then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 59)
	elseif shopid == 0x0E then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 60)
	elseif shopid == 0x0F then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 61)
	elseif shopid == 0x1A then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 62)
	elseif shopid == 0x1B then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 63)
	elseif shopid == 0x1C then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 64)
	elseif shopid == 0x1D then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 65)
	elseif shopid == 0x1E then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 66)
	elseif shopid == 0x1F then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 67)
	elseif shopid == 0x2A then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 68)
	elseif shopid == 0x2B then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 69)
	elseif shopid == 0x2C then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 70)
	elseif shopid == 0x2D then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 71)
	elseif shopid == 0x2E then
		----print("		caca")
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 72)
	elseif shopid == 0x2F then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 73)
	elseif shopid == 0x3A then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 74)
	elseif shopid == 0x3B then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 75)
	elseif shopid == 0x3C then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 76)
	elseif shopid == 0x3D then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 77)
	elseif shopid == 0x3E then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 78)
	elseif shopid == 0x3F then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 79)
	elseif shopid == 0x4A then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 80)
	elseif shopid == 0x4B then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 81)
	elseif shopid == 0x4C then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 82)
	elseif shopid == 0x4D then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 83)
	elseif shopid == 0x4E then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 84)
	elseif shopid == 0x4F then
		--print("		shopid: "..shopid)
		setShopLabelForItem(itemid, 85)
	end

	--print("END updateSeenItemForShop()")
end

function setShopLabelForItem(itemid, idx)
	--print("START setShopLabelForItem()")
	----print("		updating seen shop for: "..gItemNames[itemid].."idx: "..idx)
	activateItemLabel(gItemNames[itemid])
	activateItemLabel("Eye_"..gItemNames[itemid])

	local shopLabel = Tracker:FindObjectForCode("Shop1_"..gItemNames[itemid])
	----print("		before shopLabel.CurrentStage: "..shopLabel.CurrentStage)
	shopLabel.CurrentStage = idx + 1
	--print("END setShopLabelForItem()")
end

 

function loadShopList(segment)
	--print("START loadShopList()")
	if gCurrentShop <= 0x03 then
		return
	end
 
	local readVal = segment:ReadUInt8(CURRENT_SHOP_INVENTORY_START)
	local itemid
	for i=0, 7 do
		itemid = segment:ReadUInt8(CURRENT_SHOP_INVENTORY_START+i)
		if itemid ~= 0xFF then
			----print("		We're in a shop! $$$$$$"..gItemNames[itemid])
			updateSeenItemForShop(itemid, gCurrentShop)
		end
	end
	table.insert(gShopList_table, gCurrentShop)
	--print("END loadShopList()")
end

function isShopListLoaded(shopid)
	--print("START isShopListLoaded()")
    local lengthOfTable = 0
    for _ in pairs(gShopList_table) do lengthOfTable = lengthOfTable + 1 end
    
    if lengthOfTable == 0 then
        ----print("		skip list is empty!")
		--print("END isShopListLoaded() false 0 len")
        return false
    end

    ----print("		skip list len: "..lengthOfTable)

    for index, value in ipairs(gShopList_table) do
        ----print("		scanning skip list....i: "..index.." item: "..gItemNames[value])
        if value == shopid then
            ----print("		))) found in skip list")
			--print("END isShopListLoaded() true")
            return true
        end
    end

	--print("END isShopListLoaded() false ENDOFFUNC")
    return false

end

function updateBattleNumAliveMonsters(segment)
	--print("START updateBattleNumAliveMonsters()")
	gBattleNumAliveMonsters = segment:ReadUInt8(BATTLE_NUM_ALIVE_MONSTERS) 
	--print("END updateBattleNumAliveMonsters() -> gBattleNumAliveMonsters: ",gBattleNumAliveMonsters)
end

function updateCurrentArea(segment)
	gPrevSubMenuContexts_table = {} --clear it out
	--print("START updateCurrentArea()")
	gCurrentArea = segment:ReadUInt8(CURRENT_AREA)
	--print("END updateCurrentArea() -> gCurrentArea: 0x"..string.format("%x",gCurrentArea))
end
 
function isBattleInventoryValid(segment)
	gPrevInventoryItemsChangeCount = 0
	--print("START	 isBattleInventoryValid()")

	local r1 = segment:ReadUInt8(START_BATTLE_INVENTORY)
	local r2 = segment:ReadUInt8(START_BATTLE_INVENTORY+5)
	local r3 = segment:ReadUInt8(START_BATTLE_INVENTORY+10)
	local r4 = segment:ReadUInt8(START_BATTLE_INVENTORY+15)

	local r1q = segment:ReadUInt8(START_BATTLE_INVENTORY+3)
	local r2q = segment:ReadUInt8(START_BATTLE_INVENTORY+5+3)
	local r3q = segment:ReadUInt8(START_BATTLE_INVENTORY+10+3)
	local r4q = segment:ReadUInt8(START_BATTLE_INVENTORY+15+3)

	
 
	if r1 == BATTLE_INVENTORY_INIT_1[0] and r2 == BATTLE_INVENTORY_INIT_1[1] and r3 == BATTLE_INVENTORY_INIT_1[2] and r4 == BATTLE_INVENTORY_INIT_1[3] then
		return false
	elseif r1 == BATTLE_INVENTORY_INIT_2[0] and r2 == BATTLE_INVENTORY_INIT_2[1] and r3 == BATTLE_INVENTORY_INIT_2[2] and r4 == BATTLE_INVENTORY_INIT_2[3] then
		return false
	end

	--print("r1: 0x"..string.format("%x",r1).."		r2: "..string.format("%x",r2).."		r3: "..string.format("%x",r3).."		r4: "..string.format("%x",r4))
	
	gPrevBattleInventoryQuantities[0] = gBattleInventoryQuantities[0] 
	gPrevBattleInventoryQuantities[1] = gBattleInventoryQuantities[1] 
	gPrevBattleInventoryQuantities[2] = gBattleInventoryQuantities[2] 
	gPrevBattleInventoryQuantities[3] = gBattleInventoryQuantities[3] 

	gPrevBattleInventoryItems[0] = gBattleInventoryItems[0] 
	gPrevBattleInventoryItems[1] = gBattleInventoryItems[1] 
	gPrevBattleInventoryItems[2] = gBattleInventoryItems[2] 
	gPrevBattleInventoryItems[3] = gBattleInventoryItems[3] 

	gBattleInventoryQuantities[0] = r1q
	gBattleInventoryQuantities[1] = r2q
	gBattleInventoryQuantities[2] = r3q
	gBattleInventoryQuantities[3] = r4q

	gBattleInventoryItems[0] = r1
	gBattleInventoryItems[1] = r2
	gBattleInventoryItems[2] = r3
	gBattleInventoryItems[3] = r4

	if gPrevBattleInventoryItems[0] ~= gBattleInventoryItems[0] and gPrevBattleInventoryQuantities[0] ~= gBattleInventoryQuantities[0] then
		gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
	end
	if gPrevBattleInventoryItems[1] ~= gBattleInventoryItems[1] and gPrevBattleInventoryQuantities[1] ~= gBattleInventoryQuantities[1] then
		gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
	end
	if gPrevBattleInventoryItems[2] ~= gBattleInventoryItems[2] and gPrevBattleInventoryQuantities[2] ~= gBattleInventoryQuantities[2] then
		gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
	end
	if gPrevBattleInventoryItems[3] ~= gBattleInventoryItems[3] and gPrevBattleInventoryQuantities[3] ~= gBattleInventoryQuantities[3] then
		gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
	end
	

	
	for i=20, 5*(255-1), 5 do
		gPrevBattleInventoryItems[i/5] = gBattleInventoryItems[i/5]
		gPrevBattleInventoryQuantities[i/5] = gBattleInventoryQuantities[i/5]

		gBattleInventoryItems[i/5] = segment:ReadUInt8(START_BATTLE_INVENTORY+i)
		gBattleInventoryQuantities[i/5] = segment:ReadUInt8(START_BATTLE_INVENTORY+i+3)

		if gPrevBattleInventoryItems[i/5] ~= gBattleInventoryItems[i/5] and gPrevBattleInventoryQuantities[i/5] ~= gBattleInventoryQuantities[i/5] then
			gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
		end
		
	end

	return true
end

function updateBattleInventory(segment)
	print("START	 updateBattleInventory()")
	if segment == nil then
		--print("START	 updateBattleInventory()~~~~~~~~~~~~~~~~~~~~~~~~~~ is nil")
		print("END	 updateBattleInventory() ~out1")
		return
	else
		--print("START	 updateBattleInventory()")
	end
	 
	gBattleInventoryIsValid = isBattleInventoryValid(segment)
	
	if gInBattle == false and gBattleInventoryIsValid == false then
		--print("END updateBattleEquip() - > END*")
		gNewbattleInventoryScan = false
		print("END	 updateBattleInventory() ~out2")
		return
	end

	gNewbattleInventoryScan = true
	print("END	 updateBattleInventory()")
end
 
 
function isBattleEquipValid(segment)
	gPrevBattleEquipItems[0] = gBattleEquipItems[0]
	gPrevBattleEquipItems[1] = gBattleEquipItems[1]
	gPrevBattleEquipItems[2] = gBattleEquipItems[2]
	gPrevBattleEquipItems[3] = gBattleEquipItems[3]
	gPrevBattleEquipItems[4] = gBattleEquipItems[4]
	gPrevBattleEquipItems[5] = gBattleEquipItems[5]
	gPrevBattleEquipItems[6] = gBattleEquipItems[6]
	gPrevBattleEquipItems[7] = gBattleEquipItems[7]
	

	for i=0, 35, 5 do
		--print("i: "..i)
		gBattleEquipItems[i/5] = segment:ReadUInt8(START_BATTLE_RIGHT_HAND_EQUIPPED+i)
	end

	


	local flag = true
	if gBattleEquipItems[0] == BATTLE_EQUIP_INIT_1[0] and gBattleEquipItems[1] == BATTLE_EQUIP_INIT_1[1] and gBattleEquipItems[2] == BATTLE_EQUIP_INIT_1[2] and gBattleEquipItems[3] == BATTLE_EQUIP_INIT_1[3] and gBattleEquipItems[4] == BATTLE_EQUIP_INIT_1[4] and gBattleEquipItems[5] == BATTLE_EQUIP_INIT_1[5] and gBattleEquipItems[6] == BATTLE_EQUIP_INIT_1[6] and gBattleEquipItems[7] == BATTLE_EQUIP_INIT_1[7] then
		zeroOutBattleEquip()
		flag = false
	elseif gBattleEquipItems[0] == BATTLE_EQUIP_INIT_2[0] and gBattleEquipItems[1] == BATTLE_EQUIP_INIT_2[1] and gBattleEquipItems[2] == BATTLE_EQUIP_INIT_2[2] and gBattleEquipItems[3] == BATTLE_EQUIP_INIT_2[3] and gBattleEquipItems[4] == BATTLE_EQUIP_INIT_2[4] and gBattleEquipItems[5] == BATTLE_EQUIP_INIT_2[5] and gBattleEquipItems[6] == BATTLE_EQUIP_INIT_2[6] and gBattleEquipItems[7] == BATTLE_EQUIP_INIT_2[7] then
		--print("			 updateBattleEquip() => BATTLE_EQUIP_INIT_2 detected!")
		zeroOutBattleEquip()
		flag = false
	elseif gBattleEquipItems[0] == BATTLE_EQUIP_INIT_3[0] and gBattleEquipItems[1] == BATTLE_EQUIP_INIT_3[1] and gBattleEquipItems[2] == BATTLE_EQUIP_INIT_3[2] and gBattleEquipItems[3] == BATTLE_EQUIP_INIT_3[3] and gBattleEquipItems[4] == BATTLE_EQUIP_INIT_3[4] and gBattleEquipItems[5] == BATTLE_EQUIP_INIT_3[5] and gBattleEquipItems[6] == BATTLE_EQUIP_INIT_3[6] and gBattleEquipItems[7] == BATTLE_EQUIP_INIT_3[7] then
		--print("			 updateBattleEquip() => BATTLE_EQUIP_INIT_3 detected!")
		zeroOutBattleEquip()
		flag = false
	end
	---- CHUNK
	----

	return flag
end

function zeroOutBattleEquip()
	for i=0, 7  do
		gBattleEquipItems[i] = 0xE7 --rename card isn't awarded in ANY vanilla battles :P
		gPrevBattleEquipItems[i] = 0xE7
	end
end
 

function updateBattleEquip(segment) 
	print("START	 updateBattleEquip()")
	--we care about battle-equip changes because when an equipped item is moved down to battle inventory we want to add it to the skip-list for post battle item additions.
	
	if segment == nil then
		print("END	 updateBattleEquip() ~Out1")
		return
	else
		--print("START	 updateBattleEquip()")
	end
	 
	gBattleEquipIsValid = isBattleEquipValid(segment)
	
	if gInBattle == false and gBattleEquipIsValid == false then
		--print("END updateBattleEquip() - > END*")
		gNewbattleEquipScan = false
		print("END	 updateBattleEquip() ~Out2")
		return
	end

	print("START	 updateBattleEquip() ~ in")
	gNewbattleEquipScan = true
	-- --print("0: item: 0x"..string.format("%x",gBattleEquipItems[0]..""))
	-- --print("1: item: 0x"..string.format("%x",gBattleEquipItems[1]..""))
	-- --print("2: item: 0x"..string.format("%x",gBattleEquipItems[2]..""))
	-- --print("3: item: 0x"..string.format("%x",gBattleEquipItems[3]..""))
	-- --print("4: item: 0x"..string.format("%x",gBattleEquipItems[4]..""))
	-- --print("5: item: 0x"..string.format("%x",gBattleEquipItems[5]..""))
	-- --print("6: item: 0x"..string.format("%x",gBattleEquipItems[6]..""))
	-- --print("7: item: 0x"..string.format("%x",gBattleEquipItems[7]..""))
	--print("			 updateBattleEquip()~~~~~~~~~~~~~~~~~~~~~~~~~~ we're wearing stuff! or empty LUL gNewbattleEquipScan = true")

	
	--print("END updateBattleEquip() - > END")
	

	print("END	 updateBattleEquip()")
end

function doBattleEquipScan()
	print("START doBattleEquipScan()")
	if gNewbattleEquipScan ~= true then
		print("END doBattleEquipScan() ~out1")
		return
	end
	
	if gInBattle == true and gBattleEquipIsValid == true then



		if gBattleEquipScanInitialized ~= true then
			--this preps the change-scanner to IGNORE the battle-equipmentinv & battleequip being initialized
			print("		doBattleEquipScan() ~~ 	gBattleEquipScanInitialized ~= true")
			
			for i=0, 7 do
				gPrevBattleEquipItems[i] = gBattleEquipItems[i]
			end

			for i=0, 255 do
				gPrevBattleInventoryItems[i] = gBattleInventoryItems[i]
				gPrevBattleInventoryQuantities[i] = gBattleInventoryQuantities[i]
			end


		end

		
		local currentItem
		local prevItem
		local currentQty
		local prevQty 
		

		for i=0, 35, 5 do
			currentItem = gBattleEquipItems[i/5]
			prevItem = gPrevBattleEquipItems[i/5]
			 
			
			
			local j
			if i <= 15 then
				j = (i/5)
			elseif i >= 20 then
				j = (i/5)-4
			end

			if gBattlePartySlotsActive[j] == true then
				--print("		updateBattleEquip() -> Party member: "..j.." is active.")
				  
				if currentItem == prevItem then
					if currentItem == 0xFF then
						--empty stays empty
					elseif currentItem == 0xFF then
						--same item
					end
				else
					if currentItem ~= prevItem and prevItem ~= 0xFF and currentItem ~= 0xFF then
						--new non-empty-item in slot --was a swap
						--print("		YOU UN-EQUIPPED: 0x"..string.format("%x",prevItem))
						--print("		1YOU EQUIPPED: 0x"..string.format("%x",currentItem))

						table.insert(gBattleItemsToSkip_table, prevItem)
					elseif currentItem ~= prevItem and prevItem ~= 0xFF and currentItem == 0xFF then 
						--possible unequip occurred track It.
						--print("		unequip occurred. Tracking this item.."..prevItem)
						table.insert(gBattleItemsToSkip_table, prevItem)
					elseif currentItem ~= prevItem and prevItem == 0xFF and currentItem ~= 0xFF then
						--newly equipped item
						--print("		2YOU EQUIPPED: 0x"..string.format("%x",currentItem))
						table.insert(gBattleItemsToSkip_table, currentItem)

						----print("		THIS HAPPENS HERE. storing gTrackBattleEquipChange: "..gItemNames[gTrackBattleEquipChange])
					end

				end
			else
				--print("		updateBattleEquip() -> Party member: "..j.." not active.")
			end
		end

		gNewbattleEquipScan = false
	end
	print("END doBattleEquipScan()")
end



function updateBattleActivePartyMemberSlots(segment)
	--print("START updateBattleActivePartyMemberSlots()")

	local battleslots = segment:ReadUInt8(BATTLE_PARTY_SLOTS_BITMASK)
	
	if battleslots == 0 then
		return
	elseif battleslots > 15 then
		return
	end

	if ((battleslots & 1)  == 1) then --slot 1 is filled (top)
		gBattlePartySlotsActive[0] = true
		--print("			updateBattleActivePartyMemberSlots() 1 is active")
	else
		gBattlePartySlotsActive[0] = false
		--print("			updateBattleActivePartyMemberSlots() 1 is NOT active")
	end

	if ((battleslots & 2)  == 2) then --slot 2 is filled
		gBattlePartySlotsActive[1] = true
		--print("			updateBattleActivePartyMemberSlots() 2 is active")
	else
		gBattlePartySlotsActive[1] = false
		--print("			updateBattleActivePartyMemberSlots() 2 is NOT active")
	end

	if ((battleslots & 4)  == 4) then --slot 3 is filled
		gBattlePartySlotsActive[2] = true
		--print("			updateBattleActivePartyMemberSlots() 3 is active")
	else
		gBattlePartySlotsActive[2] = false
		--print("			updateBattleActivePartyMemberSlots() 3 is NOT active")
	end

	if ((battleslots & 8)  == 8) then --slot 4 is filled (bottom)
		gBattlePartySlotsActive[3] = true
		--print("			updateBattleActivePartyMemberSlots() 4 is active")
	else
		gBattlePartySlotsActive[3] = false
		--print("			updateBattleActivePartyMemberSlots() 4 is NOT active")
	end

	--print("battle slots (bits):  "..tostring(gBattlePartySlotsActive[0])..tostring(gBattlePartySlotsActive[1])..tostring(gBattlePartySlotsActive[2])..tostring(gBattlePartySlotsActive[3]))
end

function updateBattleCounter(segment)
	--print("START updateBattleCounter()")

	local bc2 = segment:ReadUInt8(BATTLE_COUNTER+1)
	local bc1 = segment:ReadUInt8(BATTLE_COUNTER)
	

	if bc1 == 0xFF and bc2 == 0xFF then
		gInBattle = false
		gBattleEquipScanInitialized = false
		gBattleCounter1 = 0x00
		gBattleCounter2 = 0x00
		gBattleItemsToSkip_table = {}
		--print("reset skiplist 1")
		return
	elseif bc1 == 0xE2 and bc2 == 0xE3 then
		gInBattle = false
		gBattleEquipScanInitialized = false
		gBattleCounter1 = 0x00
		gBattleCounter2 = 0x00
		gBattleItemsToSkip_table = {}
		--print("reset skiplist 2")
		return
	elseif bc1 > gBattleCounter1 and bc2 == 0x00 then
			--print("bc1: 0x"..string.format("%x",bc1).." 	bc2: 0x"..string.format("%x",bc2))
		 	gInBattle = true
			gBattleCounter1 = bc1
			gBattleCounter2 = bc2
			
			doBattleEquipScan()
			
			processBattleOrInventoryScan("battle")
	elseif bc1 == 0xFF and bc2 >= gBattleCounter2 then 
			--print("**bc1: 0x"..string.format("%x",bc1).." 	bc2: 0x"..string.format("%x",bc2))
		 	gInBattle = true
			gBattleCounter1 = bc1
			gBattleCounter2 = bc2

		 	doBattleEquipScan()
			processBattleOrInventoryScan("battle")
	end 
	 --print("END updateBattleCounter()")
end


function updateInventoryItems(segment)
	gPrevInventoryItemsChangeCount = 0

    for i=0, 255 do
		
		gPrevInventoryItems[i] = gInventoryItems[i]
        gInventoryItems[i] = segment:ReadUInt8(START_INVENTORY_ITEMS+i) 
		if gPrevInventoryItems[i] ~= gInventoryItems[i] then
			gPrevInventoryItemsChangeCount = gPrevInventoryItemsChangeCount + 1
		end
    end
	 
end

function updateInventoryItemQuantities(segment)
	print("START updateInventoryItemQuantities() - > START")

	if gCurrentArea == 0x07 or gCurrentArea == 0x0C or gCurrentArea == 0xBD then
		if gInMenu == false  then
			--print("		------------------IGNORING DUDE WHO UNEQUIPS EVERYTHING -------------------------------------")
			return
		end
	end
 
    for i=0, 255 do
		
		
		gPrevInventoryQuantities[i] = gInventoryQuantities[i]
		gInventoryQuantities[i] = segment:ReadUInt8(START_INVENTORY_QUANTITIES+i)

		if gPrevInventoryQuantities[i] == 0xFF then
			gPrevInventoryQuantities[i] = 0x00
		end
		
	end
	 
		-- qty = segment:ReadUInt8(START_INVENTORY_QUANTITIES+i)
		-- if isItemInSkipList(gInventoryItems[i]) == true then
		-- 	--print("		updateInventoryItemQuantities() -> isItemInSkipList(gInventoryItems[i]) == true item: "..gInventoryItems[i])
		-- 	gInventoryQuantities[i] = qty
		-- elseif gInventoryQuantities[i] ~= qty then
		-- 	--print("		updateInventoryItemQuantities() -> gInventoryQuantities[i] ~= qty SOMETHING CHANGED")
		-- 	if isSignificantChange() then
		-- 		------print(debugGlobals())
		-- 		--print("		updateInventoryItemQuantities() -> IT'S SIGNIFICANT")
		-- 		--print("		gInventoryQuantities[i]: "..gInventoryQuantities[i].." qty: "..qty)
		-- 		if qty == 0 then
		-- 			--print("		1")
		-- 			if gTemp_DepletedItemID == -1 or gTemp_DepletedItemID == nil then
		-- 				updateTrackerItem(gInventoryItems[i], gInventoryQuantities[i] * -1)
		-- 			else
		-- 				updateTrackerItem(gTemp_DepletedItemID, gInventoryQuantities[i] * -1)
		-- 			end
					
		-- 			--may have been used
		-- 			--may have been sold
		-- 		else
		-- 			if gInventoryQuantities[i] == 0 and qty == 0x01 then --old was zero, new is 1.
		-- 				--may have been a chest/pot/Reward
		-- 				--may have been bought
		-- 				--print("		2")
		-- 				updateTrackerItem(gInventoryItems[i], 1, i )
		-- 			elseif gInventoryQuantities[i] < qty then -- old qty was less than new qty
		-- 				--may have been a chest/pot/Reward
		-- 				--may have been bought / won
		-- 				--print("		3")
		-- 				updateTrackerItem(gInventoryItems[i], qty - gInventoryQuantities[i])
		-- 			elseif gInventoryQuantities[i] > qty then -- old qty was more than new qty
		-- 				--may have been sold
		-- 				--may have been used
		-- 				--may have been thrown/used in battle?
		-- 				--may have been colliseum wagered and spent.
		-- 				--print("		4")
		-- 				updateTrackerItem(gInventoryItems[i], (gInventoryQuantities[i] - qty) * -1)
		-- 			end
		-- 		end
		-- 	else
		-- 		--print("		updateInventoryItemQuantities() -> IT'S NOT SIGNIFICANT")
		-- 		--print("		gInventoryQuantities[i]: "..gInventoryQuantities[i].." qty: "..qty)
		-- 	end
		--	gInventoryQuantities[i] = qty
		--end
		
	print("END updateInventoryItemQuantities() - > END")

	processBattleOrInventoryScan("menu_inventory_or_cave")
	
	
end


function processBattleOrInventoryScan(MODE)
	print("START	processBattleOrInventoryScan("..MODE..")...gPrevInventoryItemsChangeCount: "..gPrevInventoryItemsChangeCount)
	if MODE == "battle" then
		if gNewbattleInventoryScan == false then
			print("END out 1...")
			return
		end 

		gNewbattleInventoryScan = false
	end

	

    local PotentiallyDepletedItem
    local PotentiallyDepletedItemQty
    local SwapCandidateItem 
	local SwapCandidateItemQty

	local currentItem
	local prevItem
	local currentQty
	local prevQty

    for i=0, (255-1) do
		if MODE == "battle" then
			currentItem = gBattleInventoryItems[i]
			prevItem = gPrevBattleInventoryItems[i]
			currentQty = gBattleInventoryQuantities[i]
			prevQty = gPrevBattleInventoryQuantities[i]
		elseif MODE == "menu_inventory_or_cave" then
			currentItem = gInventoryItems[i]
			prevItem = gPrevInventoryItems[i]
			currentQty = gInventoryQuantities[i]
			prevQty = gPrevInventoryQuantities[i]
		end
		
		if currentItem == nil or currentQty == nil or prevItem == nil or prevQty == nil then
			print("nil detected")
			return
		end

		if currentItem == prevItem and currentQty == prevQty then -- item (could be blank/empty) hasn't moved.
			if currentItem == 0xFF and currentQty == 0 then
				----print("		emptyyyyyyyyyy") --do nothing
			else
				----print("		same item!: "..gItemNames[gBattleInventoryItems])
			end
		else
			if isItemInSkipList(currentItem) and MODE == "menu_inventory_or_cave" then
				print("isItemInSkipList: "..string.format("%x",currentItem))
				 --1. battle equip item unequipped and placed into >1 qty battle-item slot. 
				 --2. battleinvent item was placed into blank equip slot
			else
				print("		prevItem: 0x"..string.format("%x",prevItem).."	currentItem: 0x"..string.format("%x",currentItem).."	prevQty: 0x"..string.format("%x",prevQty).."	currentQty: 0x"..string.format("%x",currentQty))
				if currentItem ~= prevItem and currentItem ~= 0xFF and currentQty ~= 0 then 
					--BATTLE: 	some non-empty item showed up in place of a previous item. Maybe a swap happened. Maybe reward.
					--MENU:		either chest, reward, or swap
					print("		processBattleOrInventoryScan() -> 0x"..string.format("%x",currentItem).." showed up!")
					if SwapCandidateItem == nil and gPrevInventoryItemsChangeCount <= 2 then
						SwapCandidateItem = currentItem
						print("		SwapCandidateItemQty set to: "..string.format("%x",currentItem))

						SwapCandidateItemQty = currentQty

						if PotentiallyDepletedItem ~= nil and PotentiallyDepletedItem == SwapCandidateItem  then
							-- PotentiallyDepletedItem was detected prior to now, but was moved upward to an empty slot which
							-- is now being detected as SwapCandidateItem. so, an upper-to-lower swap occured. Exit
							print("END	 processBattleOrInventoryScan() - PotentiallyDepletedItem ~= nil and PotentiallyDepletedItem == SwapCandidateItem")
							return
						end
					elseif gPrevInventoryItemsChangeCount <= 2 then
						--SwapCandidateItem isn't empty. So we already found a changed item.
						--therefore, this other changed item must be its swap partner. 
						--this case handles both upper-to-lower & lower-to-upper swaps.
						--Exit.
						print("END	 processBattleOrInventoryScan() - SwapCandidateItem ~= nil: SwapCandidateItem: ".."SwapCandidateItem: 0x"..string.format("%x",SwapCandidateItem))
						return 
					else
						--new item(s)!
						updateTrackerItem(currentItem, currentQty)
					end
				elseif currentItem == prevItem and currentQty ~= prevQty then --an item was used!
					if MODE == "battle" then
						table.insert(gBattleItemsToSkip_table, currentItem)
					end

					if currentQty > prevQty then
							
							if MODE == "battle" then
								--ignore battle rewards, let cave-mode handle it
							else
								updateTrackerItem(currentItem, 1 )
							end
					elseif currentQty < prevQty then
							updateTrackerItem(currentItem, currentQty - prevQty)
					end
				elseif currentItem == 0xFF and currentQty == 0 then --possible deplete usage. 
					PotentiallyDepletedItem = prevItem
					PotentiallyDepletedItemQty = prevQty
					print("		PotentiallyDepletedItem set to: "..string.format("%x",PotentiallyDepletedItem))

					if SwapCandidateItem ~= nil and PotentiallyDepletedItem == SwapCandidateItem  then
						--the PotentiallyDepletedItem was identified as the the SwapCandidateItem item.
						-- this means that the PotentiallyDepletedItem, which now has blank/empty in its position, was found prior to now
						--as SwapCandidateItem where the PotentiallyDepletedItem was LOWER in the battle item list, got swapped upward and
						--was detected as SwapCandidateItem. Then, down here the LOWER item is now empty and detected as PotentiallyDepletedItem.
						-- so, a swap did occur. Exit.
						print("END	 processBattleOrInventoryScan() - SwapCandidateItem ~= nil and PotentiallyDepletedItem == SwapCandidateItem")
						return
					end
					
				end
			end

			
			
		end
    end

	if PotentiallyDepletedItem ~= nil  and SwapCandidateItem == nil then
		-- PotentiallyDepletedItem never found another item that could have been swapped with it.
		-- an actual depletion occurred.
		if MODE == "battle" then
			table.insert(gBattleItemsToSkip_table, PotentiallyDepletedItem)
		end

		updateTrackerItem(PotentiallyDepletedItem, -1 * PotentiallyDepletedItemQty)
	end

	if SwapCandidateItem ~= nil  and PotentiallyDepletedItem == nil then
		-- use happened
		if MODE == "menu_inventory_or_cave" then
			updateTrackerItem(SwapCandidateItem, currentQty)
		end
	end

	 
 
  
	print("END	 processBattleOrInventoryScan()")
end

--
-- Set up memory watches on memory used for autotracking.
--
--printDebug("Adding memory watches")
ScriptHost:AddMemoryWatch("Party", 0x7E1EDE, 2, updateParty)
ScriptHost:AddMemoryWatch("Espers", 0x7E1A69, 4, updateEspers)
ScriptHost:AddMemoryWatch("Events", 0x7E1E80, 0xDF, updateEventsAndBosses)
ScriptHost:AddMemoryWatch("Special", 0x7E1DD2, 1, updateSpecial)
--
ScriptHost:AddMemoryWatch("updatePlayerModeContext", START_CONTEXT_ADDRESS, 3, updatePlayerModeContext)
ScriptHost:AddMemoryWatch("updatePlayerModeMenuSubContext", START_CONTEXT_MENU_SUB_ADDRESS, 1, updatePlayerModeMenuSubContext)
--
ScriptHost:AddMemoryWatch("grabAllCharacterRecruitmentEquipment", START_CHARACTER_EQUIP, NUM_OF_PLAYER_CHARACTERS*37, grabAllCharacterRecruitmentEquipment) 
--
ScriptHost:AddMemoryWatch("updateInventoryItems", START_INVENTORY_ITEMS, 256, updateInventoryItems) --entire fucking inventory 1 of 2
ScriptHost:AddMemoryWatch("updateInventoryItemQuantities", START_INVENTORY_QUANTITIES, 256, updateInventoryItemQuantities) --entire fucking inventory 2 of 2
--
ScriptHost:AddMemoryWatch("updateBattleEquip", START_BATTLE_RIGHT_HAND_EQUIPPED, 40, updateBattleEquip) --important! battle equip needs scanned BEFORE ALL OTHER BATTLE Watches!
ScriptHost:AddMemoryWatch("updateBattleActivePartyMemberSlots", BATTLE_PARTY_SLOTS_BITMASK, 1, updateBattleActivePartyMemberSlots)
ScriptHost:AddMemoryWatch("updateBattleInventory", START_BATTLE_INVENTORY, 5*256, updateBattleInventory) --entire fucking battle inventory
ScriptHost:AddMemoryWatch("updateBattleCounter", BATTLE_COUNTER, 2, updateBattleCounter)
ScriptHost:AddMemoryWatch("updateBattleNumAliveMonsters", BATTLE_NUM_ALIVE_MONSTERS, 1, updateBattleNumAliveMonsters)
--

ScriptHost:AddMemoryWatch("updateColosseumWager", COLOSSEUM_WAGER_ITEM, 1, updateColosseumWager)
--
ScriptHost:AddMemoryWatch("updateCurrentShop", CURRENT_SHOP, 1, updateCurrentShop)
ScriptHost:AddMemoryWatch("updateShopItemList", CURRENT_SHOP_INVENTORY_START, 8, updateShopItemList)
--
ScriptHost:AddMemoryWatch("updateCurrentArea", CURRENT_AREA, 1, updateCurrentArea)
--




--TODO[ ] DONE[x]
--new character recruit inventory [x]
--new character recruit inventory at startup [x]
--game start invent qtys (multiple) i.e. 3x fenix down [x]
--menu item use on party        [x]
--Shop sell                     [x]
--Shop sell multiple at once	[x]
--Shop sell item to depletion   [x]
--Shop sellfast				    [x]
--shop buy                      [x]
--shop buy fast                 [x]
--shop buy multiple at once		[x]
--chest/Potion                  [x]
--dead check rewards            [x]
--IGNORE equip change in menu   [x]
--IGNORE inventory arrange      [x]
--IGNORE inventory move items   [x]
--colisseum wagers: add winning item [x]
--colisseum wagers: wagered item as Use: [x] 
--item + 1 flow over to tens [x]
--RELOAD from save/reset [x]
--throw in battle [x]
--steal in battle / Ragnarok morph [x]

--TODO/BUGS
-- [x]equip moogle charm= +1 chest [x]
-- [x]equip relic/weapon/armor +1 USE [x] fixed bug in sub context if stmnts.
-- [x]LOAD GAME: reads occur during LOAD SAVE CONFIRMATION screen, so if u peek and swap between saves - differences are counted. Fixed.
-- [x]SHOP enter: doesn't pick it up [x] introduced global flag for fix.
-- [x]battle-used items being placed on the upd-inv-skip-list were bring skipped but their qty wasn't being updated in upd-inv-list, caused +1 use after the _next_ battle. fixed.
-- [x]AIRship unequip all, increments up items. also kohligen guy (who even uses that guy?)
-- [x]airship [x]buy/[x]sell/[ ]item-use in same zone-area as unequip guy: are being ignored. partial fix. see below bug.
-- [x] party menu item use. Depleting an item is not being captured. Uses prior to depletion are being captured. Fixed via gPrev flag.
--[] battle inv all wonky

-- KNOWN minor  ISSUES / limitations
-- UI: inconsistent blue-background on items (these are separate captures)
-- UI: consumable items are crapilly captured.
-- UI: considering changing (EYE) last seen shop color scheme to something else. i don't know what. 
--        something easier to ignore while you're playing? Maybe the following...
-- UI: considering making Uber Items yellow in tracker. Ragnarok, Illumina, Minerva etc.
-- BATTLE: Steal/Throw command - items update at end of battle.
-- BATTLE: Item usage that results in non-consumption i.e. after use, but before animation, like when u kill a boss -- still registers as a 'use'.

--KNOWN BUGS
-- [ ] sometimes, new character Equipment activates label but not Qty. This may be due to FAST menuing and the item_qty code executing faster than item_name code can update.
--      attempting fix via index capturing and sending through to UpdateTrackerItem()
-- 		in order to re-GET the item name.
-- rarely, chest item is missed. ex: zephyr cape was detected as empty item. possible 255 variable issue.

--print("START inits()")
initCharNameArray()
initCharactersActiveStatus()
initgCharacterInitialEquipment_2d()
initHardCodedItemNames()
 
initBattleInventoryItems() 
initBattleInventoryQuantities() 
initShopList_table()
--print("END inits()")