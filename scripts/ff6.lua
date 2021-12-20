-- Features:
-- 1. Encounter prediction: predicts steps until encounter, and what will be encountered.
--    Does not predict front/back/pincer/side/preemptive variants, not will it work properly
--    on the floating continent. (there is tentative support for this (which actually makes up
--    a good part of the code), but it is buggy, and only works well when one is on the world map,
--    and has 3 or 4 chars in party, so it is disabled by default)
-- 2. Outline treasure chests and show their contents and status (green = untaken, red = taken)
-- 3. Outline squares that trigger events. Blue = transition to new area, light blue = transition
--    to same area, very light blue = transition to map, yellow = unclassified event.
-- 4. In battle, hp and mp bars are displayed over the enemies, as well as their battle gauges.
--    Their level is also displayed. On gau's turns, a "?" is displayed by any monster whose
--    rage is not known. Additionally, the enemies' resistances etc. are displayed in a compact
--    but hopefully readable manner, as a set of 4 3x3 sqares of pixels, where each has the
--    following format:
--      fil   ; fire (red) ice (blue) lightning (yellow)
--      pwp   ; poison (green) wind (gray) holy (white)
--      ew    ; earth (brown) water (blue)
--    The order of the sqares is, from left to right, absorb, nullify, resist, weak.
-- 5. Extra information is displayed for the currently selected monster.
--    normally, only its drops and hp/mp are displayed, but if locke is selecting the
--    monster with the steal command, its steals are also listed. If relm is selecting
--    a monster with control or sketch, that information will also be indicated.
-- 6. While in the rage menu, information about what the selected rage does is
--    displayed. Only the attack part of the rage is displayed so far, since I haven't thought
--    of a compact way of displaying all the status information associated with a rage.

addHours = 0
addMinutes = 4
addSeconds = 9
addFrames = 21
textX = 160
textY = 120

lMode1 = memory.readword(0x7e1501)
lMode2 = memory.readbyte(0x7e1503)
lMode3 = memory.readbyte
cMode1 = memory.readword(0x7e1501)
cMode2 = memory.readbyte(0x7e1503)
autoText = false




drawpixel = function(x,y,color)
	if x < 0 or y < 0 then return end
	if x >= 0x100 or y >= 0xE0 then return end
	gui.drawpixel(x,y,color)
end
-- the following section handles out of bounds checking.
-- This will hopefully not be necessary in later versions of snes9x-lua
-- The bounds checking for lines is slightly more complicated, so I did
-- not bother implementing it properly.
min = function(a,b) if a < b then return a else return b end end
max = function(a,b) if a < b then return b else return a end end
order = function(a,b) if a > b then return b, a else return a,b end end
olddrawbox = gui.drawbox
gui.drawbox = function(x1,y1,x2,y2,color)
	x1,x2 = order(x1,x2)
	y1,y2 = order(y1,y2)
	x1 = min(max(0,x1),255)
	y1 = min(max(0,y1),238)
	x2 = min(max(0,x2),255)
	y2 = min(max(0,y2),238)
	olddrawbox(x1,y1,x2,y2,nil,color)
end
oldtext = gui.text
gui.text = function(x,y,text)
	if x >= 0 and x < 256 and y >= 0 and y < 239 then
		oldtext(x,y,text)
	end
end
horline = function(x1,y,x2,color)
	x1,x2 = order(x1,x2)
	x1 = min(max(0,x1),255)
	x2 = min(max(0,x2),255)
	if y >= 0 and y < 239 then
		gui.drawline(x1,y,x2,y,color)
	end
end
vertline = function(x,y1,y2,color)
	y1,y2 = order(y1,y2)
	y1 = min(max(0,y1),238)
	y2 = min(max(0,y2),238)
	if x >= 0 and x < 256 then
		gui.drawline(x,y1,x,y2,color)
	end
end


startgauge = function(x,y,w)
	gx, gy, gw = x, y, w
end
drawgauge = function(c,m,col)
	if m == 0 then m = 1 end
	local g = c*gw/m
	horline(gx,gy,gx+g,col)
	horline(gx+g,gy,gx+gw,"#000000")
	gy = gy-1
end

tochar = function(i)
	if i < 0x80 then return ""
	elseif i < 0x9a then return string.char(string.byte("A")+i-0x80)
	elseif i < 0xb4 then return string.char(string.byte("a")+i-0x9a)
	elseif i < 0xbe then return string.char(string.byte("0")+i-0xb4)
	elseif i == 0xfe then return " "
	else return "" end
end

readsnesstring = function(from,maximum)
	local res = ""
	local tmp = memory.readbyte(from)
	local i = 0
	while tmp ~= 0xFF do
		if i == maximum then break end
		res = res .. tochar(tmp)
		from = from+1
		tmp = memory.readbyte(from)
		i = i+1
	end
	return res
end

getitemname = function(id)
	return readsnesstring(0xd2b300+0xd*id+1,12)
end
getmonstername = function(id)
	return readsnesstring(0xcfc050+0xa*id,10)
end
getattackname = function(id)
	local x = 0
	local maxlen = 10
	if id < 0x36 then
		x = id*7
		maxlen = 7
	elseif id < 0x51 then
		x = id*8-0x36
		maxlen = 8
	elseif id < 0x56 then x = id*0xA-0xd8
	else x = id*0xA-0xd8 -- vet ikke hvorfor indeksen blir d8 her.
	--else id < 0x5b then x = id*0xA-0xc4
	end
	return readsnesstring(0xe6f567+x,maxlen)
end


-- This is probably not the best way of determining the game mode, but it works.
mode_battle = function()
	return memory.readword(0x7e1501) == 0x0ba7 and memory.readbyte(0x7e1503) == 0xC1
end
mode_cave = function()
	return memory.readword(0x7e1501) == 0x0182 and memory.readbyte(0x7e1503) == 0xC0
end
mode_map  = function()
	return memory.readword(0x7e1501) == 0xa728 and memory.readbyte(0x7e1503) == 0xEE
end
mode_menu = function()
	return memory.readword(0x7e1501) == 0x1387 and memory.readbyte(0x7e1503) == 0xC3
end
function HandleKeys()
	keys = input.get()

    if press('T') then
		autoText = not autoText
	end
	
	last_keys = keys                                              
end
function press(button)
    if keys[button] and not last_keys[button] then
        return true
    end
    return false
end

hours = 0
minutes = 0
seconds = 0
milliseconds = 0

