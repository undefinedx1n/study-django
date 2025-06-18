// 学习者画像系统 - 简化版主题切换器
document.addEventListener('DOMContentLoaded', function() {
    // 获取DOM元素
    const themeSwitcherBtn = document.getElementById('themeSwitcherButton');
    const themeSwitcherDropdown = document.getElementById('themeSwitcherDropdown');
    const themeIcon = document.getElementById('currentThemeIcon');
    const darkModeToggle = document.getElementById('darkModeToggle');
    
    // 主题配置
    const themes = [
        { name: '青色', className: 'theme-teal', icon: 'fas fa-tint' },
        { name: '蓝色', className: 'theme-blue', icon: 'fas fa-water' },
        { name: '紫色', className: 'theme-purple', icon: 'fas fa-fill-drip' },
        { name: '红色', className: 'theme-red', icon: 'fas fa-fire' },
        { name: '灰色', className: 'theme-gray', icon: 'fas fa-moon' }
    ];
    
    // 从localStorage中获取保存的主题和暗黑模式设置
    let currentTheme = localStorage.getItem('theme') || 'theme-blue';
    let isDarkMode = localStorage.getItem('darkMode') === 'true';
    
    // 应用保存的主题和暗黑模式
    applyTheme(currentTheme);
    if (isDarkMode) {
        document.body.classList.add('dark-mode');
        if (darkModeToggle) {
            darkModeToggle.innerHTML = '<i class="fas fa-sun me-2"></i>亮色模式';
        }
    } else {
        document.body.classList.remove('dark-mode');
        if (darkModeToggle) {
            darkModeToggle.innerHTML = '<i class="fas fa-moon me-2"></i>暗色模式';
        }
    }
    
    // 生成主题下拉菜单
    if (themeSwitcherDropdown) {
        // 添加主题选项
        themes.forEach(theme => {
            const li = document.createElement('li');
            const a = document.createElement('a');
            a.className = 'dropdown-item';
            a.href = '#';
            a.innerHTML = `<i class="${theme.icon} me-2"></i>${theme.name}`;
            a.dataset.theme = theme.className;
            
            a.addEventListener('click', function(e) {
                e.preventDefault();
                applyTheme(theme.className);
                localStorage.setItem('theme', theme.className);
            });
            
            li.appendChild(a);
            themeSwitcherDropdown.appendChild(li);
        });
        
        // 添加分隔线
        const divider = document.createElement('li');
        divider.innerHTML = '<hr class="dropdown-divider">';
        themeSwitcherDropdown.appendChild(divider);
        
        // 添加暗黑模式切换
        const darkModeLi = document.createElement('li');
        const darkModeA = document.createElement('a');
        darkModeA.className = 'dropdown-item';
        darkModeA.href = '#';
        darkModeA.id = 'darkModeToggle';
        darkModeA.innerHTML = isDarkMode ? 
            '<i class="fas fa-sun me-2"></i>亮色模式' : 
            '<i class="fas fa-moon me-2"></i>暗色模式';
        
        darkModeA.addEventListener('click', function(e) {
            e.preventDefault();
            toggleDarkMode();
        });
        
        darkModeLi.appendChild(darkModeA);
        themeSwitcherDropdown.appendChild(darkModeLi);
    }
    
    // 切换暗黑模式
    function toggleDarkMode() {
        isDarkMode = !isDarkMode;
        localStorage.setItem('darkMode', isDarkMode);
        
        if (isDarkMode) {
            document.body.classList.add('dark-mode');
            if (darkModeToggle) {
                darkModeToggle.innerHTML = '<i class="fas fa-sun me-2"></i>亮色模式';
            }
        } else {
            document.body.classList.remove('dark-mode');
            if (darkModeToggle) {
                darkModeToggle.innerHTML = '<i class="fas fa-moon me-2"></i>暗色模式';
            }
        }
    }
    
    // 应用主题
    function applyTheme(themeClass) {
        // 移除所有主题类
        themes.forEach(theme => {
            document.body.classList.remove(theme.className);
        });
        
        // 添加当前主题类
        document.body.classList.add(themeClass);
        currentTheme = themeClass;
        
        // 更新主题图标
        const selectedTheme = themes.find(theme => theme.className === themeClass);
        if (selectedTheme && themeIcon) {
            themeIcon.className = `${selectedTheme.icon} me-1`;
        }
    }
});