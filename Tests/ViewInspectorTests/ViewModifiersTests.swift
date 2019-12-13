import XCTest
import SwiftUI
@testable import ViewInspector

// MARK: - ViewSizingTests

final class ViewSizingTests: XCTestCase {
    
    func testFrameWidthHeightAlignment() throws {
        let sut = EmptyView().frame(width: 5, height: 5, alignment:
            Alignment(horizontal: .center, vertical: .center))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testFrameMinIdealMax() throws {
        let sut = EmptyView().frame(minWidth: 5, idealWidth: 5, maxWidth: 5,
                                    minHeight: 5, idealHeight: 5, maxHeight: 5,
                                    alignment: Alignment(horizontal: .center, vertical: .center))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testFixedSize() throws {
        let sut = EmptyView().fixedSize()
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testFixedSizeHorizontalVertical() throws {
        let sut = EmptyView().fixedSize(horizontal: true, vertical: false)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testLayoutPriority() throws {
        let sut = EmptyView().layoutPriority(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewPositioningTests

final class ViewPositioningTests: XCTestCase {
    
    func testPosition() throws {
        let sut = EmptyView().position(CGPoint(x: 5, y: 5))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testPositionXY() throws {
        let sut = EmptyView().position(x: 5, y: 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testOffset() throws {
        let sut = EmptyView().offset(CGSize(width: 5, height: 5))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testOffsetXY() throws {
        let sut = EmptyView().offset(x: 5, y: 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testEdgesIgnoringSafeArea() throws {
        let sut = EmptyView().edgesIgnoringSafeArea([.leading])
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testCoordinateSpace() throws {
        let sut = EmptyView().coordinateSpace(name: "")
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewAligningTests

final class ViewAligningTests: XCTestCase {
    
    func testHorizontalAlignmentGuide() throws {
        let sut = EmptyView().alignmentGuide(.leading) { _ in 5 }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testVerticalAlignmentGuide() throws {
        let sut = EmptyView().alignmentGuide(.top) { _ in 5 }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewPaddingTests

final class ViewPaddingTests: XCTestCase {
    
    func testPadding() throws {
        let sut = EmptyView().padding(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testPaddingEdgeInsets() throws {
        let sut = EmptyView().padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testPaddingEdgeSet() throws {
        let sut = EmptyView().padding([.top], 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewLayeringTests

final class ViewLayeringTests: XCTestCase {
    
    func testOverlay() throws {
        let sut = EmptyView().overlay(Text(""), alignment: .center)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testBackground() throws {
        let sut = EmptyView().background(Text(""), alignment: .center)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testZIndex() throws {
        let sut = EmptyView().zIndex(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewBorderTests

final class ViewBorderTests: XCTestCase {
    
    func testBorder() throws {
        let sut = EmptyView().border(Color.primary, width: 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewMaskingTests

final class ViewMaskingTests: XCTestCase {
    
    func testClipped() throws {
        let sut = EmptyView().clipped(antialiased: false)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testClipShape() throws {
        let sut = EmptyView().clipShape(Capsule(), style: FillStyle())
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testCornerRadius() throws {
        let sut = EmptyView().cornerRadius(5, antialiased: false)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testMask() throws {
        let sut = EmptyView().mask(Text(""))
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewScalingTests

final class ViewScalingTests: XCTestCase {
    
    func testScaledToFill() throws {
        let sut = EmptyView().scaledToFill()
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testScaledToFit() throws {
        let sut = EmptyView().scaledToFit()
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testScaleEffectFloat() throws {
        let sut = EmptyView().scaleEffect(5, anchor: .leading)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testScaleEffectSize() throws {
        let sut = EmptyView().scaleEffect(CGSize(width: 5, height: 5), anchor: .leading)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testScaleEffectXY() throws {
        let sut = EmptyView().scaleEffect(x: 5, y: 5, anchor: .center)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testAspectRatioFloat() throws {
        let sut = EmptyView().aspectRatio(5, contentMode: .fill)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testAspectRatioSize() throws {
        let sut = EmptyView().aspectRatio(CGSize(width: 5, height: 5), contentMode: .fit)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    #if !os(macOS)
    func testImageScale() throws {
        let sut = EmptyView().imageScale(.small)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    #endif
}

// MARK: - ViewTransformingTests

final class ViewTransformingTests: XCTestCase {
    
    func testRotationEffect() throws {
        let sut = EmptyView().rotationEffect(Angle(degrees: 5), anchor: .center)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testRotation3DEffect() throws {
        let sut = EmptyView().rotation3DEffect(Angle(degrees: 5), axis: (5, 5, 5),
                                               anchor: .center, anchorZ: 5, perspective: 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testProjectionEffect() throws {
        let sut = EmptyView().projectionEffect(ProjectionTransform())
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTransformEffect() throws {
        let sut = EmptyView().transformEffect(.identity)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewTextAdjustingTests

final class ViewTextAdjustingTests: XCTestCase {
    
    #if os(iOS) || os(tvOS)
    func testKeyboardType() throws {
        let sut = EmptyView().keyboardType(.namePhonePad)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    #endif
    
    func testFont() throws {
        let sut = EmptyView().font(.body)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testLineLimit() throws {
        let sut = EmptyView().lineLimit(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testLineSpacing() throws {
        let sut = EmptyView().lineSpacing(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testMultilineTextAlignment() throws {
        let sut = EmptyView().multilineTextAlignment(.center)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testMinimumScaleFactor() throws {
        let sut = EmptyView().minimumScaleFactor(5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTruncationMode() throws {
        let sut = EmptyView().truncationMode(.tail)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testAllowsTightening() throws {
        let sut = EmptyView().allowsTightening(true)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    #if !os(macOS)
    func testTextContentType() throws {
        let sut = EmptyView().textContentType(.emailAddress)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    #endif
    
    func testFlipsForRightToLeftLayoutDirection() throws {
        let sut = EmptyView().flipsForRightToLeftLayoutDirection(true)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    #if os(iOS) || os(tvOS)
    func testAutocapitalization() throws {
        let sut = EmptyView().autocapitalization(.words)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    #endif
    
    func testDisableAutocorrection() throws {
        let sut = EmptyView().disableAutocorrection(false)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewAnimationsTests

final class ViewAnimationsTests: XCTestCase {
    
    func testAnimation() throws {
        let sut = EmptyView().animation(.easeInOut)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testAnimationValue() throws {
        let sut = EmptyView().animation(.easeInOut, value: 5)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTransition() throws {
        let sut = EmptyView().transition(.slide)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}

// MARK: - ViewGesturesTests

final class ViewGesturesTests: XCTestCase {
    
    @State private var floatValue: Float = 0
    
    func testOnTapGesture() throws {
        let sut = EmptyView().onTapGesture(count: 5, perform: { })
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testOnLongPressGesture() throws {
        let sut = EmptyView().onLongPressGesture { }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testGesture() throws {
        let sut = EmptyView().gesture(MagnificationGesture(), including: .subviews)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testHighPriorityGesture() throws {
        let sut = EmptyView().highPriorityGesture(MagnificationGesture(), including: .subviews)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testSimultaneousGesture() throws {
        let sut = EmptyView().simultaneousGesture(MagnificationGesture(), including: .subviews)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    #if os(watchOS)
    func testDigitalCrownRotation() throws {
        let sut = EmptyView().digitalCrownRotation(self.$floatValue)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testDigitalCrownRotationExtended() throws {
        let sut = EmptyView().digitalCrownRotation(
            self.$floatValue, from: 5, through: 5, by: 5, sensitivity: .low,
            isContinuous: true, isHapticFeedbackEnabled: true)
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    #endif
    
    func testTransaction() throws {
        let sut = EmptyView().transaction { _ in }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
}