function CalculateTime()
    frames = snes9x.framecount()
	frames = frames + addHours * 216000 + addMinutes * 3600 + addSeconds * 60 + addFrames
	hours = math.floor(frames / 216000)
	minutes = math.floor((frames - hours * 216000) / 3600)
	seconds = math.floor((frames - hours * 216000 - minutes * 3600) / 60)
	milliseconds = math.floor((frames - hours * 216000 - minutes * 3600 - seconds * 60) * 100 / 60)
end

function OutputTime()
    --gui.text(textX, textY, "Time: " .. hours .. ":" .. string.format("%02d",minutes) .. ":" .. string.format("%02d",seconds) .. "." .. string.format("%02d",milliseconds))
    --gui.text(textX, textY + 10, "Offset: " .. addHours .. ":" .. string.format("%02d",addMinutes) .. ":" .. string.format("%02d",addSeconds) .. "." .. string.format("%02d",math.floor(addFrames * 100 / 60)))
end


-- prints a compact representation of elemental properties.
-- There are 8 elements. Each is assigned a color, and a place
-- in a 3x3 matrix of pixels.
-- fil   ; fire (red) ice (blue) lightning (yellow)
-- pwp   ; poison (green) wind (gray) holy (white)
-- ew    ; earth (brown) water (blue)
-- Colors need not be uniqe, as the position fixes things.
-- This is then surrounded by black border.
print_element = function(x,y,elem)
	-- first draw the border
	horline(x, y, x+4, "#404040")
	vertline(x+4, y, y+4, "#404040")
	vertline(x, y, y+4, "#404040")
	horline(x, y+4, x+4, "#404040")
	-- now draw the elements
	local x,y=x+1,y+1
	putpix = function(x,y,b,c)
		if b == 1 then drawpixel(x,y,c) else drawpixel(x,y,"#000000") end
	end
	cols = {
		"#ff0000","#0000ff","#ffff00",
		"#00ff00","#808080","#ffffff",
		"#a08000","#0000ff","#000000"
	}
	for i = 1, 9 do
		dx, dy = (i-1)%3, math.floor((i-1)/3)
		putpix(x+dx,y+dy,elem % 2,cols[i])
		elem = math.floor(elem/2)
	end
end

get_special = function(id)
	-- Information about the special attack
	-- This is used by rage, sketch, control.
	local special = memory.readbyte(0xcf001f+0x20*id)
	local specialn = readsnesstring(0xcfd0d0+id*10,10)
	local no_damage,no_dodge = bit(special, 6),bit(special,7)
	special = special % 0x40
	desc = "???"
	if special == 0x30 then desc = "absorb hp"
	elseif special == 0x31 then desc = "absorb mp"
	elseif special >= 0x32 then desc = "remove reflect"
	elseif special >= 0x20 then desc = string.format("+%d%%",(special-0x1f)*50)
	else
		local descs = { "Dark","Zombie","Poison","MagiTek","Clear","Imp","Petrify",
			"Death", "Condemned", "Near Fatal", "Image", "Mute", "Berserk",
			"Muddle", "Seizure", "Sleep", "Dance", "Regen", "Slow", "Haste",
			"Stop", "Shell", "Safe", "Reflect", "Rage", "Freeze", "Life 3",
			"Morph", "Chant!", "Disappear!", "Dog block", "Float" }
		desc = descs[special+1]
	end
	specialn = specialn.." ("..desc..")"
	return specialn, no_damage, no_dodge
end


print_status = function(status)
	-- Må finne ut hva bitsene i hver status byte betyr.
end

-- bit operations, since lua is silly enough to miss these
bit = function(n,i) return math.floor(n/2^i) % 2 end
bor = function(a,b)
	local c = 0
	local pot = 1
	while a ~= 0 or b ~= 0 do
		if a % 2 == 1 or b % 2 == 1 then c = c+pot end
		a = math.floor(a/2)
		b = math.floor(b/2)
		pot = pot*2
	end
	return c
end

-- to get the pixel distance from an encounter, we
-- need to fix an occational off-by-1 error for
-- count. this happens on the first frame when we reach
-- a whole square. we thus need to keep track of whether
-- the last position was whole or not
last_position_whole = true




