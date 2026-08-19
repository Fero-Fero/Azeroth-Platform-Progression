
CREDITS_SCROLL_RATE = 40;
CREDITS_FADE_RATE = 0.4;
--CREDITS_MAX_ALPHA = 0.7;
NUM_CREDITS_ART_TEXTURES_WIDE = 4;
NUM_CREDITS_ART_TEXTURES_HIGH = 2;
CACHE_WAIT_TIME = 0.5;

CreditsArtInfo = {};
CreditsArtInfo[1] = {};
CreditsArtInfo[1][1] = { file="Acrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][2] = { file="Tauren", w=640, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][3] = { file="Centaur", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][4] = { file="HordeBanner", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][5] = { file="Naga", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.4 };
CreditsArtInfo[1][6] = { file="NightsHollow", w=512, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][7] = { file="Ocean", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][8] = { file="Orc", w=256, h=512, offsetx=192, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][9] = { file="Strangle", w=512, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][10] = { file="Troll", w=640, h=512, offsetx=0, offsety=0, maxAlpha=0.6 };
CreditsArtInfo[1][11] = { file="TrollBanner", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][12] = { file="Zepplin", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][13] = { file="drake", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][14] = { file="DwarfCrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][15] = { file="Dwarfhunter", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.6 };
CreditsArtInfo[1][16] = { file="gargoyle", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][17] = { file="NightelfCrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][18] = { file="Nightelves", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][19] = { file="Orccamp", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][20] = { file="DragonIsles", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][21] = { file="tauren_hunter", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][22] = { file="Darnasis", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][23] = { file="ForsakenCrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][24] = { file="ShootingDwarf", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.6 };
CreditsArtInfo[1][25] = { file="Thunderbluff", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][26] = { file="tolbarad", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][27] = { file="TaurenCrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][28] = { file="razorfen", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][29] = { file="swampofsorrows", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][30] = { file="Desolace", w=512, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][31] = { file="SouthernDesolace", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][32] = { file="undeadcrest", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };
CreditsArtInfo[1][33] = { file="TirisfallGlades", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][34] = { file="ThousandNeedles", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][35] = { file="Elemental", w=512, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][36] = { file="Badlands", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][37] = { file="BlastedLands", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][38] = { file="Fellwood", w=768, h=512, offsetx=0, offsety=0, maxAlpha=0.7 };
CreditsArtInfo[1][39] = { file="OrcShield", w=512, h=512, offsetx=128, offsety=0, maxAlpha=0.5 };


function CreditsFrame_OnShow(self)
	CreditsFrame_Update(self);
end

function CreditsFrame_Update(self)
	CreditsScrollFrame:SetVerticalScroll(0);
	CreditsScrollFrame.scroll = 0;
	CreditsScrollFrame.scrollMax = CreditsScrollFrame:GetVerticalScrollRange() + 768;
	self.artCount = getn(CreditsArtInfo[1]);
	self.currentArt = 0;
	self.fadingIn = nil;
	self.fadingOut = nil;
	self.cacheArt = 0;
	self.cacheIndex = 1;
	self.cacheElapsed = 0;
	self.alphaIn = 0;
	self.alphaOut = 0;
	
	for i=1, NUM_CREDITS_ART_TEXTURES_HIGH, 1 do
		for j=1, NUM_CREDITS_ART_TEXTURES_WIDE, 1 do
			_G["CreditsArtAlt"..(((i - 1) * NUM_CREDITS_ART_TEXTURES_WIDE) + j)]:Hide();
			_G["CreditsArtCache"..(((i - 1) * NUM_CREDITS_ART_TEXTURES_WIDE) + j)]:SetAlpha(0.005);
		end
	end

	CreditsFrame_CacheTextures(self, 1);

	-- Set Credits Text
	CreditsText:SetText(GetCreditsText(CreditsFrame.creditsType));
end

function CreditsFrame_Switch(self, buttonID)
	PlaySound("igMainMenuOptionCheckBoxOff");
	CreditsFrame.creditsType = buttonID;
	CreditsFrame_Update(self);
	SetGlueScreen("credits");	
end

function CreditsFrame_SetArtTextures(self,textureName, index, alpha)
	local info = CreditsArtInfo[1][index];
	if ( not info ) then
		return;
	end

	local texture;
	local texIndex = 1;
	local width, height;
	_G[textureName..1]:SetPoint("TOPLEFT", "CreditsFrame", "TOPLEFT", info.offsetx, info.offsety - 128);
	for i=1, NUM_CREDITS_ART_TEXTURES_HIGH, 1 do
		height = info.h - ((i - 1) * 256);
		if ( height > 256 ) then
			height = 256;
		end
		for j=1, NUM_CREDITS_ART_TEXTURES_WIDE, 1 do
			texture = _G[textureName..(((i - 1) * NUM_CREDITS_ART_TEXTURES_WIDE) + j)];
			width = info.w - ((j - 1) * 256);
			if ( width > 256 ) then
				width = 256;
			end
			if ( (width <= 0) or (height <= 0) ) then
				texture:Hide();
			else
				texture:SetTexture("Interface\\Glues\\Credits\\"..info.file..texIndex);
				texture:SetWidth(width);
				texture:SetHeight(height);
				texture:SetAlpha(alpha);
				texture:Show();
				texIndex = texIndex + 1;
			end
		end
	end
end

function CreditsFrame_CacheTextures(self, index)
	self.cacheArt = index;
	self.cacheIndex = 1;
	self.cacheElapsed = 0;

	local info = CreditsArtInfo[1][index];
	if ( not info ) then
		return;
	end

	CreditsArtCache1:SetTexture("Interface\\Glues\\Credits\\"..info.file.."1");
end

function CreditsFrame_UpdateCache(self)
	if ( self.cacheIndex >= (NUM_CREDITS_ART_TEXTURES_WIDE * NUM_CREDITS_ART_TEXTURES_HIGH) ) then
		return;
	end
	if ( self.cacheElapsed < CACHE_WAIT_TIME ) then
		return;
	end

	self.cacheElapsed = self.cacheElapsed - CACHE_WAIT_TIME;
	self.cacheIndex = self.cacheIndex + 1;

	local info = CreditsArtInfo[1][self.cacheArt];
	if ( not info ) then
		return;
	end

	_G["CreditsArtCache"..self.cacheIndex]:SetTexture("Interface\\Glues\\Credits\\"..info.file..self.cacheIndex);
end

function CreditsFrame_UpdateArt(self, index, elapsed)
	if (index > (self.currentArt + 1) ) then
		return;
	end

	if ( index == self.currentArt ) then
		if ( self.fadingOut ) then
			self.alphaOut = max(self.alphaOut - (CREDITS_FADE_RATE * elapsed), 0);

			for i=1, NUM_CREDITS_ART_TEXTURES_HIGH, 1 do
				for j=1, NUM_CREDITS_ART_TEXTURES_WIDE, 1 do
					_G["CreditsArtAlt"..(((i - 1) * NUM_CREDITS_ART_TEXTURES_WIDE) + j)]:SetAlpha(self.alphaOut);
				end
			end

			if ( self.alphaOut <= 0 ) then
				self.fadingOut = nil;
				CreditsFrame_CacheTextures(self, self.currentArt + 1);
			end
		end

		if ( self.fadingIn ) then
			local maxAlpha = CreditsArtInfo[1][self.currentArt].maxAlpha;
			self.alphaIn = min(self.alphaIn + (CREDITS_FADE_RATE * elapsed), maxAlpha);
			for i=1, NUM_CREDITS_ART_TEXTURES_HIGH, 1 do
				for j=1, NUM_CREDITS_ART_TEXTURES_WIDE, 1 do
					_G["CreditsArt"..(((i - 1) * NUM_CREDITS_ART_TEXTURES_WIDE) + j)]:SetAlpha(self.alphaIn);
				end
			end

			if ( self.alphaIn >= maxAlpha ) then
				self.fadingIn = nil;
			end
		end
		return;
	end

	if ( self.currentArt > 0 ) then
		self.fadingOut = 1;
		self.alphaOut = CreditsArtInfo[1][self.currentArt].maxAlpha;
		CreditsFrame_SetArtTextures(self, "CreditsArtAlt", self.currentArt, self.alphaOut);
	end

	self.fadingIn = 1;
	self.alphaIn = 0;
	self.currentArt = index;
	CreditsFrame_SetArtTextures(self, "CreditsArt", index, self.alphaIn);
end

function CreditsFrame_OnUpdate(self, elapsed)
	if ( not CreditsScrollFrame:IsShown() ) then
		return;
	end

	CreditsScrollFrame.scroll = CreditsScrollFrame.scroll + (CREDITS_SCROLL_RATE * elapsed);
	if ( CreditsScrollFrame.scroll >= CreditsScrollFrame.scrollMax ) then
		SetGlueScreen("login");
		return;
	end

	self.cacheElapsed = self.cacheElapsed + elapsed;
	CreditsFrame_UpdateCache(self);

	CreditsScrollFrame:SetVerticalScroll(CreditsScrollFrame.scroll);
	CreditsFrame_UpdateArt(self, ceil(self.artCount * (CreditsScrollFrame.scroll / CreditsScrollFrame.scrollMax)), elapsed);
end

function CreditsFrame_OnScrollRangeChanged()
	CreditsScrollFrame.scrollMax = CreditsScrollFrame:GetVerticalScrollRange() + 768;
end

function CreditsFrame_OnKeyDown(key)
	if ( key == "ESCAPE" ) then
		SetGlueScreen("login");
	elseif ( key == "PRINTSCREEN" ) then
		Screenshot();
	end
end
