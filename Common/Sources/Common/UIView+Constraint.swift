import UIKit

extension UIView {
    @discardableResult
    func heightAnchor(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(lessThanOrEqualTo: NSLayoutDimension, multiplier: CGFloat,  constant: CGFloat) -> Self {
        heightAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, multiplier: multiplier, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(lessThanOrEqualToConstant: CGFloat) -> Self {
        heightAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant).isActive = true
        return self
    }

    @discardableResult
    func heightAnchor(greaterThanOrEqualToConstant: CGFloat) -> Self {
        heightAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant).isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(lessThanOrEqualToConstant: CGFloat) -> Self {
        widthAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant).isActive = true
        return self
    }

    @discardableResult
    func widthAnchor(greaterThanOrEqualToConstant: CGFloat) -> Self {
        widthAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant).isActive = true
        return self
    }

    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}
