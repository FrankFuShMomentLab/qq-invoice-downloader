@echo off
:: QQ邮箱发票下载器 - OpenClaw Skill 一键安装脚本
:: 用法: 双击运行，或在 cmd 中执行 install.bat

set "SKILLS_DIR=%USERPROFILE%\.openclaw\skills"
set "SKILL_NAME=qq-invoice-downloader"
set "REPO_URL=https://github.com/FrankFuShMomentLab/qq-invoice-downloader.git"

echo ========================================
echo  QQ邮箱发票下载器 - OpenClaw Skill 安装
echo ========================================
echo.

:: 1. 克隆/更新仓库到临时目录
echo [1/3] 克隆 skill 仓库...
if exist "%TEMP%\%SKILL_NAME%" (
    rmdir /s /q "%TEMP%\%SKILL_NAME%"
)
git clone "%REPO_URL%" "%TEMP%\%SKILL_NAME%"
if errorlevel 1 (
    echo ERROR: git clone 失败，请确认已安装 Git
    pause
    exit /b 1
)

:: 2. 复制到 OpenClaw skills 目录
echo [2/3] 安装到 OpenClaw skills 目录...
if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"
if exist "%SKILLS_DIR%\%SKILL_NAME%" (
    rmdir /s /q "%SKILLS_DIR%\%SKILL_NAME%"
)
xcopy /e /i /y "%TEMP%\%SKILL_NAME%" "%SKILLS_DIR%\%SKILL_NAME%"
if errorlevel 1 (
    echo ERROR: 复制文件失败
    pause
    exit /b 1
)

:: 3. 启用 skill（修改 OpenClaw 配置）
echo [3/3] 启用 skill...
python -c "import json, os, sys
config_path = os.path.join(os.path.expanduser('~'), '.openclaw', 'openclaw.json')
with open(config_path, 'r', encoding='utf-8') as f:
    config = json.load(f)
if 'skills' not in config: config['skills'] = {}
if 'entries' not in config['skills']: config['skills']['entries'] = {}
config['skills']['entries']['%SKILL_NAME%'] = {'enabled': True}
with open(config_path, 'w', encoding='utf-8') as f:
    json.dump(config, f, ensure_ascii=False, indent=2)
print('done')
" 2>nul

echo.
echo ========================================
echo  安装完成！
echo ========================================
echo.
echo 请重启 OpenClaw (openclaw restart)
echo.
echo 首次使用前需要配置环境变量:
echo   Windows:  set QQ_EMAIL=你的邮箱
echo             set QQ_PASSWORD=你的授权码
echo.
pause
