import '../styles/globals.css';
import { useEffect } from 'react';
import Keycloak from 'keycloak-js';

export default function App({ Component, pageProps }) {
  useEffect(() => {
    const keycloak = new Keycloak({
      url: '/keycloak/',
      realm: 'moonbase',
      clientId: 'frontend',
    });
    keycloak.init({ onLoad: 'login-required' }).then((authenticated) => {
      if (authenticated && keycloak.tokenParsed) {
        fetch('/api/user/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            username: keycloak.tokenParsed.preferred_username,
            email: keycloak.tokenParsed.email,
          }),
        });
      }
    });
  }, []);
  return <Component {...pageProps} />;
}
