//
//  TrasactionTableViewCell.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class TrasactionTableViewCell: BaseTableViewCell {

    private let timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let fromAddressLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let receivedLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let toAddressLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initView() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(fromAddressLabel)
        contentView.addSubview(receivedLabel)
        contentView.addSubview(toAddressLabel)

        timeLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.equalTo(32)
        }

        fromAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        receivedLabel.snp.makeConstraints { make in
            make.top.equalTo(fromAddressLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }

        toAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(receivedLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }

    func updateFrame(viewObject: ViewObject) {
        timeLabel.text = viewObject.timestamp.ISO8601Format()
        fromAddressLabel.text = viewObject.fromAddress
        receivedLabel.text = "\(viewObject.receivedAmount) BTC"
        toAddressLabel.text = viewObject.toAddress
    }
}

extension TrasactionTableViewCell {
    struct ViewObject {
        var receivedAmount: Decimal
        var timestamp: Date
        var fromAddress: String
        var toAddress: String
    }
}
