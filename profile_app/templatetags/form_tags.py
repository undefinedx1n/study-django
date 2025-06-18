from django import template

register = template.Library()

@register.filter(name='add_class')
def add_class(value, arg):
    css_classes = value.field.widget.attrs.get('class', '')
    if css_classes:
        css_classes = f"{css_classes} {arg}"
    else:
        css_classes = arg
    return value.as_widget(attrs={'class': css_classes})

@register.filter(name='multiply')
def multiply(value, arg):
    """将一个值乘以指定的倍数，用于百分比显示"""
    try:
        return float(value) * float(arg)
    except (ValueError, TypeError):
        return value