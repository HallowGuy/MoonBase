import { useState } from 'react';

const themes = {
  Dashboard: ['Overview', 'Stats', 'Graphs'],
  Settings: ['Profile', 'Preferences', 'Security'],
  Reports: ['Monthly', 'Annual', 'Custom'],
};

export default function Home() {
  const themeKeys = Object.keys(themes);
  const [selectedTheme, setSelectedTheme] = useState(themeKeys[0]);
  const [selectedAction, setSelectedAction] = useState(themes[themeKeys[0]][0]);

  const actions = themes[selectedTheme];

  return (
    <div className="flex h-screen text-gray-200 bg-gray-900">
      {/* Global menu */}
      <div className="w-48 bg-gray-800 p-4 space-y-2">
        {themeKeys.map((t) => (
          <button
            key={t}
            className={`block w-full text-left px-2 py-1 rounded ${
              selectedTheme === t ? 'bg-gray-700' : 'hover:bg-gray-700'
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
      <div className="w-48 bg-gray-800 p-4 space-y-2 border-l border-gray-700">
        {actions.map((a) => (
          <button
            key={a}
            className={`block w-full text-left px-2 py-1 rounded ${
              selectedAction === a ? 'bg-gray-700' : 'hover:bg-gray-700'
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
        <div className="bg-gray-800 rounded p-4">
          <p>Content for {selectedAction} in {selectedTheme}.</p>
        </div>
      </div>
    </div>
  );
}
