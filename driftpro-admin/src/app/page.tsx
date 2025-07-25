export default function Home() {
  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="container mx-auto px-4 py-8">
        <header className="mb-8">
          <h1 className="text-4xl font-bold text-center mb-4">
            DriftPro Admin Panel
          </h1>
          <p className="text-center text-gray-400">
            Administrer brukere, avdelinger og systemer for DriftPro
          </p>
        </header>
        
        <main className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {/* Dashboard Cards */}
          <div className="bg-gray-800 p-6 rounded-lg">
            <h2 className="text-xl font-semibold mb-4">👥 Brukere</h2>
            <p className="text-gray-400">Administrer alle brukere i systemet</p>
          </div>
          
          <a href="/avdelinger" className="bg-gray-800 p-6 rounded-lg hover:bg-gray-700 transition-colors cursor-pointer">
            <h2 className="text-xl font-semibold mb-4">🏢 Avdelinger</h2>
            <p className="text-gray-400">Se og administrer avdelinger</p>
          </a>
          
          <div className="bg-gray-800 p-6 rounded-lg">
            <h2 className="text-xl font-semibold mb-4">💬 Chat</h2>
            <p className="text-gray-400">Oversikt over chat-rom og meldinger</p>
          </div>
          
          <div className="bg-gray-800 p-6 rounded-lg">
            <h2 className="text-xl font-semibold mb-4">⚠️ Avvik</h2>
            <p className="text-gray-400">Administrer avvik og rapporter</p>
          </div>
          
          <div className="bg-gray-800 p-6 rounded-lg">
            <h2 className="text-xl font-semibold mb-4">📄 Dokumenter</h2>
            <p className="text-gray-400">Se alle dokumenter i systemet</p>
          </div>
          
          <div className="bg-gray-800 p-6 rounded-lg">
            <h2 className="text-xl font-semibold mb-4">📅 Skiftplan</h2>
            <p className="text-gray-400">Administrer skiftplan og tider</p>
          </div>
        </main>
        
        <footer className="mt-12 text-center text-gray-500">
          <p>DriftPro Admin Panel - Ready for deployment! 🚀</p>
        </footer>
      </div>
    </div>
  );
} 