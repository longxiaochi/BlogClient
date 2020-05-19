//
//  HomePageView.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class HomePageView: PageView {
    var tableView: UITableView!
    var dataSource: [BlogItem] = [BlogItem]()
    var isRequesting: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Method
extension HomePageView {
    // load data
    func loadPageData() {
        if dataSource.count == 0  {
            requestData()
        }
    }
    
    // request
    func requestData() {
        if (isRequesting) { return }
        isRequesting = true
        HomeService.getHomeBlogInfo(pageSize: 20, pageIndex: 1) { [weak self] (result, status) in
            switch status {
            case .success:
                let items = result as! [BlogItem]
                self?.dataSource = items
                self?.tableView.reloadData()
            case .failure:
                log("fail")
            }
            
            self?.isRequesting = false
        }
    }
}

// MARK: - InitViewProtocol
extension HomePageView: InitViewProtocol {
    func initView() {
        tableView = UITableView.lc.initTableView(frame: CGRect.zero, style: .plain, delegate: self, dataSource: self, separatorStyle: .none, showIndicator: false)
        self.addSubview(tableView)
    }
    
    func autoLayoutView() {
        tableView.mas_makeConstraints { (make) in
            make?.leading.trailing()?.bottom()?.top()?.mas_equalTo()(self)?.offset()(0)
        }
    }
}

// MARK: - UITableViewDelegate
extension HomePageView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension HomePageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "sdsdfsdf"
        return cell
    }
}
