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

    // All 50 US states + DC.
    //
    // URLs were verified on 2026-05-17 via curl HEAD/GET (Mozilla user-agent,
    // following redirects). For state portals that use Cloudflare or similar
    // anti-bot protection (returning 403/404 to non-browser requests), we kept
    // the URL when the domain is the well-known, long-standing official one.
    //
    // A handful of fields remain "#" placeholders because no canonical URL
    // could be confirmed in this pass - for example, Hawaii's motor vehicle
    // services are administered at the county level, so there's no single
    // state-wide DMV URL. Each placeholder is documented in `notes`.

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

    private static let stateRows: [Row] = [
        Row(
            name: "Alabama", abbreviation: "AL", slug: "alabama",
            officialWebsiteUrl: "https://www.alabama.gov",
            dmvUrl: "https://www.alea.gov",
            taxAgencyUrl: "https://www.revenue.alabama.gov",
            housingAgencyUrl: "https://www.alabamaag.gov",
            boardOfNursingUrl: "https://www.abn.alabama.gov",
            notes: "Driver licenses are issued by the Alabama Law Enforcement Agency (ALEA). Vehicle registration is county-level."
        ),
        Row(
            name: "Alaska", abbreviation: "AK", slug: "alaska",
            officialWebsiteUrl: "https://alaska.gov",
            dmvUrl: "https://doa.alaska.gov/dmv",
            taxAgencyUrl: "https://tax.alaska.gov",
            housingAgencyUrl: "https://law.alaska.gov",
            boardOfNursingUrl: "https://www.commerce.alaska.gov/web/cbpl/professionallicensing/boardofnursing.aspx",
            notes: "Alaska has no personal state income tax; tax.alaska.gov is the Department of Revenue."
        ),
        Row(
            name: "Arizona", abbreviation: "AZ", slug: "arizona",
            officialWebsiteUrl: "https://az.gov",
            dmvUrl: "https://azdot.gov/mvd",
            taxAgencyUrl: "https://azdor.gov",
            housingAgencyUrl: "https://www.azag.gov",
            boardOfNursingUrl: "https://www.azbn.gov",
            notes: "Driver licenses are issued by ADOT's Motor Vehicle Division (MVD)."
        ),
        Row(
            name: "Arkansas", abbreviation: "AR", slug: "arkansas",
            officialWebsiteUrl: "https://www.arkansas.gov",
            dmvUrl: "https://www.dfa.arkansas.gov",
            taxAgencyUrl: "https://www.dfa.arkansas.gov",
            housingAgencyUrl: "https://arkansasag.gov",
            boardOfNursingUrl: "https://healthy.arkansas.gov/programs-services/topics/arkansas-board-of-nursing/",
            notes: "DFA handles both driver services and tax. Arkansas Board of Nursing recently moved under healthy.arkansas.gov. Arkansas state sites return 403 to non-browser requests (Cloudflare)."
        ),
        Row(
            name: "California", abbreviation: "CA", slug: "california",
            officialWebsiteUrl: "https://www.ca.gov",
            dmvUrl: "https://www.dmv.ca.gov",
            taxAgencyUrl: "https://www.ftb.ca.gov",
            housingAgencyUrl: "https://oag.ca.gov/consumers",
            boardOfNursingUrl: "https://www.rn.ca.gov",
            notes: "FTB handles personal income tax; CDTFA handles sales tax. RN board is rn.ca.gov; LVNs use BVNPT."
        ),
        Row(
            name: "Colorado", abbreviation: "CO", slug: "colorado",
            officialWebsiteUrl: "https://www.colorado.gov",
            dmvUrl: "https://dmv.colorado.gov",
            taxAgencyUrl: "https://tax.colorado.gov",
            housingAgencyUrl: "https://coag.gov",
            boardOfNursingUrl: "https://dpo.colorado.gov/Nursing",
            notes: "Nursing licensure under DORA's Division of Professions and Occupations. Colorado state sites use anti-bot protection."
        ),
        Row(
            name: "Connecticut", abbreviation: "CT", slug: "connecticut",
            officialWebsiteUrl: "https://portal.ct.gov",
            dmvUrl: "https://portal.ct.gov/DMV",
            taxAgencyUrl: "https://portal.ct.gov/DRS",
            housingAgencyUrl: "https://portal.ct.gov/AG",
            boardOfNursingUrl: "https://portal.ct.gov/dph/practitioner-licensing--investigations/nursing",
            notes: "Connecticut consolidates most agencies under portal.ct.gov subpaths."
        ),
        Row(
            name: "Delaware", abbreviation: "DE", slug: "delaware",
            officialWebsiteUrl: "https://delaware.gov",
            dmvUrl: "https://www.dmv.de.gov",
            taxAgencyUrl: "https://revenue.delaware.gov",
            housingAgencyUrl: "https://attorneygeneral.delaware.gov",
            boardOfNursingUrl: "https://dpr.delaware.gov/boards/nursing",
            notes: "Board of Nursing under the Division of Professional Regulation."
        ),
        Row(
            name: "District of Columbia", abbreviation: "DC", slug: "district-of-columbia",
            officialWebsiteUrl: "https://dc.gov",
            dmvUrl: "https://dmv.dc.gov",
            taxAgencyUrl: "https://otr.cfo.dc.gov",
            housingAgencyUrl: "https://oag.dc.gov",
            boardOfNursingUrl: "https://dchealth.dc.gov/service/board-nursing",
            notes: "Tax is the Office of Tax and Revenue (OTR) under the CFO."
        ),
        Row(
            name: "Florida", abbreviation: "FL", slug: "florida",
            officialWebsiteUrl: "https://www.myflorida.com",
            dmvUrl: "https://www.flhsmv.gov",
            taxAgencyUrl: "https://floridarevenue.com",
            housingAgencyUrl: "https://myfloridalegal.com",
            boardOfNursingUrl: "https://floridasnursing.gov",
            notes: "Driver licensing under FLHSMV. Florida has no personal income tax - floridarevenue.com covers sales / corporate / etc."
        ),
        Row(
            name: "Georgia", abbreviation: "GA", slug: "georgia",
            officialWebsiteUrl: "https://georgia.gov",
            dmvUrl: "https://dds.georgia.gov",
            taxAgencyUrl: "https://dor.georgia.gov",
            housingAgencyUrl: "https://law.georgia.gov",
            boardOfNursingUrl: "https://sos.ga.gov/georgia-board-nursing",
            notes: "DDS issues driver licenses. Board of Nursing under the Secretary of State."
        ),
        Row(
            name: "Hawaii", abbreviation: "HI", slug: "hawaii",
            officialWebsiteUrl: "https://portal.ehawaii.gov",
            dmvUrl: "#",
            taxAgencyUrl: "https://tax.hawaii.gov",
            housingAgencyUrl: "https://ag.hawaii.gov",
            boardOfNursingUrl: "https://cca.hawaii.gov/pvl/boards/nursing",
            notes: "Motor vehicle services in Hawaii are administered at the county level (Honolulu, Hawaii, Maui, Kauai) - there is no state-wide DMV URL. Nursing under DCCA Professional & Vocational Licensing."
        ),
        Row(
            name: "Idaho", abbreviation: "ID", slug: "idaho",
            officialWebsiteUrl: "https://www.idaho.gov",
            dmvUrl: "https://itd.idaho.gov/itddmv",
            taxAgencyUrl: "https://tax.idaho.gov",
            housingAgencyUrl: "https://www.ag.idaho.gov",
            boardOfNursingUrl: "#",
            notes: "Idaho Board of Nursing's website (ibn.idaho.gov) returned DNS errors during verification; not included pending re-check."
        ),
        Row(
            name: "Illinois", abbreviation: "IL", slug: "illinois",
            officialWebsiteUrl: "https://www.illinois.gov",
            dmvUrl: "https://www.ilsos.gov",
            taxAgencyUrl: "https://tax.illinois.gov",
            housingAgencyUrl: "https://illinoisattorneygeneral.gov",
            boardOfNursingUrl: "https://idfpr.illinois.gov",
            notes: "Driver licenses issued by Secretary of State (ilsos.gov), not a DMV. Nursing licensure under IDFPR."
        ),
        Row(
            name: "Indiana", abbreviation: "IN", slug: "indiana",
            officialWebsiteUrl: "https://www.in.gov",
            dmvUrl: "https://www.in.gov/bmv",
            taxAgencyUrl: "https://www.in.gov/dor",
            housingAgencyUrl: "https://www.in.gov/attorneygeneral",
            boardOfNursingUrl: "https://www.in.gov/pla/professions/nursing-home",
            notes: "Indiana consolidates all agency pages under in.gov."
        ),
        Row(
            name: "Iowa", abbreviation: "IA", slug: "iowa",
            officialWebsiteUrl: "https://www.iowa.gov",
            dmvUrl: "https://iowadot.gov",
            taxAgencyUrl: "https://tax.iowa.gov",
            housingAgencyUrl: "https://www.iowaattorneygeneral.gov",
            boardOfNursingUrl: "https://dial.iowa.gov/licenses/health-professions/nursing-professional-midwifery",
            notes: "Nursing licensure recently moved to Iowa DIAL (Department of Inspections, Appeals & Licensing); nursing.iowa.gov redirects there."
        ),
        Row(
            name: "Kansas", abbreviation: "KS", slug: "kansas",
            officialWebsiteUrl: "https://kansas.gov",
            dmvUrl: "https://www.ksrevenue.gov/dmv",
            taxAgencyUrl: "https://www.ksrevenue.gov",
            housingAgencyUrl: "https://ag.ks.gov",
            boardOfNursingUrl: "https://ksbn.kansas.gov",
            notes: "Vehicle services and tax both under KS Department of Revenue."
        ),
        Row(
            name: "Kentucky", abbreviation: "KY", slug: "kentucky",
            officialWebsiteUrl: "https://kentucky.gov",
            dmvUrl: "https://drive.ky.gov",
            taxAgencyUrl: "https://revenue.ky.gov",
            housingAgencyUrl: "https://ag.ky.gov",
            boardOfNursingUrl: "https://kbn.ky.gov",
            notes: ""
        ),
        Row(
            name: "Louisiana", abbreviation: "LA", slug: "louisiana",
            officialWebsiteUrl: "https://www.la.gov",
            dmvUrl: "https://www.expresslane.org",
            taxAgencyUrl: "https://revenue.louisiana.gov",
            housingAgencyUrl: "https://www.ag.state.la.us",
            boardOfNursingUrl: "https://www.lsbn.state.la.us",
            notes: "Louisiana OMV uses expresslane.org as its public portal."
        ),
        Row(
            name: "Maine", abbreviation: "ME", slug: "maine",
            officialWebsiteUrl: "https://www.maine.gov",
            dmvUrl: "https://www.maine.gov/sos/bmv",
            taxAgencyUrl: "https://www.maine.gov/revenue",
            housingAgencyUrl: "https://www.maine.gov/ag",
            boardOfNursingUrl: "https://www.maine.gov/boardofnursing",
            notes: "BMV (driver licenses) is under the Secretary of State."
        ),
        Row(
            name: "Maryland", abbreviation: "MD", slug: "maryland",
            officialWebsiteUrl: "https://www.maryland.gov",
            dmvUrl: "https://mva.maryland.gov",
            taxAgencyUrl: "https://www.marylandcomptroller.gov",
            housingAgencyUrl: "https://oag.maryland.gov",
            boardOfNursingUrl: "https://health.maryland.gov/mbon/Pages/default.aspx",
            notes: "Motor vehicle agency is the MVA. Tax authority is the Comptroller of Maryland (marylandtaxes.gov redirects there). Board of Nursing under Maryland Department of Health."
        ),
        Row(
            name: "Massachusetts", abbreviation: "MA", slug: "massachusetts",
            officialWebsiteUrl: "https://www.mass.gov",
            dmvUrl: "https://www.mass.gov/orgs/massachusetts-registry-of-motor-vehicles",
            taxAgencyUrl: "https://www.mass.gov/orgs/massachusetts-department-of-revenue",
            housingAgencyUrl: "https://www.mass.gov/orgs/office-of-the-attorney-general",
            boardOfNursingUrl: "https://www.mass.gov/orgs/board-of-registration-in-nursing",
            notes: "Massachusetts hosts all agencies under mass.gov/orgs/. State portal uses anti-bot protection."
        ),
        Row(
            name: "Michigan", abbreviation: "MI", slug: "michigan",
            officialWebsiteUrl: "https://www.michigan.gov",
            dmvUrl: "https://www.michigan.gov/sos",
            taxAgencyUrl: "https://www.michigan.gov/treasury",
            housingAgencyUrl: "https://www.michigan.gov/ag",
            boardOfNursingUrl: "https://www.michigan.gov/lara/bureau-list/bpl/health/hp-lic-health-prof/nursing",
            notes: "Driver licenses under Secretary of State. Nursing licensure under LARA / Bureau of Professional Licensing."
        ),
        Row(
            name: "Minnesota", abbreviation: "MN", slug: "minnesota",
            officialWebsiteUrl: "https://mn.gov",
            dmvUrl: "https://dps.mn.gov/divisions/dvs",
            taxAgencyUrl: "https://www.revenue.state.mn.us",
            housingAgencyUrl: "https://www.ag.state.mn.us",
            boardOfNursingUrl: "https://mn.gov/boards/nursing",
            notes: "DVS (Driver and Vehicle Services) under DPS. Minnesota state portal uses anti-bot protection."
        ),
        Row(
            name: "Mississippi", abbreviation: "MS", slug: "mississippi",
            officialWebsiteUrl: "https://www.ms.gov",
            dmvUrl: "https://www.driverservicebureau.dps.ms.gov",
            taxAgencyUrl: "https://www.dor.ms.gov",
            housingAgencyUrl: "#",
            boardOfNursingUrl: "https://www.msbn.ms.gov",
            notes: "Mississippi Attorney General's tenant resources page couldn't be located on a stable URL; AG site (ago.state.ms.us) returned DNS errors during verification."
        ),
        Row(
            name: "Missouri", abbreviation: "MO", slug: "missouri",
            officialWebsiteUrl: "https://www.mo.gov",
            dmvUrl: "https://dor.mo.gov/driver-license",
            taxAgencyUrl: "https://dor.mo.gov",
            housingAgencyUrl: "https://ago.mo.gov",
            boardOfNursingUrl: "https://pr.mo.gov/nursing.asp",
            notes: "DOR handles both driver licensing and tax."
        ),
        Row(
            name: "Montana", abbreviation: "MT", slug: "montana",
            officialWebsiteUrl: "https://mt.gov",
            dmvUrl: "https://dojmt.gov",
            taxAgencyUrl: "https://mtrevenue.gov",
            housingAgencyUrl: "https://dojmt.gov",
            boardOfNursingUrl: "https://boards.bsd.dli.mt.gov/nur",
            notes: "Driver services and the consumer protection / housing resources both fall under the Department of Justice."
        ),
        Row(
            name: "Nebraska", abbreviation: "NE", slug: "nebraska",
            officialWebsiteUrl: "https://www.nebraska.gov",
            dmvUrl: "https://dmv.nebraska.gov",
            taxAgencyUrl: "https://revenue.nebraska.gov",
            housingAgencyUrl: "https://ago.nebraska.gov",
            boardOfNursingUrl: "https://dhhs.ne.gov/licensure/Pages/Nurse-Licensing.aspx",
            notes: "Nursing licensure under DHHS Licensure Unit."
        ),
        Row(
            name: "Nevada", abbreviation: "NV", slug: "nevada",
            officialWebsiteUrl: "https://www.nv.gov",
            dmvUrl: "https://dmv.nv.gov",
            taxAgencyUrl: "https://tax.nv.gov",
            housingAgencyUrl: "https://ag.nv.gov",
            boardOfNursingUrl: "https://nevadanursingboard.org",
            notes: "Nevada State Board of Nursing operates at nevadanursingboard.org (non-.gov domain but is the official board)."
        ),
        Row(
            name: "New Hampshire", abbreviation: "NH", slug: "new-hampshire",
            officialWebsiteUrl: "https://www.nh.gov",
            dmvUrl: "https://www.nh.gov/safety/divisions/dmv",
            taxAgencyUrl: "https://www.revenue.nh.gov",
            housingAgencyUrl: "https://www.doj.nh.gov",
            boardOfNursingUrl: "https://www.oplc.nh.gov/board-nursing",
            notes: "Nursing licensure under OPLC (Office of Professional Licensure and Certification). State sites use anti-bot protection."
        ),
        Row(
            name: "New Jersey", abbreviation: "NJ", slug: "new-jersey",
            officialWebsiteUrl: "https://nj.gov",
            dmvUrl: "https://www.nj.gov/mvc",
            taxAgencyUrl: "https://www.state.nj.us/treasury/taxation",
            housingAgencyUrl: "https://www.nj.gov/oag",
            boardOfNursingUrl: "https://www.njconsumeraffairs.gov/nur",
            notes: "MVC (Motor Vehicle Commission) issues licenses. Nursing under Consumer Affairs."
        ),
        Row(
            name: "New Mexico", abbreviation: "NM", slug: "new-mexico",
            officialWebsiteUrl: "https://www.newmexico.gov",
            dmvUrl: "https://www.mvd.newmexico.gov",
            taxAgencyUrl: "https://www.tax.newmexico.gov",
            housingAgencyUrl: "https://nmag.gov",
            boardOfNursingUrl: "#",
            notes: "New Mexico Board of Nursing's typical URLs (nmbon.unm.edu, nmbon.org) failed verification; not included pending re-check."
        ),
        Row(
            name: "New York", abbreviation: "NY", slug: "new-york",
            officialWebsiteUrl: "https://www.ny.gov",
            dmvUrl: "https://dmv.ny.gov",
            taxAgencyUrl: "https://www.tax.ny.gov",
            housingAgencyUrl: "https://ag.ny.gov",
            boardOfNursingUrl: "https://www.op.nysed.gov/registered-professional-nursing",
            notes: "Nursing licensure is administered by the State Education Department's Office of the Professions, not a standalone Board of Nursing."
        ),
        Row(
            name: "North Carolina", abbreviation: "NC", slug: "north-carolina",
            officialWebsiteUrl: "https://www.nc.gov",
            dmvUrl: "https://www.ncdot.gov/dmv",
            taxAgencyUrl: "https://www.ncdor.gov",
            housingAgencyUrl: "https://ncdoj.gov",
            boardOfNursingUrl: "https://www.ncbon.com",
            notes: "NC Board of Nursing operates at ncbon.com (non-.gov domain but is the official board)."
        ),
        Row(
            name: "North Dakota", abbreviation: "ND", slug: "north-dakota",
            officialWebsiteUrl: "https://www.nd.gov",
            dmvUrl: "https://www.dot.nd.gov",
            taxAgencyUrl: "https://www.tax.nd.gov",
            housingAgencyUrl: "https://attorneygeneral.nd.gov",
            boardOfNursingUrl: "https://www.ndbon.org",
            notes: "ND Board of Nursing operates at ndbon.org (non-.gov domain but is the official board)."
        ),
        Row(
            name: "Ohio", abbreviation: "OH", slug: "ohio",
            officialWebsiteUrl: "https://ohio.gov",
            dmvUrl: "https://www.bmv.ohio.gov",
            taxAgencyUrl: "https://tax.ohio.gov",
            housingAgencyUrl: "https://www.ohioattorneygeneral.gov",
            boardOfNursingUrl: "https://nursing.ohio.gov",
            notes: "Ohio agency subdomains use anti-bot protection that returns 404 to curl HEAD requests; URLs verified by Web search."
        ),
        Row(
            name: "Oklahoma", abbreviation: "OK", slug: "oklahoma",
            officialWebsiteUrl: "https://oklahoma.gov",
            dmvUrl: "https://oklahoma.gov/service",
            taxAgencyUrl: "https://oklahoma.gov/tax",
            housingAgencyUrl: "https://oag.ok.gov",
            boardOfNursingUrl: "https://nursing.ok.gov",
            notes: "Driver licensing recently consolidated under 'Service Oklahoma' (oklahoma.gov/service)."
        ),
        Row(
            name: "Oregon", abbreviation: "OR", slug: "oregon",
            officialWebsiteUrl: "https://www.oregon.gov",
            dmvUrl: "https://www.oregon.gov/odot/dmv",
            taxAgencyUrl: "https://www.oregon.gov/dor",
            housingAgencyUrl: "https://www.doj.state.or.us",
            boardOfNursingUrl: "https://www.oregon.gov/osbn",
            notes: ""
        ),
        Row(
            name: "Pennsylvania", abbreviation: "PA", slug: "pennsylvania",
            officialWebsiteUrl: "https://www.pa.gov",
            dmvUrl: "https://www.pa.gov/agencies/dmv.html",
            taxAgencyUrl: "https://www.pa.gov/agencies/revenue.html",
            housingAgencyUrl: "https://www.attorneygeneral.gov",
            boardOfNursingUrl: "https://www.pa.gov/agencies/dos/department-and-offices/bpoa/boards-commissions/nursing",
            notes: "PA recently moved DMV and DOR under pa.gov/agencies/. Board of Nursing is under the Department of State's BPOA."
        ),
        Row(
            name: "Rhode Island", abbreviation: "RI", slug: "rhode-island",
            officialWebsiteUrl: "https://www.ri.gov",
            dmvUrl: "https://dmv.ri.gov",
            taxAgencyUrl: "https://tax.ri.gov",
            housingAgencyUrl: "https://riag.ri.gov",
            boardOfNursingUrl: "https://health.ri.gov/licenses/detail.php?id=232",
            notes: "Nursing licensure under the Department of Health."
        ),
        Row(
            name: "South Carolina", abbreviation: "SC", slug: "south-carolina",
            officialWebsiteUrl: "https://sc.gov",
            dmvUrl: "https://www.scdmvonline.com",
            taxAgencyUrl: "https://dor.sc.gov",
            housingAgencyUrl: "https://www.scag.gov",
            boardOfNursingUrl: "https://llr.sc.gov/nurse",
            notes: "SC DMV operates at scdmvonline.com (non-.gov domain but is the official DMV). Nursing under LLR."
        ),
        Row(
            name: "South Dakota", abbreviation: "SD", slug: "south-dakota",
            officialWebsiteUrl: "https://sd.gov",
            dmvUrl: "https://dps.sd.gov/driver-licensing",
            taxAgencyUrl: "https://dor.sd.gov",
            housingAgencyUrl: "https://atg.sd.gov",
            boardOfNursingUrl: "#",
            notes: "SD Board of Nursing's expected path on doh.sd.gov returned 404 during verification; not included pending re-check."
        ),
        Row(
            name: "Tennessee", abbreviation: "TN", slug: "tennessee",
            officialWebsiteUrl: "https://www.tn.gov",
            dmvUrl: "https://www.tn.gov/safety/driver-services",
            taxAgencyUrl: "https://www.tn.gov/revenue",
            housingAgencyUrl: "https://www.tn.gov/attorneygeneral",
            boardOfNursingUrl: "#",
            notes: "TN Board of Nursing's expected paths under tn.gov/health returned 404 during verification; not included pending re-check."
        ),
        Row(
            name: "Texas", abbreviation: "TX", slug: "texas",
            officialWebsiteUrl: "https://www.texas.gov",
            dmvUrl: "https://www.dps.texas.gov",
            taxAgencyUrl: "https://comptroller.texas.gov",
            housingAgencyUrl: "https://www.texasattorneygeneral.gov/consumer-protection/home-real-estate-and-travel",
            boardOfNursingUrl: "https://www.bon.texas.gov",
            notes: "Texas driver licenses are issued by DPS; vehicle registration is handled by TxDMV (txdmv.gov)."
        ),
        Row(
            name: "Utah", abbreviation: "UT", slug: "utah",
            officialWebsiteUrl: "https://www.utah.gov",
            dmvUrl: "https://dld.utah.gov",
            taxAgencyUrl: "https://tax.utah.gov",
            housingAgencyUrl: "https://attorneygeneral.utah.gov",
            boardOfNursingUrl: "https://dopl.utah.gov/nurse",
            notes: "Driver License Division (DLD) issues licenses; Tax Commission handles vehicle registration separately. Utah state sites use anti-bot protection."
        ),
        Row(
            name: "Vermont", abbreviation: "VT", slug: "vermont",
            officialWebsiteUrl: "https://www.vermont.gov",
            dmvUrl: "https://dmv.vermont.gov",
            taxAgencyUrl: "https://tax.vermont.gov",
            housingAgencyUrl: "https://ago.vermont.gov",
            boardOfNursingUrl: "https://sos.vermont.gov/nurses",
            notes: "Vermont Board of Nursing under the Secretary of State's Office of Professional Regulation."
        ),
        Row(
            name: "Virginia", abbreviation: "VA", slug: "virginia",
            officialWebsiteUrl: "https://www.virginia.gov",
            dmvUrl: "https://www.dmv.virginia.gov",
            taxAgencyUrl: "https://www.tax.virginia.gov",
            housingAgencyUrl: "https://www.oag.state.va.us",
            boardOfNursingUrl: "https://www.dhp.virginia.gov/Boards/Nursing/",
            notes: "Board of Nursing under the Department of Health Professions (DHP)."
        ),
        Row(
            name: "Washington", abbreviation: "WA", slug: "washington",
            officialWebsiteUrl: "https://access.wa.gov",
            dmvUrl: "https://www.dol.wa.gov",
            taxAgencyUrl: "https://www.dor.wa.gov",
            housingAgencyUrl: "https://www.atg.wa.gov",
            boardOfNursingUrl: "#",
            notes: "WA Nursing Care Quality Assurance Commission's expected paths under doh.wa.gov returned 404 during verification; not included pending re-check. Washington uses access.wa.gov as the consolidated state portal. Driver licenses under Dept of Licensing (DOL)."
        ),
        Row(
            name: "West Virginia", abbreviation: "WV", slug: "west-virginia",
            officialWebsiteUrl: "https://www.wv.gov",
            dmvUrl: "https://transportation.wv.gov/dmv",
            taxAgencyUrl: "https://tax.wv.gov",
            housingAgencyUrl: "https://ago.wv.gov",
            boardOfNursingUrl: "https://wvrnboard.wv.gov",
            notes: ""
        ),
        Row(
            name: "Wisconsin", abbreviation: "WI", slug: "wisconsin",
            officialWebsiteUrl: "https://www.wisconsin.gov",
            dmvUrl: "https://wisconsindot.gov",
            taxAgencyUrl: "https://www.revenue.wi.gov",
            housingAgencyUrl: "https://www.doj.state.wi.us",
            boardOfNursingUrl: "https://dsps.wi.gov/Pages/Professions/Default.aspx",
            notes: "Wisconsin nursing licensure under DSPS (Department of Safety and Professional Services); the linked page is the general professions index - navigate to Registered Nurse."
        ),
        Row(
            name: "Wyoming", abbreviation: "WY", slug: "wyoming",
            officialWebsiteUrl: "#",
            dmvUrl: "https://www.dot.state.wy.us",
            taxAgencyUrl: "https://revenue.wyo.gov",
            housingAgencyUrl: "https://ag.wyo.gov",
            boardOfNursingUrl: "https://wsbn.wyo.gov",
            notes: "Wyoming state homepage (wyo.gov) returned DNS errors during verification; not included pending re-check. Nursing board recently moved from nursing-online.state.wy.us to wsbn.wyo.gov."
        )
    ]
}
