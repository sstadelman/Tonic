import XCTest
@testable import Tonic

final class ChordTests: XCTestCase {

    func testChords() {
        let chord = Chord(notes: [Note(.C), Note(.E), Note(.G)])
        XCTAssertTrue(chord.isTriad)

        let Cs = Chord(notes: [.Cs, .Es, .Gs])

        XCTAssertEqual(Cs.name, "C♯")

        let Db = Chord(notes: [.Db, .F, .Ab])

        XCTAssertEqual(Db.name, "D♭")

        let Asm = Chord(notes: [.As, .Cs, .Es])

        XCTAssertEqual(Asm.name, "A♯m")

        let Bbm = Chord(notes: [.Bb, .Db, .F])

        XCTAssertEqual(Bbm.name, "B♭m")
    }

    func testNaming() {

        let pitches = PitchSet(numbers: [61, 65, 68])

        let Cs = pitches.chord(in: .Cs)
        let Db = pitches.chord(in: .Db)

        XCTAssertEqual(Cs.notes, [.Cs, .Es, .Gs])
        XCTAssertEqual(Db.notes, [.Db, .F, .Ab])
        XCTAssertEqual(Cs.name, "C♯")
        XCTAssertEqual(Db.name, "D♭")

    }

    func testInversions() {
        let chord = Chord(notes: [Note(.C), Note(.E), Note(.G)])
        XCTAssertTrue(chord.isTriad)

        let firstInversion = Chord(notes: [Note(.C), Note(.E), Note(.A, octave: 6)])
        XCTAssertEqual(firstInversion.name, "Am")

        let secondInversion = Chord(notes: [Note(.E, octave: 1), Note(.A), Note(.C)])
        XCTAssertEqual(secondInversion.name, "Am")
    }

    func testDiminishedChords() {

        let aDim = Chord(notes: [Note(.A), Note(.C), Note(.E, accidental: .flat)])
        XCTAssertEqual(aDim.name, "A°")

        let bDim = Chord(notes: [Note(.B), Note(.D), Note(.F)])
        XCTAssertEqual(bDim.name, "B°")


    }

    func testAugmentedChords() {

        let cAug = Chord(notes: [Note(.C), Note(.E), Note(.G, accidental: .sharp)])
        XCTAssertEqual(cAug.name, "C⁺")

        let aAug = Chord(notes: [Note(.A), Note(.C, accidental: .sharp), Note(.E, accidental: .sharp)])
        XCTAssertEqual(aAug.name, "A⁺")

        let dbAug = Chord(notes: [Note(.D, accidental: .flat), Note(.F), Note(.A)])
        XCTAssertEqual(dbAug.name, "D♭⁺")
    }

    func testChordHausdorff() {
        let C = Chord(notes: [Note(.C), Note(.E), Note(.G)])

        XCTAssertEqual(C.hausdorff(to: C), 0)

        let Cm = Chord(notes: [Note(.C), Note(.E, accidental: .flat), Note(.G)])

        XCTAssertEqual(C.hausdorff(to: Cm), 1)
    }
}
