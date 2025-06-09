import { useState } from 'react';

// Menus used to demonstrate a simple light themed application layout
const themes = {
  Accueil: ['Tableau de bord', 'Rapports'],
  'Mon Profil': ['Informations', 'Préférences'],
  Paramètres: ['Général', 'Sécurité'],
  Configuration: ['Système', 'Intégrations'],
};

export default function Home() {
  const themeKeys = Object.keys(themes);
  const [selectedTheme, setSelectedTheme] = useState(themeKeys[0]);
  const [selectedAction, setSelectedAction] = useState(themes[themeKeys[0]][0]);

  const actions = themes[selectedTheme];

  return (
    <div className="flex flex-col h-screen text-gray-800 bg-gray-100">
      <div className="flex flex-1">
        {/* Global menu */}
        <div className="w-48 bg-white p-4 space-y-2 border-r">
        {themeKeys.map((t) => (
          <button
            key={t}
            className={`block w-full text-left px-2 py-1 rounded ${
              selectedTheme === t ? 'bg-blue-200' : 'hover:bg-blue-100'
            }`}
            onClick={() => {
              setSelectedTheme(t);
              setSelectedAction(themes[t][0]);
            }}
          >
            {t}
          </button>
        ))}
      </div>

      {/* Actions for selected theme */}
      <div className="w-48 bg-gray-50 p-4 space-y-2 border-l">
        {actions.map((a) => (
          <button
            key={a}
            className={`block w-full text-left px-2 py-1 rounded ${
              selectedAction === a ? 'bg-blue-200' : 'hover:bg-blue-100'
            }`}
            onClick={() => setSelectedAction(a)}
          >
            {a}
          </button>
        ))}
      </div>

      {/* Main content */}
        <div className="flex-1 p-8" style={{ width: '70%' }}>
          <h1 className="text-2xl font-semibold mb-4">{selectedTheme} - {selectedAction}</h1>
          <div className="bg-white rounded p-4 shadow">
            <p>Content for {selectedAction} in {selectedTheme}.</p>
          </div>
        </div>
      </div>
      <footer className="h-10 bg-gray-200 border-t flex items-center justify-between px-4 text-sm">
        <div>Users: 102 • Memory: 68%</div>
        <div className="space-x-2">
          <a href="#" className="text-blue-600 hover:underline">Docs</a>
          <a href="#" className="text-blue-600 hover:underline">Support</a>
        </div>
      </footer>
    </div>
  );
}
