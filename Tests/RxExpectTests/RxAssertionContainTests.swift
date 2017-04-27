//
//  RxAssertionContainTests.swift
//  RxExpect
//
//  Created by Suyeol Jeon on 25/01/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxExpect

final class RxAssertionContainTests: XCTestCase {

  func testAssertContainOfNonEquatable() {
    RxExpect("it should assert contain of non equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<NonEquatable>()
      test.input(source, [
        next(100, NonEquatable(name: "A")),
        next(200, NonEquatable(name: "B")),
      ])
      test.assert(source).contains { event in
        event.value.element?.name == "B"
      }
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail contain of non equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<NonEquatable>()
      test.input(source, [
        next(100, NonEquatable(name: "A")),
        next(200, NonEquatable(name: "B")),
      ])
      test.assert(source).contains { event in
        event.value.element?.name == "C"
      }
      XCTAssertFalse(result.isPassed)
    }
  }

  func testAssertNotContainOfNonEquatable() {
    RxExpect("it should assert not contain of non equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<NonEquatable>()
      test.input(source, [
        next(100, NonEquatable(name: "A")),
        next(200, NonEquatable(name: "B")),
      ])
      test.assert(source).not().contains { event in
        event.value.element?.name == "C"
      }
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail not contain of non equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<NonEquatable>()
      test.input(source, [
        next(100, NonEquatable(name: "A")),
        next(200, NonEquatable(name: "B")),
      ])
      test.assert(source).not().contains { event in
        event.value.element?.name == "B"
      }
      XCTAssertFalse(result.isPassed)
    }
  }

  func testAssertContainOfEquatable() {
    RxExpect("it should assert contain of equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).contains(next(100, "A"))
      XCTAssertTrue(result.isPassed)
    }
    RxExpect("it should assert fail contain of equatable events") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).contains(next(100, "C"))
      XCTAssertFalse(result.isPassed)
    }

    RxExpect("it should assert contain of equatable elements") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).contains("A")
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail contain of equatable elements") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).contains("C")
      XCTAssertFalse(result.isPassed)
    }
  }

  func testAssertNotContainOfEquatable() {
    RxExpect("it should assert not contain of equatable events with different element") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains(next(100, "C"))
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail not contain of equatable events with different element") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains(next(100, "A"))
      XCTAssertFalse(result.isPassed)
    }

    RxExpect("it should assert not contain of equatable events with different time") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains(next(200, "A"))
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail not contain of equatable events with different time") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains(next(200, "B"))
      XCTAssertFalse(result.isPassed)
    }

    RxExpect("it should assert not contain of equatable elements") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains("a")
      XCTAssertTrue(result.isPassed)
    }

    RxExpect("it should assert fail not contain of equatable elements") { test in
      let result = watch(test)
      let source = PublishSubject<String>()
      test.input(source, [
        next(100, "A"),
        next(200, "B"),
      ])
      test.assert(source).not().contains("A")
      XCTAssertFalse(result.isPassed)
    }
  }

}
