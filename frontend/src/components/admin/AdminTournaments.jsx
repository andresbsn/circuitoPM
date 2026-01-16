import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'

export default function AdminTournaments() {
  const navigate = useNavigate()
  const [tournaments, setTournaments] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [editingTournament, setEditingTournament] = useState(null)
  const [formData, setFormData] = useState({
    nombre: '',
    fecha_inicio: '',
    fecha_fin: '',
    descripcion: '',
    estado: 'draft',
    double_points: false
  })
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchTournaments()
  }, [])

  const fetchTournaments = async () => {
    try {
      const response = await api.get('/api/admin/tournaments')
      if (response.data.ok) {
        setTournaments(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching tournaments:', error)
    }
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const dataToSend = {
        ...formData,
        fecha_inicio: formData.fecha_inicio || null,
        fecha_fin: formData.fecha_fin || null
      }

      if (editingTournament) {
        const response = await api.put(`/api/admin/tournaments/${editingTournament.id}`, dataToSend)
        if (response.data.ok) {
          setToast({ message: 'Torneo actualizado', type: 'success' })
        }
      } else {
        const response = await api.post('/api/admin/tournaments', dataToSend)
        if (response.data.ok) {
          setToast({ message: 'Torneo creado', type: 'success' })
        }
      }
      setShowModal(false)
      setFormData({ nombre: '', fecha_inicio: '', fecha_fin: '', descripcion: '', estado: 'draft', double_points: false })
      setEditingTournament(null)
      fetchTournaments()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleEdit = (tournament) => {
    setEditingTournament(tournament)
    setFormData({
      nombre: tournament.nombre,
      fecha_inicio: tournament.fecha_inicio?.split('T')[0] || '',
      fecha_fin: tournament.fecha_fin?.split('T')[0] || '',
      descripcion: tournament.descripcion || '',
      estado: tournament.estado,
      double_points: tournament.double_points || false
    })
    setShowModal(true)
  }

  const handleDelete = async (id) => {
    if (!confirm('¿Estás seguro de eliminar este torneo?')) return

    try {
      await api.delete(`/api/admin/tournaments/${id}`)
      setToast({ message: 'Torneo eliminado', type: 'success' })
      fetchTournaments()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    }
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900">Torneos</h2>
        <button
          onClick={() => {
            setEditingTournament(null)
            setFormData({ nombre: '', fecha_inicio: '', fecha_fin: '', descripcion: '', estado: 'draft', double_points: false })
            setShowModal(true)
          }}
          className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
        >
          Nuevo Torneo
        </button>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
        {tournaments.map(tournament => (
          <div key={tournament.id} className="bg-white rounded-lg shadow p-6">
            <div className="flex justify-between items-start mb-4">
              <h3 className="text-lg font-semibold text-gray-900">{tournament.nombre}</h3>
              <span className={`px-2 py-1 text-xs rounded ${
                tournament.estado === 'inscripcion' ? 'bg-primary-100 text-primary-800' :
                tournament.estado === 'en_curso' ? 'bg-green-100 text-green-800' :
                tournament.estado === 'finalizado' ? 'bg-gray-100 text-gray-800' :
                'bg-yellow-100 text-yellow-800'
              }`}>
                {tournament.estado}
              </span>
            </div>
            <p className="text-sm text-gray-600 mb-4">{tournament.descripcion}</p>
            <div className="flex items-center gap-2 mb-4">
              <div className="text-xs text-gray-500">
                {tournament.categories?.length || 0} categorías
              </div>
              {tournament.double_points && (
                <span className="px-2 py-1 text-xs font-semibold rounded bg-yellow-100 text-yellow-800 border border-yellow-300">
                  ⭐ x2 Puntos
                </span>
              )}
            </div>
            <div className="flex space-x-2">
              <button
                onClick={() => navigate(`/admin/tournaments/${tournament.id}`)}
                className="flex-1 text-sm bg-primary-600 text-white px-3 py-2 rounded hover:bg-primary-700"
              >
                Gestionar
              </button>
              <button
                onClick={() => handleEdit(tournament)}
                className="text-sm border border-gray-300 px-3 py-2 rounded hover:bg-gray-50"
              >
                Editar
              </button>
              <button
                onClick={() => handleDelete(tournament.id)}
                className="text-sm text-red-600 border border-red-300 px-3 py-2 rounded hover:bg-red-50"
              >
                Eliminar
              </button>
            </div>
          </div>
        ))}
      </div>

      <Modal isOpen={showModal} onClose={() => setShowModal(false)} title={editingTournament ? 'Editar Torneo' : 'Nuevo Torneo'}>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Nombre</label>
            <input
              type="text"
              value={formData.nombre}
              onChange={(e) => setFormData({ ...formData, nombre: e.target.value })}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Descripción</label>
            <textarea
              value={formData.descripcion}
              onChange={(e) => setFormData({ ...formData, descripcion: e.target.value })}
              rows="3"
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">Fecha Inicio</label>
              <input
                type="date"
                value={formData.fecha_inicio}
                onChange={(e) => setFormData({ ...formData, fecha_inicio: e.target.value })}
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Fecha Fin</label>
              <input
                type="date"
                value={formData.fecha_fin}
                onChange={(e) => setFormData({ ...formData, fecha_fin: e.target.value })}
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
              />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Estado</label>
            <select
              value={formData.estado}
              onChange={(e) => setFormData({ ...formData, estado: e.target.value })}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="draft">Borrador</option>
              <option value="inscripcion">Inscripción</option>
              <option value="en_curso">En Curso</option>
              <option value="finalizado">Finalizado</option>
            </select>
          </div>
          <div className="flex items-center">
            <input
              type="checkbox"
              id="double_points"
              checked={formData.double_points}
              onChange={(e) => setFormData({ ...formData, double_points: e.target.checked })}
              className="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300 rounded"
            />
            <label htmlFor="double_points" className="ml-2 block text-sm text-gray-900">
              <span className="font-medium">Torneo de Doble Puntaje</span>
              <span className="block text-xs text-gray-500">Los puntos asignados se multiplicarán por 2</span>
            </label>
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Guardando...' : 'Guardar'}
            </button>
          </div>
        </form>
      </Modal>
    </div>
  )
}
