import { useState, useEffect } from 'react'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminPlayers() {
  const [players, setPlayers] = useState([])
  const [loading, setLoading] = useState(false)
  const [filters, setFilters] = useState({ nombre: '', dni: '' })
  const [playerDetails, setPlayerDetails] = useState(null)
  const [showModal, setShowModal] = useState(false)
  const [toast, setToast] = useState(null)
  
  // Edit states
  const [isEditing, setIsEditing] = useState(false)
  const [formData, setFormData] = useState({})
  const [categories, setCategories] = useState([])
  const [localities, setLocalities] = useState([])
  const [saving, setSaving] = useState(false)

  useEffect(() => {
    fetchPlayers()
    fetchAuxData()
  }, [])

  const fetchAuxData = async () => {
    try {
      const [catsRes, locsRes] = await Promise.all([
        api.get('/api/categories'),
        api.get('/api/tournament-categories/localities')
      ])
      
      if (catsRes.data.ok) setCategories(catsRes.data.data)
      if (locsRes.data.ok) setLocalities(locsRes.data.data)
    } catch (error) {
      console.error('Error fetching auxiliary data:', error)
    }
  }


  const fetchPlayers = async () => {
    setLoading(true)
    try {
      const { nombre, dni } = filters
      const response = await api.get('/api/admin/players', { params: { nombre, dni } })
      if (response.data.ok) {
        setPlayers(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching players:', error)
      setToast({ message: 'Error al cargar jugadores', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleFilterChange = (e) => {
    setFilters({ ...filters, [e.target.name]: e.target.value })
  }

  const handleSearch = (e) => {
    e.preventDefault()
    fetchPlayers()
  }

  const handleSelectPlayer = async (player) => {
    setPlayerDetails(null)
    setIsEditing(false)
    setShowModal(true)
    try {
      const response = await api.get(`/api/admin/players/${player.dni}`)
      if (response.data.ok) {
        setPlayerDetails(response.data.data)
        setFormData({ ...response.data.data.player })
      }
    } catch (error) {
      console.error('Error fetching player details:', error)
      setToast({ message: 'Error al cargar detalles del jugador', type: 'error' })
    }
  }

  const handleStartEdit = () => {
    setIsEditing(true)
  }

  const handleCancelEdit = () => {
    setIsEditing(false)
    setFormData({ ...playerDetails.player })
  }

  const handleInputChange = (e) => {
    const { name, value } = e.target
    setFormData(prev => ({ ...prev, [name]: value }))
  }

  const handleSavePlayer = async (e) => {
    e.preventDefault()
    setSaving(true)
    try {
      const response = await api.put(`/api/admin/players/${formData.dni}`, formData)
      if (response.data.ok) {
        setToast({ message: 'Jugador actualizado correctamente', type: 'success' })
        setIsEditing(false)
        // Refresh local details
        setPlayerDetails(prev => ({ ...prev, player: response.data.data }))
        // Refresh list
        fetchPlayers()
      }
    } catch (error) {
      console.error('Error saving player:', error)
      setToast({ message: 'Error al guardar cambios', type: 'error' })
    } finally {
      setSaving(false)
    }
  }

  return (
    <div className="p-4 md:p-6 bg-gray-50 min-h-screen">
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-800 tracking-tight">Gestión de Jugadores</h2>
      </div>

      <div className="bg-white p-5 rounded-2xl shadow-sm border border-gray-200 mb-6">
        <form onSubmit={handleSearch} className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-xs font-bold text-gray-400 uppercase mb-1">Nombre / Apellido</label>
            <input
              type="text"
              name="nombre"
              value={filters.nombre}
              onChange={handleFilterChange}
              placeholder="Buscar por nombre..."
              className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none transition-all"
            />
          </div>
          <div>
            <label className="block text-xs font-bold text-gray-400 uppercase mb-1">DNI</label>
            <input
              type="text"
              name="dni"
              value={filters.dni}
              onChange={handleFilterChange}
              placeholder="Documento..."
              className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none transition-all"
            />
          </div>
          <div className="flex items-end">
            <button
              type="submit"
              className="w-full bg-primary-600 text-white px-6 py-2 rounded-xl font-bold hover:bg-primary-700 transition-all shadow-lg shadow-primary-200"
            >
              Filtrar Resultados
            </button>
          </div>
        </form>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-gray-200 overflow-hidden">
        <div className="hidden md:block">
          <table className="min-w-full divide-y divide-gray-100">
            <thead className="bg-gray-50/50">
              <tr>
                <th className="px-6 py-4 text-left text-[10px] font-black text-gray-400 uppercase">DNI</th>
                <th className="px-6 py-4 text-left text-[10px] font-black text-gray-400 uppercase">Jugador</th>
                <th className="px-6 py-4 text-left text-[10px] font-black text-gray-400 uppercase">Categoría</th>
                <th className="px-6 py-4 text-center text-[10px] font-black text-gray-400 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {loading ? (
                <tr><td colSpan="4" className="py-10 text-center text-gray-400">Cargando...</td></tr>
              ) : players.map(player => (
                <tr key={player.dni} className="hover:bg-primary-50/20 transition-colors">
                  <td className="px-6 py-4 text-sm font-mono text-gray-500">{player.dni}</td>
                  <td className="px-6 py-4 text-sm font-bold text-gray-700">{player.apellido}, {player.nombre}</td>
                  <td className="px-6 py-4 text-sm">
                    <span className="px-2 py-1 bg-indigo-50 text-indigo-600 rounded-lg text-xs font-bold border border-indigo-100">
                      {player.categoriaBase?.name || 'S/D'}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-center">
                    <button
                      onClick={() => handleSelectPlayer(player)}
                      className="text-primary-600 font-bold text-sm hover:underline"
                    >
                      Ver / Editar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        
        {/* Mobile List */}
        <div className="md:hidden divide-y divide-gray-100">
          {players.map(player => (
            <div key={player.dni} className="p-4" onClick={() => handleSelectPlayer(player)}>
              <p className="font-bold text-gray-800">{player.apellido}, {player.nombre}</p>
              <p className="text-xs text-gray-400 mb-2">{player.dni}</p>
              <span className="px-2 py-0.5 bg-gray-100 text-gray-600 rounded text-[10px] font-bold uppercase">{player.categoriaBase?.name || 'S/D'}</span>
            </div>
          ))}
        </div>
      </div>

      <Modal
        isOpen={showModal}
        onClose={() => {
          setShowModal(false)
          setPlayerDetails(null)
          setIsEditing(false)
        }}
        title={isEditing ? "Editar Perfil" : "Ficha Integral"}
        maxWidth="sm:max-w-3xl"
      >
        <div className="max-h-[80vh] overflow-y-auto pr-2 custom-scrollbar">
          {playerDetails ? (
            <div className="space-y-6">
              {/* Header Info */}
              <div className="flex justify-between items-start sticky top-0 bg-white z-10 py-2 border-b border-gray-50 mb-4">
                <div className="flex items-center gap-4">
                  <div className="w-14 h-14 bg-gradient-to-br from-primary-500 to-primary-700 text-white rounded-2xl flex items-center justify-center shadow-lg shadow-primary-200">
                    <span className="text-xl font-black">{playerDetails.player.nombre[0]}{playerDetails.player.apellido[0]}</span>
                  </div>
                  <div>
                    <h3 className="text-xl font-black text-gray-900 leading-none mb-1">{playerDetails.player.nombre} {playerDetails.player.apellido}</h3>
                    <p className="text-xs font-bold text-gray-400 uppercase tracking-widest">DNI: {playerDetails.player.dni}</p>
                  </div>
                </div>
                {!isEditing && (
                  <button
                    onClick={handleStartEdit}
                    className="bg-primary-50 text-primary-600 px-4 py-2 rounded-xl text-sm font-bold hover:bg-primary-100 transition-colors flex items-center gap-2"
                  >
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>
                    Editar Datos
                  </button>
                )}
              </div>

              {isEditing ? (
                <form onSubmit={handleSavePlayer} className="grid grid-cols-1 md:grid-cols-2 gap-4 animate-fadeIn">
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Nombre</label>
                    <input
                      type="text"
                      name="nombre"
                      value={formData.nombre}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    />
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Apellido</label>
                    <input
                      type="text"
                      name="apellido"
                      value={formData.apellido}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    />
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Teléfono</label>
                    <input
                      type="text"
                      name="telefono"
                      value={formData.telefono || ''}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    />
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Género</label>
                    <select
                      name="genero"
                      value={formData.genero}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    >
                      <option value="M">Masculino</option>
                      <option value="F">Femenino</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Categoría Base</label>
                    <select
                      name="categoria_base_id"
                      value={formData.categoria_base_id}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    >
                      {categories.map(cat => (
                        <option key={cat.id} value={cat.id}>{cat.name} ({cat.gender})</option>
                      ))}
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className="text-[10px] font-black text-gray-400 uppercase">Localidad</label>
                    <select
                      name="locality_id"
                      value={formData.locality_id || ''}
                      onChange={handleInputChange}
                      className="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-primary-500 outline-none"
                    >
                      <option value="">Seleccionar Localidad</option>
                      {localities.map(loc => (
                        <option key={loc.id} value={loc.id}>{loc.name} ({loc.province})</option>
                      ))}
                    </select>
                  </div>
                  <div className="md:col-span-2 flex gap-3 pt-4 sticky bottom-0 bg-white py-4 border-t border-gray-50">
                    <button
                      type="submit"
                      disabled={saving}
                      className="flex-1 bg-primary-600 text-white py-3 rounded-xl font-bold hover:bg-primary-700 transition-all shadow-lg shadow-primary-100 disabled:opacity-50"
                    >
                      {saving ? 'Guardando...' : 'Guardar Cambios'}
                    </button>
                    <button
                      type="button"
                      onClick={handleCancelEdit}
                      className="flex-1 bg-gray-100 text-gray-600 py-3 rounded-xl font-bold hover:bg-gray-200 transition-all"
                    >
                      Cancelar
                    </button>
                  </div>
                </form>
              ) : (
                <div className="space-y-8 animate-fadeIn">
                  {/* View Mode Grid */}
                  <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                    <div className="p-3 bg-gray-50 rounded-2xl border border-gray-100">
                      <p className="text-[9px] font-black text-gray-400 uppercase mb-1">Género</p>
                      <p className="text-sm font-bold text-gray-700">{playerDetails.player.genero === 'M' ? '🎾 Masculino' : '🎾 Femenino'}</p>
                    </div>
                    <div className="p-3 bg-gray-50 rounded-2xl border border-gray-100">
                      <p className="text-[9px] font-black text-gray-400 uppercase mb-1">Teléfono</p>
                      <p className="text-sm font-bold text-gray-700">{playerDetails.player.telefono || '--'}</p>
                    </div>
                    <div className="p-3 bg-gray-50 rounded-2xl border border-gray-100">
                      <p className="text-[9px] font-black text-gray-400 uppercase mb-1">Localidad</p>
                      <p className="text-sm font-bold text-gray-700 truncate">{playerDetails.player.locality?.name || 'S/D'}</p>
                    </div>
                    <div className="col-span-2 md:col-span-3 p-3 bg-primary-50 rounded-2xl border border-primary-100">
                      <p className="text-[9px] font-black text-primary-400 uppercase mb-1">Categoría Oficial</p>
                      <p className="text-sm font-black text-primary-700 uppercase tracking-tight">{playerDetails.player.categoriaBase?.name || 'S/D'}</p>
                    </div>
                  </div>

                  {/* Teams Section */}
                  <div>
                    <h4 className="text-xs font-black text-gray-400 uppercase tracking-widest mb-4 flex items-center gap-2">
                       <span className="w-1 h-3 bg-primary-500 rounded-full"></span>
                       Parejas e Inscripciones
                    </h4>
                    {playerDetails.teams.length > 0 ? (
                      <div className="space-y-3">
                        {playerDetails.teams.map(team => (
                          <div key={team.id} className="border border-gray-100 rounded-2xl p-4 hover:border-primary-200 transition-colors bg-white shadow-sm">
                            <div className="flex justify-between items-center mb-3">
                              <p className="text-sm font-bold text-gray-800">
                                <span className="text-gray-400 font-medium mr-2">Con:</span>
                                {team.player1.dni === playerDetails.player.dni 
                                  ? `${team.player2.nombre} ${team.player2.apellido}`
                                  : `${team.player1.nombre} ${team.player1.apellido}`}
                              </p>
                              <span className={`px-2 py-0.5 text-[9px] font-black uppercase rounded-lg ${team.estado === 'activa' ? 'bg-green-100 text-green-700' : 'bg-red-50 text-red-600'}`}>
                                {team.estado}
                              </span>
                            </div>
                            {team.registrations && team.registrations.length > 0 && (
                              <div className="bg-gray-50/50 rounded-xl p-3 space-y-2">
                                {team.registrations.map(reg => (
                                  <div key={reg.id} className="flex justify-between items-center text-xs">
                                    <div className="flex flex-col">
                                       <span className="font-bold text-gray-700">{reg.tournamentCategory?.tournament?.nombre}</span>
                                       <span className="text-[10px] text-gray-400">{reg.tournamentCategory?.category?.name}</span>
                                    </div>
                                    <span className={`px-2 py-0.5 rounded-lg font-black text-[10px] uppercase ${
                                      reg.estado === 'confirmado' ? 'bg-blue-100 text-blue-600' : 'bg-gray-100 text-gray-500'
                                    }`}>
                                      {reg.estado}
                                    </span>
                                  </div>
                                ))}
                              </div>
                            )}
                          </div>
                        ))}
                      </div>
                    ) : (
                      <p className="text-sm text-gray-400 italic text-center py-4">No se registran parejas vinculadas.</p>
                    )}
                  </div>
                </div>
              )}
            </div>
          ) : (
            <div className="py-20 text-center space-y-4">
              <div className="w-10 h-10 border-4 border-primary-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
              <p className="text-xs font-bold text-gray-400 uppercase tracking-widest">Cargando perfil...</p>
            </div>
          )}
        </div>
      </Modal>

      <style jsx>{`
        .custom-scrollbar::-webkit-scrollbar {
          width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
          background: #f1f1f1;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
          background: #ddd;
          border-radius: 10px;
        }
        @keyframes fadeIn {
          from { opacity: 0; transform: translateY(5px); }
          to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeIn {
          animation: fadeIn 0.4s ease-out forwards;
        }
      `}</style>
    </div>
  )
}
