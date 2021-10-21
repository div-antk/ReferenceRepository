//
//  WebViewController.swift
//  ReferenceRepository
//
//  Created by Takuya Ando on 2021/09/28.
//

import UIKit
import WebKit
import Instantiate
import InstantiateStandard

class WebViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet private weak var webView: WKWebView!

    struct Dependency {
        let url: URL
    }

    func inject(_ dependency: Dependency) {
        url = dependency.url
    }

    // swiftlint:disable implicitly_unwrapped_optional
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSURLRequest(url: url)
        webView.load(request as URLRequest)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
