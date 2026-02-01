---
name: unity-il2cpp-modding
description: Unity Il2Cpp 模组开发经验总结。基于 Il2CppInterop 框架，提供 Il2Cpp 运行时交互、方法挂钩、类型访问、委托调用等核心开发知识，适用于 MelonLoader、BepInEx 等模组框架。
license: MIT
---

# Unity Il2Cpp 模组开发

本技能总结了基于 Il2CppInterop 框架开发 Unity Il2Cpp 游戏模组的核心经验和技术要点。

## 核心概念

### Il2Cpp 运行时环境

Il2Cpp（Intermediate Language To C++）是 Unity 的脚本后端技术，将 IL 代码编译为 C++ 代码。

**关键特性：**
- 运行时类型系统与原 Unity Mono 不同
- 使用 Il2CppInterop 作为桥接层
- 需要理解 Il2Cpp 的对象生命周期管理
- 内存管理遵循 Il2Cpp 的垃圾回收机制

### 主要模组框架支持

- **MelonLoader**: 内置 Il2CppInterop 支持
- **BepInEx**: 通过 Il2CppInterop 插件支持
- **独立使用**: 可以直接引用 Il2CppInterop 库

## 类型系统与访问

### Il2Cpp 类型基础

Il2Cpp 中的类型通过 Il2CppInterop 进行桥接：

```csharp
// 获取 Il2Cpp 类型
var il2cppType = Il2CppType.Of<SomeGameClass>();

// 通过名称查找类型（性能较低，避免在 Update 中频繁使用）
var typeByName = Il2CppType.From("Assembly-CSharp", "GameNamespace.GameClass");
```

### Il2Cpp 对象创建

```csharp
// 创建 Il2Cpp 对象实例
var gameObject = new Il2CppSystem.GameObject("MyObject");

// 使用反射创建（当构造函数有参数时）
var type = Il2CppType.From("Assembly-CSharp", "MyClass");
var instance = type.GetConstructor().Invoke(new object[] { arg1, arg2 });
```

### 字段与属性访问

```csharp
// 直接访问（编译时已知类型）
var component = gameObject.GetComponent<SomeComponent>();

// 反射访问（运行时动态）
var field = type.GetField("fieldName");
var value = field.GetValue(instance);
field.SetValue(instance, newValue);

// 属性访问
var property = type.GetProperty("PropertyName");
var propValue = property.GetValue(instance);
```

## 方法挂钩 (Hooking)

### 使用 Harmony 或 Il2Cpp 原生 Hook

#### 方法补丁（Harmony 风格）

```csharp
using HarmonyLib;

[HarmonyPatch(typeof(TargetClass), "TargetMethod")]
public class MyPatch
{
    // 前置补丁：在原始方法前执行
    [HarmonyPrefix]
    static bool Prefix(TargetClass __instance, ref int __0)
    {
        // __instance: 被调用方法的实例
        // __0, __1, ...: 方法参数（按顺序）
        // ref 参数可以修改传入值
        
        // 返回 false 可跳过原始方法执行
        return true; // 继续执行原始方法
    }
    
    // 后置补丁：在原始方法后执行
    [HarmonyPostfix]
    static void Postfix(TargetClass __instance, int __0, ref int __result)
    {
        // __result: 修改方法的返回值
        __result = modifiedValue;
    }
    
    // 转置补丁：完全替代原始方法
    [HarmonyTranspiler]
    static IEnumerable<CodeInstruction> Transpiler(IEnumerable<CodeInstruction> instructions)
    {
        // IL 代码操作，高级用法
        return instructions;
    }
}
```

#### Il2Cpp 特定 Hook 技术

```csharp
using Il2CppInterop.Runtime;
using Il2CppInterop.Runtime.InteropTypes;

// 获取方法指针并进行原生 Hook
var methodInfo = typeof(TargetClass).GetMethod("TargetMethod");
var methodPointer = methodInfo.MethodHandle.GetFunctionPointer();

// 使用 Detours 或 MinHook 进行底层 Hook
// 注意：需要处理 Il2Cpp 的调用约定
```

### 委托与回调

Il2Cpp 中的委托处理需要特别注意：

```csharp
// 创建 Il2Cpp 委托
public delegate void MyCallback(IntPtr ptr);

// 转换方法为 Il2Cpp 委托
var action = (Il2CppSystem.Action)Delegate.CreateDelegate(
    typeof(Il2CppSystem.Action), 
    target, 
    "MethodName"
);

// 事件订阅
someObject.OnEvent += (Il2CppSystem.Action)MyHandler;
```

## Il2Cpp 集合与数组

### Il2Cpp 数组处理

```csharp
// Il2Cpp 数组
Il2CppReferenceArray<SomeType> il2cppArray;

// 转换常规数组到 Il2Cpp 数组
var managedArray = new[] { 1, 2, 3 };
var il2cppArray = new Il2CppStructArray<int>(managedArray);

// 遍历 Il2Cpp 数组
foreach (var item in il2cppArray)
{
    // 处理 item
}
```

### Il2Cpp 列表和字典

```csharp
// Il2Cpp List
var list = new Il2CppSystem.Collections.Generic.List<Il2CppSystem.String>();
list.Add("item1");

// Il2Cpp Dictionary
var dict = new Il2CppSystem.Collections.Generic.Dictionary<Il2CppSystem.String, Il2CppSystem.Int32>();
dict["key"] = 42;
```

## 字符串处理

Il2Cpp 字符串与托管字符串的转换：

