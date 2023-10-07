import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="spot-list"
export default class extends Controller {
  static targets = ["spotListContainer"];

  switchTabContent(event) {
    // 表示されているタブとコンテンツを消す処理
    // アクティブ状態だとtabには.tab-active.text-primary.bg-base-100がついている
    // .tab-activeをもつDOMから上記クラスをremoveさせる
    // Element: removeAttribute() メソッド

    // コンテンツには特になし。アクティブでないコンテンツに.hiddenがついている
    // タブから紐づく形でコンテンツを発見させて要素を変えたい
    // .contents_activeを検討したがTabと紐づかなければ処理に違和感がある
    // tabにdata-tab-numberでナンバリングする
    // `.contenttab${Number}`でquerySelectorで取得する

    // クリックしたタブをアクティブにする処理
    // クリックしたタブに紐づいたコンテンツを表示させる処理


    );
  }
}