function mainLoop()


	while true do

		--writeXYcoords()
		 

		-- Are we in battle?
		offset = 100
		if mode_battle() then
			--snes9x.speedmode("maximum")
			
			-- memory.writebyte(0x7e3bfc, 0)
			-- memory.writebyte(0x7e3bfd, 0)
			-- memory.writebyte(0x7e3bfe, 0)
			-- memory.writebyte(0x7e3bff, 0)
			-- memory.writebyte(0x7e3c00, 0)
			-- memory.writebyte(0x7e3c01, 0)
			-- memory.writebyte(0x7e3c02, 0)
			-- memory.writebyte(0x7e3c03, 0)
			-- memory.writebyte(0x7e3c04, 0)
			-- memory.writebyte(0x7e3c05, 0)
			-- memory.writebyte(0x7e3c06, 0)
			-- memory.writebyte(0x7e3c07, 0)
			
			sel_side, sel_i = memory.readbyte(0x7e7ace), memory.readbyte(0x7e7acf)
			sel_enemy, sel_party = memory.readbyte(0x7e7b7e),memory.readbyte(0x7e7b7d)
			sel_multi = memory.readbyte(0x7e7b7f)
			-- loop through present monsters
			for i = 0, 5 do
				-- a few shortcuts
				j, k = 2*i, 2*(4+i)
				state = memory.readword(0x7e3aa0+k)
				if state ~= 0 and bit(state,15) ~= 1 then
				-- get coordinates (we should know the size of the monster too, but we don't)
				x = memory.readbyte(0x7e80c2+1+j)
				-- this size is really the x-offset of the pointing hand relative to the start
				-- of the sprite. For a normal attack, this works fine, but for monsters on the
				-- right hand side of the screen, this offset is 0, as the hand is on their left
				-- side. To do things properly, I should get this in a more direct fashion, but
				-- I can't be bothered
				xsize = memory.readbyte(0x7e807a+1+j)
				if xsize == 0 then xsize = 0x20 end
				y = memory.readbyte(0x7e80ce+1+j)
				-- other interesting information
				id   = memory.readword(0x7e3388+j)
				xp   = memory.readword(0x7e3d8c+j)
				gold = memory.readword(0x7e3da0+j)
				hp   = memory.readword(0x7e3bf4+k)
				mp   = memory.readword(0x7e3c08+k)
				mhp  = memory.readword(0x7e3c1c+k)
				mmp  = memory.readword(0x7e3c30+k)
				level= memory.readbyte(0x7e3b18+k)
				speed= memory.readbyte(0x7e3b19+k)
				gauge= memory.readword(0x7e3218+k)
				-- elements
				absorb  =  memory.readbyte(0x7e3bcc+k)
				nullify =  memory.readbyte(0x7e3bcd+k)
				resist  =  memory.readbyte(0x7e3be1+k)
				weak    =  memory.readbyte(0x7e3be0+k)
				stealn  =  memory.readbyte(0x7e3311+j)
				stealr  =  memory.readbyte(0x7e3310+j)
				dropn   =  memory.readbyte(0xcf3000+4*id+3)
				dropr   =  memory.readbyte(0xcf3000+4*id+2)

				name = getmonstername(id)

				-- Print the gauges
				startgauge(x,y,xsize)
				drawgauge(mp, mmp, "#0000ff")
				drawgauge(hp, mhp, "#00ff00")
				drawgauge(gauge, 0x10000, "#ff0000")
				by = gy
				gui.text(x-16, by-8, string.format("%2d",level))
				print_element(x, by-6, absorb)
				print_element(x+4, by-6, nullify)
				print_element(x+8, by-6, resist)
				print_element(x+12, by-6, weak)
				gui.text(x+18, by-8, ""..hp)

				active_slot = memory.readbyte(0x7e0201)
				active_player = memory.readbyte(0x7e3ed8+active_slot*2)
				menu_pos = memory.readbyte(0x7e890f+active_slot)
				relm_info = active_player == 8 and menu_pos == 1
				locke_info = active_player == 1 and menu_pos == 1
				gau_info = active_player == 0xb

				if gau_info then
					local id_byte, id_bit = math.floor(id/8), id % 8
					if bit(memory.readbyte(0x7e1d2c+id_byte),id_bit) == 0 then
						-- monster not known!
						gui.text(x-8,y,"?")
					end
				end
				
				-- More detailed information for the monster we point to.
				-- This will depend on how it is being pointed to
				if (sel_side == 0 or sel_side == 2) and sel_i == i and
					sel_multi == 0 and sel_enemy ~= 0 then
					--gui.text(10,offset,"Level "..level.." "..name)
					--offset = offset+10
					gui.text(10,offset,string.format("HP:%d/%d, MP:%d/%d",hp,mhp,mp,mmp))
					offset = offset+10
					--gui.text(10,offset,string.format("XP:%d, gold:%d",xp,gold))
					--offset = offset+10
					if locke_info then
						gui.text(10,offset,string.format("Steal %s/%s", getitemname(stealn), getitemname(stealr)))
						offset = offset+10
					end
					gui.text(10,offset,string.format("Drops %s/%s", getitemname(dropn), getitemname(dropr)))
					offset = offset+10
					-- Special attack description
					specialn = get_special(id)
					-- Sketch
					sketch1 = memory.readbyte(0xcf4300+2*id)
					sketch2 = memory.readbyte(0xcf4300+2*id+1)
					-- control
					control, controln = {}, {}
					for ctrl_i = 0, 3 do
						control[ctrl_i] = memory.readbyte(0xcf3d00+4*id+ctrl_i)
					end
					if sketch1 == 0xEF then sketch1n = specialn else sketch1n = getattackname(sketch1) end
					if sketch2 == 0xEF then sketch2n = specialn else sketch2n = getattackname(sketch2) end
					for ctrl_i = 0, 3 do
						local ctrl,foo = control[ctrl_i]
						if ctrl == 0xEF then foo = specialn
						elseif ctrl == 0xFF then foo = "Nothing"
						else foo = getattackname(ctrl) end
						controln[ctrl_i] = foo
					end
					if relm_info then
						gui.text(10,offset,string.format("Sketch %s/%s", sketch2n, sketch1n))
						offset = offset+10
						gui.text(10,offset,string.format("Control %s/%s",controln[0],controln[1]))
						offset = offset+10
						gui.text(10,offset,string.format("        %s/%s",controln[2],controln[3]))
						offset = offset+10
					end
				end
			end end
			-- Rage information when in the rage menu
			if memory.readbyte(0x7e7bd4) == 0x24 then
				x = memory.readbyte(0x7e892f)
				y = memory.readbyte(0x7e8933)
				scroll = memory.readbyte(0x7e892b)
				i = 2*(y+scroll)+x
				id = memory.readbyte(0x7e257e + i)
				if id ~= 0xFF then
					-- What rages does this monster have?
					rage1 = memory.readbyte(0xcf4600+2*id)
					rage2 = memory.readbyte(0xcf4600+2*id+1)
					-- Special attack description
					specialn = get_special(id)
					if rage1 == 0xEF then rage1n = specialn else rage1n = getattackname(rage1) end
					if rage2 == 0xEF then rage2n = specialn else rage2n = getattackname(rage2) end
					gui.text(10,offset,string.format("%s/%s", rage1n, rage2n))
					offset = offset+10
				end
			end
		elseif mode_cave() then
			snes9x.speedmode("normal")
			-- get the screen position
			sx     = memory.readword(0x7e8297)
			sy     = memory.readword(0x7e8299)
			if sx >= 0x8000 then sx = sx-0x10000 end
			if sy >= 0x8000 then sy = sy-0x10000 end
			
			
			--JC main()
			mainListener_DrawPaths()
			
			
			
			
			
			-- prepare to loop through treasures
			area   = memory.readword(0x7e0082)
			table  = 0xed8634
			i      = memory.readword(0xed82f4+2*area)
			to     = memory.readword(0xed82f4+2*(area+1))
			 
			 
			-- loop through the treasures
			while i ~= to do
				-- read from the treasure information array
				xi     = memory.readbyte(table+i)
				yi     = memory.readbyte(table+i+1)
				flagi  = memory.readword(table+i+2)
				item   = memory.readbyte(table+i+4)
				
				name   = getitemname(item)
				-- Has the box been taken? To find out, we need to
				-- do some bit manipulation.
				byte_index = math.floor(flagi/8)
				bit_index = flagi % 8
				if byte_index >= 0x40 then
					byte_index = byte_index - 0x40*math.floor(byte_index/0x40)
				end
				flag = memory.readbyte(0x7e1e40+byte_index)
				flag = flag % (2^(bit_index+1))
				flag = math.floor(flag/ 2^bit_index)
				-- flag is now 0 if not taken and 1 if taken
				--print("area:"..string.format("%02X",area).." i:"..i.." item address:"..string.format("%02X",item).." open/closed flag: "..flag)
				if flag == 0 then color = "#00ff00" else color = "#ff0000" end

				-- get the real x,y position, using the fact that
				-- each square is 0x10 big.
				x,y = 0x10*xi, 0x10*yi
				-- relative coordinates
				rx, ry = x-sx, y-sy

				-- draw a nice red box around the treasure box
				gui.drawbox(rx, ry, rx+0x10, ry+0x10, color) --treasure
				--gui.text(rx, ry-5, name)

				i = i + 5
			end
			table = 0xdfbb00
			i     = memory.readword(table+2*area)
			to    = memory.readword(table+2*(area+1))
			-- loop through the transitions
			while i ~= to do
				-- read from the treasure information array
				xi     = memory.readbyte(table+i)
				yi     = memory.readbyte(table+i+1)
				hmm    = memory.readword(table+i+2)
				xti    = memory.readbyte(table+i+4)
				yti    = memory.readbyte(table+i+5)
				area2 = hmm % 0x200
				-- is it to the same area? If so, color it
				-- light blue. Else make it normal blue.
				if area2 == area then color = "#8080ff"
				else color = "#0000ff" end

				-- get the real x,y position, using the fact that
				-- each square is 0x10 big.
				x,y = 0x10*xi, 0x10*yi
				-- relative coordinates
				rx, ry = x-sx, y-sy
				--gui.drawbox(rx, ry, rx+0x10, ry+0x10, color) -- Entrance Triggers

				i = i + 6
			end
			table = 0xedf480
			i     = memory.readword(table+2*area)
			to    = memory.readword(table+2*(area+1))
			-- loop through the wide transitions
			while i ~= to do
				-- read from the treasure information array
				xi     = memory.readbyte(table+i)
				yi     = memory.readbyte(table+i+1)
				dxi    = memory.readbyte(table+i+2)
				dyi    = 0
				hmm    = memory.readword(table+i+3)
				xti    = memory.readbyte(table+i+5)
				yti    = memory.readbyte(table+i+6)
				area2 = hmm % 0x200
				if dxi >= 0x80 then dxi, dyi = 0, dxi % 0x80 end
				-- is it to the same area? If so, color it
				-- light blue. Else make it normal blue.
				if area2 == area then color = "#8080ff" --dull blue
				elseif area2 == 0x1ff then color = "#b0b0ff" --duller blue
				else color = "#0000ff" end --blue

				-- get the real x,y position, using the fact that
				-- each square is 0x10 big.
				x,y,dx,dy = 0x10*xi, 0x10*yi, 0x10*dxi, 0x10*dyi
				-- relative coordinates
				rx, ry = x-sx, y-sy
				--gui.drawbox(rx, ry, rx+dx+0x10, ry+dy+0x10, color) -- Long Entrance Triggers 

				i = i + 7
			end
			
			--ACTIONABLE OBJECTS JC
			
			table= 0xc40000
			i    = memory.readword(0xc40000+2*area)
			to   = memory.readword(0xc40000+2*(area+1))
			-- loop through the reactions
			while i ~= to do
				-- read from the treasure information array
				xi     = memory.readbyte(table+i)
				yi     = memory.readbyte(table+i+1)
				react1 = memory.readword(table+i+2)
				react2 = memory.readbyte(table+i+4)
				color = "#ffff00" --yellow

				-- get the real x,y position, using the fact that
				-- each square is 0x10 big.
				x,y = 0x10*xi, 0x10*yi
				-- relative coordinates
				rx, ry = x-sx, y-sy
				--gui.drawbox(rx, ry, rx+0x10, ry+0x10, color) --Event Triggers
				
				i = i + 5
			end
		else
			snes9x.speedmode("normal")
		end
		-- encounter counter
		if mode_map() or mode_cave() then
			-- Equipment-derived information is not kept permanently, it is recomputed
			-- at the beginning of every frame, I think. We need to know if the party
			-- has the moogle charm or charm bangle effect.
			-- We will therefore loop through the equipment of all characters.
			field_effects = 0
			status_effects = 0
			char_in_party = 0
			for id = 0, 0xF do
				tmp = memory.readbyte(0x7e1850+id)
				if tmp % 8 == memory.readbyte(0x7e1a6d) then
					-- character is present. If necessary, information about
					-- row and slot is also awailable in tmp.
					char_in_party = char_in_party + 1
					x = id*0x25+0x1F -- start of equipment
					for i = 0, 5 do
						item = memory.readbyte(0x7e1600+x+i)
						if item ~= 0xFF then
							-- item actually equipped
							field_effects = bor(field_effects,memory.readbyte(0xd85005+item*0x1e))
							status_effects = bor(status_effects,memory.readbyte(0xd8500a+item*0x1e))
						end
					end
				end
			end
			-- field_effects is what is later put in 11df

			if mode_map() then --field
				terrain = memory.readbyte(0x7e11f9) % 8
				at_22 = memory.readbyte(0xc0c28f+terrain) -- lave tall, men hva betyr de?
				a = memory.readbyte(0xc0c297+terrain) -- denne arrayen følger rett etter. samme størrelsesorden.
				-- b og c er faktisk x og y-posisjonen på kartet til *forrige encounter*!
				last_x = memory.readbyte(0x7e1f60)
				last_y = memory.readbyte(0x7e1f61)
				zone_x, zone_y = math.floor(last_x/0x20),math.floor(last_y/0x20)
				zone = memory.readbyte(0x7e1f64)*0x40+zone_y*8+zone_x

				-- a må inneholde en mapping fra terreng til offsets i følgende array.
				-- merkelig at slikt trengs.
				pack_index = memory.readbyte(0xcf5400+zone*4+a)
				--gui.text(textX, textY + 30, "XXXpack index: " .. pack_index)
				-- den høye byten her angir kanskje om det er world of balance eller ruin eller noe annet?
				encounter_rate_index = math.floor(memory.readbyte(0xcf5800+zone) / 4^at_22) % 4
				 -- field_effects har info om charm bangle etc. encounter_rate_index info om more/less enc.
				x = (field_effects)%4*8 + encounter_rate_index*2
				-- x er nå indeks inn i encounter rate-tabellen.
				encounter_rate = memory.readword(0xc0c29f+x)
			else --town
				area = memory.readword(0x7e0082)
				ax,ay = math.floor(area/4), area % 4
				a = (memory.readbyte(0xcf5880+ax) / 4^ay) % 4
				x = ((memory.readbyte(0x7e11df) % 4) * 4 + a) * 2
				encounter_rate = memory.readword(0xc0c2bf+x)
				if bit(memory.readbyte(0x7e0525),7) == 0 then
					encounter_rate = 0
				end
				pack_index = memory.readbyte(0xcf5600+area)
				--gui.text(textX, textY + 30, "YYYpack index: " .. pack_index)
			end
			enc1 = memory.readword(0x7e1f6e)
			enc2 = memory.readbyte(0x7e1fa1)
			enc3 = memory.readbyte(0x7e1fa4)
			count = 1
			if encounter_rate ~= 0 then
				for i = 0, 100 do
					enc1 = enc1 + encounter_rate
					if enc1 >= 0x10000 then enc1 = 0xff00 end
					enc2 = (enc2+1) % 0x100
					if enc2 == 0 then enc3 = (enc3 + 0x11) % 0x100 end
					if (memory.readbyte(0xc0fd00+enc2)+enc3) % 0x100 < math.floor(enc1/0x100) then break end
					count = count+1
				end
				gui.text(10,offset,"Encounter in ".. count.." steps.")
				offset = offset+10

				-- Veldt?
				if pack_index == 0xFF then
					enc_veldt = (memory.readbyte(0x7e1fa5)+1) % 0x40
					-- find a nonzero byte in the encountered formations bitarray.
					while memory.readbyte(0x7e1ddd+enc_veldt) == 0 do
						enc_veldt = (enc_veldt+1) % 0x40
					end
					enc5 = memory.readbyte(0x7e1fa3)
					enc4 = (memory.readbyte(0x7e1fa2)+1) % 0x100
					if enc4 == 0 then enc5 = enc5 + 0x17 end
					bit_index = (memory.readbyte(0x7ec0fd00+enc4)+enc5) % 0x8
					bitset = memory.readbyte(0x7e1ddd+enc_veldt)
					-- find a nonzero bit, starting at a random position
					while bit(bitset,bit_index) == 0 do
						bit_index = (bit_index+1) % 8
					end
					formation = enc_veldt*8+bit_index
				else
					x = pack_index*8
					-- Encounter type. x is the index into the monster pack array
					enc1 = (memory.readbyte(0x7e1fa2)+1) % 0x100
					enc2 = memory.readbyte(0x7e1fa3)
					if enc1 == 0 then enc2 = enc2+0x17 end
					a = (memory.readbyte(0xc0fd00+enc1)+enc2) % 0x100

					if a > 0x50 then x = x+2 end
					if a > 0xa0 then x = x+2 end
					if a > 0xf0 then x = x+2 end
					formation = memory.readword(0xcf4800+x)
				end

	-- At this point, we have all the frame-independent information about the
	-- encounter we can get. The following is an attempt to handle the frame-
	-- dependent information by predicting at what frame an encounter will occur.
	-- This is formation variation (on the floating continent only), attack type
	-- (front, back, pincer, side) and preemptiv or not. However, this ended in
	-- failure. It works for 3-4 chars in party on the map, mostly, but not for
	-- fewer chars, and not when not on the world map. If you want to enable it,
	-- comment the following line
				skip_frame_dependent = true

				if not skip_frame_dependent then
					-- To find out more about the encounter, we need the frame-
					-- dependent be variable. We must first predict the number
					-- of pixels we are away from an encounter.
					if mode_map() then
						faceing = memory.readbyte(0x7e00f6)
						xpos = memory.readword(0x7e00c6)
						ypos = memory.readword(0x7e00c8)
					else
					-- have to loop through all chars to find out who is the leader?
					-- However, the position we get this way does not move smoothly. Bleh.
						for id = 0, 0xF do
							local delta = 0x29*id
							xpos, ypos = 0,0
							if bit(memory.readbyte(0x7e0867+delta),7) == 1 then
								faceing = memory.readbyte(0x7e086f+delta)
								xpos = memory.readword(0x7e086a+delta)
								ypos = memory.readword(0x7e086d+delta)
								break
							end
						end
					end
					if faceing == 0 then pixels = ypos % 0x10
					elseif faceing == 1 then
						pixels = xpos % 0x10
						if pixels ~= 0 then pixels = 0x10-pixels end
					elseif faceing == 2 then
						pixels = ypos % 0x10
						if pixels ~= 0 then pixels = 0x10-pixels end
					else pixels = xpos % 0x10
					end
					-- this is the pixels left in our current step. then add the number
					-- of whole steps
					standing_still = false
					if pixels == 0 then
						-- this is a whole position. was the last position whole too?
						if last_position_whole then
							standing_still = true
							pixels = 0x10*count
						else pixels = 0x10*(count-1) end
						last_position_whole = true
					else
						pixels = pixels + 0x10*(count-1)
						last_position_whole = false
					end
					-- sprint shoes?
					if mode_cave() and bit(status_effects,5) then
						pixels = math.floor(pixels/2)
					end
					-- compensate for the time it takes to start moving
					if standing_still then
						if mode_map() then pixels = pixels+2
						else
							if bit(status_effects,5) == 1 then
								pixels = pixels + memory.readbyte(0x7e0021e) % 4
							else pixels = pixels + memory.readbyte(0x7e0021e) % 4 end
						end
					end
					-- we assume that we are walking with maximum speed of 1 pixel per frame
					-- this will lead to be getting this value at the beginning of battle
					be = 4*((memory.readbyte(0x7e021e)+pixels+0x22) % 0x3c)
					gui.text(10,90,string.format("be: %x vs %x, %x %x", memory.readbyte(0x7e00be), be,pixels,xpos))

					if math.floor(formation / 0x8000) == 1 then
						-- High bit of formation set: randomly add 0..3 to formation
						be = (be+1) % 0x100
						a = memory.readbyte(0xc0fd00+be) % 4
						formation = (formation+a) % 0x8000
					end
				end
				info1 = memory.readbyte(0xcf5900+4*formation)
				info2 = memory.readbyte(0xcf5900+4*formation+1)
				info3 = memory.readbyte(0xcf5900+4*formation+2)
				info4 = memory.readbyte(0xcf5900+4*formation+3)

				-- Build monster list
				start = 0xcf6201+15*formation
				present = memory.readbyte(start)
				which = {}
				number_of_enemies = 0
				for i = 1, 6 do
					if present % 2 == 1 then
						id = memory.readbyte(start+i)
						if which[id] then which[id] = which[id]+1
						else which[id] = 1 end
						number_of_enemies = number_of_enemies + 1
					end
					present = math.floor(present/2)
				end
				-- Display list
				for id, num in pairs(which) do
					gui.text(10, offset, ""..num.." "..getmonstername(id))
					offset = offset + 10
				end

				if not skip_frame_dependent then
					-- What kind of encounter?
					variant = math.floor(info1 / 0x10) % 0x10
					-- variant is four bits long, and those bits are front, back, pincer, side; inverted.
					-- from high to low.
					-- let us extract these
					allowed = {}
					allowed_number = 0
					for i = 0, 3 do
						allowed[i] = 1 - variant % 2
						allowed_number = allowed_number + allowed[i]
						variant = math.floor(variant/2)
					end
					if bit(status_effects,1) == 1 then
						-- back guard, disable back and pincer.
						-- This will prefer to remove pincer if not
						-- both can be removed.
						for i = 1, 2 do if allowed_number > 1 then
							allowed[i] = 0
							allowed_number = allowed_number-1
						end end
					end
					if char_in_party < 3 and allowed_number > 1 then
						-- not enough characters to do side attack
						allowed[3] = 0
						allowed_number = allowed_number - 1
					end

					-- Now we pick one of the possibilities
					-- First find the sum of the weights
					local sum = 0
					for i = 0, 3 do if allowed[i] == 1 then
						sum = sum + memory.readbyte(0xc25279+i)+1
					end end
					-- before this point, be has been incremented by other things
					be = be + 0xa + 2*number_of_enemies + char_in_party
					-- get a random number from 0 to sum-1, using be
					be = (be+1) % 0x100
					rnd = math.floor(memory.readbyte(0xc0fd00+be)*sum/0x100)
					-- now loop through again, and pick the first that is bigger
					-- than the number
					sum = 0
					for i = 0, 3 do if allowed[3-i] == 1 then
						sum = sum + memory.readbyte(0xc25279+i)+1
						if sum > rnd then
							chosen = 3-i
							break
						end
					end end

					vardesc = { "Front", "Back", "Pincer", "Side" }

					-- Finally, describe the result
					if chosen ~= 0 then
						gui.text(10, offset, string.format("%s attack",vardesc[chosen+1]))
						offset = offset+10
					end
				end
			end
		end
		HandleKeys()
		
		testingShopData()	
		
		if autoText then
			--gui.text(textX,textY + 20,"(T) Auto Text : On")          
		else
			--gui.text(textX,textY + 20,"(T) Auto Text : Off")          
		end

		if autoText and (snes9x.framecount() % 6  == 0 or ((snes9x.framecount() - 1) % 6 == 0)) then
			curPad = joypad.get()
			curPad.A = true
			joypad.set(curPad)
		end

		if (memory.readbyte(0x7e1dd2) % 2 == 0) and (memory.readword(0x7e1501) == 0xa509) and (memory.readbyte(0x7e1503) == 0xEE) then 
			x1 = memory.readword(0x7e0b00)
			y1 = memory.readword(0x7e0b02)
			x2 = memory.readword(0x7e0b04)
			y2 = memory.readword(0x7e0b06)
			
			gui.line(x1 + 176, 156, x1 + 176, 219, "#008080")
			gui.line(176, y1 + 156, 239, y1 + 156, "#008080")
			gui.line(x2 + 176, 156, x2 + 176, 219, "#008080")
			gui.line(176, y2 + 156, 239, y2 + 156, "#008080")
			gui.pixel(x1 + 176, y1 + 156, "#00ffff")
			gui.pixel(x2 + 176, y2 + 156, "#00ffff")
			
		end

		--for moviemaking
		--cMode1, cMode2 = memory.readword(0x7e1501), memory.readbyte(0x7e1503)
		--if lMode1 ~= cMode1 and lMode2 ~= cMode2 then
		--	snes9x.pause()
		--end
		--lMode1 = cMode1
		--lMode2 = cMode2

		CalculateTime()
		OutputTime()
		
		
		snes9x.frameadvance()
	end
end --end mainLoop()

function drawWhiteBoxes()

	gridx=0
	gridy=0
	XTileOffsetPixel=8 
	YTileOffsetPixel=0 
	for c = 0, 255 do
		gui.drawbox(gridx*16+XTileOffsetPixel, gridy*16+YTileOffsetPixel, gridx*16+XTileOffsetPixel+0x10, gridy*16+YTileOffsetPixel+0x10, "#ffffff")
		--gui.text( gridx*16+XTileOffsetPixel, gridy*16+YTileOffsetPixel,c)
		
		gridx=gridx+1
		if gridx%16==0 then
			gridx=0
			gridy=gridy+1
		end
	end
end

  
 


function writeXYcoords()
	
	local XposAddr ="0x7E0541"
	local YposAddr="0x7E00B0"
	local myaddress="0x0541"
	--gui.text( 1*0x10,8*0x10+6, "x:" .. memory.readbyte(XposAddr).. " " .. "y:" .. memory.readbyte(YposAddr) )
	gui.text( 1*0x10,8*0x10+6, myaddress .. ":" .. memory.readbyte(myaddress))
end




function forceWritePrevCorrd_CatchUp()
	prev_x_coord = current_x_coord
	prev_y_coord = current_y_coord
	--writeCurrCorrd()
end

prev_face = 0
function getReadFacingDirectionAsCharString()
	direction = memory.readbyte(0x7E1EB6)
	if prev_face ~= direction then
		prev_face = direction
		--print("face:"..prev_face)
	end
	
	return convertHexFacingToChar(direction)
	
end

function convertHexFacingToChar(direction)
	--print("face:"..direction)
	
	if direction == 1 then
		return "U"
	elseif direction == 2 then
		return "R"
	elseif direction == 4 then
		return "D"
	elseif direction == 8 then
		return "L"
	end
end

function drawDirectionBox(rx,ry,arrowDirection)
	--print("arrowDirection"..arrowDirection)
	 
	if arrowDirection == "U" then
		gui.text(rx+0x05+0x02, ry+0x01,"^")--U
	elseif arrowDirection == "R" then
		gui.text(rx+0x06+0x06, ry+0x06,">")--R
	elseif arrowDirection == "D" then
		gui.text(rx+0x05+0x02, ry+0x09,"V")--D
	elseif arrowDirection == "L" then
		gui.text(rx+0x01, ry+0x06,"<")--L
	end
	
	
		
		
		

end


function is_Rtrigger_ButtonBeingPressed()
	local buttonByte = memory.readbyte(0x7E000C)
	
	
	if buttonByte == 0x10 then
		return true
	else
		return false
	end
	
end

function is_Ltrigger_ButtonBeingPressed()
	local buttonByte = memory.readbyte(0x7E000C)
	
	
	if buttonByte == 0x20 then
		return true
	else
		return false
	end
end




--global vars
current_area = -1
current_x_coord = -1
current_y_coord = -1

prev_area = -1
prev_x_coord = -2
prev_y_coord = -2

	-- file = io.open ("test.txt","a")
	-- file:write("\nAPP START","\n")
	-- file:close()
 

gCurrentAreaTable = {}
gCurrentAreaStepListSize = -1
gIsAreaFileLoaded = false
--end global vars

function mainListener_DrawPaths()
	--print("Observing Current Area...")
	
	
	observeCurrentAreaForChanges()
	recordTilePositionAndDrawThem()
	--print("Observing Current Area...Complete.")
end

function observeCurrentAreaForChanges()
	
	if current_area == -1 and prev_area == -1 then --init
		current_area = memory.readword(0x7e0082)
		prev_area = current_area
		print("area init done."..prev_area)
		else
		--print("area init skipped")
	end
	
	current_area = memory.readword(0x7e0082)
	 
	--print("gIsAreaFileLoaded:"..tostring(gIsAreaFileLoaded))
	if not gIsAreaFileLoaded then
		readFromAreaFileWriteToAreaTable(current_area)
	end
	
	drawAreaSteps(current_area)
	
	if prev_area ~= current_area then --new area
		print("Entered New Area")
		prev_area = current_area
	 	
		readFromAreaFileWriteToAreaTable(current_area)
		drawAreaSteps(current_area)
	end
end

function recordTilePositionAndDrawThem()
	local facingDirection = getReadFacingDirectionAsCharString()
	if is_Rtrigger_ButtonBeingPressed() then
		gui.text( 1*0x10,10*0x10+6,"Recording steps...")--.."facing:"..getReadFacingDirectionAsCharString()) 
		
		--current_area = memory.readword(0x7e0082)
		
		current_x_coord = memory.readbyte(0x7E0541)
		current_y_coord = memory.readbyte(0x7E00B0)
	elseif is_Ltrigger_ButtonBeingPressed() then
		gui.text( 1*0x10,10*0x10+6,"Scanning current steps...")--.."facing:"..getReadFacingDirectionAsCharString()) 
		current_x_coord = memory.readbyte(0x7E0541)
		current_y_coord = memory.readbyte(0x7E00B0)
		markAreaTableCoordsForDeletionAndTurnOff(current_x_coord, current_y_coord)
	else
		return
	end
	
	--gui.text( 1*0x10,8*0x10+6,"Area:" .. current_area .. " x:" .. current_x_coord .. ",y:" .. current_y_coord .. ",px:" .. prev_x_coord .. ",py:" .. prev_y_coord)
	if prev_x_coord ~= current_x_coord or prev_y_coord ~= current_y_coord then
		--
		
		if math.abs(prev_x_coord - current_x_coord) > 1 or math.abs(prev_y_coord - current_y_coord) > 1 then
			print("TELEPORTED...ignoring coord.")
		else
			if is_Rtrigger_ButtonBeingPressed() then
				--print("p:"..prev_x_coord .. "," .. prev_y_coord..","..getReadFacingDirectionAsCharString())
				writeCoordsToFile(current_area, prev_x_coord, prev_y_coord, facingDirection)
			end
			
		end
		
		prev_x_coord = current_x_coord
		prev_y_coord = current_y_coord
	end
