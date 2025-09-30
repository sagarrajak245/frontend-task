import './Header.css';

const Header = () => {
  return (
    <header className="header">
      <div className="logo-container">

        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#10b981" strokeWidth="2">
          <polyline points="20 6 9 17 4 12"></polyline>
          <polyline points="20 6 9 17 4 12" transform="translate(0, 4)"></polyline>
        </svg>
        <h1 className="logo-text">DoubleTick</h1>
      </div>
    </header>
  );
};

export default Header;
