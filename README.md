# 学习者画像系统 (Learner Profile System)

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Django](https://img.shields.io/badge/Django-3.2.25-green.svg)](https://www.djangoproject.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📖 项目简介

学习者画像系统是一个基于Django框架开发的智能教育分析平台，通过机器学习算法对学生学习行为数据进行深度分析，生成个性化的学习者画像，为教育工作者提供数据驱动的教学决策支持。

### 🎯 核心功能

- **多维度学习分析**: 从知识技能、学习态度、课程兴趣三个维度全面评估学生学习表现
- **智能聚类分析**: 基于K-Means算法对学生进行分组，识别不同类型的学习者特征
- **可视化数据展示**: 雷达图、统计图表等多种方式直观展示分析结果
- **个性化推荐**: 根据学生画像提供针对性的学习建议和改进方案
- **权限管理系统**: 支持学生和管理员两种角色，确保数据安全

## 🏗️ 技术架构

### 后端技术栈
- **Django 3.2.25**: Web框架
- **MySQL**: 数据库
- **scikit-learn**: 机器学习库
- **pandas & numpy**: 数据处理
- **matplotlib**: 数据可视化

### 前端技术栈
- **HTML5/CSS3**: 页面结构样式
- **JavaScript**: 交互逻辑
- **Bootstrap**: UI组件库
- **Chart.js**: 图表展示

## 📊 系统功能模块

### 1. 用户管理模块
- 学生注册/登录
- 管理员账户管理
- 用户权限控制

### 2. 数据录入模块
- 学习记录数据录入
- 批量数据导入
- 数据验证和清洗

### 3. 画像分析模块
- 多维度评分计算
- 聚类分析算法
- 画像结果生成

### 4. 结果展示模块
- 雷达图可视化
- 统计分析报告
- 个性化推荐

### 5. 系统管理模块
- 数据导出功能
- 模型训练日志
- 系统监控面板

## 🚀 快速开始

### 环境要求
- Python 3.8+
- MySQL 5.7+
- pip

### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/your-username/learner-profile-system.git
cd learner-profile-system
```

2. **创建虚拟环境**
```bash
python -m venv venv
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate
```

3. **安装依赖**
```bash
pip install -r requirements.txt
```

4. **配置数据库**
```bash
# 创建MySQL数据库
mysql -u root -p
CREATE DATABASE learner_profile_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

5. **配置环境变量**
```bash
# 创建.env文件
cp .env.example .env
# 编辑.env文件，配置数据库连接信息
```

6. **数据库迁移**
```bash
python manage.py makemigrations
python manage.py migrate
```

7. **创建超级用户**
```bash
python manage.py createsuperuser
```

8. **启动开发服务器**
```bash
python manage.py runserver
```

访问 http://127.0.0.1:8000 即可使用系统

## 📁 项目结构

```
learner-profile-system/
├── DjangoProject/          # Django项目配置
│   ├── settings.py        # 项目设置
│   ├── urls.py           # 主URL配置
│   └── wsgi.py           # WSGI配置
├── profile_app/          # 主应用模块
│   ├── models.py         # 数据模型
│   ├── views.py          # 视图函数
│   ├── forms.py          # 表单类
│   ├── ml_utils.py       # 机器学习工具
│   ├── admin.py          # 管理后台
│   └── templates/        # 模板文件
├── static/               # 静态文件
├── templates/            # 全局模板
├── requirements.txt      # 依赖包列表
├── manage.py            # Django管理脚本
└── README.md            # 项目说明文档
```

## 🔧 核心算法

### 多维度评分算法
系统从三个维度对学生进行评分：

1. **知识技能维度** (权重: 50%)
   - 作业得分 (40%)
   - 实训通过率 (30%)
   - 测验完成率 (30%)

2. **学习态度维度** (权重: 30%)
   - 签到得分 (30%)
   - 作业按时完成率 (40%)
   - 视频观看率 (30%)

3. **课程兴趣维度** (权重: 20%)
   - 测验完成次数 (30%)
   - 作业完成次数 (30%)
   - 课程互动得分 (40%)

### 聚类分析算法
- 使用K-Means算法进行学生分组
- 通过轮廓系数和Gap统计量确定最优聚类数
- 支持二级聚类分析，提供更精细的分组结果

## 📈 使用指南

### 管理员操作流程

1. **登录系统**
   - 访问登录页面
   - 使用管理员账户登录

2. **数据录入**
   - 进入数据录入页面
   - 添加学生基本信息
   - 录入学习记录数据

3. **启动分析**
   - 进入聚类分析页面
   - 配置分析参数
   - 执行聚类分析

4. **查看结果**
   - 查看分析报告
   - 导出数据结果
   - 生成可视化图表

### 学生操作流程

1. **注册登录**
   - 学生注册账户
   - 登录系统

2. **查看画像**
   - 访问学生仪表板
   - 查看个人学习画像
   - 获取学习建议

## 🔒 安全特性

- 基于Django内置的安全机制
- 用户权限分级管理
- 数据输入验证和清洗
- SQL注入防护
- XSS攻击防护

## 📝 API文档

### 主要接口

- `GET /admin/dashboard/` - 管理员仪表板
- `GET /student/dashboard/` - 学生仪表板
- `POST /data/input/` - 数据录入
- `POST /cluster/analysis/` - 聚类分析
- `GET /result/radar/<int:record_id>/` - 雷达图展示

## 🤝 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📞 联系方式

- 项目维护者: [Your Name]
- 邮箱: [your.email@example.com]
- 项目链接: [https://github.com/your-username/learner-profile-system]

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者和教育工作者。

---

⭐ 如果这个项目对您有帮助，请给我们一个星标！ 