# Ansibleプレイブック開発実行環境構築

## 概要
- Ansibleプレイブックを開発及び実行する環境は、Devcontainerを使用して構築します。
  - Devcontainerを使用すると、業務PCにインストールされたVScodeからVM上のコンテナ内にプレイブック開発実行環境を自動で構築することができます。
  - [devcontainerの利用イメージ](https://cacoo.com/diagrams/2Fzc28YvN1gsZgnd/9619E)
- 本ドキュメントでは、Devcontainerを使用したプレイブック開発実行環境構築の手順を記載します。

## 手順
- 業務PC設定
- プレイブック開発実行用VM設定
- 環境構築確認

## 業務PC設定
### 必須ソフトウェアのインストール
- 以下のソフトウェアをインストールしてください。
  - VScode
    - https://code.visualstudio.com/download
  - VScodeのRemote Development extension
    - https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack

### SSH設定
- 業務PCの`ssh_config`を編集し、プレイブック開発実行用VMにSSHでログインできるよう設定してください。
- 可能であれば`ssh-agent`を設定してください。

## プレイブック開発実行用VM設定

### プレイブック開発実行用VMにログイン
- 業務PCからプレイブック開発実行用VMに、SSH経由でログインしてください。

### ユーザ作成
- プレイブックを開発する人用の個人ユーザを作成してください。
- 業務PCからプレイブック開発実行用VMにSSH経由で接続できるよう、個人ユーザのauthorized_keysに公開鍵を登録してください。

### Gitインストール
- Gitをインストールしてください。
- 個人ユーザ毎に`user.name`と`user.email`を設定してください。
```
git config --global user.name <Firstname Lastname>
```
```
git config --global user.email <username>@idcf.jp
```

### Dockerインストール
- Dockerをインストールしてください。
  - [公式の手順](https://docs.docker.com/engine/install/)
- 個人ユーザがsudoなしでdockerコマンドを実行できるよう設定してください。
  - [公式の手順](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)

### Gitレポジトリをクローン
- Gitレポジトリを任意の場所にクローンしてください。
```console
git clone git@github.com:idcf-private/ops-architect.git
```

## 環境構築確認
### VScodeでプレイブック開発実行用VM上のGitレポジトリを開く
- VScodeのRemote Developmentの機能を使用し、プレイブック開発実行用VMに接続してください。
- VScodeでクローンしたGitレポジトリを開いてください。

### 環境変数用ファイルの用意
- .devcontainer/.env
  - コンテナビルド時の環境変数を設定してください。
```env
UID=プレイブック開発実行用VM用上のユーザのUID(Ex. 1000)
GID=プレイブック開発実行用VM用上のユーザのGID(Ex. 1000)
```

### コンテナのビルド&起動&接続
- VScode上で`F1` -> `Dev Containers: Rebuild and Reopen in Container`を実行してください。
  - 初回実行時はコンテナのビルドが実行されるので数分程度時間がかかります。

### Ansibleバージョン確認
- VScodeでターミナルを開き、`ansible --version`コマンドを実行してください。
  - Pythonの仮想環境が自動で有効化されない場合、VScodeでプレイブックのファイルを一つ開いてからターミナルを開いてください。
```console
(ansible-workspace) vscode@524a744b1252:/workspace$ ansible --version
ansible [core 2.18.6]
  config file = None
  configured module search path = ['/home/vscode/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /app/.venv/lib/python3.13/site-packages/ansible
  ansible collection location = /home/vscode/.ansible/collections:/usr/share/ansible/collections
  executable location = /app/.venv/bin/ansible
  python version = 3.13.5 (main, Jul 11 2025, 22:43:46) [Clang 20.1.4 ] (/app/.venv/bin/python)
  jinja version = 3.1.6
  libyaml = True
```

## その他
### プレイブック開発実行環境への再接続
- `VScodeでプレイブック開発実行用VM上のGitレポジトリを開く`の手順を実行してください。
- VScode上で`F1` -> `Dev Containers: Reopen in Container`を実行してください。
