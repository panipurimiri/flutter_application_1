#!/bin/bash

# lib フォルダ内の対象ファイルをリストアップ
files=(lib/crypto_bg_color_*.dart)

for file in "${files[@]}"; do
  echo "------------------------------------------------"
  echo "🚀 実行中: $file"
  echo "📸 スクショを撮ったら、ターミナルで【Enter】を押して次へ進みます"
  echo "------------------------------------------------"

  # Flutterをバックグラウンドで実行
  flutter run -t "$file" &
  
  # プロセスIDを取得
  FLUTTER_PID=$!

  # ユーザーの入力待ち（ここでスクショを撮る時間を確保）
  read -p "次へ進むには Enter を押してください..."

  # Flutterプロセスを終了（qと同じ役割）
  kill $FLUTTER_PID
  
  # 終了処理を待つ
  sleep 2
done

echo "✅ 全てのファイルの実行が完了しました！"
