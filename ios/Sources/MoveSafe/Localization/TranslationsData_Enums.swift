import Foundation

/// Translations for enum-derived display labels: RiskLevel, JurisdictionType,
/// SourceType, SourceStatus, ProfileFlag. Plus the four Disclaimers strings.
///
/// These are the .label / .description / .raw-string values returned from
/// the enums in `Models/Enums.swift` and `Utils/SafeCopy.swift`.
enum EnumTranslations {
    static let spanish: [String: String] = [
        // MARK: - RiskLevel.label
        "Awareness item": "Punto informativo",
        "Verify soon": "Verificar pronto",
        "Important to verify": "Importante verificar",
        // "Do not assume" is already in UITranslations - duplicate keys are safe (merge keeps later)

        // MARK: - RiskLevel.description
        "Worth knowing about. Usually administrative or low-stakes to verify.": "Vale la pena conocerlo. Suele ser administrativo o de bajo impacto al verificar.",
        "Can cause inconvenience, fees, or compliance problems if ignored.": "Puede causar molestias, tarifas o problemas de cumplimiento si se ignora.",
        "May involve penalties or licensing consequences.": "Puede implicar sanciones o consecuencias de licencia.",
        "Rules vary widely. Verify with official sources.": "Las normas varían mucho. Verifique con fuentes oficiales.",

        // MARK: - JurisdictionType.label
        "State law": "Ley estatal",
        "Local ordinance": "Ordenanza local",
        "Federal law": "Ley federal",
        "Agency rule": "Norma de agencia",
        "Professional licensing board": "Junta de licencias profesionales",
        "School / institution policy": "Política escolar / institucional",
        "Employer policy": "Política del empleador",
        "Administrative requirement": "Requisito administrativo",
        "Practical requirement": "Requisito práctico",
        "Mixed jurisdiction": "Jurisdicción mixta",

        // MARK: - SourceType.label
        "Official state agency": "Agencia estatal oficial",
        "Official local agency": "Agencia local oficial",
        "Official federal agency": "Agencia federal oficial",
        "School or institution": "Escuela o institución",
        "Legal aid (general info)": "Ayuda legal (información general)",
        "Secondary reference": "Referencia secundaria",
        // "Professional licensing board" and "Placeholder source" already covered above and in UI

        // MARK: - SourceStatus.label - all already in UITranslations

        // MARK: - ProfileFlag.label
        "I have a car": "Tengo automóvil",
        "I rent housing": "Alquilo vivienda",
        "I own a pet": "Tengo mascota",
        "I am moving for school": "Me mudo por estudios",
        "I am moving for work": "Me mudo por trabajo",
        "I am a nursing or healthcare student": "Soy estudiante de enfermería o área de salud",
        "I hold or need a professional license": "Tengo o necesito una licencia profesional",
        "I may stay temporarily": "Es posible que me quede de manera temporal",
        "I plan to relocate permanently": "Planeo mudarme de manera permanente",
        "I may work in the destination state": "Es posible que trabaje en el estado de destino",
        "I'm a Dreamer (DACA / similar)": "Soy Dreamer (DACA o similar)",
        "I'm a green card holder (LPR)": "Soy residente permanente (LPR)",
        "I'm on a nonimmigrant visa (F-1, H-1B, J-1, etc.)": "Tengo una visa de no inmigrante (F-1, H-1B, J-1, etc.)",
        "Show high-risk categories separately": "Mostrar las categorías de alto riesgo por separado",

        // MARK: - Disclaimers (Utils/SafeCopy.swift)
        "MoveSafe provides general legal and administrative information based on publicly available sources. It does not provide legal advice, does not create an attorney-client relationship, and should not be used as a substitute for advice from a licensed attorney in your jurisdiction. Laws and agency rules change frequently. Always verify information with official sources before making decisions.": "MoveSafe proporciona información legal y administrativa general basada en fuentes públicamente disponibles. No proporciona asesoría legal, no crea una relación abogado-cliente, y no debe usarse como sustituto de la asesoría de un abogado licenciado en su jurisdicción. Las leyes y normas de agencias cambian con frecuencia. Verifique siempre la información con fuentes oficiales antes de tomar decisiones.",
        "General information only. Not legal advice. Verify with official sources.": "Solo información general. No es asesoría legal. Verifique con fuentes oficiales.",
        "Based on your selected states and purpose, here are topics to verify before moving. This checklist is not a legal conclusion.": "Con base en los estados y propósito seleccionados, estos son los temas que conviene verificar antes de mudarse. Esta lista no es una conclusión legal.",
        "This checklist is based on your selected categories and available source data. It may not include every requirement that applies to your situation.": "Esta lista se basa en las categorías que seleccionó y en los datos de fuentes disponibles. Puede no incluir todos los requisitos que aplican a su situación.",

        // MARK: - Engine warnings (Engine/ChecklistEngine.swift)
        "Some checklist items use placeholder sources. Replace with official sources before relying on them.": "Algunos elementos de la lista usan fuentes provisionales. Reemplácelas con fuentes oficiales antes de basarse en ellos.",
        "Some sources have not been verified recently. Check the official website before relying on them.": "Algunas fuentes no se han verificado recientemente. Revise el sitio web oficial antes de basarse en ellas.",
        "High-risk categories require separate verification. MoveSafe does not determine whether possession, transportation, or use of regulated items is lawful.": "Las categorías de alto riesgo requieren verificación por separado. MoveSafe no determina si la posesión, el transporte o el uso de artículos regulados es lícito.",
        "This checklist is not a legal conclusion. Verify with official sources and consult a licensed professional where appropriate.": "Esta lista no es una conclusión legal. Verifique con fuentes oficiales y consulte con un profesional licenciado cuando sea apropiado.",
        "Origin and destination are the same. MoveSafe is designed for state-to-state moves - some items may not apply.": "El origen y el destino son los mismos. MoveSafe está diseñado para mudanzas entre estados; algunos elementos pueden no aplicar.",
    ]
}
