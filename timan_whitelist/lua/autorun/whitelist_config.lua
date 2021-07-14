--[[------------------------------------------------------

НАСТРОЙКА СКРИТПА:
lang - выбор языка. Доступно - RU, EN
vehicle_list - массив техники, на которую будет работать вайтлист
vehicle_list_name - массив названиq техники в F6. Название должно быть схоже с техникой, которую вы ввели в vehicle_list.
ПРИМЕР:
vehicle_list = {"lunasflightschool_arc170", "lunasflightschool_iftx"} - вайтлист на ЭРК170 и IFTX
соответсвнно:
vehicle_list_name = {"ARC170", "IFTx"} - первый ARC170, так как он первый в массиве vehicle_list, и второй IFTx, так как он второй в vehicle_list

----------------------------------------------------------

SCRIPT CONFIGURATION:
lang - language selection. Available - RU, EN
vehicle_list - an array of vehicles for which the whitelist will work
vehicle_list_name - array of vehicle names in F6. The name should be similar to the vehicle you entered in vehicle_list.
EXAMPLE:
vehicle_list = {"lunasflightschool_arc170", "lunasflightschool_iftx"} - whitelist for ERK170 and IFTX
respectively:
vehicle_list_name = {"ARC170", "IFTx"} - the first ARC170, since it is the first in the vehicle_list array, and the second IFTx, since it is the second in vehicle_list

--------------------------------------------------------]]




lang = "RU"

vehicle_list = {"lunasflightschool_arc170", "lunasflightschool_iftx"}
vehicle_list_name = {"ARC170", "IFTx"}

if lang == "RU" then
	lang_text = {
		"Выбрать игрока",
		"Выбрать технику",
		"Выдать доступ",
		"Забрать доступ",
	}
elseif lang == "EN" then
	lang_text = {
		"Select a player",
		"Select a vehicle",
		"Grant access",
		"Take back access",
	}
end