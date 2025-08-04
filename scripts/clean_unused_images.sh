#!/bin/bash

################################################################################
# 脚本名称: clean_unused_images.sh
# 功能描述: 自动检测并删除Flutter项目中未使用的图片资源
# 适用项目结构:
#   yinqishe_app/
#   ├── lib/
#   │   └── generate/
#   │       └── app_image_path.dart  # 自动生成的图片路径文件
#   └── scripts/
#       ├── clean_unused_images.sh    # 本脚本
#       └── temp/                    # 临时文件夹（自动创建和清理）
################################################################################

### ---------------------------- 使用方法 -------------------------------- ###
# 1. 准备脚本
#    - 确保脚本位于项目根目录的 scripts/ 子目录中
#    - 赋予执行权限:
#      chmod +x scripts/clean_unused_images.sh
#
# 2. 执行脚本（在任意目录运行）:
#    ./scripts/clean_unused_images.sh
#
# 3. 执行流程:
#    [1] 提取声明的图片路径常量
#    [2] 扫描代码中使用的图片常量
#    [3] 有效性检查（检测拼写错误/未定义常量）
#    [4] 生成未使用图片清单
#    [5] 交互式确认删除
#    [6] 清理临时文件
#
# 4. 执行结果示例:
#    ✔ 成功运行:
#       === 行数统计 ===
#        237 declared_mapping.txt
#        172 used_constants.txt
#         65 unused_images.txt
#       [显示未使用的图片清单...]
#    
#    ✘ 发现错误:
#       === 错误：以下常量未定义 ===
#       invalid_constant_1
#       invalid_constant_2
#
# 5. 注意事项:
#    - 删除操作不可逆！建议先提交代码到Git
#    - 动态拼接的图片路径需手动检查
#    - Android Studio需重启刷新资源索引
### ---------------------------------------------------------------------- ###

# ---------------------------- 路径配置 -------------------------------- #
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"       # 脚本所在目录
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"            # 项目根目录
TEMP_DIR="$SCRIPT_DIR/temp"                       # 临时文件目录

# ---------------------------- 初始化清理 ------------------------------ #
# 清理旧临时文件并创建目录
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

# ---------------------------- 核心逻辑 -------------------------------- #
# [步骤1] 提取常量名与路径的映射关系
echo "正在解析图片路径声明..."
grep "static const String" "$PROJECT_DIR/lib/generate/app_image_path.dart" \
  | sed -E "s/static const String ([a-zA-Z0-9_]+) *= *'([^']+)';/\1 \2/" \
  | sort -u > "$TEMP_DIR/declared_mapping.txt"

# [步骤2] 收集实际使用的常量名
echo "正在扫描代码引用..."
grep -rnh --include='*.dart' -Eo 'AppImagePath\.\w+' "$PROJECT_DIR/lib/" \
  | awk -F'.' '{print $2}' \
  | sort -u > "$TEMP_DIR/used_constants.txt"

# [步骤3] 检查无效常量（未定义的引用）
echo "正在验证常量有效性..."
awk 'NR==FNR {declared[$1]=1; next} !declared[$1] {print $1}' \
  "$TEMP_DIR/declared_mapping.txt" \
  "$TEMP_DIR/used_constants.txt" > "$TEMP_DIR/invalid_constants.txt"

# 错误处理：存在无效常量
if [ -s "$TEMP_DIR/invalid_constants.txt" ]; then
  echo -e "\n\033[31m‼️  错误：发现未定义的常量引用（共 $(wc -l < "$TEMP_DIR/invalid_constants.txt") 处）\033[0m"
  echo -e "\033[31m===============================================\033[0m"
  cat "$TEMP_DIR/invalid_constants.txt"
fi

# [步骤4] 生成未使用图片清单
echo "正在生成未使用资源清单..."
awk 'NR==FNR {used[$1]=1; next} !used[$1] {print $2}' \
  "$TEMP_DIR/used_constants.txt" \
  "$TEMP_DIR/declared_mapping.txt" > "$TEMP_DIR/unused_images.txt"

# ---------------------------- 结果展示 -------------------------------- #
clear
echo -e "\n\033[34m================ 资源清理报告 ================\033[0m"
echo -e "项目目录: \033[35m$PROJECT_DIR\033[0m"
echo -e "扫描结果:"
echo -e "  - 已声明图片: \033[33m$(wc -l < "$TEMP_DIR/declared_mapping.txt")\033[0m"
echo -e "  - 使用中图片: \033[32m$(wc -l < "$TEMP_DIR/used_constants.txt")\033[0m"
echo -e "  - 未使用图片: \033[31m$(wc -l < "$TEMP_DIR/unused_images.txt")\033[0m"
echo -e "\033[34m=============================================\033[0m"

# 显示未使用图片清单
if [ -s "$TEMP_DIR/unused_images.txt" ]; then
  echo -e "\n\033[31m以下图片未被使用:\033[0m"
  cat "$TEMP_DIR/unused_images.txt"
else
  echo -e "\n\033[32m✅ 未发现未使用的图片资源！\033[0m"
  rm -rf "$TEMP_DIR"
  exit 0
fi

# ---------------------------- 交互删除 -------------------------------- #
echo -e "\n\033[31m‼️  警告：删除操作不可逆！\033[0m"
read -p "是否确认删除以上文件？(y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "\n\033[31m开始删除未使用图片...\033[0m"
  while read -r image; do
    full_path="$PROJECT_DIR/$image"
    if [ -f "$full_path" ]; then
      rm "$full_path"
      echo -e "已删除: \033[31m$image\033[0m"
    else
      echo -e "文件不存在: \033[33m$image\033[0m"
    fi
  done < "$TEMP_DIR/unused_images.txt"
fi

# ---------------------------- 清理退出 -------------------------------- #
rm -rf "$TEMP_DIR"
echo -e "\n\033[32m✅ 操作完成！\033[0m"
echo -e "\n\033[32m✅ 请重新生成本地化字符串 \033[0m"