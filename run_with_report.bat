@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   QQ邮箱发票下载器 v8.1 - 自动报告版
echo ========================================
echo.

set SKILL_DIR=C:\Users\admin\.openclaw\workspace\skills\skills\qq-invoice-downloader
set OUTPUT_DIR=Z:\OpenClaw\InvoiceOC

REM 检查参数
if "%1"=="" (
    echo 用法: run_invoice_downloader.bat [开始日期] [结束日期]
    echo 示例: run_invoice_downloader.bat 260201 260310
    echo.
    echo 或直接运行以下命令:
    echo   python %SKILL_DIR%\invoice_downloader_v81.py 260201 260310
    exit /b 1
)

REM 运行发票下载器
echo [1/2] 运行发票下载器...
python %SKILL_DIR%\invoice_downloader_v81.py %1 %2

REM 写入最新报告路径
echo [2/2] 更新报告记录...
python %SKILL_DIR%\write_latest.py

echo.
echo ========================================
echo   下载完成! 
echo   最新报告路径已记录.
echo   请告知 momo 发送报告到 webchat
echo ========================================
