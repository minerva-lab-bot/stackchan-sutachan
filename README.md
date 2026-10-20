<p align="center"><img src="docs/banner.jpg" alt="すたちゃん" width="100%"></p>

# スタックチャン × Groki Bot カスタム（すたちゃん）

市販のスタックチャン（M5Stack CoreS3）＋オープンソースの [Groki Bot](https://github.com/JosssphZhou/groki-bot) を、AI と一緒に自分好みにカスタムしたものです。一から作ったわけではなく、上流プロジェクトに小さなパッチと設定を足しただけです。誰でも好きに真似して、自由にカスタムしてください。

## できること
- ウェイクワード「すたちゃん」で起動（予備で「Hi Grok」も）
- 呼んだ時だけ動く（勝手に首を振るアイドル動作と顔追従をオフ）
- Mac に挿した USB マイク対応（ffmpeg / avfoundation 経由）
- 頭をなでると「なでなで♡」の吹き出し
- 「寝て」で眠り、「すたちゃん、起きて」で起きる
- 毎朝 7:30 に声かけ →「うん」で今日の予定・大事なメール・天気を読み上げ
- お店の売上確認（エージェント経由）
- Chatwork でスタッフ宛ての下書き作成（送信前に必ず確認）
- その他: スピーカー再生が会話を重ねるごとに遅く・ガサガサになる不具合の修正（M5Unified）、中継の再接続修正

## 構成
```
patches/firmware.patch   ファームウェア (main/demo_loop.cpp)
patches/firmware-M5Unified.patch  M5Unified サブモジュール (スピーカー修正)
patches/gateway.patch    ゲートウェイ (USBマイク、複数ウェイクワード、再接続修正)
examples/.env.example    gateway/.env に追記する設定例（<...> を自分の値に）
examples/morning_call.sh 朝の声かけスクリプト（cron 用）
LICENSE                  上流と同じ Boost Software License 1.0
```

## 使い方
```bash
git clone --recursive https://github.com/JosssphZhou/groki-bot.git
cd groki-bot
git apply /path/to/patches/gateway.patch
git apply /path/to/patches/firmware.patch
# M5Unified はサブモジュールなので中で当てる
(cd components/M5Unified && git apply /path/to/patches/firmware-M5Unified.patch)
```
その後は上流 README の手順でファームウェアをビルド・書き込みし、`gateway/.env` に `examples/.env.example` の内容を追記してゲートウェイを起動します。

朝の声かけ: `examples/morning_call.sh` の `<GATEWAY_LAN_IP>` を書き換え、`crontab -e` で
`30 7 * * * /path/to/morning_call.sh` を追加。

※ パッチは上流の特定コミット時点のものです。上流が更新されていると当たらない場合があります。

## クレジット・ライセンス
- 上流: [JosssphZhou/groki-bot](https://github.com/JosssphZhou/groki-bot)（Boost Software License 1.0）
- M5Unified の修正部分は M5Unified（MIT License）のファイルに対する変更です
- このリポジトリのパッチ・設定例も上流に合わせて Boost Software License 1.0 で公開します（LICENSE 参照）
- スタックチャンは ししかわ さん発のオープンソースロボットです
