# リファレンスリポジトリ

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

バージョンも指定できる。

```terminal
mint install realm/swiftlint@0.24.2
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
この中に設定を書く。内容は割愛。  
ビルドされるたびにこの設定に基づいて警告が出てくれる。  
`swiftlint rules` で設定を確認できる。

## ライブラリ

### Cocoapodsの導入

```terminal
pod init
```

Podfileを編集する（ここではVimを使っているが任意）

```terminal
vi Podfile
```

```
  pod 'Moya/RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'Instantiate'
  pod 'InstantiateStandard'
  pod 'Kingfisher'
```

```terminal
pod install
```

### RxSwift、RxCocoa

割愛

### Moya、Alamofire

API通信ライブラリ。  
使用例として両方入れているが片方でOK。  

### Instantiate

導入にあたって Main.storyboard のファイル名をViewControllerと同じ名前に修正する必要がある。  

**修正方法**  
<https://qiita.com/antk/items/0f8eed4a2cf3ba4f638c>

### Kingfisher

画像ライブラリ。  
ここではプロフィール画像を表示するために使用する。  

