//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class MarketView: UIView {

    // MARK: - Internal properties

    private let badgeImageSize = CGSize(width: 30, height: 30)

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var externalLinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(frameworkImageNamed: "webview")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    private lazy var titleLabel: Label = {
        let label = Label(style: .detail(.licorice))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        isAccessibilityElement = true

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(externalLinkImageView)
        addSubview(badgeImageView)
        backgroundColor = .clear

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: .mediumSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            externalLinkImageView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor),
            externalLinkImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),

            badgeImageView.widthAnchor.constraint(equalToConstant: badgeImageSize.width),
            badgeImageView.heightAnchor.constraint(equalToConstant: badgeImageSize.height),
            badgeImageView.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -.smallSpacing),
            badgeImageView.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: .mediumSpacing),
        ])
    }

    // MARK: - Dependency injection

    public func prepareForReuse() {
        iconImageView.image = nil
        badgeImageView.image = nil
        titleLabel.text = ""
        accessibilityLabel = ""
    }

    public var model: MarketListViewModel? {
        didSet {
            iconImageView.image = model?.iconImage
            titleLabel.text = model?.title
            accessibilityLabel = model?.accessibilityLabel

            let showExternalLinkIcon = model?.showExternalLinkIcon ?? false
            externalLinkImageView.isHidden = !showExternalLinkIcon
            badgeImageView.image = model?.badgeImage
        }
    }
}
