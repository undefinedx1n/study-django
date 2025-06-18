import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from django.core.exceptions import ValidationError
from .exceptions import InsufficientDataError, DataAnalysisError
from .models import StudentRecord, ClusterResult, ModelLog
from sklearn.metrics import silhouette_score, calinski_harabasz_score
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import platform
import os
import logging
from scipy.spatial.distance import pdist

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# 配置matplotlib中文字体
def configure_matplotlib_fonts():
    system = platform.system()
    if system == 'Windows':
        plt.rcParams['font.sans-serif'] = ['Microsoft YaHei', 'SimHei', 'Arial Unicode MS']
        plt.rcParams['font.family'] = 'sans-serif'
    elif system == 'Darwin':  # macOS
        plt.rcParams['font.sans-serif'] = ['Arial Unicode MS', 'Heiti TC', 'STHeiti']
        plt.rcParams['font.family'] = 'sans-serif'
    elif system == 'Linux':
        plt.rcParams['font.sans-serif'] = ['DejaVu Sans', 'WenQuanYi Micro Hei', 'WenQuanYi Zen Hei']
        plt.rcParams['font.family'] = 'sans-serif'
    
    plt.rcParams['axes.unicode_minus'] = False  # 正确显示负号
    plt.rcParams['font.size'] = 12  # 设置默认字体大小
    plt.rcParams['figure.dpi'] = 300  # 设置默认DPI
    plt.rcParams['savefig.dpi'] = 300  # 设置保存图片的DPI

# 在模块级别调用配置函数
configure_matplotlib_fonts()

