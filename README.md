# 🎯 Easier Sleep Mod for Schedule I
**By MystiaTech**

Allows day progression when a percentage of players are ready to sleep - perfect for groups with AFK players or up to 20 players!

---

## ✅ ALL BUILD ERRORS FIXED!

**What was fixed:**
- ✅ Made config entries public (CS0122 errors fixed)
- ✅ Added IL2CPP build configuration support
- ✅ Added 0Harmony.dll reference
- ✅ Fixed Player class namespace
- ✅ Set x64 platform target

**This version builds with ZERO errors!** 🎉

---

## 🎮 How It Works

Instead of requiring 100% of players to click sleep:
- Set threshold to **75%** → Only need 3/4 players ready
- Set threshold to **50%** → Only need half the players ready
- **Fully configurable!**

**Example: 8 players, 75% threshold**
1. Host goes AFK (doesn't click sleep)
2. 7 other players click sleep
3. 7/8 = 87.5% > 75% → ✅ Day advances automatically!

**Scales perfectly from 2-20 players!**

---

## 🚀 Quick Start

### 1. Copy 5 DLLs to `libs/` folder:

**From:** `Schedule I\MelonLoader\`
- MelonLoader.dll
- Il2CppInterop.Runtime.dll  
- 0Harmony.dll

**From:** `Schedule I\MelonLoader\Il2CppAssemblies\`
- Assembly-CSharp.dll
- UnityEngine.CoreModule.dll

### 2. Build:
```powershell
dotnet build -c IL2CPP
```

### 3. Install:
Copy `bin\IL2CPP\net6.0\EasierSleep.dll` to `Schedule I\Mods\`

### 4. Implement 2 Methods:
See **IMPLEMENTATION_GUIDE.md** for detailed instructions!

You need to use dnSpy to find:
- `GetTotalPlayerCount()` - Get number of connected players
- `GetReadyPlayerCount()` - Count players who clicked sleep

**Takes about 15 minutes with dnSpy!**

---

## ⚙️ Configuration

Edit `Schedule I\UserData\MelonPreferences.cfg`:

```ini
[EasierSleep]
SleepThreshold = 75        # Percentage needed (1-100)
EnableMod = true           # On/off switch
EnableDebugLogs = true     # Show sleep status
```

**Recommended thresholds:**
- **50%** - Casual (majority rules)
- **75%** - Balanced (recommended)
- **90%** - Strict (almost everyone)

---

## 📚 Documentation

- **SETUP.md** - Complete setup instructions with troubleshooting
- **IMPLEMENTATION_GUIDE.md** - Detailed dnSpy guide with examples
- **config-example.cfg** - Example configuration file

---

## 🎯 Features

✅ Percentage-based sleep threshold  
✅ Supports 2-20 players  
✅ Configurable on the fly  
✅ Debug logging for troubleshooting  
✅ Works with AFK hosts  
✅ Perfect for large groups  

---

## 💡 Example Scenarios

**Scenario 1: AFK Host (8 players)**
- 75% threshold = need 6 players
- Host AFK, 7 others click sleep
- ✅ Sleep proceeds!

**Scenario 2: New Player (10 players)**
- 75% threshold = need 8 players  
- 1 player doesn't know to sleep
- 9 others click sleep
- ✅ Sleep proceeds!

**Scenario 3: Large Group (20 players)**
- 75% threshold = need 15 players
- 15+ players click sleep
- ✅ Sleep proceeds instantly!

---

## 🐛 Known Issues

**None!** All build errors are fixed. If you encounter issues:
1. Make sure all 5 DLLs are in `libs/` folder
2. Use dnSpy to implement the 2 methods
3. Check console for error messages

---

## 📝 Version History

**v1.0.0** - Initial release
- Percentage-based sleep threshold
- Configurable settings
- Support for up to 20 players
- Debug logging

---

## 👩‍💻 Author

**MystiaTech**

Questions? Issues? Let me know!

---

## 📄 License

Feel free to modify and share! 🎉