end

curr_delete_x,curr_delete_y = -1

function markAreaTableCoordsForDeletionAndTurnOff(delete_x,delete_y)
	if curr_delete_x == delete_x then
		if curr_delete_y == delete_y then
			return
		end
	end
	curr_delete_x=delete_x
	curr_delete_y=delete_y

	local line_number_to_delete = -1
	local i=1
	print("deleting "..delete_x..","..delete_y)
	if gCurrentAreaTable ~= nil then
		local number_steps = #gCurrentAreaTable[current_area]
		for i=1,number_steps do
			if tonumber(gCurrentAreaTable[current_area][i][1]) == delete_x then
				if tonumber(gCurrentAreaTable[current_area][i][2]) == delete_y then
					gCurrentAreaTable[current_area][i][3] = "X" -- X's get ignored in draw()
					line_number_to_delete = i
					editCurrentAreaFileMarkXAtLine(line_number_to_delete)
					return 
				end
			end				
		end
		print("...didn't find coord to delete!...")
	end
end

function editCurrentAreaFileMarkXAtLine(line_number_to_delete)
    local hFile = io.open("area_"..current_area .. ".txt", "r") --Reading.
	local lines = {}
	local restOfFile
	local lineCt = 1
	for line in hFile:lines() do
	  if(lineCt == line_number_to_delete) then --Is this the line to modify?
		lines[#lines + 1] = "0,0,X" --Change old line into new line.
		restOfFile = hFile:read("*a")
		break
	  else
		lineCt = lineCt + 1
		lines[#lines + 1] = line
	  end
	end
	hFile:close()

	hFile = io.open("area_"..current_area .. ".txt", "w") --write the file.
	for i, line in ipairs(lines) do
	  hFile:write(line, "\n")
	end
	hFile:write(restOfFile)
	hFile:close()
end

function cleanCurrentAreaFileByRemovingXs()
    local hFile = io.open("area_"..current_area .. ".txt", "r") --Reading.
	local lines = {}
	local restOfFile
	local lineCt = 1
	for line in hFile:lines() do
	  if(line ~= "0,0,X") then --Is this the line to modify?
		lineCt = lineCt + 1
		lines[#lines + 1] = line
	  end
	end
	hFile:close()

	hFile = io.open("area_"..current_area .. ".txt", "w") --write the file.
	for i, line in ipairs(lines) do
	  hFile:write(line, "\n")
	end
	hFile:write(restOfFile)
	hFile:close()
end

function writeCoordsToFile(current_area, prev_x_coord, prev_y_coord, facingDirection)
	local file = io.open("area_"..current_area .. ".txt","a") --create file
	
	file:write(prev_x_coord..","..prev_y_coord..","..facingDirection,"\n")
	file:close()
	
	addNewCoordToActiveAreaTable(prev_x_coord,prev_y_coord,facingDirection)
	--drawOneBox(prev_x_coord,prev_y_coord,"#00FF00")
end

function addNewCoordToActiveAreaTable(x,y,facingDirection)
	if gCurrentAreaStepListSize == -1 then
		gCurrentAreaStepListSize = 0;
	end
	if gCurrentAreaTable ~= nil then 
		if gCurrentAreaTable[current_area] ~= nil then 
			gCurrentAreaTable[current_area][gCurrentAreaStepListSize+1] = {}     -- create a new row
			gCurrentAreaTable[current_area][gCurrentAreaStepListSize+1][1] = x
			gCurrentAreaTable[current_area][gCurrentAreaStepListSize+1][2] = y
			gCurrentAreaTable[current_area][gCurrentAreaStepListSize+1][3] = facingDirection
			
			gCurrentAreaStepListSize = gCurrentAreaStepListSize + 1
		end
	end
end

function readFromAreaFileWriteToAreaTable(current_area)
	print("Reading from area file...")
	
	local numLines
    
	if not file_exists("area_"..current_area .. ".txt") then
		print("file doesnt exist...")
		local file = io.open("area_"..current_area .. ".txt","w") --create file
		
		file:write("0,0,X","\n")
		file:close()
		numLines = 1
	else
		print("file exists...")
		numLines = getNumberOfLinesForAreaFile(current_area)
		 
	end
	
	
	gCurrentAreaStepListSize = numLines
	
	
	print("numLines: "..numLines)
	if numLines ~= 0 then
		initCurrentAreaTable(numLines)
		writeToCurrentAreaTable()
	end
	
	gIsAreaFileLoaded = true
	print("Reading from area file.....Complete.")
end

function file_exists(name)
	local f = io.open(name, "r")
	if f~= nil then io.close(f) return true
	else return false end
end
 

function getNumberOfLinesForAreaFile(current_area)
	local numLines = 0
	local file = io.open("area_"..current_area .. ".txt", "r")
	 
	for _ in file:lines() do
	  numLines = numLines + 1
	end
	file:close() 
	print("#numLines:" ..numLines)
	return numLines
end

function initCurrentAreaTable(numLines)
	gCurrentAreaTable[current_area] = {}
	for i=1,numLines do
		gCurrentAreaTable[current_area][i] = {}     -- create a new row
		for j=1,3 do
			gCurrentAreaTable[current_area][i][j] = 0
		end
    end
end

function writeToCurrentAreaTable()
		print("writeToCurrentAreaTable.....")
		local i=1
		file = io.open("area_"..current_area .. ".txt","r")
		for line in file:lines() do
			
			local x, y = line:match("%d+,%d+")
			x = string.match(line, '[0-9]+')
			y = string.match(line, ',[0-9]+,')
			f = string.sub(line, -1) 
			y = string.gsub(y,",","")
			f = string.gsub(f,",","")
			
			if f ~= "X" then
			-- print("x: " .. x)
			-- print("y: " .. y)
			-- print("f: " .. f)
			 
				gCurrentAreaTable[current_area][i][1] = x
				gCurrentAreaTable[current_area][i][2] = y
				gCurrentAreaTable[current_area][i][3] = f
			end
			
			i = i + 1		
			
		end
		file:close()
		print("writeToCurrentAreaTable....Complete.")
end

function drawAreaSteps(current_area) 
	--print("Starting draw...")
	if gCurrentAreaTable[current_area] == nil then
		return
	end
	local number_steps = #gCurrentAreaTable[current_area]
	--gui.text( 1*0x10,8*0x10+7,"ctr:"..ctr)
	--print("len" .. ctr)
	for i=1,number_steps do
		-- get the screen position
		sx     = memory.readword(0x7e8297)
		sy     = memory.readword(0x7e8299)
		if sx >= 0x8000 then sx = sx-0x10000 end
		if sy >= 0x8000 then sy = sy-0x10000 end
		
		xi     = gCurrentAreaTable[current_area][i][1]
		yi     = gCurrentAreaTable[current_area][i][2]
		
		if gCurrentAreaTable[current_area][i][3] ~= "X" then
			drawOneBox(xi,yi,"#ffff00")
		end
		
	end 
	
	--print("Draw done")
end 

function drawOneBox(xi,yi,color)
	-- get the real x,y position, using the fact that
	-- each square is 0x10 big.
	x,y = 0x10*xi, 0x10*yi
	-- relative coordinates
	rx, ry = x-sx, y-sy
	
	gui.drawbox(rx, ry, rx+0x10, ry+0x10, color) --normal --381E47
	--gui.drawbox(rx, ry-0x12, rx+0x10, ry+0x10-0x0A, color) --my custom box
	
	 
end

function testingShopData()

	local cursorSlot = memory.readbyte(0x7E004B) -- which slot the player is pointing at
    local itemId = memory.readbyte(0x7E9D89 + cursorSlot) -- list of shop items in that list


	local baseShopData = 0xC47AC0
	local blockSizeShopData = 0x09
	local shopId = 0x11
	
	 
	
	--gui.text( 1*0x10,10*0x10+6,"Recording steps..."..memory.readbyte(0xC46AC0 + 0x05 + (0x0E * 132)))--..memory.readword(0x7C30))
	--gui.text( 1*0x10,10*0x10+6,"onscreen debug: "..memory.readbyte(0xC47AC0 + 0x00 + (17 * 0x09)))--..memory.readword(0x7C30))
	--gui.text( 1*0x10,10*0x10+6,"onscreen debug: "..memory.readbyte(0xC47AC0 + 0x00 + (0x2F * 0x09)))--..memory.readword(0x7C30))
	
	--gui.text( 1*0x10,10*0x10+6,"onscreen debug: ".."0x".. string.format("%02X",memory.readbyte(0xC47AC0 + 0x01 + (17 * 0x09))))--..memory.readword(0x7C30))
	--gui.text( 1*0x10,10*0x10+6,"onscreen debug: ".."0x".. string.format("%02X",memory.readbyte(baseShopData + 0x01 + (shopId * blockSizeShopData))))--..memory.readword(0x7C30))
	--gui.text( 1*0x10,10*0x10+6,"onscreen debug: "..items)--..memory.readword(0x7C30))
	--
	local itemName = getitemname(memory.readbyte(baseShopData + 0x01 + (shopId * blockSizeShopData)))
	local itemList = ""
	for i=0,7 do
		item = getitemname(memory.readbyte(baseShopData + i+1 + (shopId * blockSizeShopData)))
		itemList=itemList..item
	end
	
	gui.text( 1*0x10,10*0x10+6,"onscreen debug: "..itemList)
	
end

function printItem()
  print(string.format("%02X",memory.readbyte(0x7E001A))) -- or memory.getregister("a") or equivalent since accumulator currently contains item index
end

os.execute("cls")

memory.registerexecute(0xC04C88,printItem)
--memory.registerexecute(0x0583 ,printItem)

mainLoop()