class LearnerProfileAnalyzer:
    def __init__(self, min_samples=10, max_clusters=10):
        self.min_samples = min_samples
        self.max_clusters = max_clusters  # 最大聚类数
        self.features = [
            'homework_score', 'training_pass_rate', 'test_completion_rate',
            'sign_in_score', 'homework_completion_rate', 'video_watch_rate',
            'test_completion_count', 'homework_completion_count',
            'course_interaction_score'
        ]
        self.dimension_groups = {
            '知识技能': ['homework_score', 'training_pass_rate', 'test_completion_rate'],
            '学习态度': ['sign_in_score', 'homework_completion_rate', 'video_watch_rate'],
            '课程兴趣': ['test_completion_count', 'homework_completion_count', 'course_interaction_score']
        }
        # 维度权重
        self.dimension_weights = {
            '知识技能': 0.5,
            '学习态度': 0.3,
            '课程兴趣': 0.2
        }
        # 各维度内部权重
        self.knowledge_skill_weights = {
            'homework_score': 0.4,
            'training_pass_rate': 0.3,
            'test_completion_rate': 0.3
        }
        self.attitude_weights = {
            'sign_in_score': 0.3,
            'homework_completion_rate': 0.4,
            'video_watch_rate': 0.3
        }
        self.interest_weights = {
            'test_completion_count': 0.3,
            'homework_completion_count': 0.3,
            'course_interaction_score': 0.4
        }
        # 定义评级映射参数
        self.rating_thresholds = {
            "优秀": 90,
            "良好": 70,
            "中等": 50,
            "待提高": 0
        }
        # 测验和作业完成次数的最大参考值（用于标准化）
        self.max_test_count = 10  # 根据实际情况调整
        self.max_homework_count = 20  # 根据实际情况调整

    def preprocess_data(self, records):
        """预处理学生记录数据"""
        # 数据验证
        if len(records) < self.min_samples:
            raise InsufficientDataError(f"样本数必须大于 {self.min_samples}")

        data = [[getattr(record, feature) for feature in self.features]
                for record in records]

        # 值域检查
        for row in data:
            if any(np.isnan(val) or np.isinf(val) for val in row):
                raise ValidationError("存在无效的数据值")

        scaler = StandardScaler()
        normalized_data = scaler.fit_transform(data)

        return normalized_data, data  # 返回标准化数据和原始数据

    def evaluate_clustering(self, data, labels, cluster_name=""):
        """评估聚类效果"""
        unique_labels = np.unique(labels)
        if len(unique_labels) < 2:
            logger.info(f"{cluster_name} 只有一个类别，跳过评估")
            return None, None, None
            
        try:
            silhouette_avg = silhouette_score(data, labels)
            calinski_avg = calinski_harabasz_score(data, labels)
            
            # 计算类内方差和类间距离
            cluster_centers = [np.mean(data[labels == i], axis=0) for i in unique_labels]
            intra_var = np.mean([np.var(data[labels == i]) for i in unique_labels])
            inter_dist = np.mean([np.linalg.norm(c1 - c2) 
                                for i, c1 in enumerate(cluster_centers)
                                for c2 in cluster_centers[i+1:]])
            
            logger.info(f"\n{cluster_name} 聚类评估结果:")
            logger.info(f"轮廓系数 (Silhouette Score): {silhouette_avg:.3f}")
            logger.info(f"Calinski-Harabasz 指数: {calinski_avg:.3f}")
            logger.info(f"类内平均方差: {intra_var:.3f}")
            logger.info(f"类间平均距离: {inter_dist:.3f}")
            
            return silhouette_avg, calinski_avg, {"intra_var": intra_var, "inter_dist": inter_dist}
        except Exception as e:
            logger.error(f"{cluster_name} 评估失败: {str(e)}")
            return None, None, None

 
    def sort_clusters_by_performance(self, kmeans, normalized_data, importance_weights=None):
        """根据聚类中心的性能指标对聚类进行排序"""
        # 如果没有提供重要性权重，则使用等权重
        if importance_weights is None:
            importance_weights = np.ones(kmeans.cluster_centers_.shape[1]) / kmeans.cluster_centers_.shape[1]
        
        # 将重要性权重转换为numpy数组
        importance_weights = np.array(importance_weights)
        
        # 计算每个聚类中心的加权平均分数
        centers = kmeans.cluster_centers_
        performance_scores = np.sum(centers * importance_weights, axis=1)
        
        # 从高到低排序（最佳性能指标为正值）
        sorted_indices = np.argsort(performance_scores)[::-1]
        
        # 创建标签映射：旧标签 -> 新标签（按性能排序）
        label_mapping = {old_label: new_label for new_label, old_label in enumerate(sorted_indices)}
        
        # 应用映射到聚类标签
        labels = kmeans.labels_
        sorted_labels = np.array([label_mapping[label] for label in labels])
        
        # 记录排序过程
        logger.info("聚类中心性能排序:")
        for idx, score in zip(sorted_indices, performance_scores[sorted_indices]):
            logger.info(f"原始聚类 {idx} -> 新标签 {label_mapping[idx]}, 性能分数: {score:.4f}")
        
        return sorted_labels, label_mapping

    def find_optimal_k(self, data, max_k=None):
        """使用轮廓系数和Gap统计量确定最优聚类数"""
        if max_k is None:
            max_k = min(self.max_clusters, len(data) // 2)
        
        silhouette_scores = []
        gap_stats = []
        
        # 计算参考数据的分布
        ref_dispersions = []
        for k in range(1, max_k + 1):
            ref_data = np.random.uniform(low=data.min(axis=0), high=data.max(axis=0),
                                       size=data.shape)
            kmeans = KMeans(n_clusters=k, random_state=42)
            kmeans.fit(ref_data)
            ref_dispersions.append(kmeans.inertia_)
        
        # 计算实际数据的轮廓系数和Gap统计量
        for k in range(2, max_k + 1):
            kmeans = KMeans(n_clusters=k, random_state=42)
            labels = kmeans.fit_predict(data)
            silhouette_scores.append(silhouette_score(data, labels))
            
            # 计算Gap统计量
            gap = np.log(ref_dispersions[k-1]) - np.log(kmeans.inertia_)
            gap_stats.append(gap)
        
        # 综合考虑轮廓系数和Gap统计量
        optimal_k = np.argmax(silhouette_scores) + 2
        gap_optimal_k = np.argmax(gap_stats) + 2
        
        logger.info(f"轮廓系数推荐的最优聚类数: {optimal_k}")
        logger.info(f"Gap统计量推荐的最优聚类数: {gap_optimal_k}")
        
        # 如果两种方法的推荐值相差不大，取较小值
        if abs(optimal_k - gap_optimal_k) <= 2:
            return min(optimal_k, gap_optimal_k)
        # 否则优先考虑轮廓系数
        return optimal_k

    def update_model(self):
        """更新模型并进行聚类分析"""
        try:
            # 记录开始分析
            logger.info("开始聚类分析...")
            
            records = StudentRecord.objects.all()
            logger.info(f"获取学生记录: 总计 {len(records)} 条")
            
            if len(records) < self.min_samples:
                logger.error(f"样本数不足: 当前{len(records)}条，最少需要{self.min_samples}条")
                raise InsufficientDataError(f"样本数({len(records)})不足，无法进行聚类")

            # 数据预处理
            try:
                logger.info("开始数据预处理...")
                normalized_data, raw_data = self.preprocess_data(records)
                logger.info(f"数据预处理完成: 标准化后数据维度 {normalized_data.shape}")
            except ValidationError as e:
                logger.error(f"数据预处理失败: {str(e)}")
                raise DataAnalysisError(f"数据预处理失败: {str(e)}")
            except Exception as e:
                logger.error(f"数据预处理过程发生未知错误: {str(e)}")
                raise DataAnalysisError(f"数据预处理失败: {str(e)}")
            
            # 动态确定最优聚类数
            try:
                logger.info("开始确定最优聚类数...")
                optimal_k = self.find_optimal_k(normalized_data)
                logger.info(f"确定最优聚类数: {optimal_k}")
                
                if optimal_k < 2:
                    logger.error("无法确定合适的聚类数量，数据可能不适合聚类分析")
                    raise DataAnalysisError("无法确定合适的聚类数量，请检查数据分布")
                
                # 第一次聚类（粗分类）
                logger.info(f"开始第一次聚类，聚类数量k={optimal_k}...")
                first_kmeans = KMeans(n_clusters=optimal_k, random_state=42)
                first_kmeans.fit(normalized_data)
                logger.info("第一次聚类完成")
            except Exception as e:
                logger.error(f"聚类过程失败: {str(e)}")
                raise DataAnalysisError(f"聚类分析失败: {str(e)}")

            
            # 根据特征重要性对聚类进行排序
            try:
                logger.info("开始根据特征重要性对聚类排序...")
                # 构建特征重要性权重，将重要特征权重设为高值
                feature_importance = np.ones(len(self.features))
                for i, feature in enumerate(self.features):
                    if feature in self.dimension_groups['知识技能']:
                        feature_importance[i] = 1.5  # 知识技能特征权重更高
                
                # 对聚类标签进行排序（从最好到最差）
                first_labels, first_label_mapping = self.sort_clusters_by_performance(
                    first_kmeans, normalized_data, feature_importance)
                logger.info("聚类排序完成")
            except Exception as e:
                logger.error(f"聚类排序过程失败: {str(e)}")
                raise DataAnalysisError(f"聚类排序失败: {str(e)}")
            
            try:
                # 评估第一次聚类
                logger.info("开始评估第一次聚类...")
                silhouette_avg, calinski_avg, metrics = self.evaluate_clustering(
                    normalized_data, first_labels, "第一次聚类")
                
                # 可视化第一次聚类
                self.plot_cluster_distribution(first_labels, "第一次聚类分布")
                
                # 分析每个聚类的特征
                self.analyze_cluster_characteristics(raw_data, first_labels, self.features)
            except Exception as e:
                logger.error(f"聚类评估过程失败: {str(e)}")
                # 这个错误不应该中断整个流程，所以不抛出异常
                logger.warning("跳过聚类评估，继续处理...")
            
            try:
                # 第二次聚类（细分类）- 仅用于分析，不用于评分
                logger.info("开始第二次聚类...")
                second_labels = np.zeros_like(first_labels)
                for cluster in range(optimal_k):
                    cluster_mask = first_labels == cluster
                    cluster_data = normalized_data[cluster_mask]
                    cluster_size = len(cluster_data)
                    
                    logger.info(f"处理第 {cluster} 个聚类，样本数量: {cluster_size}")
                    
                    if cluster_size < 3:  # 如果样本太少，跳过二次聚类
                        second_labels[cluster_mask] = 0
                        logger.info(f"聚类 {cluster} 样本数量不足 (只有 {cluster_size} 个)，跳过二次聚类")
                        continue
                    
                    # 计算数据分布特征
                    data_variance = np.var(cluster_data)
                    data_range = np.ptp(cluster_data)  # 数据范围（最大值-最小值）
                    
                    # 基于数据分布特征动态调整聚类数
                    if data_variance > 0.5 and data_range > 1.5:  # 数据分散
                        n_clusters = min(5, cluster_size // self.min_samples)
                    else:  # 数据集中
                        n_clusters = min(3, cluster_size // self.min_samples)
                    
                    # 确保每个类别至少有最小样本数
                    n_clusters = max(2, min(n_clusters, cluster_size // self.min_samples))
                    
                    # 确保n_clusters有效且大于1
                    if n_clusters <= 1:
                        logger.warning(f"聚类 {cluster} 的二次聚类数量计算结果小于等于1，设为默认值2")
                        n_clusters = 2
                    
                    logger.info(f"对聚类 {cluster} 进行二次聚类，聚类数量: {n_clusters}")
                    
                    sub_kmeans = KMeans(n_clusters=n_clusters, random_state=42)
                    sub_kmeans.fit(cluster_data)
                    
                    # 对二级聚类也进行排序
                    sub_labels_sorted, _ = self.sort_clusters_by_performance(
                        sub_kmeans, cluster_data, feature_importance)
                    
                    # 将排序后的二级聚类标签赋值给对应位置
                    second_labels[cluster_mask] = sub_labels_sorted
                    
                    try:
                        # 评估每个子类的聚类效果
                        silhouette, calinski, metrics = self.evaluate_clustering(
                            cluster_data, sub_labels_sorted, f"第二次聚类-组{cluster}")
                        
                        # 记录评估指标
                        logger.info(f"\n二级聚类-组{cluster}评估指标:")
                        logger.info(f"数据方差: {data_variance:.3f}")
                        logger.info(f"数据范围: {data_range:.3f}")
                        logger.info(f"选择的聚类数: {n_clusters}")
                        if metrics:
                            logger.info(f"类内方差: {metrics['intra_var']:.3f}")
                            logger.info(f"类间距离: {metrics['inter_dist']:.3f}")
                        
                        self.plot_cluster_distribution(sub_labels_sorted, f"第二次聚类-组{cluster}分布")
                    except Exception as e:
                        logger.error(f"对聚类 {cluster} 的二次聚类评估失败: {str(e)}")
                        # 继续处理下一个聚类
            except Exception as e:
                logger.error(f"第二次聚类过程失败: {str(e)}")
                logger.warning("跳过第二次聚类，使用第一次聚类结果继续...")
                second_labels = first_labels.copy()

            try:
                # 直接计算各维度得分（不使用聚类结果）
                logger.info("开始计算各维度得分...")
                dimension_scores = self.calculate_dimension_scores_direct(records)
                
                # 计算最终得分和评级
                logger.info("计算最终得分和评级...")
                final_scores, ratings = self.calculate_final_scores_and_ratings(dimension_scores)
            except Exception as e:
                logger.error(f"计算得分和评级失败: {str(e)}")
                raise DataAnalysisError(f"计算得分失败: {str(e)}")
            
            try:
                # 保存聚类和评分结果
                logger.info("保存聚类和评分结果到数据库...")
                self.save_results(records, first_labels, second_labels, final_scores, dimension_scores, ratings)
                
                # 记录模型评估指标
                self.log_model_metrics(records, normalized_data, first_kmeans, first_labels, silhouette_avg)
            except Exception as e:
                logger.error(f"保存结果到数据库失败: {str(e)}")
                raise DataAnalysisError(f"保存分析结果失败: {str(e)}")
            
            logger.info("聚类分析完成！")
            return True

        except InsufficientDataError as e:
            logger.error(f"数据不足: {str(e)}")
            return False
        except DataAnalysisError as e:
            logger.error(f"数据分析错误: {str(e)}")
            return False
        except Exception as e:
            logger.error(f"模型更新失败，发生未知错误: {str(e)}")
            import traceback
            traceback.print_exc()
            return False

    def analyze_cluster_characteristics(self, data, labels, feature_names):
        """分析每个聚类的特征特性"""
        data = np.array(data)
        for cluster_id in np.unique(labels):
            cluster_data = data[labels == cluster_id]
            cluster_size = len(cluster_data)
            
            # 计算该聚类在各特征上的平均值
            center = np.mean(cluster_data, axis=0)
            
            logger.info(f"\n聚类 {cluster_id} (样本数: {cluster_size}):")
            for i, feat in enumerate(feature_names):
                logger.info(f"  {feat}: {center[i]:.2f}")
            
            # 打印每个维度的平均得分
            knowledge_avg = np.mean([
                self.calculate_knowledge_score(row[0], row[1], row[2])
                for row in cluster_data[:, 0:3]
            ])
            
            attitude_avg = np.mean([
                self.calculate_attitude_score(row[0], row[1], row[2])
                for row in cluster_data[:, 3:6]
            ])
            
            # 归一化测验和作业次数
            normalized_test_counts = np.minimum(1.0, cluster_data[:, 6] / self.max_test_count)
            normalized_homework_counts = np.minimum(1.0, cluster_data[:, 7] / self.max_homework_count)
            
            interest_avg = np.mean([
                self.calculate_interest_score(test_count, homework_count, interaction_score)
                for test_count, homework_count, interaction_score in zip(
                    normalized_test_counts, 
                    normalized_homework_counts, 
                    cluster_data[:, 8]
                )
            ])
            
            logger.info(f"  维度平均分数:")
            logger.info(f"    知识技能: {knowledge_avg:.2f}")
            logger.info(f"    学习态度: {attitude_avg:.2f}")
            logger.info(f"    课程兴趣: {interest_avg:.2f}")
            
            # 计算该聚类的最终平均分
            final_avg = (
                knowledge_avg * self.dimension_weights['知识技能'] +
                attitude_avg * self.dimension_weights['学习态度'] +
                interest_avg * self.dimension_weights['课程兴趣']
            )
            logger.info(f"    最终平均分: {final_avg:.2f}")
            logger.info(f"    评级: {self.map_score_to_rating(final_avg)}")

    def calculate_knowledge_score(self, homework_score, training_pass_rate, test_completion_rate):
        """计算知识技能得分"""
        return (
            self.knowledge_skill_weights['homework_score'] * homework_score +
            self.knowledge_skill_weights['training_pass_rate'] * training_pass_rate * 100 +
            self.knowledge_skill_weights['test_completion_rate'] * test_completion_rate * 100
        )

    def calculate_attitude_score(self, sign_in_score, homework_completion_rate, video_watch_rate):
        """计算学习态度得分"""
        return (
            self.attitude_weights['sign_in_score'] * sign_in_score +
            self.attitude_weights['homework_completion_rate'] * homework_completion_rate * 100 +
            self.attitude_weights['video_watch_rate'] * video_watch_rate * 100
        )

    def calculate_interest_score(self, normalized_test_count, normalized_homework_count, interaction_score):
        """计算课程兴趣得分"""
        return (
            self.interest_weights['test_completion_count'] * normalized_test_count * 100 +
            self.interest_weights['homework_completion_count'] * normalized_homework_count * 100 +
            self.interest_weights['course_interaction_score'] * interaction_score
        )

    def calculate_dimension_scores_direct(self, records):
        """直接计算各维度得分，不使用聚类结果"""
        dimension_scores = []
        
        for record in records:
            # 1. 知识技能维度 - 直接加权平均
            knowledge_score = self.calculate_knowledge_score(
                record.homework_score,
                record.training_pass_rate,
                record.test_completion_rate
            )
            
            # 2. 学习态度维度 - 直接加权平均
            attitude_score = self.calculate_attitude_score(
                record.sign_in_score,
                record.homework_completion_rate,
                record.video_watch_rate
            )
            
            # 3. 课程兴趣维度 - 直接加权平均（需要标准化测验和作业次数）
            normalized_test_count = min(1.0, record.test_completion_count / self.max_test_count)
            normalized_homework_count = min(1.0, record.homework_completion_count / self.max_homework_count)
            
            interest_score = self.calculate_interest_score(
                normalized_test_count,
                normalized_homework_count,
                record.course_interaction_score
            )
            
            # 记录分数详情（用于调试）
            logger.debug(f"学生ID: {record.id}")
            logger.debug(f"  知识技能：{knowledge_score:.2f} (作业:{record.homework_score:.2f}, 实训:{record.training_pass_rate:.2f}, 测验:{record.test_completion_rate:.2f})")
            logger.debug(f"  学习态度：{attitude_score:.2f} (签到:{record.sign_in_score:.2f}, 作业完成:{record.homework_completion_rate:.2f}, 视频观看:{record.video_watch_rate:.2f})")
            logger.debug(f"  课程兴趣：{interest_score:.2f} (测验次数:{record.test_completion_count}, 作业次数:{record.homework_completion_count}, 互动:{record.course_interaction_score:.2f})")
            
            dimension_scores.append({
                'knowledge_score': knowledge_score,
                'attitude_score': attitude_score,
                'interest_score': interest_score
            })
            
        return dimension_scores

    def calculate_final_scores_and_ratings(self, dimension_scores):
        """计算最终得分和评级"""
        final_scores = []
        ratings = []
        
        for scores in dimension_scores:
            # 计算最终得分
            final_score = (
                self.dimension_weights['知识技能'] * scores['knowledge_score'] +
                self.dimension_weights['学习态度'] * scores['attitude_score'] +
                self.dimension_weights['课程兴趣'] * scores['interest_score']
            )
            
            # 四舍五入到整数
            final_score_rounded = round(final_score)
            
            # 确定评级
            rating = self.map_score_to_rating(final_score)
            
            final_scores.append(final_score_rounded)
            ratings.append(rating)
            
        return final_scores, ratings

    def map_score_to_rating(self, score):
        """将分数映射到评级"""
        if score >= self.rating_thresholds["优秀"]:
            return "优秀"
        elif score >= self.rating_thresholds["良好"]:
            return "良好"
        elif score >= self.rating_thresholds["中等"]:
            return "中等"
        else:
            return "待提高"

    def save_results(self, records, first_labels, second_labels, final_scores, dimension_scores, ratings):
        """保存聚类结果和学生最终得分到数据库"""
        if len(records) != len(first_labels) or \
           len(records) != len(second_labels) or \
           len(records) != len(final_scores) or \
           len(records) != len(dimension_scores) or \
           len(records) != len(ratings):
            error_msg = "输入数据长度不匹配，无法保存结果。"
            logger.error(error_msg)
            raise ValueError(error_msg)

        # 清除旧的聚类结果
        ClusterResult.objects.all().delete()

        for i, student_record_obj in enumerate(records):
            try:
                # 确保 student_record_obj 是 StudentRecord 的实例
                if not isinstance(student_record_obj, StudentRecord):
                    logger.error(f"传递给 save_results 的 records[{i}] 不是 StudentRecord 实例，而是 {type(student_record_obj)}")
                    continue

                ClusterResult.objects.create(
                    student_record=student_record_obj,
                    cluster_id=first_labels[i],  # 使用一级聚类标签作为 cluster_id
                    # first_level_cluster 和 second_level_cluster 已从模型中移除，故注释掉
                    # first_level_cluster=first_labels[i],
                    # second_level_cluster=second_labels[i],
                    final_score=final_scores[i],
                    knowledge_dimension_score=dimension_scores[i]['knowledge_score'], # 修正字段名
                    attitude_dimension_score=dimension_scores[i]['attitude_score'],   # 修正字段名
                    interest_dimension_score=dimension_scores[i]['interest_score'],   # 修正字段名
                    rating=ratings[i]  # 修正字段名
                )
            except Exception as e:
                logger.error(f"保存学生 {student_record_obj.user.username if hasattr(student_record_obj, 'user') else '未知学生'} 的聚类结果失败: {e}") # 更安全的获取用户名
        logger.info("聚类结果和最终得分已成功保存到数据库。")

    def log_model_metrics(self, records, normalized_data, kmeans, labels, silhouette_avg=None):
        """记录模型评估指标"""
        if silhouette_avg is None and len(np.unique(labels)) > 1:
            try:
                silhouette_avg = silhouette_score(normalized_data, labels)
   
            except ValueError: # Handle cases where silhouette score cannot be computed
                silhouette_avg = None
        
        # 计算总误差平方和
        total_sse = None
        if hasattr(kmeans, 'inertia_'):
            total_sse = kmeans.inertia_
        else:
            # 手动计算SSE (如果需要，但通常KMeans对象会有inertia_)
            # total_sse = np.sum((normalized_data - kmeans.cluster_centers_[labels]) ** 2)
            pass

        performance_metrics_data = {
            'sample_count': len(records),
            'total_sse': total_sse,
            'silhouette_score': silhouette_avg if silhouette_avg is not None else 'N/A',
            # 可以添加更多指标，例如 Calinski-Harabasz Score 等
        }
        
        # 记录模型日志
        ModelLog.objects.create(
            # sample_count, total_sse, silhouette_score 已移至 performance_metrics
            # model_type 可以在 __init__ 或者调用时传入，这里使用默认值或已有值
            # parameters 也可以在这里构造并传入
            performance_metrics=performance_metrics_data,
            notes=f"聚类分析完成，处理了 {len(records)} 条记录。"
        )
        logger.info(f"记录了模型评估指标：{performance_metrics_data}")

    def first_level_clustering(self, normalized_data):
        """执行第一级聚类"""
        try:
            kmeans_first = KMeans(n_clusters=3, random_state=42)
            first_labels = kmeans_first.fit_predict(normalized_data)
            return first_labels
        except Exception as e:
            raise DataAnalysisError(f"聚类分析失败: {str(e)}")

    def calculate_scores(self, student_record):
        """单个学生的评分计算（用于新添加的学生）"""
        # 计算知识技能得分
        knowledge_score = self.calculate_knowledge_score(
            student_record.homework_score,
            student_record.training_pass_rate,
            student_record.test_completion_rate
        )
        
        # 计算学习态度得分
        attitude_score = self.calculate_attitude_score(
            student_record.sign_in_score,
            student_record.homework_completion_rate,
            student_record.video_watch_rate
        )
        
        # 计算课程兴趣得分
        normalized_test_count = min(1.0, student_record.test_completion_count / self.max_test_count)
        normalized_homework_count = min(1.0, student_record.homework_completion_count / self.max_homework_count)
        
        interest_score = self.calculate_interest_score(
            normalized_test_count,
            normalized_homework_count,
            student_record.course_interaction_score
        )
        
        # 计算综合得分
        final_score = (
            knowledge_score * self.dimension_weights['知识技能'] +
            attitude_score * self.dimension_weights['学习态度'] +
            interest_score * self.dimension_weights['课程兴趣']
        )
        
        # 确定评级
        rating = self.map_score_to_rating(final_score)
        
        return knowledge_score, attitude_score, interest_score, final_score, rating

    def update_student_profile_scores(self, student_record_instance):
        """计算并更新单个学生的画像得分及ClusterResult记录"""
        if not isinstance(student_record_instance, StudentRecord):
            logger.error("传递给 update_student_profile_scores 的不是有效的StudentRecord实例")
            return False

        try:
            knowledge_score, attitude_score, interest_score, final_score, rating = self.calculate_scores(student_record_instance)

            # 更新或创建 ClusterResult
            cluster_result, created = ClusterResult.objects.update_or_create(
                student_record=student_record_instance,
                defaults={
                    'knowledge_dimension_score': knowledge_score,
                    'attitude_dimension_score': attitude_score,
                    'interest_dimension_score': interest_score,
                    'final_score': round(final_score), # 确保与批量更新时一致，四舍五入
                    'rating': rating,
                    # cluster_id 通常在全局分析时确定，此处不修改或根据需要设置为None/特定值
                    # 'cluster_id': None # or some logic if needed
                }
            )
            if created:
                logger.info(f"为学生 {student_record_instance.id} 创建了新的 ClusterResult。")
            else:
                logger.info(f"更新了学生 {student_record_instance.id} 的 ClusterResult。")
            return True
        except Exception as e:
            logger.error(f"更新学生 {student_record_instance.id} 的画像得分失败: {e}", exc_info=True)
            return False

    def determine_subcluster_count(self, cluster_data, parent_cluster_label):
        """为每个一级聚类确定合适的二级聚类数"""
        # 基础限制
        cluster_size = len(cluster_data)
        if cluster_size < 6:  # 样本太少，不进行二次聚类
            return 1
        
        # 计算数据特征
        data_variance = np.mean(np.var(cluster_data, axis=0))
        data_range = np.mean(np.ptp(cluster_data, axis=0))
        
        # 计算类内距离和类间距离比率
        distances = pdist(cluster_data)
        avg_distance = np.mean(distances)
        std_distance = np.std(distances)
        
        # 计算数据密度
        density_ratio = std_distance / avg_distance if avg_distance > 0 else 0
        
        # 基于数据特征动态确定聚类数范围
        if density_ratio > 0.7 and data_variance > 0.4:  # 高度分散
            max_subclusters = min(5, cluster_size // 6)
        elif density_ratio > 0.5 and data_variance > 0.3:  # 中度分散
            max_subclusters = min(4, cluster_size // 8)
        elif density_ratio > 0.3 and data_variance > 0.2:  # 轻度分散
            max_subclusters = min(3, cluster_size // 10)
        else:  # 高度集中
            max_subclusters = min(2, cluster_size // 12)
        
        # 确保至少有1个子类
        max_subclusters = max(1, max_subclusters)
        
        # 如果可能的聚类数大于1，使用评估方法确定最优聚类数
        if max_subclusters > 1:
            optimal_k = self.determine_optimal_clusters(
                cluster_data, max_clusters=max_subclusters)
            
            logger.info(f"一级聚类{parent_cluster_label}的二级聚类分析:")
            logger.info(f"  样本数: {cluster_size}")
            logger.info(f"  数据方差: {data_variance:.3f}")
            logger.info(f"  数据范围: {data_range:.3f}")
            logger.info(f"  密度比率: {density_ratio:.3f}")
            logger.info(f"  最大可能聚类数: {max_subclusters}")
            logger.info(f"  选择的最优聚类数: {optimal_k}")
            
            return optimal_k
        else:
            return 1

    def determine_optimal_clusters(self, data, max_clusters=10):
        """使用多种方法综合确定最优聚类数"""
        # 样本数限制
        n_samples = len(data)
        max_possible_clusters = min(max_clusters, n_samples // 5)
        
        if max_possible_clusters < 2:
            return 2  # 确保至少有2个聚类
        
        # 计算不同聚类数的评估指标
        silhouette_scores = []
        calinski_scores = []
        inertia_values = []
        
        for k in range(2, max_possible_clusters + 1):
            kmeans = KMeans(n_clusters=k, random_state=42, n_init=10)
            labels = kmeans.fit_predict(data)
            
            # 计算轮廓系数
            try:
                silhouette_avg = silhouette_score(data, labels)
                silhouette_scores.append(silhouette_avg)
            except:
                silhouette_scores.append(-1)  # 无效值
            
            # 计算Calinski-Harabasz指数
            try:
                calinski_avg = calinski_harabasz_score(data, labels)
                calinski_scores.append(calinski_avg)
            except:
                calinski_scores.append(0)  # 无效值
            
            # 计算惯性（簇内平方和）
            inertia_values.append(kmeans.inertia_)
        
        # 归一化各指标
        if silhouette_scores and max(silhouette_scores) > 0:
            norm_silhouette = [s/max(silhouette_scores) for s in silhouette_scores]
        else:
            norm_silhouette = [0] * len(silhouette_scores)
        
        if calinski_scores and max(calinski_scores) > 0:
            norm_calinski = [c/max(calinski_scores) for c in calinski_scores]
        else:
            norm_calinski = [0] * len(calinski_scores)
        
        # 计算惯性变化率（肘部法则）
        inertia_changes = []
        for i in range(1, len(inertia_values)):
            change = (inertia_values[i-1] - inertia_values[i]) / inertia_values[i-1]
            inertia_changes.append(change)
        inertia_changes.append(0)  # 补齐长度
        
        # 综合评分 (权重可调整)
        combined_scores = [
            0.4 * s + 0.3 * c + 0.3 * i 
            for s, c, i in zip(norm_silhouette, norm_calinski, inertia_changes)
        ]
        
        # 选择最优聚类数
        optimal_k = combined_scores.index(max(combined_scores)) + 2
        
        # 记录评估过程
        logger.info(f"最优聚类数评估结果:")
        for k in range(2, max_possible_clusters + 1):
            i = k - 2
            logger.info(f"  聚类数={k}: 轮廓系数={silhouette_scores[i]:.3f}, "
                       f"CH指数={calinski_scores[i]:.1f}, 惯性变化={inertia_changes[i]:.3f}, "
                       f"综合评分={combined_scores[i]:.3f}")
        logger.info(f"选择的最优聚类数: {optimal_k}")
        
        return optimal_k