--STEAM_0:0:118287139 self:GetValue()

--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
--████████████████████████████████████████████████SERVER SIDE█████████████████████████████████████████████████████████
--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████


if SERVER then

	include('whitelist_config.lua')

	local line
	local list
	local i = 1

	print( "Инициализая скрипта завершена......." )
	function Vehicle_Entering( ply, vehicle, role )

		--print(ply:GetEyeTrace().Entity:GetClass())
		list = file.Open( "timan_data/anti_veh_data.txt", "r", "DATA" )
		FIND_NICK = false
		for i = 1, 100 do
			line = list:ReadLine()
			if line == nil then
				line = ""
			end
			if string.find( line, ply:SteamID() .. " => " ..  ply:GetEyeTrace().Entity:GetClass() ) ~= nil then
				FIND_NICK = true
				break
			else
				if FIND_NICK ~= true then
					FIND_NICK = false
				end
			end
		end
		list:Close()
		for i = 1,#vehicle_list do
			if ply:GetEyeTrace().Entity:GetClass() == vehicle_list[i] then
				if FIND_NICK ~= true then return false end
			end
		end
	end 
	hook.Add( "CanPlayerEnterVehicle", "Vehicle_Entering", Vehicle_Entering )
end



--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
--████████████████████████████████████████████████CLIENT SIDE█████████████████████████████████████████████████████████
--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

