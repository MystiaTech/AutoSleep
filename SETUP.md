# ✅ READY TO USE - Auto-Sleep Mod (FIXED!)

## 🔧 What Was Fixed:
1. ✅ Added `0Harmony.dll` reference (was missing!)
2. ✅ Fixed class name: `Player` (not `PlayerScripts`)
3. ✅ Set platform target to x64 (fixes architecture warning)

**The mod is now ready to build and use!**

---

## 🚀 Quick Setup (3 Steps)

### Step 1: Copy DLLs to `libs/` folder

Copy these **5 files** from your game installation:

**From:** `C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\`
- `MelonLoader.dll`
- `Il2CppInterop.Runtime.dll`
- `0Harmony.dll` ⚠️ **DON'T FORGET THIS ONE!**

**From:** `C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\Il2CppAssemblies\`
- `Assembly-CSharp.dll`
- `UnityEngine.CoreModule.dll`

Your folder structure should look like:
```
AutoSleepMod/
├── AutoSleep.cs
├── AutoSleep.csproj
├── QUICKSTART.md
└── libs/
    ├── MelonLoader.dll
    ├── Il2CppInterop.Runtime.dll
    ├── 0Harmony.dll          ⬅️ NEW!
    ├── Assembly-CSharp.dll
    └── UnityEngine.CoreModule.dll
```

### Step 2: Build

Open PowerShell in the `AutoSleepMod` folder and run:

```powershell
dotnet build -c IL2CPP
```

**OR:**

```powershell
dotnet build -c Release
```

Both work! You should see:
```
Build succeeded.
    0 Warning(s)
    0 Error(s)
```

The DLL will be at: `bin\IL2CPP\net6.0\EasierSleep.dll`  
(or `bin\Release\net6.0\EasierSleep.dll` if you used Release)

### Step 3: Install

Copy `bin\Release\net6.0\AutoSleep.dll` to:
```
C:\Program Files (x86)\Steam\steamapps\common\Schedule I\Mods\
```

**DONE!** 🎉

---

## 🎮 Testing

1. **Launch Schedule I**
2. **Check console for:**
   ```
   AutoSleep mod initializing! 🛏️
   ✅ Config loaded!
      Auto Sleep Delay: 5 minutes
      Auto Sleep Enabled: True
   ```

3. **Play until 4AM** (time will freeze)

4. **You should see:**
   ```
   ⏰ Detected sleep check! Timer started...
   ⏳ Time until auto-sleep: 4.5 minutes
   ⏳ Time until auto-sleep: 4.0 minutes
   ...
   💤 Timer expired! Forcing sleep to proceed...
   ```

5. **Day advances automatically!** ✨

---

## ⚙️ Configuration

Edit: `Schedule I\UserData\MelonPreferences.cfg`

Find `[AutoSleep]` section:

```ini
[AutoSleep]
AutoSleepDelay = 5.0      # Minutes to wait (change this!)
EnableAutoSleep = true     # On/off switch
EnableDebugLogs = true     # Show countdown messages
```

**Recommended for testing:** Set to `1.0` for faster testing!

---

## 🧪 Multiplayer Test

1. Join multiplayer with a friend
2. Wait until 4AM
3. **You (host) DON'T get in bed** (go AFK)
4. **Friend gets in bed**
5. Wait 5 minutes (or whatever you set)
6. **Day advances even though you're AFK!** 🎉

---

## ❓ Troubleshooting

**Build errors about "0Harmony not found":**
- Make sure you copied `0Harmony.dll` to `libs/` folder!
- It's in the same folder as `MelonLoader.dll`

**Build errors about "PlayerScripts is a namespace":**
- Already fixed! The patch now correctly targets `Player` class

**Architecture mismatch warning:**
- Already fixed! Project now targets x64 architecture

**Mod loads but timer never starts:**
- Make sure you reach 4AM and see the game freeze
- Check for "Detected sleep check!" message
- If missing, share the console log!

**Game crashes:**
- Check MelonLoader console for error details
- Share the error message and I'll help!

---

## 🎯 Technical Details

The mod patches this method:
```
Il2CppScheduleOne.PlayerScripts.Player.AreAllPlayersReadyToSleep()
```

**How it works:**
1. Game calls `AreAllPlayersReadyToSleep()` at 4AM
2. Our `Prefix` patch detects the call and starts timer
3. Game checks if all players are in bed (returns true/false)
4. Our `Postfix` patch intercepts the result
5. If timer expired: force result to `true` (everyone ready!)
6. Game proceeds to advance day 💤

---

## 📝 All Errors Fixed!

✅ **CS1069** - Missing 0Harmony reference → Added `0Harmony.dll`  
✅ **CS0118** - PlayerScripts is a namespace → Changed to `Player` class  
✅ **MSB3270** - Architecture mismatch → Set `PlatformTarget` to x64  

**Everything should build successfully now!**
