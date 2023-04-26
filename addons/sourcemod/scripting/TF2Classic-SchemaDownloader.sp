#include <sdktools>
#include <sourcemod>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "TF2Classic Schema Downloader",
	author = "azzy",
	version = "1.3"
}

Handle UseValveFs;

public void OnPluginStart()
{
	UseValveFs = CreateConVar("sm_schemadownloader_mode", "0", "0 = only search for files inside gamedir. 1 = search for files inside any mounted path");
}

public void OnMapStart()
{
	char MapName[PLATFORM_MAX_PATH], ItemSchemaPath[PLATFORM_MAX_PATH], SoundScriptPath[PLATFORM_MAX_PATH], ParticleScriptPath[PLATFORM_MAX_PATH];

	GetCurrentMap(MapName, sizeof(MapName));
	Format(ItemSchemaPath, sizeof(ItemSchemaPath), "maps/%s_items_game.txt", MapName);
	Format(SoundScriptPath, sizeof(SoundScriptPath), "maps/%s_level_sounds.txt", MapName);
	Format(ParticleScriptPath, sizeof(ParticleScriptPath), "maps/%s_particles.txt", MapName);

	if(FileExists(ItemSchemaPath, GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load(ItemSchemaPath);
		PrintToServer("[TF2Classic Schema Downloader] Item Schema for map %s added to Downloads Table", MapName);
	}
	else if(FileExists("maps/custom_items_game.txt", GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load("maps/custom_items_game.txt");
		PrintToServer("[TF2Classic Schema Downloader] Global Item Schema added to Downloads Table", MapName);
	} 

	if(FileExists(SoundScriptPath, GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load(SoundScriptPath);
		PrintToServer("[TF2Classic Schema Downloader] Sound Script for map %s added to Downloads Table", MapName);
	}
	else if(FileExists("maps/custom_level_sounds.txt", GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load("maps/custom_level_sounds.txt");
		PrintToServer("[TF2Classic Schema Downloader] Global Sound Script added to Downloads Table", MapName);
	}

	if(FileExists(ParticleScriptPath, GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load(ParticleScriptPath);
		PrintToServer("[TF2Classic Schema Downloader] Particle Script for map %s added to Downloads Table", MapName);
	}
	else if(FileExists("maps/custom_particles.txt", GetConVarBool(UseValveFs), NULL_STRING))
	{
		Load("maps/custom_particles.txt");
		PrintToServer("[TF2Classic Schema Downloader] Global Particle Script added to Downloads Table", MapName);
	}
}

void Load(const char[] path)
{
	PrecacheGeneric(path, true);
	AddFileToDownloadsTable(path);
}
