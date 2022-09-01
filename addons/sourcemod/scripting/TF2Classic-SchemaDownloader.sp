#include <sdktools>
#include <sourcemod>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "TF2Classic Schema Downloader",
	author = "azzy",
	version = "1.0"
}

public void OnMapStart()
{
	char MapName[PLATFORM_MAX_PATH], ItemSchemaPath[PLATFORM_MAX_PATH], SoundScriptPath[PLATFORM_MAX_PATH], ParticleScriptPath[PLATFORM_MAX_PATH];

	GetCurrentMap(MapName, sizeof(MapName));

	if(Format(ItemSchemaPath, sizeof(ItemSchemaPath), "maps/%s_items_game.txt", MapName))
	{
		Load(ItemSchemaPath);
		PrintToServer("[TF2Classic Schema Downloader] Item Schema for map %s added to Downloads Table", MapName);
	} 

	if(Format(SoundScriptPath, sizeof(SoundScriptPath), "maps/%s_level_sounds.txt", MapName))
	{
		Load(SoundScriptPath);
		PrintToServer("[TF2Classic Schema Downloader] Sound Script for map %s added to Downloads Table", MapName);
	} 

	if(Format(ParticleScriptPath, sizeof(ParticleScriptPath), "maps/%s_particles.txt", MapName))
	{
		Load(ParticleScriptPath);
		PrintToServer("[TF2Classic Schema Downloader] Particle Script for map %s added to Downloads Table", MapName);
	}
}

void Load(const char[] path)
{
	PrecacheGeneric(path, true);
	AddFileToDownloadsTable(path);
}
