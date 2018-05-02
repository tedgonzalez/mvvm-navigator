//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

enum Sections: String {
    case dna
    case components
    case listViews
    case fullscreen

    static var all: [Sections] {
        return [
            .dna,
            .components,
            .listViews,
            .fullscreen,
        ]
    }

    var numberOfItems: Int {
        switch self {
        case .dna:
            return DnaViews.all.count
        case .components:
            return ComponentViews.all.count
        case .listViews:
            return ListViews.all.count
        case .fullscreen:
            return FullscreenViews.all.count
        }
    }

    static func formattedName(for section: Int) -> String {
        let section = Sections.all[section]
        let rawClassName = section.rawValue
        return rawClassName.capitalizingFirstLetter
    }

    static func formattedName(for indexPath: IndexPath) -> String {
        let section = Sections.all[indexPath.section]
        var rawClassName: String
        switch section {
        case .dna:
            rawClassName = DnaViews.all[indexPath.row].rawValue
        case .components:
            rawClassName = ComponentViews.all[indexPath.row].rawValue
        case .listViews:
            rawClassName = ListViews.all[indexPath.row].rawValue
        case .fullscreen:
            rawClassName = FullscreenViews.all[indexPath.row].rawValue
        }

        return rawClassName.replacingOccurrences(of: "DemoView", with: "").capitalizingFirstLetter
    }

    static func viewController(for indexPath: IndexPath) -> UIViewController {
        let section = Sections.all[indexPath.section]
        switch section {
        case .dna:
            let selectedView = DnaViews.all[indexPath.row]
            return selectedView.viewController
        case .components:
            let selectedView = ComponentViews.all[indexPath.row]
            return selectedView.viewController
        case .listViews:
            let selectedView = ListViews.all[indexPath.row]
            return selectedView.viewController
        case .fullscreen:
            let selectedView = FullscreenViews.all[indexPath.row]
            return selectedView.viewController
        }
    }

    private static let lastSelectedRowKey = "lastSelectedRowKey"
    private static let lastSelectedSectionKey = "lastSelectedSectionKey"

    static var lastSelectedIndexPath: IndexPath? {
        get {
            guard let row = UserDefaults.standard.object(forKey: lastSelectedRowKey) as? Int else { return nil }
            guard let section = UserDefaults.standard.object(forKey: lastSelectedSectionKey) as? Int else { return nil }
            return IndexPath(row: row, section: section)
        }
        set {
            if let row = newValue?.row {
                UserDefaults.standard.set(row, forKey: lastSelectedRowKey)
            } else {
                UserDefaults.standard.removeObject(forKey: lastSelectedRowKey)
            }

            if let section = newValue?.section {
                UserDefaults.standard.set(section, forKey: lastSelectedSectionKey)
            } else {
                UserDefaults.standard.removeObject(forKey: lastSelectedSectionKey)
            }
            UserDefaults.standard.synchronize()
        }
    }
}

enum DnaViews: String {
    case colorDemoView
    case fontDemoView
    case spacingDemoView

    var viewController: UIViewController {
        switch self {
        case .colorDemoView:
            return ViewController<ColorDemoView>()
        case .fontDemoView:
            return ViewController<FontDemoView>()
        case .spacingDemoView:
            return ViewController<SpacingDemoView>()
        }
    }

    static var all: [DnaViews] {
        return [
            .colorDemoView,
            .fontDemoView,
            .spacingDemoView,
        ]
    }
}

enum ComponentViews: String {
    case broadcastDemoView
    case broadcastContainerDemoView
    case buttonDemoView
    case labelDemoView
    case ribbonDemoView
    case textFieldDemoView
    case toastDemoView
    case switchViewDemoView
    case inlineConsentDemoView

    var viewController: UIViewController {
        switch self {
        case .broadcastDemoView:
            return ViewController<BroadcastDemoView>()
        case .broadcastContainerDemoView:
            return ViewController<BroadcastContainerDemoView>()
        case .buttonDemoView:
            return ViewController<ButtonDemoView>()
        case .labelDemoView:
            return ViewController<LabelDemoView>()
        case .ribbonDemoView:
            return ViewController<RibbonDemoView>()
        case .textFieldDemoView:
            return ViewController<TextFieldDemoView>()
        case .toastDemoView:
            return ViewController<ToastDemoView>()
        case .switchViewDemoView:
            return ViewController<SwitchViewDemoView>()
        case .inlineConsentDemoView:
            return ViewController<InlineConsentDemoView>()
        }
    }

    static var all: [ComponentViews] {
        return [
            .broadcastDemoView,
            .broadcastContainerDemoView,
            .buttonDemoView,
            .labelDemoView,
            .ribbonDemoView,
            .textFieldDemoView,
            .toastDemoView,
            .switchViewDemoView,
            .inlineConsentDemoView,
        ]
    }
}

enum ListViews: String {
    case market
    case gridPreview

    static var all: [ListViews] {
        return [
            .market,
            .gridPreview,
        ]
    }

    var viewController: UIViewController {
        switch self {
        case .market:
            return ViewController<MarketListViewDemoView>()
        case .gridPreview:
            return ViewController<GridPreviewListViewDemoView>()
        }
    }
}

enum FullscreenViews: String {
    case frontpageViewDemoView
    case registerViewDemoView
    case consentViewDemoView
    case emptyViewDemoView
    case loginViewDemoView

    var viewController: UIViewController {
        switch self {
        case .frontpageViewDemoView:
            return ViewController<FrontpageViewDemoView>()
        case .registerViewDemoView:
            return ViewController<RegisterViewDemoView>()
        case .loginViewDemoView:
            return ViewController<LoginViewDemoView>()
        case .emptyViewDemoView:
            return ViewController<EmptyViewDemoView>()
        case .consentViewDemoView:
            return ViewController<ConsentViewDemoView>()
        }
    }

    static var all: [FullscreenViews] {
        return [
            .frontpageViewDemoView,
            .registerViewDemoView,
            .consentViewDemoView,
            .emptyViewDemoView,
            .loginViewDemoView,
        ]
    }
}
