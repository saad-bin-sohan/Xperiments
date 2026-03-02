import { useState } from 'react';
import { signOut } from 'firebase/auth';
import { auth } from './core/firebase';
import { LoginForm } from './features/auth/LoginForm';
import { useAdminSession } from './features/auth/useAdminSession';
import { DashboardPanel } from './features/dashboard/DashboardPanel';
import { GalleryManagerPanel } from './features/gallery/GalleryManagerPanel';
import { UserManagerPanel } from './features/users/UserManagerPanel';
import { FeatureFlagsPanel } from './features/featureFlags/FeatureFlagsPanel';
import { LoadingBlock, ErrorBlock } from './components/StateBlocks';

type AdminTab = 'dashboard' | 'gallery' | 'users' | 'flags';

const TABS: Array<{ key: AdminTab; label: string }> = [
  { key: 'dashboard', label: 'Dashboard' },
  { key: 'gallery', label: 'Gallery Manager' },
  { key: 'users', label: 'User Manager' },
  { key: 'flags', label: 'Feature Flags' },
];

export default function App() {
  const { loading, user, unauthorizedMessage, error } = useAdminSession();
  const [activeTab, setActiveTab] = useState<AdminTab>('dashboard');

  if (loading) {
    return (
      <div className="page-shell">
        <LoadingBlock message="Checking admin session..." />
      </div>
    );
  }

  if (error) {
    return (
      <div className="page-shell">
        <ErrorBlock message={error} />
      </div>
    );
  }

  if (!user) {
    return <LoginForm notice={unauthorizedMessage} />;
  }

  return (
    <div className="page-shell">
      <header className="top-bar">
        <div>
          <h1>Xperiments Admin</h1>
          <p className="muted">Signed in as {user.email}</p>
        </div>
        <button
          type="button"
          onClick={() => {
            void signOut(auth);
          }}
        >
          Sign Out
        </button>
      </header>

      <nav className="tab-nav" aria-label="Admin navigation">
        {TABS.map((tab) => (
          <button
            key={tab.key}
            type="button"
            className={activeTab === tab.key ? 'tab active' : 'tab'}
            onClick={() => setActiveTab(tab.key)}
          >
            {tab.label}
          </button>
        ))}
      </nav>

      <main className="content-grid">
        {activeTab === 'dashboard' ? <DashboardPanel /> : null}
        {activeTab === 'gallery' ? <GalleryManagerPanel /> : null}
        {activeTab === 'users' ? <UserManagerPanel /> : null}
        {activeTab === 'flags' ? <FeatureFlagsPanel /> : null}
      </main>
    </div>
  );
}
