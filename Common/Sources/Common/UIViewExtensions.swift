import UIKit

public extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }

    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}

public extension UIView {
    @discardableResult
    func setAccessibilityIdentifier(_ id: String) -> Self {
        accessibilityIdentifier = id
        return self
    }

    @discardableResult
    func setAccessibilityIdentifier(viewController: UIViewController.Type, _ id: Int) -> Self {
        accessibilityIdentifier = "\(String(describing: viewController))<\(id)>"
        return self
    }
}

public extension UIView {
    @discardableResult
    func setTranslatesAutoresizingMaskIntoConstraints(_ translate: Bool) -> Self {
        translatesAutoresizingMaskIntoConstraints = translate
        return self
    }

    @discardableResult
    func prepareForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
