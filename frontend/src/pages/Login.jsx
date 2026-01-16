import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import Toast from '../components/Toast'
import fapLogo from '../assets/fap.jpg'
import logo from '../assets/logo.jpeg'

export default function Login() {
  const [dni, setDni] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const { login } = useAuth()
  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      const user = await login(dni, password)
      navigate(user.role === 'admin' ? '/admin' : '/dashboard')
    } catch (err) {
      setError(err.response?.data?.error?.message || err.message || 'Error al iniciar sesión')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen flex">
      {/* Left Side - Hero Section (Hidden on mobile) */}
      <div className="hidden lg:flex lg:w-1/2 bg-gray-900 relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-primary-600/90 to-gray-900/90 z-10" />
        <div className="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1554068865-24cecd4e34b8?auto=format&fit=crop&q=80')] bg-cover bg-center" />
        
        <div className="relative z-20 flex flex-col justify-center px-12 text-white h-full">
          <img src={logo} alt="Circuito Pádel PM" className="h-24 w-auto mb-8 rounded-2xl shadow-2xl border-2 border-white/20 self-start" />
          <h2 className="text-4xl font-bold mb-6">Tu pasión, tu circuito.</h2>
          <p className="text-lg text-gray-200 mb-8 max-w-md">
            Gestiona tus inscripciones, consulta rankings y sigue los torneos en tiempo real. La plataforma oficial del Circuito Pádel PM.
          </p>
          <div className="flex items-center gap-4 bg-white/10 backdrop-blur-sm p-4 rounded-xl border border-white/20 w-fit">
            <img src={fapLogo} alt="FAP Logo" className="h-12 w-auto rounded bg-white p-1" />
            <div>
              <p className="text-sm font-semibold">Avalado por</p>
              <p className="text-xs text-gray-300">Federación Argentina de Pádel</p>
            </div>
          </div>
        </div>
      </div>

      {/* Right Side - Login Form */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8 bg-gray-50">
        <div className="max-w-md w-full">
          {error && <Toast message={error} type="error" onClose={() => setError('')} />}
          
          <div className="bg-white rounded-2xl shadow-xl p-8 sm:p-12 border border-gray-100">
            <div className="text-center mb-10">
              <h1 className="text-3xl font-extrabold text-gray-900 tracking-tight">¡Bienvenido de nuevo!</h1>
              <p className="text-gray-500 mt-2">Ingresa a tu cuenta para continuar</p>
            </div>

            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label htmlFor="dni" className="block text-sm font-semibold text-gray-700 mb-1">
                  DNI
                </label>
                <input
                  id="dni"
                  type="text"
                  value={dni}
                  onChange={(e) => setDni(e.target.value)}
                  required
                  className="appearance-none block w-full px-4 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent transition duration-150 ease-in-out sm:text-sm bg-gray-50 hover:bg-white"
                  placeholder="Ingresa tu número de documento"
                />
              </div>

              <div>
                <div className="flex items-center justify-between mb-1">
                  <label htmlFor="password" className="block text-sm font-semibold text-gray-700">
                    Contraseña
                  </label>
                  <a href="#" className="text-sm font-medium text-primary-600 hover:text-primary-500">
                    ¿Olvidaste tu contraseña?
                  </a>
                </div>
                <input
                  id="password"
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  className="appearance-none block w-full px-4 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent transition duration-150 ease-in-out sm:text-sm bg-gray-50 hover:bg-white"
                  placeholder="••••••••"
                />
              </div>

              <div className="pt-2">
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-semibold text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-50 transition-all duration-200 transform hover:-translate-y-0.5"
                >
                  {loading ? (
                    <span className="flex items-center">
                      <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Iniciando...
                    </span>
                  ) : 'Iniciar Sesión'}
                </button>
              </div>
            </form>

            <div className="mt-8 text-center border-t border-gray-100 pt-6">
              <p className="text-sm text-gray-600">
                ¿Aún no tienes cuenta?{' '}
                <Link to="/register" className="font-semibold text-primary-600 hover:text-primary-500 transition-colors">
                  Regístrate ahora
                </Link>
              </p>
            </div>
            
            <div className="mt-6 text-center">
               <Link to="/" className="text-xs text-gray-400 hover:text-gray-600 transition-colors">
                  Volver al inicio
               </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
