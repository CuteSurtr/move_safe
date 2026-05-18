import Foundation

enum States {
    static let all: [USState] = stateRows.map { row in
        USState(
            id: "state-\(row.slug)",
            name: row.name,
            abbreviation: row.abbreviation,
            slug: row.slug,
            officialWebsiteUrl: row.officialWebsiteUrl,
            dmvUrl: row.dmvUrl,
            taxAgencyUrl: row.taxAgencyUrl,
            housingAgencyUrl: row.housingAgencyUrl,
            boardOfNursingUrl: row.boardOfNursingUrl,
            notes: row.notes
        )
    }

    static let byId: [String: USState] = Dictionary(uniqueKeysWithValues: all.map { ($0.id, $0) })

    // All 50 US states + DC. URLs marked `verified` were HEAD-checked or content-
    // checked on 2026-05-17. URLs still set to "#" are placeholders — agency
    // homepages exist for those states but weren't confirmed in this pass.
    //
    // The eight original MVP states (CA, AZ, TX, NY, MD, PA, IL, VA) have all
    // five URL fields verified. The remaining 42 + DC fall back to placeholder
    // and surface as "Placeholder source" in the UI.

    private struct Row {
        let name: String
        let abbreviation: String
        let slug: String
        let officialWebsiteUrl: String
        let dmvUrl: String
        let taxAgencyUrl: String
        let housingAgencyUrl: String
        let boardOfNursingUrl: String
        let notes: String
    }

    private static let placeholderRow = (
        official: "#", dmv: "#", tax: "#", housing: "#", nursing: "#",
        notes: "URLs not yet verified. Add verified official agency URLs before relying on this state."
    )

    private static func placeholder(_ name: String, _ abbr: String, _ slug: String) -> Row {
        Row(
            name: name, abbreviation: abbr, slug: slug,
            officialWebsiteUrl: placeholderRow.official,
            dmvUrl: placeholderRow.dmv,
            taxAgencyUrl: placeholderRow.tax,
            housingAgencyUrl: placeholderRow.housing,
            boardOfNursingUrl: placeholderRow.nursing,
            notes: placeholderRow.notes
        )
    }

