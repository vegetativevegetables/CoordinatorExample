//
//  ContentListItemCollectionViewCell.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

final class ContentListItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "contentListItem"
    
    // MARK: - ConstraintsUpdating protocol
    var allConstraints = [NSLayoutConstraint]()
    
    // MARK: - Private properties
    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = NumberOfLines.id
        return label
    }()
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = NumberOfLines.text
        return label
    }()
    
    private static let outerSpacing: CGFloat = 8.0
    private static let innerSpacing: CGFloat = 8.0
    
    private struct NumberOfLines {
        static let id = 1
        static let text = 0
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        let outerSpacing = ContentListItemCollectionViewCell.outerSpacing
        let innerSpacing = ContentListItemCollectionViewCell.innerSpacing

        constraints += [idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outerSpacing),
                        idLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: outerSpacing),
                        idLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -outerSpacing),
                        idLabel.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -innerSpacing)]
        constraints += [textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: outerSpacing),
                        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -outerSpacing),
                        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -innerSpacing)]
        
        setup(constraints: constraints)
        
        super.updateConstraints()
    }
    
    // MARK: - Private methods
    private func setup() {
        for subview in [textLabel, idLabel] {
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }

        setNeedsUpdateConstraints()
    }
    
    // MARK: - Public methods
    func configure(viewModel: ContentListItemCollectionViewCellViewModel) {
        idLabel.text = viewModel.id
        textLabel.text = viewModel.text
    }

    static func heightForCell(width: CGFloat, viewModel: ContentListItemCollectionViewCellViewModel) -> CGFloat {
        let textWidth = width - (outerSpacing * 2)
        let cellHeight = outerSpacing +
            UILabel.heightForLabel(
                width: textWidth,
                text: viewModel.id,
                font: UILabel().font,
                numberOfLines: NumberOfLines.id
            ) +
            innerSpacing +
            UILabel.heightForLabel(
                width: textWidth,
                text: viewModel.text,
                font: UILabel().font,
                numberOfLines: NumberOfLines.text
            ) +
        outerSpacing
        return cellHeight
    }
}

extension ContentListItemCollectionViewCell: ConstraintsUpdating { }
