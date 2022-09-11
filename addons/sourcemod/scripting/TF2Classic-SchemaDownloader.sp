#include <sdktools>
#include <sourcemod>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "TF2Classic Schema Downloader",
	author = "azzy",
	version = "1.1"
}

public void OnMapStart()
{
	char MapName[PLATFORM_MAX_PATH], ItemSchemaPath[PLATFORM_MAX_PATH], SoundScriptPath[PLATFORM_MAX_PATH], ParticleScriptPath[PLATFORM_MAX_PATH];

	GetCurrentMap(MapName, sizeof(MapName));
	Format(ItemSchemaPath, sizeof(ItemSchemaPath), "maps/%s_items_game.txt", MapName);
	Format(SoundScriptPath, sizeof(SoundScriptPath), "maps/%s_level_sounds.txt", MapName);
	Format(ParticleScriptPath, sizeof(ParticleScriptPath), "maps/%s_particles.txt", MapName);

	if(FileExists(ItemSchemaPath, true, NULL_STRING))
	{
		Load(ItemSchemaPath);
		PrintToServer("[TF2Classic Schema Downloader] Item Schema for map %s added to Downloads Table", MapName);
	} 

	if(FileExists(SoundScriptPath, true, NULL_STRING))
	{
		Load(SoundScriptPath);
		PrintToServer("[TF2Classic Schema Downloader] Sound Script for map %s added to Downloads Table", MapName);
	} 

	if(FileExists(ParticleScriptPath, true, NULL_STRING))
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