    private static let stateRows: [Row] = [
        placeholder("Alabama",       "AL", "alabama"),
        placeholder("Alaska",        "AK", "alaska"),

        Row(
            name: "Arizona", abbreviation: "AZ", slug: "arizona",
            officialWebsiteUrl: "https://az.gov",
            dmvUrl: "https://azdot.gov/mvd",
            taxAgencyUrl: "https://azdor.gov",
            housingAgencyUrl: "https://www.azag.gov",
            boardOfNursingUrl: "https://www.azbn.gov",
            notes: "Driver licenses are issued by ADOT's Motor Vehicle Division (MVD), not a standalone DMV."
        ),

        placeholder("Arkansas",      "AR", "arkansas"),

        Row(
            name: "California", abbreviation: "CA", slug: "california",
            officialWebsiteUrl: "https://www.ca.gov",
            dmvUrl: "https://www.dmv.ca.gov",
            taxAgencyUrl: "https://www.ftb.ca.gov",
            housingAgencyUrl: "https://oag.ca.gov/consumers",
            boardOfNursingUrl: "https://www.rn.ca.gov",
            notes: "FTB handles personal income tax; CDTFA handles sales tax. Board of Registered Nursing (RN) is at rn.ca.gov; LVNs use a separate board."
        ),

        placeholder("Colorado",      "CO", "colorado"),
        placeholder("Connecticut",   "CT", "connecticut"),
        placeholder("Delaware",      "DE", "delaware"),
        placeholder("District of Columbia", "DC", "district-of-columbia"),
        placeholder("Florida",       "FL", "florida"),
        placeholder("Georgia",       "GA", "georgia"),
        placeholder("Hawaii",        "HI", "hawaii"),
        placeholder("Idaho",         "ID", "idaho"),

        Row(
            name: "Illinois", abbreviation: "IL", slug: "illinois",
            officialWebsiteUrl: "https://www.illinois.gov",
            dmvUrl: "https://www.ilsos.gov",
            taxAgencyUrl: "https://tax.illinois.gov",
            housingAgencyUrl: "https://illinoisattorneygeneral.gov",
            boardOfNursingUrl: "https://idfpr.illinois.gov",
            notes: "Driver licenses in Illinois are issued by the Secretary of State (ilsos.gov), not a DMV. Nursing licensure is under IDFPR."
        ),

        placeholder("Indiana",       "IN", "indiana"),
        placeholder("Iowa",          "IA", "iowa"),
        placeholder("Kansas",        "KS", "kansas"),
        placeholder("Kentucky",      "KY", "kentucky"),
        placeholder("Louisiana",     "LA", "louisiana"),
        placeholder("Maine",         "ME", "maine"),

        Row(
            name: "Maryland", abbreviation: "MD", slug: "maryland",
            officialWebsiteUrl: "https://www.maryland.gov",
            dmvUrl: "https://mva.maryland.gov",
            taxAgencyUrl: "https://www.marylandcomptroller.gov",
            housingAgencyUrl: "https://oag.maryland.gov",
            boardOfNursingUrl: "https://health.maryland.gov/mbon/Pages/default.aspx",
            notes: "Maryland's motor vehicle agency is the MVA. Tax authority is the Comptroller of Maryland. Board of Nursing now lives under the Department of Health."
        ),

        placeholder("Massachusetts", "MA", "massachusetts"),
        placeholder("Michigan",      "MI", "michigan"),
        placeholder("Minnesota",     "MN", "minnesota"),
        placeholder("Mississippi",   "MS", "mississippi"),
        placeholder("Missouri",      "MO", "missouri"),
        placeholder("Montana",       "MT", "montana"),
        placeholder("Nebraska",      "NE", "nebraska"),
        placeholder("Nevada",        "NV", "nevada"),
        placeholder("New Hampshire", "NH", "new-hampshire"),
        placeholder("New Jersey",    "NJ", "new-jersey"),
        placeholder("New Mexico",    "NM", "new-mexico"),

        Row(
            name: "New York", abbreviation: "NY", slug: "new-york",
            officialWebsiteUrl: "https://www.ny.gov",
            dmvUrl: "https://dmv.ny.gov",
            taxAgencyUrl: "https://www.tax.ny.gov",
            housingAgencyUrl: "https://ag.ny.gov",
            boardOfNursingUrl: "https://www.op.nysed.gov/registered-professional-nursing",
            notes: "Nursing licensure in New York is administered by the State Education Department's Office of the Professions, not a standalone Board of Nursing."
        ),

        placeholder("North Carolina","NC", "north-carolina"),
        placeholder("North Dakota",  "ND", "north-dakota"),
        placeholder("Ohio",          "OH", "ohio"),
        placeholder("Oklahoma",      "OK", "oklahoma"),
        placeholder("Oregon",        "OR", "oregon"),

        Row(
            name: "Pennsylvania", abbreviation: "PA", slug: "pennsylvania",
            officialWebsiteUrl: "https://www.pa.gov",
            dmvUrl: "https://www.pa.gov/agencies/dmv.html",
            taxAgencyUrl: "https://www.pa.gov/agencies/revenue.html",
            housingAgencyUrl: "https://www.attorneygeneral.gov",
            boardOfNursingUrl: "https://www.pa.gov/agencies/dos/department-and-offices/bpoa/boards-commissions/nursing",
            notes: "PA's DMV and Department of Revenue now live under pa.gov/agencies/. Board of Nursing is under the Department of State's Bureau of Professional and Occupational Affairs (BPOA)."
        ),

        placeholder("Rhode Island",  "RI", "rhode-island"),
        placeholder("South Carolina","SC", "south-carolina"),
        placeholder("South Dakota",  "SD", "south-dakota"),
        placeholder("Tennessee",     "TN", "tennessee"),

        Row(
            name: "Texas", abbreviation: "TX", slug: "texas",
            officialWebsiteUrl: "https://www.texas.gov",
            dmvUrl: "https://www.dps.texas.gov",
            taxAgencyUrl: "https://comptroller.texas.gov",
            housingAgencyUrl: "https://www.texasattorneygeneral.gov/consumer-protection/home-real-estate-and-travel",
            boardOfNursingUrl: "https://www.bon.texas.gov",
            notes: "Texas driver licenses are issued by DPS; vehicle registration is handled by TxDMV (txdmv.gov). The DPS URL covers the licensing side."
        ),

        placeholder("Utah",          "UT", "utah"),
        placeholder("Vermont",       "VT", "vermont"),

        Row(
            name: "Virginia", abbreviation: "VA", slug: "virginia",
            officialWebsiteUrl: "https://www.virginia.gov",
            dmvUrl: "https://www.dmv.virginia.gov",
            taxAgencyUrl: "https://www.tax.virginia.gov",
            housingAgencyUrl: "https://www.oag.state.va.us",
            boardOfNursingUrl: "https://www.dhp.virginia.gov/Boards/Nursing/",
            notes: "Board of Nursing is under the Department of Health Professions (DHP)."
        ),

        placeholder("Washington",    "WA", "washington"),
        placeholder("West Virginia", "WV", "west-virginia"),
        placeholder("Wisconsin",     "WI", "wisconsin"),
        placeholder("Wyoming",       "WY", "wyoming")
    ]
}
