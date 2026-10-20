#!/bin/bash
# スタックチャンの朝の声かけ（cron 例: 30 7 * * * /path/to/morning_call.sh）
# <GATEWAY_LAN_IP> をゲートウェイを動かしている PC の LAN IP に置き換えてください。
mkdir -p "$HOME/groki-setup/logs"
/usr/bin/curl -s -m15 -X POST -H 'Content-Type: application/json' \
  -d '{"text":"（システムからの朝の連絡。ユーザーはまだ話していない）元気に「おはよう！今日の予定とメール、天気をまとめて聞く？」とだけ声に出して聞いて、返事を待つ。"}' \
  http://<GATEWAY_LAN_IP>:8766/debug/inject-text >> "$HOME/groki-setup/logs/morning_call.log" 2>&1
echo " $(date)" >> "$HOME/groki-setup/logs/morning_call.log"
