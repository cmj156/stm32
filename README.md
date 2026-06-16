# STM32 自平衡小车

基于STM32F103的两轮自平衡小车，使用MPU6050姿态传感器和PID控制算法实现动态平衡。

## 硬件配置

| 组件 | 型号/规格 | 接口 |
|------|-----------|------|
| 主控芯片 | STM32F103C8 (Cortex-M3, 72MHz) | - |
| 姿态传感器 | MPU6050 (6轴陀螺仪+加速度计) | I2C |
| 显示屏 | OLED (0.96寸) | I2C |
| 遥控器 | 红外遥控器 | 红外接收 |
| 电机驱动 | 直流减速电机 | PWM |
| 电源 | 7.4V锂电池组 | - |

## 功能特性

- **自平衡控制**: 基于PID算法的实时姿态控制
- **姿态检测**: MPU6050实时采集角度数据
- **OLED显示**: 实时显示角度、PID参数等信息
- **红外遥控**: 支持遥控器控制前进、后退、转向
- **参数调节**: 支持运行时PID参数调整

## 项目结构

```
STM32/
├── Core/                    # STM32CubeMX生成的核心代码
│   ├── Inc/                 # 头文件
│   │   ├── main.h
│   │   ├── gpio.h
│   │   ├── i2c.h
│   │   ├── tim.h
│   │   ├── mpu6050.h
│   │   └── PID.h
│   └── Src/                 # 源文件
│       ├── main.c           # 程序入口
│       ├── gpio.c           # GPIO配置
│       ├── i2c.c            # I2C通信
│       ├── tim.c            # 定时器配置
│       ├── mpu6050.c        # MPU6050驱动
│       ├── PID.c            # PID控制算法
│       └── stm32f1xx_it.c   # 中断处理
├── Board/                   # 外设驱动
│   ├── app.c                # 应用逻辑
│   ├── display.c            # 显示驱动
│   ├── IR.c                 # 红外遥控
│   └── OLED/                # OLED驱动
│       └── oled.c
├── Drivers/                 # STM32 HAL驱动库
│   └── STM32F1xx_HAL_Driver/
├── MDK-ARM/                 # Keil MDK工程文件
│   ├── F103.uvprojx         # 工程文件
│   └── startup_stm32f103xb.s
├── build/                   # 构建输出
│   └── F103/
│       ├── F103.hex         # 烧录文件
│       ├── F103.axf         # 调试文件
│       └── F103.map         # 内存映射
└── .gitignore
```

## 编译环境

- **IDE**: Keil MDK-ARM v5
- **芯片支持包**: STM32F1xx_DFP
- **编译器**: ARM Compiler v6 (armclang)

## 构建步骤

1. 打开Keil MDK工程文件 `MDK-ARM/F103.uvprojx`
2. 选择目标芯片: STM32F103C8
3. 点击 **Build** (或按F7) 编译工程
4. 编译成功后在 `build/F103/` 目录生成 `F103.hex`

## 烧录方法

### 方法一: ST-Link
1. 连接ST-Link调试器到开发板SWD接口
2. 在Keil中点击 **Download** (或按F8)
3. 等待烧录完成

### 方法二: 串口ISP
1. 使用USB-TTL转换器连接开发板BOOT0引脚
2. 将BOOT0置高，复位进入Bootloader
3. 使用FlyMcu或STM32CubeProgrammer烧录 `F103.hex`
4. 烧录完成后将BOOT0置低，复位启动

## 软件架构

```
┌─────────────────────────────────────┐
│           main.c (主循环)           │
├─────────────────────────────────────┤
│     app.c (应用逻辑/状态机)         │
├──────────┬──────────┬───────────────┤
│  PID.c   │ MPU6050  │   IR.c       │
│ (平衡控制)│ (姿态检测)│ (遥控输入)  │
├──────────┴──────────┴───────────────┤
│        display.c + oled.c           │
│           (显示输出)                │
├─────────────────────────────────────┤
│        STM32 HAL Driver             │
│    (I2C, TIM, GPIO, NVIC)          │
└─────────────────────────────────────┘
```

## 引脚定义

| 功能 | 引脚 | 说明 |
|------|------|------|
| I2C_SCL | PB6 | MPU6050/OLED时钟线 |
| I2C_SDA | PB7 | MPU6050/OLED数据线 |
| IR_RECV | PA1 | 红外接收头 |
| MOTOR_L | PA0/PA1 | 左电机PWM |
| MOTOR_R | PA2/PA3 | 右电机PWM |
| OLED_SCL | PB10 | OLED I2C时钟(软件) |
| OLED_SDA | PB11 | OLED I2C数据(软件) |

## PID参数说明

PID控制参数位于 `Core/Src/PID.c`，可通过串口或OLED菜单实时调整：

- **Kp**: 比例系数，决定响应速度
- **Ki**: 积分系数，消除稳态误差
- **Kd**: 微分系数，抑制振荡

## 注意事项

1. 首次烧录前确保BOOT0引脚接地
2. 调试时建议先降低PID参数，防止电机过冲
3. MPU6050需要水平安装，焊接时注意虚焊
4. 电池电压低于6.5V时应充电，避免欠压损坏电机

## License

MIT License