if CLIENT then
	include('whitelist_config.lua')

	surface.CreateFont('info', {
	font = 'Noto Sans',
	size = 15,
	weight = 15
	} )

	hook.Add( "PlayerButtonDown", "keypress_AntiVeh", function( ply, button )
	if ( button == KEY_F6 ) then

		local PlayerArray = {}
	 	local PlayerCounter, i, Global_Index, press = 1
	 	local PlyVeh, PlyVeh_Add
	 	local Veh, Veh_Add

		local FrameAntiVeh = vgui.Create( "DFrame" )
		FrameAntiVeh:SetPos((ScrW() / 2) - (ScrW() / 4), (ScrH() / 2) - (ScrW() / 8) )
		FrameAntiVeh:SetSize(ScrW() / 2, ScrH() / 2)
		FrameAntiVeh:SetTitle( "" )
		FrameAntiVeh:SetVisible( true )
		FrameAntiVeh:SetDraggable( true )
		FrameAntiVeh:ShowCloseButton( false )
		FrameAntiVeh:MakePopup()

		function FrameAntiVeh:Init()
			self.startTime = SysTime()
		end

		function FrameAntiVeh:Paint()
			Derma_DrawBackgroundBlur( self, self.startTime )
			draw.RoundedBox( 8, 0, 0, FrameAntiVeh:GetWide(), FrameAntiVeh:GetTall(), Color( 250, 250, 250, 255 ) )
			draw.RoundedBox( 8, 0, 20, FrameAntiVeh:GetWide(), 2, Color( 102, 102, 102, 255 ) )
		end	


		local DermaButton = vgui.Create( "DButton", FrameAntiVeh )
		DermaButton:SetText( "" )
		DermaButton:SetPos( FrameAntiVeh:GetWide() - 50, 0 )
		DermaButton:SetSize( 50, 20 )

		function DermaButton:Paint()
			draw.RoundedBox( 4, 0, 0, DermaButton:GetWide(), DermaButton:GetTall(), Color( 204, 0, 0, 255 ) )
			draw.RoundedBox( 0, 0, 5, DermaButton:GetWide(), 15, Color( 204, 0, 0, 255 ) )
		end	

		DermaButton.DoClick = function()
			FrameAntiVeh:Close()
		end

		press = 1
		
		local DermaButton_VehWitelist = vgui.Create( "DButton", FrameAntiVeh )
		DermaButton_VehWitelist:SetText( "" )
		DermaButton_VehWitelist:SetPos( 0, 20 )
		DermaButton_VehWitelist:SetSize( 100, 20 )

		DermaButton_VehWitelist.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, DermaButton_VehWitelist:GetWide(), DermaButton_VehWitelist:GetTall(), Color( 250, 250, 250, 255 ) )
			draw.RoundedBox( 0, 0, 0, DermaButton_VehWitelist:GetWide(), 15, Color( 250, 250, 250, 255 ) )

			if press ~= 1 then
				draw.RoundedBox( 0, 0, 0, DermaButton_VehWitelist:GetWide(), 2, Color( 102, 102, 102, 255 ) )
			end

			draw.RoundedBox( 0, 0, 18, DermaButton_VehWitelist:GetWide(), 2, Color( 102, 102, 102, 255 ) )
			--draw.RoundedBox( 0, 0, 0, 2, DermaButton_VehWitelist:GetTall(), Color( 102, 102, 102, 255 ) )
			draw.RoundedBox( 0, 98, 0, 2, DermaButton_VehWitelist:GetTall(), Color( 102, 102, 102, 255 ) )

			draw.SimpleText( "Техника", "info", w / 2,  h / 2.0, Color( 102, 102, 102 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end	

		DermaButton_VehWitelist.DoClick = function()
			press = 1
		end

		local DermaButton_JobsWitelist = vgui.Create( "DButton", FrameAntiVeh )
		DermaButton_JobsWitelist:SetText( "" )
		DermaButton_JobsWitelist:SetPos( 102, 20 )
		DermaButton_JobsWitelist:SetSize( 100, 20 )
		
		DermaButton_JobsWitelist.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, DermaButton_JobsWitelist:GetWide(), DermaButton_JobsWitelist:GetTall(), Color( 250, 250, 250, 255 ) )
			draw.RoundedBox( 0, 0, 0, DermaButton_JobsWitelist:GetWide(), 15, Color( 250, 250, 250, 255 ) )


			draw.RoundedBox( 0, 0, 18, DermaButton_JobsWitelist:GetWide(), 2, Color( 102, 102, 102, 255 ) )
			if press ~= 2 then
				draw.RoundedBox( 0, 0, 0, DermaButton_JobsWitelist:GetWide(), 2, Color( 102, 102, 102, 255 ) )
			end	
			draw.RoundedBox( 0, 0, 0, 2, DermaButton_JobsWitelist:GetTall(), Color( 102, 102, 102, 255 ) )
			draw.RoundedBox( 0, 98, 0, 2, DermaButton_JobsWitelist:GetTall(), Color( 102, 102, 102, 255 ) )

			draw.SimpleText( "Профы", "info", w / 2,  h / 2.0, Color( 102, 102, 102 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end	

		DermaButton_JobsWitelist.DoClick = function()
			press = 2
		end

		--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████





		local ComboBoxPlyAdd = vgui.Create( "DComboBox", FrameAntiVeh )
		ComboBoxPlyAdd:SetPos( 0, (FrameAntiVeh:GetTall() / 2) - 100)
		ComboBoxPlyAdd:SetSize( FrameAntiVeh:GetWide(), 25 )
		ComboBoxPlyAdd:SetValue( lang_text[1] )
		PlayerCounter = 1
		for k,v in pairs(player.GetAll()) do
			ComboBoxPlyAdd:AddChoice( v:Nick() )
			PlayerArray[PlayerCounter] = v:SteamID()
			PlayerCounter = PlayerCounter + 1
		end
		ComboBoxPlyAdd.OnSelect = function( self, index, value )
			PlyVeh_Add = PlayerArray[index]
			Global_Index = index
			
		end

		local ComboBoxVehAdd = vgui.Create( "DComboBox", FrameAntiVeh )
		ComboBoxVehAdd:SetPos( 0, (FrameAntiVeh:GetTall() / 2) - 70)
		ComboBoxVehAdd:SetSize( FrameAntiVeh:GetWide(), 25 )
		ComboBoxVehAdd:SetValue( lang_text[2])

		
		for i = 1,#vehicle_list_name do
			ComboBoxVehAdd:AddChoice( vehicle_list_name[i] )
		end
		ComboBoxVehAdd.OnSelect = function( self, index, value )
			Veh_Add = vehicle_list[index]
			
		end

		local ButtonAdd = vgui.Create( "DButton", FrameAntiVeh )
		ButtonAdd:SetText( "" )
		ButtonAdd:SetPos( (FrameAntiVeh:GetWide() / 2) - 100, (FrameAntiVeh:GetTall() / 2) - 40)
		ButtonAdd:SetSize( 200, 25 )

		ButtonAdd.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, ButtonAdd:GetWide(), ButtonAdd:GetTall(), Color( 0, 230, 0, 255 ) )
			draw.SimpleText( lang_text[3], "info", w / 2,  h / 2.0, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		ButtonAdd.DoClick = function()
			if string.find( file.Read("timan_data/anti_veh_data.txt"), PlayerArray[Global_Index] .. " => " .. Veh_Add) == nil then
				file.Write("timan_data/anti_veh_data.txt",file.Read("timan_data/anti_veh_data.txt") .. "\n" .. PlayerArray[Global_Index] .. " => " .. Veh_Add) 
			end

		end




		--████████████████████████████████████████████████████████████████████████████████████████████████████████████████████




		local ComboBoxPlyDelete = vgui.Create( "DComboBox", FrameAntiVeh )
		ComboBoxPlyDelete:SetPos( 0, (FrameAntiVeh:GetTall() / 2))
		ComboBoxPlyDelete:SetSize( FrameAntiVeh:GetWide(), 25 )
		ComboBoxPlyDelete:SetValue( lang_text[1] )
		PlayerCounter = 1
		for k,v in pairs(player.GetAll()) do
			ComboBoxPlyDelete:AddChoice( v:Nick() )
			PlayerArray[PlayerCounter] = v:SteamID()
			PlayerCounter = PlayerCounter + 1
		end
		ComboBoxPlyDelete.OnSelect = function( self, index, value )
			PlyVeh_Delete = PlayerArray[index]
			Global_Index = index
			
		end

		local ComboBoxVehDelete = vgui.Create( "DComboBox", FrameAntiVeh )
		ComboBoxVehDelete:SetPos( 0, (FrameAntiVeh:GetTall() / 2) + 30)
		ComboBoxVehDelete:SetSize( FrameAntiVeh:GetWide(), 25 )
		ComboBoxVehDelete:SetValue( lang_text[2] )

		
		for i = 1,#vehicle_list_name do
			ComboBoxVehDelete:AddChoice( vehicle_list_name[i] )
		end
		ComboBoxVehDelete.OnSelect = function( self, index, value )
			Veh_Delete = vehicle_list[index]
			
		end

		local ButtonDelete = vgui.Create( "DButton", FrameAntiVeh )
		ButtonDelete:SetText( "" )
		ButtonDelete:SetPos( (FrameAntiVeh:GetWide() / 2) - 100, (FrameAntiVeh:GetTall() / 2) + 60)
		ButtonDelete:SetSize( 200, 25 )

		ButtonDelete.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, ButtonDelete:GetWide(), ButtonDelete:GetTall(), Color( 230, 0, 0, 255 ) )
			draw.SimpleText( lang_text[4], "info", w / 2,  h / 2.0, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		ButtonDelete.DoClick = function()
			if string.find( file.Read("timan_data/anti_veh_data.txt"), PlayerArray[Global_Index] .. " => " .. Veh_Delete) ~= nil then
				file.Write("timan_data/anti_veh_data.txt", string.Replace(file.Read("timan_data/anti_veh_data.txt"), "\n" .. PlayerArray[Global_Index] .. " => " .. Veh_Delete, ""))
			end

		end


	end
	end )



end


	
