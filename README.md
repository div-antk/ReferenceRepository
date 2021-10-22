# リファレンスリポジトリ

## 概要

QiitaのAPIを使用したクライアントアプリです。  
弊社で使用しているiOSの基本的な技術、ライブラリ、及びアーキテクチャで構成されています。  
新しくアサインされたメンバーが技術体系を学ぶ、または取り入れてみたいライブラリを実験として使う場としてのリポジトリを想定しています。  

### 主に使われている技術

- MVVMアーキテクチャにおけるRxSwiftの基本的なデータバインディング
- 基礎的なライブラリを使用したAPI通信、及びRepositoryを絡めた実装
  - 記事一覧の取得、RxSwiftを使用したフリーワード検索機能
- tableViewの基礎的な実装
- 基礎的なユニットテスト

#### MVVM

以下の観点に基づいた設計としてKickstarterのインターフェースを参考にしています。  

- 入力と出力は違いが識別できるか
- 入力は外部から読み出しができないようになっているか
- 入力は必須か
- 入力はストリームを渡せるか

## gitignoreを記入

Vimで書く場合。  

```
vi .gitignore
```

ファイルを作成してIDEで書きたい場合。  

```
touch .gitignore
```

## SwiftLint導入

導入のためにMintをインストール。  

```terminal
brew install mint
```

SwiftLintを導入。  

```terminal
mint install realm/swiftlint
```

`mint list` でインストールされているか確認できる。  

### スクリプトを記述

- Xcodeで対象のプロジェクトファイルを開く> TARGETS
- 対象のターゲットを選択 > Build Phases
- 左上にある+ をクリック> New Run Script Phase

```
if which mint >/dev/null; then
  mint run swiftlint swiftlint autocorrect --format
  mint run swiftlint swiftlint
else
  echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
fi
```

スクリプト以外の項目はいじらなくていい。  

### yml（設定ファイル）の作成

ルートディレクトリ（xcodeprojと同じ階層）に `.swiftlint.yml` を作成。  
この中に設定を書く。  
ビルドされるたびにこの設定に基づいて警告が出てくれる。  
`swiftlint rules` で設定を確認できる。  

## ライブラリ

CocoaPodsを使用してインストールする。  

```terminal
pod install
```

### RxSwift、RxCocoa

割愛

### Moya、Alamofire

API通信ライブラリ。  
本リポジトリでは使用例として両方入れているが、実際はどちらかでOK。  

### Instantiate

導入にあたって Main.storyboard のファイル名をViewControllerと同じ名前に修正する必要がある。  

**修正方法**  
<https://qiita.com/antk/items/0f8eed4a2cf3ba4f638c>

### Kingfisher

画像をキャッシュするライブラリ。  
本リポジトリではプロフィール画像を表示するためにURLから画像をキャッシュしている。  

```swift
let imageUrl = URL(string: article.user.profile_image_url)
cell.userImageView.kf.setImage(with: imageUrl)
```

### Quick/Nimble

ユニットテストのためのライブラリ。  
「期待と結果が一致するか」が確認できるのはXCTest（Xcodeに標準で入ってる）と変わらないが「より要求仕様に近い形でテストコードを表現しよう」という考え方が特徴。  

