@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ========================================
echo    团建组织人抽签小程序  -  一键发布
echo ========================================
echo.

REM 第 1 步：把主文件同步为 index.html（GitHub Pages 用它作为首页）
copy /Y "团建组织人抽签小程序.html" "index.html" >nul
if errorlevel 1 (
  echo [错误] 当前目录找不到 "团建组织人抽签小程序.html"
  echo        请把本脚本和该网页文件放在同一个文件夹里。
  echo.
  pause
  exit /b 1
)
echo [1/3] 已更新 index.html

REM 第 2 步：提交改动
git add -A
git commit -m "更新 %date% %time%" >nul 2>&1
if errorlevel 1 (
  echo [2/3] 没有检测到新的改动，跳过提交。
) else (
  echo [2/3] 已提交本次改动。
)

REM 第 3 步：推送到 GitHub
echo [3/3] 正在推送到 GitHub ...
git push
if errorlevel 1 (
  echo.
  echo [错误] 推送失败，请检查网络连接或 GitHub 登录状态。
  echo.
  pause
  exit /b 1
)

echo.
echo ========================================
echo    发布成功！约 1 分钟后线上自动生效：
echo    https://link10086.github.io/team-draw/
echo ========================================
echo.
pause
