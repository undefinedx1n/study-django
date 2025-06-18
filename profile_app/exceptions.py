class DataAnalysisError(Exception):
    """机器学习数据分析过程中的自定义异常"""
    pass

class InsufficientDataError(DataAnalysisError):
    """数据样本不足时的异常"""
    pass