//
//  KokoroVoice.swift
//  Zotero
//
//  A Kokoro on-device neural voice (https://github.com/a2sandoval/kokoro-tts-ios).
//  The model is bundled with the app; synthesis runs fully offline via sherpa-onnx.
//

import Foundation

/// A Kokoro neural voice. `sid` is the speaker id passed to the Kokoro engine.
struct KokoroVoice: Codable, Equatable, Hashable {
    let sid: Int
    /// Voice code, e.g. "af_heart" (American Female) or "am_adam" (American Male).
    let code: String

    /// Display name derived from the code: "af_heart" -> "Heart".
    var displayName: String {
        let name = code.split(separator: "_").last.map(String.init) ?? code
        return name.prefix(1).uppercased() + name.dropFirst()
    }

    var accentDescription: String {
        if code.hasPrefix("af_") { return "American Female" }
        if code.hasPrefix("am_") { return "American Male" }
        return "English"
    }

    // MARK: - Curated voices

    /// Warm, natural female voice — the community's top-rated Kokoro voice.
    static let heart = KokoroVoice(sid: 3, code: "af_heart")
    /// Deep, natural male voice.
    static let adam = KokoroVoice(sid: 11, code: "am_adam")

    /// Voices offered in Zotero's read-aloud picker.
    static let all: [KokoroVoice] = [.heart, .adam]

    static func with(sid: Int) -> KokoroVoice? {
        return all.first(where: { $0.sid == sid })
    }
}
