# STM32F103 自平衡球/平台

基于 STM32F103C8T6 的双轴自平衡平台项目，使用 MPU6050 姿态传感器、PID 控制算法和舵机驱动实现球体平衡控制。

## 硬件平台

| 组件 | 型号/规格 |
|------|-----------|
| MCU | STM32F103C8T6 (MINI-F103C8T6) |
| IMU | MPU6050 (I2C) |
| 显示 | 0.96寸 OLED (I2C) |
| 遥控 | 红外遥控器 |
| 执行器 | 2路舵机 (Pitch/Roll) |
| 调试 | UART 串口 |

## 软件架构

```
├── Src/                    # STM32 HAL 驱动层
│   ├── main.c              # 主程序入口
│   ├── i2c.c               # I2C 通信
│   ├── tim.c               # 定时器配置
│   ├── gpio.c              # GPIO 配置
│   ├── usart.c             # 串口通信
│   └── mpu6050.c           # MPU6050 驱动
├── Board/                  # 应用层
│   ├── app.c               # 应用初始化与主逻辑
│   ├── display.c           # OLED 显示管理
│   ├── IR.c                # 红外遥控解码
│   └── OLED/               # OLED 驱动
└── MDK-ARM/                # Keil 工程文件
    └── F103.uvprojx
```

## 核心功能

### 1. 姿态解算
- **MPU6050** 采集三轴加速度和角速度
- **卡尔曼滤波** 融合加速度计与陀螺仪数据，输出低噪声姿态角

### 2. PID 控制
- 支持死区消除、设定值加权、微分低通滤波
- 条件积分 Anti-windup 防积分饱和
- 双轴独立 PID 控制 (Pitch + Roll)

### 3. 外设交互
- OLED 实时显示姿态角和 PID 参数
- 红外遥控器切换模式和调整参数

## 开发环境

- **IDE**: Keil MDK-ARM v5
- **工具链**: ARM Compiler v6
- **固件库**: STM32Cube HAL
- **调试器**: ST-Link / J-Link

## 编译与烧录

1. 打开 `MDK-ARM/F103.uvprojx`
2. 选择 **Debug** 或 **Release** 配置
3. 点击 **Build** (F7) 编译
4. 连接 ST-Link，点击 **Download** (F8) 烧录

## 引脚分配

| 功能 | 引脚 | 说明 |
|------|------|------|
| MPU6050 SCL | PB10 | I2C2 |
| MPU6050 SDA | PB11 | I2C2 |
| OLED SCL | PB6 | I2C1 |
| OLED SDA | PB7 | I2C1 |
| 舵机 Pitch | PA8 | TIM1_CH1 |
| 舵机 Roll | PA0 | TIM2_CH1 |
| IR 接收 | PA1 | 外部中断 |
| UART TX | PA9 | USART1 |
| UART RX | PA10 | USART1 |

## 作者

CMJ
