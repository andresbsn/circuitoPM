export default function Modal({ isOpen, onClose, title, children, maxWidth = 'sm:max-w-lg' }) {
  if (!isOpen) return null

  return (
    <div className="fixed inset-0 z-50 overflow-y-auto">
      <div className="flex items-center justify-center min-h-screen px-4 py-6 text-center sm:p-0">
        <div className="fixed inset-0 transition-opacity bg-gray-900 bg-opacity-50 backdrop-blur-sm" onClick={onClose}></div>

        <div className={`relative inline-block align-middle bg-white rounded-2xl text-left shadow-2xl transform transition-all sm:my-8 w-full ${maxWidth}`}>
          <div className="bg-white px-6 py-6 rounded-2xl">
            <div className="flex flex-col">
              <div className="flex justify-between items-center mb-6 border-b border-gray-100 pb-4">
                <h3 className="text-xl font-black text-gray-900">
                  {title}
                </h3>
                <button 
                  onClick={onClose}
                  className="p-2 hover:bg-gray-100 rounded-xl transition-colors text-gray-400 hover:text-gray-600"
                >
                  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
              <div className="w-full">
                {children}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
