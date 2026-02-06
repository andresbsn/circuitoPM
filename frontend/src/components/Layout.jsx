import { useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import logo from '../assets/logo_original.jpeg';

export default function Layout({ children, title, navigationItems = [] }) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const { user, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  // Basic SVGs for hamburger and close
  const MenuIcon = () => (
    <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
    </svg>
  );
  
  const XIcon = () => (
    <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
    </svg>
  );

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col font-sans">
       {/* Top Navigation Bar - Glassmorphism */}
      <nav className="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-gray-200 transition-all duration-300">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              {/* Mobile menu button */}
              <div className="flex items-center md:hidden mr-2">
                <button
                  onClick={() => setSidebarOpen(!sidebarOpen)}
                  className="inline-flex items-center justify-center p-2 rounded-lg text-gray-500 hover:text-gray-900 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-primary-500 transition-colors"
                >
                  <span className="sr-only">Abrir menú</span>
                  {sidebarOpen ? <XIcon /> : <MenuIcon />}
                </button>
              </div>

              <div className="flex-shrink-0 flex items-center cursor-pointer group gap-3" onClick={() => navigate('/')}>
                 <img src={logo} alt="Logo" className="h-10 w-auto rounded-lg shadow-sm border border-gray-200" />
                 {/* Premium Text Effect for Logo */}
                 <h1 className="text-xl md:text-2xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-primary-700 to-gray-800 tracking-tight group-hover:opacity-80 transition-opacity">
                   {title || 'Circuito Pádel PM'}
                 </h1>
              </div>

              {/* Desktop Navigation Links */}
              <div className="hidden md:ml-8 md:flex md:space-x-1">
                 {navigationItems.map((item) => {
                    const isActive = item.current !== undefined ? item.current : location.pathname === item.href;
                    const commonClasses = `px-3 py-2 rounded-md text-sm font-medium transition-all duration-200 ${
                      isActive
                        ? 'text-primary-700 bg-primary-50'
                        : 'text-gray-600 hover:text-gray-900 hover:bg-gray-100'
                    }`;

                    return item.onClick ? (
                      <button
                        key={item.name}
                        onClick={item.onClick}
                        className={commonClasses}
                      >
                        {item.name}
                      </button>
                    ) : (
                      <Link
                        key={item.name}
                        to={item.href}
                        className={commonClasses}
                      >
                        {item.name}
                      </Link>
                    );
                 })}
              </div>
            </div>

            {/* User Dropdown / Logout */}
            <div className="flex items-center space-x-4">
               {user ? (
                 <div className="flex items-center space-x-3">
                   <div className="hidden md:flex flex-col items-end mr-2">
                     <span className="text-sm font-semibold text-gray-900 leading-none">
                       {user.profile?.nombre || user.username}
                     </span>
                     <span className="text-xs text-gray-500 mt-1 uppercase tracking-wide">
                        {user.role}
                     </span>
                   </div>
                   <button
                     onClick={logout}
                     className="bg-white border border-gray-200 p-2 rounded-full text-gray-500 hover:text-red-600 hover:border-red-200 hover:bg-red-50 focus:outline-none transition-all duration-200 shadow-sm"
                     title="Cerrar Sesión"
                   >
                     <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                       <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                     </svg>
                   </button>
                 </div>
               ) : (
                 <div className="flex items-center space-x-4">
                    <Link to="/login" className="bg-primary-600 hover:bg-primary-700 text-white px-5 py-2.5 rounded-lg text-sm font-semibold shadow-md shadow-primary-500/30 hover:shadow-lg hover:shadow-primary-500/40 transition-all duration-200 transform hover:-translate-y-0.5">
                      Iniciar Sesión
                    </Link>
                 </div>
               )}
            </div>
          </div>
        </div>

        {/* Mobile Menu (Drawer-like) */}
        {sidebarOpen && (
          <div className="md:hidden absolute top-16 left-0 w-full bg-white/95 backdrop-blur-xl border-b border-gray-200 shadow-xl z-40 transition-all duration-200 animate-fade-in-down">
            <div className="pt-2 pb-4 space-y-1 px-4">
              {navigationItems.map((item) => {
                const isActive = item.current !== undefined ? item.current : location.pathname === item.href;
                const commonClasses = `block px-4 py-3 rounded-lg text-base font-medium transition-colors ${
                    isActive
                      ? 'bg-primary-50 text-primary-700'
                      : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
                  }`;

                return item.onClick ? (
                  <button
                    key={item.name}
                    onClick={() => {
                      item.onClick();
                      setSidebarOpen(false);
                    }}
                    className={`${commonClasses} w-full text-left`}
                  >
                    {item.name}
                  </button>
                ) : (
                  <Link
                    key={item.name}
                    to={item.href}
                    onClick={() => setSidebarOpen(false)}
                    className={commonClasses}
                  >
                    {item.name}
                  </Link>
                );
              })}
               {/* Mobile Logout/User Info */}
               {user && (
                 <div className="mt-4 pt-4 border-t border-gray-100">
                    <div className="flex items-center px-4 mb-3">
                      <div className="flex-shrink-0">
                         <div className="h-10 w-10 rounded-full bg-gradient-to-br from-primary-100 to-primary-200 flex items-center justify-center text-primary-700 font-bold border border-primary-100">
                            {user.username?.charAt(0).toUpperCase()}
                         </div>
                      </div>
                      <div className="ml-3">
                        <div className="text-base font-medium text-gray-900">{user.profile?.nombre || user.username}</div>
                        <div className="text-sm font-medium text-gray-500">{user.email}</div>
                      </div>
                    </div>
                    <button
                      onClick={() => {
                        logout();
                        setSidebarOpen(false);
                      }}
                      className="block w-full text-left px-4 py-3 rounded-lg text-base font-medium text-red-600 hover:bg-red-50 transition-colors"
                    >
                      Cerrar Sesión
                    </button>
                 </div>
               )}
            </div>
          </div>
        )}
      </nav>

      <main className="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 animate-fade-in">
        {children}
      </main>
      
      {/* Optional: Simple Footer */}
      <footer className="bg-white border-t border-gray-200 py-6 mt-auto">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex justify-center text-gray-400 text-sm">
          &copy; {new Date().getFullYear()} Circuito Pádel PM. Todos los derechos reservados.
        </div>
      </footer>
    </div>
  );
}
