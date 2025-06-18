from django.core.management.base import BaseCommand
import numpy as np
from scipy.stats import norm, uniform, beta
from django.contrib.auth.models import User
from profile_app.models import UserProfile, StudentRecord, ClusterResult, ModelLog
from profile_app.ml_utils import LearnerProfileAnalyzer
import time
import logging
import matplotlib
matplotlib.use('Agg')  # 在导入pyplot之前设置
import matplotlib.pyplot as plt
import random
from datetime import datetime, timedelta
from django.db import transaction

logger = logging.getLogger(__name__)

class Command(BaseCommand):
    help = '生成测试数据用于聚类分析验证和学生登录测试'

    def add_arguments(self, parser):
        parser.add_argument('count', type=int, help='要生成的记录数量')
        parser.add_argument('--keep-existing', action='store_true', help='保留现有数据')
        parser.add_argument('--clear-all-data', action='store_true', help='清空所有数据(包括管理员账户在内的所有用户、记录和日志)')
        parser.add_argument('--distribution', choices=['normal', 'uniform', 'skewed', 'clustered', 'realistic'], 
                          default='realistic', help='数据分布类型')
        parser.add_argument('--time-patterns', action='store_true',
                          help='添加时间变化模式')
        parser.add_argument('--special-patterns', action='store_true',
                          help='添加特殊学习行为模式')
        parser.add_argument('--password', default='123456', help='为所有生成的学生账户设置的统一密码')
    
    # 生成唯一的姓名
    def generate_unique_name(self, used_names, gender):
        # 预定义姓氏和名字列表，确保足够多样性
        last_names = ['赵', '钱', '孙', '李', '周', '吴', '郑', '王', '冯', '陈', 
                      '褚', '卫', '蒋', '沈', '韩', '杨', '朱', '秦', '尤', '许',
                      '何', '吕', '施', '张', '孔', '曹', '严', '华', '金', '魏',
                      '陶', '姜', '戚', '谢', '邹', '喻', '柏', '水', '窦', '章']
                      
        first_names_male = ['伟', '强', '磊', '洋', '勇', '军', '杰', '涛', '明', '超', 
                            '刚', '平', '辉', '健', '亮', '俊', '峰', '旭', '鹏', '鑫',
                            '浩', '坤', '彬', '霆', '宇', '毅', '杨', '佳', '宁', '泽',
                            '鸿', '睿', '诚', '铭', '雷', '龙', '振', '荣', '飞', '国']
                            
        first_names_female = ['芳', '娜', '敏', '静', '丽', '红', '萍', '霞', '燕', '玲', 
                              '丹', '婷', '雪', '珊', '琴', '雯', '蓉', '琼', '兰', '洁',
                              '岚', '梦', '瑶', '琳', '琪', '怡', '桂', '婉', '瑜', '璐',
                              '嘉', '凌', '莉', '晴', '盈', '颖', '姝', '彤', '萱', '月']
        
        # 根据性别选择对应的名字列表
        if gender == 'male':
            first_name_list = first_names_male
        else:  # gender == 'female'
            first_name_list = first_names_female
        
        # 尝试组合直到找到一个未使用的名字
        name = None
        attempts = 0
        max_attempts = 100  # 设置最大尝试次数以避免无限循环
        
        while attempts < max_attempts:
            # 随机选择姓和名
            last = random.choice(last_names)
            first = random.choice(first_name_list)
            # 有时使用双字名
            if random.random() < 0.3:  # 30%的概率使用两个字的名
                first += random.choice(first_name_list)
            
            name = last + first
            if name not in used_names:
                used_names.add(name)
                return name
            
            attempts += 1
        
        # 如果尝试多次仍未成功，使用姓名+时间戳确保唯一性
        timestamp = int(time.time() * 1000) % 10000  # 使用毫秒时间戳的后4位
        unique_name = f"{random.choice(last_names)}{random.choice(first_name_list)}{timestamp}"
        
        # 确保生成的名字唯一
        while unique_name in used_names:
            timestamp = (timestamp + 1) % 10000
            unique_name = f"{random.choice(last_names)}{random.choice(first_name_list)}{timestamp}"
        
        used_names.add(unique_name)
        self.stdout.write(self.style.WARNING(f"达到最大尝试次数，生成带时间戳的唯一姓名: {unique_name}"))
        return unique_name

    # 学习风格原型定义
    def get_learning_styles(self):
        return {
            '全面发展型': {
                'knowledge_weight': 1.0,
                'attitude_weight': 1.0,
                'interest_weight': 1.0,
                'correlation': {
                    'homework_score_training_pass_rate': 0.7,
                    'sign_in_score_video_watch_rate': 0.8,
                    'test_completion_count_homework_completion_count': 0.6
                }
            },
            '理论见长型': {
                'knowledge_weight': 1.3,
                'attitude_weight': 0.9,
                'interest_weight': 0.8,
                'correlation': {
                    'homework_score_training_pass_rate': 0.5,
                    'sign_in_score_video_watch_rate': 0.7,
                    'test_completion_count_homework_completion_count': 0.4
                }
            },
            '实践偏好型': {
                'knowledge_weight': 0.9,
                'attitude_weight': 1.0,
                'interest_weight': 1.3,
                'correlation': {
                    'homework_score_training_pass_rate': 0.8,
                    'sign_in_score_video_watch_rate': 0.6,
                    'test_completion_count_homework_completion_count': 0.7
                }
            },
            '自主学习型': {
                'knowledge_weight': 1.1,
                'attitude_weight': 0.7,
                'interest_weight': 1.2,
                'correlation': {
                    'homework_score_training_pass_rate': 0.6,
                    'sign_in_score_video_watch_rate': 0.4,
                    'test_completion_count_homework_completion_count': 0.8
                }
            },
            '被动学习型': {
                'knowledge_weight': 0.8,
                'attitude_weight': 1.2,
                'interest_weight': 0.7,
                'correlation': {
                    'homework_score_training_pass_rate': 0.7,
                    'sign_in_score_video_watch_rate': 0.9,
                    'test_completion_count_homework_completion_count': 0.5
                }
            }
        }

    # 时间模式定义
    def get_time_patterns(self):
        return {
            'improving': 0.3,    # 进步型学生比例
            'declining': 0.1,    # 退步型学生比例
            'fluctuating': 0.2,  # 波动型学生比例
            'stable': 0.4        # 稳定型学生比例
        }

    # 特殊行为模式定义
    def get_special_patterns(self):
        return {
            'exam_focused': 0.15,       # 考试导向型
            'homework_neglect': 0.1,    # 作业忽视型
            'video_preference': 0.15,   # 视频偏好型
            'interactive_learner': 0.1, # 互动学习型
            'normal': 0.5               # 无特殊模式
        }

    def generate_correlated_features(self, base_value, std_dev, correlation_matrix, feature_names):
        """生成具有相关性的特征数据"""
        n_features = len(feature_names)
        
        # 创建协方差矩阵
        cov_matrix = np.eye(n_features) * (std_dev ** 2)
        for i in range(n_features):
            for j in range(i+1, n_features):
                key = f"{feature_names[i]}_{feature_names[j]}"
                rev_key = f"{feature_names[j]}_{feature_names[i]}"
                corr = correlation_matrix.get(key, correlation_matrix.get(rev_key, 0.2))
                cov_matrix[i, j] = corr * std_dev * std_dev
                cov_matrix[j, i] = cov_matrix[i, j]
        
        # 生成多元正态分布数据
        mean_vector = np.ones(n_features) * base_value
        features = np.random.multivariate_normal(mean_vector, cov_matrix)
        
        # 确保数据在有效范围内
        features = np.clip(features, 0, 100)
        
        return {name: value for name, value in zip(feature_names, features)}

    def apply_time_pattern(self, base_data, pattern_type, intensity=0.1):
        """应用时间变化模式到基础数据"""
        if pattern_type == 'improving':
            # 模拟学习进步模式
            factor = 1 + intensity
        elif pattern_type == 'declining':
            # 模拟学习倒退模式
            factor = 1 - intensity
        elif pattern_type == 'fluctuating':
            # 模拟波动模式
            factor = 1 + intensity * (np.random.random() - 0.5)
        else:  # stable
            # 稳定模式
            factor = 1.0
        
        # 应用变化因子
        return {k: np.clip(v * factor, 0, 100) for k, v in base_data.items()}

    def apply_special_pattern(self, data, pattern_type):
        """应用特殊学习行为模式"""
        if pattern_type == 'exam_focused':
            # 考试导向型：测验成绩高，其他参与度低
            data['test_completion_rate'] = min(100, data['test_completion_rate'] * 1.5)
            data['video_watch_rate'] = data['video_watch_rate'] * 0.7
        elif pattern_type == 'homework_neglect':
            # 作业忽视型：作业完成率低，但测验和课堂参与度高
            data['homework_completion_rate'] = data['homework_completion_rate'] * 0.5
            data['course_interaction_score'] = min(100, data['course_interaction_score'] * 1.3)
        elif pattern_type == 'video_preference':
            # 视频偏好型：视频观看率高，但作业和测验参与度低
            data['video_watch_rate'] = min(100, data['video_watch_rate'] * 1.5)
            data['homework_completion_rate'] = data['homework_completion_rate'] * 0.8
        elif pattern_type == 'interactive_learner':
            # 互动学习型：课堂互动高，自主学习低
            data['course_interaction_score'] = min(100, data['course_interaction_score'] * 1.4)
            data['video_watch_rate'] = data['video_watch_rate'] * 0.7
        
        return {k: np.clip(v, 0, 100) for k, v in data.items()}

    def generate_realistic_student_data(self, profile_type, learning_style_name, time_pattern=None, special_pattern=None):
        """生成真实的学生数据"""
        profiles = {
            '优秀': {
                'base_score': 90,
                'std_dev': 5,
                'test_count_range': (8, 10),
                'homework_count_range': (16, 20)
            },
            '良好': {
                'base_score': 75,
                'std_dev': 7,
                'test_count_range': (6, 8),
                'homework_count_range': (14, 16)
            },
            '中等': {
                'base_score': 60,
                'std_dev': 10,
                'test_count_range': (4, 6),
                'homework_count_range': (10, 14)
            },
            '较低': {
                'base_score': 45,
                'std_dev': 8,
                'test_count_range': (2, 4),
                'homework_count_range': (6, 10)
            },
            '待提高': {
                'base_score': 30,
                'std_dev': 6,
                'test_count_range': (0, 2),
                'homework_count_range': (0, 6)
            }
        }

        profile = profiles[profile_type]
        style_params = self.get_learning_styles()[learning_style_name]
        
        # 应用学习风格权重
        knowledge_base = np.clip(profile['base_score'] * style_params['knowledge_weight'], 0, 100)
        attitude_base = np.clip(profile['base_score'] * style_params['attitude_weight'], 0, 100)
        interest_base = np.clip(profile['base_score'] * style_params['interest_weight'], 0, 100)
        
        # 生成相关性特征
        knowledge_features = self.generate_correlated_features(
            knowledge_base, 
            profile['std_dev'],
            style_params['correlation'],
            ['homework_score', 'training_pass_rate', 'test_completion_rate']
        )
        
        attitude_features = self.generate_correlated_features(
            attitude_base,
            profile['std_dev'],
            style_params['correlation'],
            ['sign_in_score', 'homework_completion_rate', 'video_watch_rate']
        )
        
        # 生成计数类指标
        test_min, test_max = profile['test_count_range']
        hw_min, hw_max = profile['homework_count_range']
        
        test_completion_count = np.random.randint(test_min, test_max + 1)
        homework_completion_count = np.random.randint(hw_min, hw_max + 1)
        
        # 课程互动分数
        course_interaction_score = np.clip(interest_base + np.random.normal(0, profile['std_dev']), 0, 100)
        
        # 合并所有特征
        student_data = {
            **knowledge_features,
            **attitude_features,
            'test_completion_count': test_completion_count,
            'homework_completion_count': homework_completion_count,
            'course_interaction_score': course_interaction_score
        }
        
        # 应用时间模式（如果指定）
        if time_pattern:
            student_data = self.apply_time_pattern(student_data, time_pattern, intensity=0.15)
        
        # 应用特殊行为模式（如果指定）
        if special_pattern and special_pattern != 'normal':
            student_data = self.apply_special_pattern(student_data, special_pattern)
        
        # 确保比率类数据在0-1范围内
        for key in ['training_pass_rate', 'test_completion_rate', 'homework_completion_rate', 'video_watch_rate']:
            if key in student_data:
                student_data[key] = np.clip(student_data[key] / 100.0, 0.0, 1.0)
        
        return student_data

    def generate_student_id(self, index, year=None):
        """生成唯一的学号"""
        if year is None:
            year = datetime.now().year
            
        # 格式：年份 + 5位序号，例如：2023 + 00001 = 202300001
        student_id = f"{year}{index:05d}"
        return student_id

    @transaction.atomic
    def handle(self, *args, **options):
        count = options['count']
        keep_existing = options.get('keep_existing', False)
        clear_all_data = options.get('clear_all_data', False)
        distribution_type = options.get('distribution', 'realistic')
        use_time_patterns = options.get('time_patterns', False)
        use_special_patterns = options.get('special_patterns', False)
        student_password = options.get('password', '123456')
        
        # 用于跟踪已使用的姓名集合
        used_names = set()
        
        # 清除现有数据
        if clear_all_data:
            self.stdout.write('清空所有数据...')
            # 删除所有聚类结果
            cluster_results_count = ClusterResult.objects.all().count()
            ClusterResult.objects.all().delete()
            self.stdout.write(f'清除了 {cluster_results_count} 个聚类结果。')
            
            # 删除所有学生记录
            student_records_count = StudentRecord.objects.all().count()
            StudentRecord.objects.all().delete()
            self.stdout.write(f'清除了 {student_records_count} 个学生记录。')
            
            # 删除所有普通用户（非超级用户）
            users_count = User.objects.filter(is_superuser=False).count()
            User.objects.filter(is_superuser=False).delete()
            self.stdout.write(f'清除了 {users_count} 个普通用户账户。')
            
            # 清除所有模型日志
            logs_count = ModelLog.objects.all().count()
            ModelLog.objects.all().delete()
            self.stdout.write(f'清除了 {logs_count} 个模型训练日志。')
            
            self.stdout.write(self.style.SUCCESS('所有数据已清空。'))
            
        elif not keep_existing:
            self.stdout.write('清除现有测试数据...')
            # 查找测试用户以便删除
            test_users = User.objects.filter(username__startswith='student')
            deleted_user_count, _ = test_users.delete()
            self.stdout.write(f'清除了 {deleted_user_count} 个测试用户及其关联数据。')
            # 清除所有模型日志
            ModelLog.objects.all().delete()
            self.stdout.write('清除了所有模型训练日志。')
        
        # 设置学生分布
        if distribution_type == 'normal':
            distribution = {'优秀': 0.1, '良好': 0.2, '中等': 0.4, '较低': 0.2, '待提高': 0.1}
        elif distribution_type == 'skewed':
            distribution = {'优秀': 0.05, '良好': 0.15, '中等': 0.5, '较低': 0.2, '待提高': 0.1}
        elif distribution_type == 'clustered':
            distribution = {'优秀': 0.3, '良好': 0.2, '中等': 0.2, '较低': 0.2, '待提高': 0.1}
        elif distribution_type == 'realistic':
            distribution = {'优秀': 0.15, '良好': 0.25, '中等': 0.35, '较低': 0.15, '待提高': 0.1}
        else:  # uniform
            distribution = {'优秀': 0.2, '良好': 0.2, '中等': 0.2, '较低': 0.2, '待提高': 0.2}

        learning_styles_names = list(self.get_learning_styles().keys())
        time_patterns_names = list(self.get_time_patterns().keys()) if use_time_patterns else [None]
        special_patterns_names = list(self.get_special_patterns().keys()) if use_special_patterns else [None]
        
        time_pattern_weights = list(self.get_time_patterns().values()) if use_time_patterns else [1.0]
        special_pattern_weights = list(self.get_special_patterns().values()) if use_special_patterns else [1.0]
        
        # 用于导出学生账户信息的列表
        student_accounts_info = []
        
        records_created_count = 0
        current_year = datetime.now().year
        
        # 创建学生分布报告的表头
        self.stdout.write("\n学生分布报告:")
        self.stdout.write("="*40)
        self.stdout.write(f"{'类型':<10}{'计划数量':<10}{'实际数量':<10}{'百分比':<10}")
        self.stdout.write("-"*40)
        
        # 追踪各类型学生的实际生成数量
        actual_distribution = {profile_type: 0 for profile_type in distribution.keys()}
        
        # 确保随机性
        random.seed()
        
        # 生成测试数据
        for profile_type, ratio in distribution.items():
            profile_target_count = int(count * ratio)
            
            for i in range(profile_target_count):
                if records_created_count >= count:  # 确保不超过总数
                    break
                
                user_idx = records_created_count + 1
                
                # 生成唯一的学号
                student_id = self.generate_student_id(user_idx, current_year)
                
                # 确定性别（严格限制为男/女两类）
                gender = random.choice(['male', 'female'])
                
                # 生成唯一的姓名
                name = self.generate_unique_name(used_names, gender)
                
                # 创建用户账户
                username = f"student{user_idx:05d}"
                email = f"{username}@example.edu.cn"
                
                # 创建用户对象
                user = User.objects.create_user(
                    username=username,
                    email=email,
                    password=student_password  # 使用统一的密码
                )
                
                # 更新用户资料
                user_profile = UserProfile.objects.get(user=user)  # 信号会自动创建
                user_profile.name = name
                user_profile.student_id = student_id
                user_profile.gender = gender
                user_profile.role = 'student'
                user_profile.save()
                
                # 验证姓名是否已正确设置
                user_profile.refresh_from_db()
                if not user_profile.name or user_profile.name == user.username:
                    self.stdout.write(self.style.WARNING(f"警告: 学生 {username} 的姓名未正确设置，手动更新..."))
                    user_profile.name = name
                    user_profile.save(update_fields=['name'])
                
                # 记录账户信息以供导出
                student_accounts_info.append({
                    '用户名': username,
                    '密码': student_password,
                    '姓名': name,
                    '学号': student_id,
                    '性别': '男' if gender == 'male' else '女',
                    '类型': profile_type
                })
                
                # 生成学生学习数据
                learning_style_name = random.choice(learning_styles_names)
                time_pattern = random.choices(time_patterns_names, weights=time_pattern_weights, k=1)[0] if use_time_patterns else None
                special_pattern = random.choices(special_patterns_names, weights=special_pattern_weights, k=1)[0] if use_special_patterns else None
                
                student_data = self.generate_realistic_student_data(
                    profile_type, 
                    learning_style_name,
                    time_pattern,
                    special_pattern
                )
                
                # 创建学生记录
                record = StudentRecord(user=user, **student_data)
                record.save()
                
                records_created_count += 1
                actual_distribution[profile_type] += 1
            
            if records_created_count >= count:
                break
        
        # 打印分布报告
        for profile_type, target_ratio in distribution.items():
            target_count = int(count * target_ratio)
            actual_count = actual_distribution[profile_type]
            actual_ratio = actual_count / records_created_count if records_created_count > 0 else 0
            self.stdout.write(f"{profile_type:<10}{target_count:<10}{actual_count:<10}{actual_ratio:.2%}")
        
        self.stdout.write("="*40)
        
        # 将学生账户信息导出到控制台
        self.stdout.write("\n学生账户信息 (前10个):")
        self.stdout.write("="*80)
        self.stdout.write(f"{'用户名':<15}{'密码':<15}{'姓名':<15}{'学号':<15}{'性别':<10}{'类型':<10}")
        self.stdout.write("-"*80)
        
        # 只显示前10个账户，避免输出过多
        for info in student_accounts_info[:10]:
            self.stdout.write(f"{info['用户名']:<15}{info['密码']:<15}{info['姓名']:<15}{info['学号']:<15}{info['性别']:<10}{info['类型']:<10}")
        
        if len(student_accounts_info) > 10:
            self.stdout.write(f"... 及其他 {len(student_accounts_info) - 10} 个账户")
        
        self.stdout.write("="*80)
        
        # 导出账户信息到CSV文件
        try:
            import csv
            csv_file_path = "student_accounts.csv"
            with open(csv_file_path, 'w', newline='', encoding='utf-8') as csvfile:
                fieldnames = ['用户名', '密码', '姓名', '学号', '性别', '类型']
                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                writer.writeheader()
                for info in student_accounts_info:
                    writer.writerow(info)
            self.stdout.write(f"\n所有账户信息已导出到 {csv_file_path}")
        except Exception as e:
            self.stdout.write(f"\n导出账户信息时发生错误: {str(e)}")
        
        self.stdout.write(self.style.SUCCESS(
            f'\n成功生成 {records_created_count} 条符合新模型的测试数据(用户、画像、学习记录)'))
        
        # 运行聚类分析
        if records_created_count > 0:
            self.stdout.write('正在为新生成的数据运行聚类分析...')
            try:
                analyzer = LearnerProfileAnalyzer()
                success = analyzer.update_model()
                if success:
                    self.stdout.write(self.style.SUCCESS(
                        '聚类分析成功完成，可视化数据已更新'))
                else:
                    self.stdout.write(self.style.WARNING(
                        '聚类分析过程中发生错误或无充足数据进行分析'))
            except Exception as e:
                self.stdout.write(self.style.ERROR(f'聚类分析失败: {str(e)}'))
        else:
            self.stdout.write(self.style.NOTICE('没有生成新的学生记录，跳过聚类分析。'))