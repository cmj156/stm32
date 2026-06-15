# STM32F103 平衡车项目

基于 STM32F103 的平衡车/自平衡机器人项目，使用 Keil MDK 开发。

## 项目结构

```
MDK-ARM/
├── F103.uvprojx          # Keil 工程文件
├── startup_stm32f103xb.s # 启动文件
├── F103/                 # 编译输出
├── RTE/                  # Keil 运行时环境
└── scripts/              # 辅助脚本
```

## 模块说明

| 模块 | 文件 | 功能 |
|------|------|------|
| 主程序 | `main.c` | 程序入口与主循环 |
| 应用逻辑 | `app.c / app.h` | 应用层控制逻辑 |
| PID 控制 | `PID.c / PID.h` | PID 算法实现 |
| MPU6050 | `mpu6050.c / mpu6050.h` | 六轴传感器驱动（加速度+陀螺仪） |
| OLED 显示 | `oled.c / oled.h` | OLED 屏幕驱动（I2C） |
| 显示模块 | `display.c / display.h` | 界面显示逻辑 |
| I2C 通信 | `i2c.c / i2c.h` | 软件 I2C 驱动 |
| GPIO | `gpio.c / gpio.h` | GPIO 初始化与控制 |
| 定时器 | `tim.c / tim.h` | 定时器配置（PWM 输出） |
| 串口通信 | `usart.c / usart.h` | UART 调试输出 |
| 红外遥控 | `IR.c / IR.h` | 红外接收与解码 |
| 中断处理 | `stm32f1xx_it.c` | 中断向量处理 |

## 硬件平台

- **MCU**: STM32F103 (Cortex-M3, 72MHz)
- **传感器**: MPU6050 六轴 IMU
- **显示**: OLED (I2C)
- **电机驱动**: 待确认
- **遥控**: 红外遥控器
- **开发工具**: Keil MDK-ARM

## 构建

1. 打开 `F103.uvprojx`
2. 选择 Build → Rebuild All
3. 输出文件在 `F103/F103.hex`

## 开发环境

- Keil MDK-ARM
- STM32CubeMX 生成的 HAL 库
- CMSIS 库

## 使用说明（快速上手）

- 进入项目目录：

```bash
cd "d:\\diansai\\STM32 B\\STM32\\MDK-ARM"
```

- 常用开发流程：编辑 → 编译（Keil）→ 调试 → 提交 → 推送。

```bash
git add -A
git commit -m "描述本次修改"
git push
```

> 本地 `main` 分支已推送为远程分支 `stm32-project`（位于 `https://github.com/cmj156/blog.git`），因此 `git push` 会将更新推到该远程分支。

## 推送与远程说明

- 如果你希望把项目迁移到新的独立仓库（推荐），请在 GitHub 新建仓库后执行：

```bash
git remote set-url origin https://github.com/<你的用户名>/<新仓库名>.git
git push -u origin main
```

- 如果使用 SSH 推送，建议先把私钥添加到 `ssh-agent`，避免每次输入 passphrase：

```powershell
Start-Service ssh-agent
ssh-add C:\\Users\\CMJ\\.ssh\\id_ed25519
```

## scripts 目录说明

- `scripts/new_post.ps1`：一个用于 Hugo 博客的辅助脚本（如果你同时维护博客，可以在博客仓库中使用）。

## 常见问题

- 推送被拒绝提示 `Updates were rejected because the remote contains work that you do not have locally`：表示远程已有不同历史。为避免覆盖远程博客，本项目已将代码推到远程分支 `stm32-project`。

- 如需强制覆盖远程 `main`（风险大，不推荐），可执行：

```bash
git push -u origin main --force
```

如需我帮你创建独立仓库并迁移当前项目，或将 `README.md` 做进一步定制，请告诉我你要的内容（例如：增加构建步骤、硬件接线图、API 说明等）。
