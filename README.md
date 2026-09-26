# CoongFu
 
## **这个文档是AI写的！！！**

基于 Godot 4.6 的 2D 俯视角射击游戏，核心玩法是「自定义子弹行为」：玩家可以在游戏内用可视化积木编辑器拼装脚本来决定子弹怎么飞、怎么发射。

## 特性

- 内嵌 [ShrimpVM](addons/shrimpvm) 可视化积木脚本虚拟机，行为脚本可在游戏内编辑并实时运行
- 游戏专属积木节点库（`irs/`）：向鼠标发射子弹、注入能量、加速、随机数等
- 鸡系敌人生态：小鸡 / 母鸡 / 公鸡，多种子弹类型（鸡蛋、火球、星星、紫水晶）
- 能量系统：攻击积攒能量，发射子弹时消耗
- 经验球拾取与 HUD 成长条

## 操作

| 按键     | 行为           |
|----------|----------------|
| WASD     | 移动           |
| 空格     | 冲刺           |
| 鼠标左键 | 攻击           |
| 鼠标右键 | 格挡           |
| Tab      | 打开积木编辑器 |

## 目录结构

```plain
abstracts/    实体基类（BaseEntity → BaseLiving → BasePlayer/BaseEnemy、BaseBullet、BaseEffect、BasePanel）
contents/     游戏内容（Bullet 子弹、Entity 鸡、Items 道具、Effects、AI、Panels、Bar UI）
irs/          游戏专属 ShrimpIR 积木节点
scenes/       World 主战斗场景、CoongFuEditor 游戏内编辑器、HUD
utils/        工具类（Math、Time、Controllers、Managers、Structs）
addons/       ShrimpVM 插件（git submodule）
```

## 开发

1. 使用 Godot 4.6 打开项目（渲染使用 GL Compatibility + D3D12，物理使用 Jolt）
2. ShrimpVM 插件随项目自动启用（`addons/shrimpvm`）
3. `F5` 运行，主场景为 `scenes/World/World.tscn`

### 自定义积木节点

在 `irs/` 下新建继承 `ShrimpIR` 的脚本，实现 `execute` / `decompile` / `create_from` / `get_wrapper_schema` 即可被游戏内编辑器和导入器识别，参见 [BulletShotNode.gd](irs/BulletShotNode.gd)。
