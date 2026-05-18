import { Routes, Route, Navigate } from "react-router-dom";
import { PageShell } from "./components/layout/PageShell";
import LandingPage from "./pages/LandingPage";
import BuilderPage from "./pages/BuilderPage";
import ResultsPage from "./pages/ResultsPage";

export default function App() {
  return (
    <PageShell>
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/builder" element={<BuilderPage />} />
        <Route path="/results" element={<ResultsPage />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </PageShell>
  );
}
