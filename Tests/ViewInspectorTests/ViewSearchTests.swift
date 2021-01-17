import XCTest
import Combine
import SwiftUI

@testable import ViewInspector

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
private struct Test {
    struct InnerView: View, Inspectable {
        var body: some View {
            Button(action: { }, label: {
                HStack { Text("Btn") }
            }).mask(Group {
                Text("Test")
            })
        }
    }
    struct MainView: View, Inspectable {
        var body: some View {
            AnyView(Group {
                SwiftUI.EmptyView()
                    .padding()
                    .overlay(HStack {
                        SwiftUI.EmptyView()
                            .id("5")
                        InnerView()
                            .padding(15)
                            .tag(9)
                    })
                Text("123")
                    .font(.footnote)
                    .tag(4)
                    .id(7)
                    .background(Button("xyz", action: { }))
                Divider().modifier(Test.Modifier())
            })
        }
    }
    struct ConditionalView: View, Inspectable {
        let falseCondition = false
        let trueCondition = true
        
        var body: some View {
            HStack {
                if falseCondition {
                    Text("1")
                }
                Text("2")
                if trueCondition {
                    Text("3")
                }
            }
        }
    }
    struct Modifier: ViewModifier, Inspectable {
        func body(content: Modifier.Content) -> some View {
            AnyView(content
                .overlay(Text("Modifier")))
        }
    }
    struct NonInspectableView: View {
        var body: some View {
            SwiftUI.EmptyView()
        }
    }
    struct EmptyView: View, Inspectable {
        var body: some View {
            Text("empty")
        }
    }
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, *)
    struct ConflictingViewTypeNamesStyle: ButtonStyle {
        public func makeBody(configuration: Configuration) -> some View {
            Group {
                Test.EmptyView()
                Label("", image: "")
                configuration.label
            }
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
final class ViewSearchTests: XCTestCase {
    
    func testFindAll() throws {
        let testView = Test.MainView()
        XCTAssertEqual(try testView.inspect().findAll(ViewType.ZStack.self).count, 0)
        XCTAssertEqual(try testView.inspect().findAll(ViewType.HStack.self).count, 2)
        XCTAssertEqual(try testView.inspect().findAll(ViewType.Button.self).count, 2)
        XCTAssertEqual(try testView.inspect().findAll(ViewType.Text.self).map({ try $0.string() }),
                       ["Btn", "Test", "123", "xyz", "Modifier"])
        XCTAssertEqual(try testView.inspect().findAll(Test.InnerView.self).count, 1)
        XCTAssertEqual(try testView.inspect().findAll(where: { (try? $0.overlay()) != nil }).count, 2)
    }
    
    func testFindText() throws {
        let testView = Test.MainView()
        XCTAssertEqual(try testView.inspect().find(text: "123").pathToRoot,
        "view(MainView.self).anyView().group().text(1)")
        XCTAssertEqual(try testView.inspect().find(text: "Test").pathToRoot,
        """
        view(MainView.self).anyView().group().emptyView(0).overlay().hStack()\
        .view(InnerView.self, 1).button().mask().group().text(0)
        """)
        XCTAssertEqual(try testView.inspect().find(text: "Btn").pathToRoot,
        """
        view(MainView.self).anyView().group().emptyView(0).overlay().hStack()\
        .view(InnerView.self, 1).button().labelView().hStack().text(0)
        """)
        XCTAssertEqual(try testView.inspect().find(text: "xyz").pathToRoot,
        "view(MainView.self).anyView().group().text(1).background().button().labelView().text()")
        XCTAssertEqual(try testView.inspect().find(text: "Modifier").pathToRoot,
        """
        view(MainView.self).anyView().group().divider(2).modifier(Modifier.self)\
        .anyView().viewModifierContent().overlay().text()
        """)
        XCTAssertEqual(try testView.inspect().find(
            textWhere: { _, attr -> Bool in
                try attr.font() == .footnote
            }).string(), "123")
        XCTAssertThrows(try testView.inspect().find(text: "unknown"),
                        "Search did not find a match")
        XCTAssertThrows(try testView.inspect().find(ViewType.Text.self, relation: .parent),
                        "Search did not find a match")
    }
    
    func testFindButton() throws {
        let testView = Test.MainView()
        XCTAssertNoThrow(try testView.inspect().find(button: "Btn"))
        XCTAssertNoThrow(try testView.inspect().find(button: "xyz"))
        XCTAssertThrows(try testView.inspect().find(button: "unknown"),
                        "Search did not find a match")
    }
    
    func testFindViewWithId() throws {
        let testView = Test.MainView()
        XCTAssertNoThrow(try testView.inspect().find(viewWithId: "5").emptyView())
        XCTAssertNoThrow(try testView.inspect().find(viewWithId: 7).text())
        XCTAssertThrows(try testView.inspect().find(viewWithId: 0),
                        "Search did not find a match")
    }
    
    func testFindViewWithTag() throws {
        let testView = Test.MainView()
        XCTAssertNoThrow(try testView.inspect().find(viewWithTag: 4).text())
        XCTAssertNoThrow(try testView.inspect().find(viewWithTag: 9).view(Test.InnerView.self))
        XCTAssertThrows(try testView.inspect().find(viewWithTag: 0),
                        "Search did not find a match")
    }
    
    func testFindCustomView() throws {
        let testView = Test.MainView()
        XCTAssertNoThrow(try testView.inspect().find(Test.InnerView.self))
        XCTAssertNoThrow(try testView.inspect().find(Test.InnerView.self, containing: "Btn"))
        XCTAssertThrows(try testView.inspect().find(Test.InnerView.self, containing: "123"),
                        "Search did not find a match")
    }
    
    func testFindForConditionalView() throws {
        let testView = Test.ConditionalView()
        let texts = try testView.inspect().findAll(ViewType.Text.self)
        let values = try texts.map { try $0.string() }
        XCTAssertEqual(values, ["2", "3"])
    }
    
    func testFindMatchingBlockerView() {
        let view = AnyView(Test.NonInspectableView().id(5))
        XCTAssertNoThrow(try view.inspect().find(viewWithId: 5))
        XCTAssertThrows(try view.inspect().find(ViewType.EmptyView.self),
                        "Search did not find a match. Possible blockers: NonInspectableView")
    }
    
    func testConflictingViewTypeNames() throws {
        guard #available(iOS 14.0, macOS 11.0, tvOS 14.0, *) else { return }
        let style = Test.ConflictingViewTypeNamesStyle()
        let sut = try style.inspect(isPressed: true)
        XCTAssertEqual(try sut.find(text: "empty").pathToRoot,
                       "group().view(EmptyView.self, 0).text()")
        XCTAssertEqual(try sut.find(ViewType.Label.self).pathToRoot,
                       "group().label(1)")
        XCTAssertEqual(try sut.find(ViewType.StyleConfiguration.Label.self).pathToRoot,
                       "group().styleConfigurationLabel(2)")
    }
    
    func testStubViewBody() throws {
        _ = TraverseStubView().body
    }
}