```csharp
// 托管字符串转 Il2Cpp 字符串
Il2CppSystem.String il2cppString = "managed string";

// Il2Cpp 字符串转托管字符串
string managedString = il2cppString.ToString();

// 直接转换
Il2CppSystem.String il2cppStr = new Il2CppSystem.String(managedStr);
```

## 常用 Il2Cpp 类型

### 基础类型映射

| C# 类型 | Il2CppInterop 类型 |
|---------|-------------------|
| `string` | `Il2CppSystem.String` |
| `object` | `Il2CppSystem.Object` |
| `int` | `Il2CppSystem.Int32` |
| `float` | `Il2CppSystem.Single` |
| `bool` | `Il2CppSystem.Boolean` |
| `byte[]` | `Il2CppStructArray<byte>` |
| `T[]` | `Il2CppReferenceArray<T>` / `Il2CppStructArray<T>` |

### Unity Il2Cpp 类型

```csharp
// 常用 Unity 类型的 Il2Cpp 版本
Il2CppSystem.GameObject
Il2CppSystem.Transform
Il2CppSystem.Component
Il2CppSystem.Vector3
Il2CppSystem.Quaternion

// 转换示例
UnityEngine.Vector3 managed = il2cppVector3;
Il2CppUnityEngine.Vector3 il2cpp = managed;
```

## 运行时交互模式

### 查找游戏对象

```csharp
// 查找场景中的对象
var objects = UnityEngine.Object.FindObjectsOfType<Il2CppSomeComponent>();

// 通过路径查找
var foundObject = GameObject.Find("Path/To/Object");
```

### 组件访问

```csharp
// 获取组件（Il2Cpp 版本）
var component = gameObject.GetComponent<Il2CppType.ComponentType>();

// 动态获取
var comp = gameObject.GetComponent(Il2CppType.From("Assembly-CSharp", "SomeComponent"));
```

## 最佳实践与注意事项

### 性能优化

1. **缓存类型和方法信息**
   ```csharp
   // 不好的做法：每次调用都反射
   var method = type.GetMethod("MethodName");
   
   // 好的做法：缓存反射结果
   private static readonly MethodInfo cachedMethod = 
       typeof(TargetClass).GetMethod("MethodName");
   ```

2. **避免频繁的 Il2Cpp/Managed 边界跨越**
   - 批量处理数据而非逐个处理
   - 缓存 Il2Cpp 对象引用

3. **谨慎使用字符串操作**
   - Il2Cpp 字符串转换有开销
   - 优先使用直接比较而非字符串操作

### 内存管理

1. **注意 Il2Cpp 对象生命周期**
   ```csharp
   // 保持对 Il2Cpp 对象的引用
   private Il2CppSystem.GameObject cachedObject;
   ```

2. **避免 Il2Cpp 对象被过早回收**
   - 在托管代码中保持强引用
   - 使用 `GC.KeepAlive()` 防止优化掉引用

### 调试技巧

1. **使用 Il2CppDumper 分析游戏**
   - 获取类型定义和方法签名
   - 帮助理解游戏内部结构

2. **日志记录**
   ```csharp
   // 使用 MelonLoader 日志
   MelonLogger.Msg($"[MyMod] Value: {value}");
   
   // 或者使用 BepInEx
   Logger.LogInfo($"[MyMod] Value: {value}");
   ```

3. **异常处理**
   ```csharp
   try
   {
       // Il2Cpp 调用
   }
   catch (Il2CppException ex)
   {
       // 处理 Il2Cpp 异常
       MelonLogger.Error($"Il2Cpp Error: {ex.Message}");
   }
   catch (Exception ex)
   {
       // 处理托管异常
       MelonLogger.Error($"Error: {ex}");
   }
   ```

## 常见问题与解决方案

### Q: 遇到 "Method not found" 错误
**A**: 检查方法签名是否正确，Il2Cpp 可能进行了方法内联或剥离。使用 Il2CppDumper 验证方法是否存在。

### Q: 委托回调导致崩溃
**A**: 确保委托的生命周期管理正确，使用 `Il2CppSystem.Delegate` 类型并防止过早 GC。

### Q: 类型转换失败
**A**: 检查是否正确引用了 Il2Cpp 版本的类型。确保使用 `Il2CppType.From()` 或 `Il2CppType.Of<>()`。

### Q: 游戏更新后模组失效
**A**: Il2Cpp 方法地址可能改变，需要重新分析游戏并更新钩子地址。考虑实现版本检测机制。

## 参考资源

- [Il2CppInterop GitHub](https://github.com/BepInEx/Il2CppInterop)
- [Harmony 文档](https://harmony.pardeike.net/)
- [MelonLoader Wiki](https://melonwiki.xyz/)
- [BepInEx 文档](https://docs.bepinex.dev/)

## 示例模组结构

```
MyIl2CppMod/
├── MyMod.csproj          # 引用 Il2CppInterop 和框架
├── ModMain.cs            # 入口类
├── Patches/
│   ├── GamePatch.cs      # Harmony 补丁
│   └── UIPatch.cs
├── Utils/
│   ├── Il2CppHelper.cs   # Il2Cpp 辅助工具
│   └── ReflectionCache.cs # 反射缓存
└── Config/
    └── ModConfig.cs      # 模组配置
```

## 版本兼容性

- **Unity 2019.4+**: 完整支持
- **Unity 2020.x**: 完整支持
- **Unity 2021.x**: 完整支持
- **Unity 2022.x+**: 需要最新 Il2CppInterop 版本

注意：不同 Unity 版本的 Il2Cpp 输出可能有差异，建议针对目标游戏版本测试。
