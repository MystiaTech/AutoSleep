using MelonLoader;
using HarmonyLib;
using UnityEngine;

#if MONO
using ScheduleOne.PlayerScripts;
#else
using Il2CppScheduleOne.PlayerScripts;
#endif

[assembly: MelonInfo(typeof(EasierSleepMod.EasierSleep), "EasierSleep", "1.0.0", "MystiaTech")]
[assembly: MelonGame("TVGS", "Schedule I")]

namespace EasierSleepMod
{
    /// <summary>
    /// Easier Sleep Mod - Allows day progression when a percentage of players are ready to sleep.
    /// Perfect for groups up to 20 players where not everyone needs to be ready!
    /// </summary>
    public class EasierSleep : MelonMod
    {
        // Config - PUBLIC so Harmony patch can access
        private static MelonPreferences_Category configCategory;
        public static MelonPreferences_Entry<int> sleepThresholdEntry;
        public static MelonPreferences_Entry<bool> enableModEntry;
        public static MelonPreferences_Entry<bool> enableDebugLogsEntry;
        
        public override void OnInitializeMelon()
        {
            LoggerInstance.Msg("EasierSleep mod initializing! 🛏️");
            
            // Create config
            configCategory = MelonPreferences.CreateCategory("EasierSleep", "Easier Sleep Settings");
            
            sleepThresholdEntry = configCategory.CreateEntry(
                "SleepThreshold", 
                75, 
                "Sleep Threshold (%)",
                "Percentage of players needed to sleep. 75 = 75% of players must click sleep to advance. Range: 1-100"
            );
            
            enableModEntry = configCategory.CreateEntry(
                "EnableMod",
                true,
                "Enable Mod",
                "If false, mod does nothing and requires 100% of players."
            );
            
            enableDebugLogsEntry = configCategory.CreateEntry(
                "EnableDebugLogs",
                true,
                "Enable Debug Logs",
                "Show detailed logging for troubleshooting"
            );
            
            LoggerInstance.Msg("✅ Config loaded!");
            LoggerInstance.Msg($"   Sleep Threshold: {sleepThresholdEntry.Value}%");
            LoggerInstance.Msg($"   Mod Enabled: {enableModEntry.Value}");
        }
    }
    
    // ========================================================================
    // HARMONY PATCH - This intercepts the game's sleep check!
    // ========================================================================
    
    [HarmonyPatch(typeof(Player), "AreAllPlayersReadyToSleep")]
    public static class SleepCheckPatch
    {
        public static void Postfix(ref bool __result)
        {
            // Skip if mod is disabled
            if (!EasierSleep.enableModEntry.Value)
                return;
            
            // If already true (everyone naturally ready), don't interfere
            if (__result)
            {
                if (EasierSleep.enableDebugLogsEntry.Value)
                {
                    MelonLogger.Msg("✅ All players naturally ready to sleep!");
                }
                return;
            }
            
            // Game says NOT everyone is ready - check if threshold is met
            try
            {
                int totalPlayers = GetTotalPlayerCount();
                int readyPlayers = GetReadyPlayerCount();
                
                if (totalPlayers == 0)
                {
                    // No players detected, don't interfere
                    return;
                }
                
                float percentage = (readyPlayers * 100f) / totalPlayers;
                int threshold = EasierSleep.sleepThresholdEntry.Value;
                
                if (EasierSleep.enableDebugLogsEntry.Value)
                {
                    MelonLogger.Msg($"💤 Sleep Check: {readyPlayers}/{totalPlayers} ready ({percentage:F1}%) - Need: {threshold}%");
                }
                
                // Check if threshold is met
                if (percentage >= threshold)
                {
                    MelonLogger.Msg($"🎉 Threshold met! {readyPlayers}/{totalPlayers} ready ({percentage:F1}%) - Allowing sleep!");
                    __result = true; // Override! Force sleep to proceed!
                }
                else
                {
                    if (EasierSleep.enableDebugLogsEntry.Value)
                    {
                        int needed = Mathf.CeilToInt((threshold / 100f) * totalPlayers);
                        int more = needed - readyPlayers;
                        MelonLogger.Msg($"⏳ Need {more} more player(s) to sleep ({needed} total)");
                    }
                }
            }
            catch (System.Exception ex)
            {
                MelonLogger.Error($"Error in sleep check: {ex.Message}");
            }
        }
        
        // ====================================================================
        // IMPLEMENTED USING GAME'S OWN CODE!
        // Found by reverse engineering AreAllPlayersReadyToSleep()
        // ====================================================================
        
        private static int GetTotalPlayerCount()
        {
            // From the game's code: Player.PlayerList is a static list
            if (Player.PlayerList == null || Player.PlayerList.Count == 0)
            {
                return 0;
            }
            
            return Player.PlayerList.Count;
        }
        
        private static int GetReadyPlayerCount()
        {
            // From the game's code: Loop through Player.PlayerList and check IsReadyToSleep
            if (Player.PlayerList == null || Player.PlayerList.Count == 0)
            {
                return 0;
            }
            
            int count = 0;
            for (int i = 0; i < Player.PlayerList.Count; i++)
            {
                // Null check (game does this too)
                if (Player.PlayerList[i] != null && Player.PlayerList[i].IsReadyToSleep)
                {
                    count++;
                }
            }
            
            return count;
        }
    }
}
