/*
Function:
	A3A_fnc_punishment_FF_checkNearHQ

Description:
	Checks if grenade or explosive created near Petros. Punishes accordingly.

Scope:
	<LOCAL> Execute on player you wish to check for FF.

Environment:
	<ANY>

Parameters:
	<OBJECT> Player that created grenade or explosive.
	<STRING> Weapon that created projectile.
	<OBJECT> Projectile.

Returns:
	<BOOLEAN> true if it hasn't crashed; false if not near HQ; nil if it has crashed.

Examples Vanilla:
	private _EH_fired = {
		params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		[_unit,_weapon,_projectile] call A3A_fnc_punishment_FF_checkNearHQ;
	};
	player addEventHandler ["Fired", _EH_fired];

Examples ACE:
	private _EH_ace_explosives_place = {
		params ["_explosive","_dir","_pitch","_unit"];
		[_unit,"Put",_explosive] call A3A_fnc_punishment_FF_checkNearHQ;
	};
	["ace_explosives_place", _EH_ace_explosives_place] call CBA_fnc_addEventHandler;

Author: Caleb Serafin
Date Updated: 28 May 2020
License: MIT License, Copyright (c) 2019 Barbolani & The Official AntiStasi Community
*/
params ["_unit","_weapon","_projectile"];
private _fileName = "fn_punishment_FF_checkNearHQ.sqf";

if !(_weapon in ["Put","Throw"]) exitWith {false};
private _distancePetros = _unit distance petros;
if !(_distancePetros <= 100) exitWith {false};

deleteVehicle _projectile;
if (_distancePetros < 10) then {
	[_unit, 60, 0.4, objNull] call A3A_fnc_punishment_FF; // Call to override hint later.
};
["FF Warning", "You cannot throw grenades or place explosives within 100m of base."] call A3A_fnc_customHint;
[2, format ["EXPLOSIVE DISCHARGE HQ | %1 [%2] distance from Petros: %3", name _unit, getPlayerUID _unit, _distancePetros], _filename] call A3A_fnc_log;
true;