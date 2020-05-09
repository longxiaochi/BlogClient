//
//  MeViewController.swift
//  BlogClient
//
//  Created by Long on 2020/4/27.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit


class MeViewController: UIBaseViewController {
    let bgImageHeight: CGFloat = 230

    var tableView: UITableView!
    var backgroundImage: UIImageView!
    let dataSource = [
        [R.image.accountSetting() as Any, R.string.localizable.setting(), R.image.rightArrow() as Any],
        [R.image.accountFeedback() as Any, R.string.localizable.feedback(), R.image.rightArrow() as Any],
        [R.image.accountAbout() as Any, R.string.localizable.about(), R.image.rightArrow() as Any]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = R.color.white_FFFFFF()
        self.setupUI()
    }
}

// MARK: - InitViewProtocol
extension MeViewController: InitViewProtocol {
    func InitView() {
        backgroundImage = UIImageView.lc.initImageView(frame: CGRect.init(x: 0, y: 0, width:self.view.lc.width , height: bgImageHeight), image: R.image.accountBackgroundImage())
        self.view.addSubview(backgroundImage)
        
        tableView = UITableView.lc.initTableView(frame: .zero, style: .plain, delegate: self, dataSource: self, separatorStyle: .none)
        tableView.backgroundColor = UIColor.clear
        tableView.register(R.nib.meTableViewCell)
        
        let tableHeadView = MeTableHeadView(frame: CGRect.init(x: 0, y: 0, width: self.view.lc.width, height: 290))
        tableHeadView.delegate = self
        tableView.tableHeaderView = tableHeadView
        
        self.view.addSubview(tableView)
    }
    
    func AutoLayoutView() {
        tableView.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.view)?.offset()(0)
        }
    }
}

// MARK: - MeTableHeadViewDelegate
extension MeViewController: MeTableHeadViewDelegate {
    func selectMyBlog() {
        log("selectMyBlog")
    }
    
    func selectEssay() {
        log("selectEssay")
    }
    
    func selectFave() {
        log("selectFave")
    }
    
    func selectSetting() {
        log("selectSetting")
    }

    func selectFeedback() {
        log("selectFeedback")
    }

    func selectAbout() {
        log("selectAbout")
    }
}

// MARK: - UITableViewDelegate
extension MeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.selectSetting()
        } else if indexPath.row == 1 {
            self.selectFeedback()
        } else if indexPath.row == 2 {
            self.selectAbout()
        }
    }
}

// MARK: - UITableViewDataSource
extension MeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.meTableViewCell, for: indexPath)
        let objInfo = dataSource.lc.objectAtIndex(indexPath.row) as? [Any]
        
        cell?.configCell(icon: objInfo?.lc.objectAtIndex(0) as? UIImage, content: objInfo?.lc.objectAtIndex(1) as? String ?? "", arrowIcon: objInfo?.lc.objectAtIndex(2) as? UIImage)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UIScrollViewDelegate
extension MeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetSetY: CGFloat = scrollView.contentOffset.y
        
        if (offsetSetY > 0) {
            backgroundImage.frame = CGRect.init(x: 0, y: -offsetSetY, width: self.view.lc.width, height: bgImageHeight)
        } else {
            let curBgImgHeight = bgImageHeight - offsetSetY
            let curBgImgWidth = (self.view.lc.width / bgImageHeight) * curBgImgHeight
            backgroundImage.frame = CGRect.init(x: -(curBgImgWidth - self.view.lc.width)/2, y: 0, width: curBgImgWidth, height: curBgImgHeight)
        }
    }
}


