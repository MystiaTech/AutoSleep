# 📚 libs/

This folder contains game and MelonLoader DLL references needed to build the mod.

## Required Files:

```
libs/
├── MelonLoader.dll                  ← From game's MelonLoader folder
├── Il2CppInterop.Runtime.dll        ← From game's MelonLoader folder (for IL2CPP)
├── Mono/
│   └── Assembly-CSharp.dll          ← From Mono game build
├── IL2CPP/
│   └── Assembly-CSharp.dll          ← From IL2CPP game build
└── UnityEngine.CoreModule.dll       ← From either game build
```

## How to get these files:

### Step 1: Install MelonLoader
1. **Install MelonLoader** for Schedule I (Thunderstore does this automatically)
2. **Run Schedule I once** (let MelonLoader generate files)
3. **Close the game**

### Step 2: Navigate to game folder
```
C:\Program Files (x86)\Steam\steamapps\common\Schedule I\
```

### Step 3: Copy MelonLoader DLLs
Go to the main game folder and copy:
- `MelonLoader\MelonLoader.dll` → Copy to `libs\MelonLoader.dll`
- `MelonLoader\Il2CppInterop.Runtime.dll` → Copy to `libs\Il2CppInterop.Runtime.dll`

### Step 4: Copy Game DLLs
Go to `MelonLoader\Il2CppAssemblies\` and copy:
- `Assembly-CSharp.dll` → Copy to BOTH `libs\Mono\` AND `libs\IL2CPP\`
- `UnityEngine.CoreModule.dll` → Copy to `libs\`

## Full Path Examples:

**MelonLoader DLLs:**
```
FROM: C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\MelonLoader.dll
TO:   EasierSleepMod\libs\MelonLoader.dll

FROM: C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\Il2CppInterop.Runtime.dll
TO:   EasierSleepMod\libs\Il2CppInterop.Runtime.dll
```

**Game DLLs:**
```
FROM: C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\Il2CppAssemblies\Assembly-CSharp.dll
TO:   EasierSleepMod\libs\Mono\Assembly-CSharp.dll
AND:  EasierSleepMod\libs\IL2CPP\Assembly-CSharp.dll

FROM: C:\Program Files (x86)\Steam\steamapps\common\Schedule I\MelonLoader\Il2CppAssemblies\UnityEngine.CoreModule.dll
TO:   EasierSleepMod\libs\UnityEngine.CoreModule.dll
```

## Why do we need these?

**MelonLoader DLLs:**
- `MelonLoader.dll` - Core modding framework
- `Il2CppInterop.Runtime.dll` - Required for IL2CPP mod support

**Game DLLs:**
- `Assembly-CSharp.dll` - Contains Schedule I's game code
- `UnityEngine.CoreModule.dll` - Unity engine basics

Without these, the mod won't compile!

## Don't commit these files!

These DLLs are copyrighted. The `.gitignore` prevents them from being committed to version control. Everyone building the mod needs to get their own copies from their game installation.
