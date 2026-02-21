import { useEffect, useState } from 'react'

const ICONS = {
  success: (
    <svg className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
    </svg>
  ),
  error: (
    <svg className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
    </svg>
  ),
  warning: (
    <svg className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fillRule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clipRule="evenodd" />
    </svg>
  ),
  info: (
    <svg className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
      <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clipRule="evenodd" />
    </svg>
  )
}

const STYLES = {
  success: {
    bg: 'bg-emerald-50 border-emerald-400',
    text: 'text-emerald-800',
    icon: 'text-emerald-500',
    close: 'text-emerald-500 hover:text-emerald-700 hover:bg-emerald-100',
    bar: 'bg-emerald-500'
  },
  error: {
    bg: 'bg-red-50 border-red-400',
    text: 'text-red-800',
    icon: 'text-red-500',
    close: 'text-red-500 hover:text-red-700 hover:bg-red-100',
    bar: 'bg-red-500'
  },
  warning: {
    bg: 'bg-amber-50 border-amber-400',
    text: 'text-amber-800',
    icon: 'text-amber-500',
    close: 'text-amber-500 hover:text-amber-700 hover:bg-amber-100',
    bar: 'bg-amber-500'
  },
  info: {
    bg: 'bg-blue-50 border-blue-400',
    text: 'text-blue-800',
    icon: 'text-blue-500',
    close: 'text-blue-500 hover:text-blue-700 hover:bg-blue-100',
    bar: 'bg-blue-500'
  }
}

// Duration in ms per type
const DURATIONS = {
  success: 4000,
  error: 8000,
  warning: 6000,
  info: 5000
}

export default function Toast({ message, type = 'success', onClose, duration }) {
  const [visible, setVisible] = useState(true)
  const [exiting, setExiting] = useState(false)
  const effectiveDuration = duration || DURATIONS[type] || 5000
  const style = STYLES[type] || STYLES.info
  const icon = ICONS[type] || ICONS.info

  useEffect(() => {
    const timer = setTimeout(() => {
      handleClose()
    }, effectiveDuration)

    return () => clearTimeout(timer)
  }, [effectiveDuration])

  const handleClose = () => {
    setExiting(true)
    setTimeout(() => {
      setVisible(false)
      onClose()
    }, 300)
  }

  if (!visible) return null

  return (
    <div
      className={`fixed top-4 right-4 z-[9999] max-w-sm w-full transition-all duration-300 ${
        exiting ? 'opacity-0 translate-x-8' : 'opacity-100 translate-x-0'
      }`}
      style={{ animation: exiting ? 'none' : 'toastSlideIn 0.4s ease-out' }}
    >
      <div className={`${style.bg} border-l-4 rounded-lg shadow-lg overflow-hidden`}>
        <div className="p-4">
          <div className="flex items-start">
            <div className={`flex-shrink-0 ${style.icon}`}>
              {icon}
            </div>
            <div className="ml-3 flex-1">
              <p className={`text-sm font-medium ${style.text}`}>
                {message}
              </p>
            </div>
            <div className="ml-4 flex-shrink-0">
              <button
                onClick={handleClose}
                className={`inline-flex rounded-md p-1.5 focus:outline-none transition-colors ${style.close}`}
              >
                <span className="sr-only">Cerrar</span>
                <svg className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                  <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
                </svg>
              </button>
            </div>
          </div>
        </div>
        {/* Progress bar */}
        <div className="h-1 w-full bg-black/5">
          <div
            className={`h-full ${style.bar} rounded-br`}
            style={{
              animation: `toastProgress ${effectiveDuration}ms linear forwards`
            }}
          />
        </div>
      </div>

      <style>{`
        @keyframes toastSlideIn {
          from {
            opacity: 0;
            transform: translateX(100%);
          }
          to {
            opacity: 1;
            transform: translateX(0);
          }
        }
        @keyframes toastProgress {
          from { width: 100%; }
          to { width: 0%; }
        }
      `}</style>
    </div>
  )
}

/**
 * Inline alert component for forms (doesn't auto-dismiss).
 * Use this for login/register errors so the user can clearly see the message.
 */
export function AlertMessage({ message, type = 'error', onClose }) {
  if (!message) return null

  const style = STYLES[type] || STYLES.error
  const icon = ICONS[type] || ICONS.error

  return (
    <div
      className={`${style.bg} border-l-4 rounded-lg p-4 mb-4`}
      style={{ animation: 'alertShake 0.5s ease-in-out' }}
      role="alert"
    >
      <div className="flex items-start">
        <div className={`flex-shrink-0 ${style.icon} mt-0.5`}>
          {icon}
        </div>
        <div className="ml-3 flex-1">
          <p className={`text-sm font-semibold ${style.text}`}>
            {type === 'error' ? '¡Error!' : type === 'warning' ? '¡Atención!' : 'Información'}
          </p>
          <p className={`text-sm mt-1 ${style.text} opacity-90`}>
            {message}
          </p>
        </div>
        {onClose && (
          <div className="ml-4 flex-shrink-0">
            <button
              onClick={onClose}
              className={`inline-flex rounded-md p-1.5 focus:outline-none transition-colors ${style.close}`}
            >
              <span className="sr-only">Cerrar</span>
              <svg className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
              </svg>
            </button>
          </div>
        )}
      </div>

      <style>{`
        @keyframes alertShake {
          0%, 100% { transform: translateX(0); }
          15% { transform: translateX(-6px); }
          30% { transform: translateX(5px); }
          45% { transform: translateX(-4px); }
          60% { transform: translateX(3px); }
          75% { transform: translateX(-2px); }
          90% { transform: translateX(1px); }
        }
      `}</style>
    </div>
  )
}
