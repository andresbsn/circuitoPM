import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import PlayerPoints from '../components/player/PlayerPoints'
import Toast from '../components/Toast'
import Button from '../components/Button'
import Badge from '../components/Badge'
import Card from '../components/Card'
import Modal from '../components/Modal'
import { useToast } from '../hooks/useToast'
import { useModal } from '../hooks/useModal'
import { filterActiveTeams } from '../utils/helpers'
import { tabStyles } from '../utils/styles'
import api from '../services/api'

import Layout from '../components/Layout'

export default function PlayerDashboard() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()
  const [activeTab, setActiveTab] = useState('tournaments')
  const [tournaments, setTournaments] = useState([])
  const [myTeams, setMyTeams] = useState([])
  const [myRegistrations, setMyRegistrations] = useState([])
  const teamModal = useModal()
  const enrollModal = useModal()
  const [companionDni, setCompanionDni] = useState('')
  const [selectedTournamentCategory, setSelectedTournamentCategory] = useState(null)
  const [selectedTeam, setSelectedTeam] = useState(null)
  const [scheduleProblems, setScheduleProblems] = useState('')
  const { toast, showSuccess, showError, hideToast } = useToast()
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetchData()
  }, [])

  const fetchData = async () => {
    try {
      const [tournamentsRes, teamsRes, registrationsRes] = await Promise.all([
        api.get('/api/tournaments'),
        api.get('/api/teams/me'),
        api.get('/api/registrations/me')
      ])

      if (tournamentsRes.data.ok) setTournaments(tournamentsRes.data.data)
      if (teamsRes.data.ok) setMyTeams(teamsRes.data.data)
      if (registrationsRes.data.ok) setMyRegistrations(registrationsRes.data.data)
    } catch (error) {
      console.error('Error fetching data:', error)
    }
  }

  const handleCreateTeam = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/api/teams', { companion_dni: companionDni })
      if (response.data.ok) {
        showSuccess('Pareja creada exitosamente')
        teamModal.close()
        setCompanionDni('')
        fetchData()
      }
    } catch (error) {
      showError(error.response?.data?.error?.message || 'Error al crear pareja')
    } finally {
      setLoading(false)
    }
  }

  const handleEnroll = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/api/registrations', {
        tournament_category_id: selectedTournamentCategory.id,
        team_id: selectedTeam,
        schedule_problems: scheduleProblems
      })
      if (response.data.ok) {
        showSuccess('Inscripción realizada exitosamente')
        enrollModal.close()
        setSelectedTournamentCategory(null)
        setSelectedTeam(null)
        setScheduleProblems('')
        fetchData()
      }
    } catch (error) {
      showError(error.response?.data?.error?.message || 'Error al inscribirse')
    } finally {
      setLoading(false)
    }
  }

  const openEnrollModal = (tournamentCategory) => {
    setSelectedTournamentCategory(tournamentCategory)
    enrollModal.open()
  }

  return (
    <Layout title="Circuito Pádel PM">
      {toast && <Toast message={toast.message} type={toast.type} onClose={hideToast} />}

      <div className="mb-8">
        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-1">
          <nav className="flex space-x-2 overflow-x-auto" aria-label="Tabs">
            {[
              { id: 'tournaments', label: 'Torneos' },
              { id: 'teams', label: 'Mis Parejas' },
              { id: 'registrations', label: 'Mis Inscripciones' },
              { id: 'points', label: 'Mis Puntos' },
            ].map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`
                  flex-1 py-3 px-4 rounded-lg text-sm font-medium transition-all duration-200 whitespace-nowrap
                  ${activeTab === tab.id 
                    ? 'bg-primary-50 text-primary-700 shadow-sm' 
                    : 'text-gray-500 hover:text-gray-700 hover:bg-gray-50'}
                `}
              >
                {tab.label}
              </button>
            ))}
          </nav>
        </div>
      </div>

        {activeTab === 'tournaments' && (
          <div className="space-y-6 animate-fade-in-up">
            <h2 className="text-2xl font-bold text-gray-900 border-l-4 border-primary-500 pl-3">Torneos Disponibles</h2>
            {tournaments.length === 0 ? (
               <div className="bg-white rounded-xl shadow-sm p-8 text-center border border-gray-200">
                  <p className="text-gray-500">No hay torneos disponibles en este momento.</p>
               </div>
            ) : (
              <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                {tournaments.map(tournament => (
                  <div key={tournament.id} className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg transition-all duration-300">
                     <div className="h-2 bg-gradient-to-r from-primary-500 to-primary-700"></div>
                     <div className="p-6">
                        <h3 className="text-lg font-bold text-gray-900 mb-2">{tournament.nombre}</h3>
                        <p className="text-sm text-gray-600 mb-4 line-clamp-2">{tournament.descripcion}</p>
                        
                        <div className="space-y-3">
                           {tournament.categories?.map(tc => (
                             <div key={tc.id} className="flex justify-between items-center p-3 bg-gray-50 rounded-lg">
                               <span className="text-sm font-medium text-gray-700">{tc.category.name}</span>
                               {tc.inscripcion_abierta ? (
                                 <button
                                   onClick={() => openEnrollModal(tc)}
                                   className="px-3 py-1.5 bg-primary-600 text-white text-xs font-semibold rounded-md shadow-sm hover:bg-primary-700 transition-colors focus:ring-2 focus:ring-primary-500 focus:ring-offset-1"
                                 >
                                   Inscribirse
                                 </button>
                               ) : (
                                 <span className="text-xs font-medium text-red-600 bg-red-50 px-2 py-1 rounded">Cerrado</span>
                               )}
                             </div>
                           ))}
                        </div>
                     </div>
                     <div className="bg-gray-50 px-6 py-3 border-t border-gray-100">
                        <button
                          onClick={() => navigate(`/tournaments/${tournament.id}`)}
                          className="w-full text-center text-sm font-medium text-primary-600 hover:text-primary-800 transition-colors"
                        >
                          Ver Detalles Completos &rarr;
                        </button>
                     </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {activeTab === 'teams' && (
          <div className="space-y-6 animate-fade-in-up">
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
              <h2 className="text-2xl font-bold text-gray-900 border-l-4 border-primary-500 pl-3">Mis Parejas</h2>
              <Button variant="primary" onClick={teamModal.open} className="w-full sm:w-auto shadow-md">
                + Crear Nueva Pareja
              </Button>
            </div>
            
            {myTeams.length === 0 ? (
               <div className="bg-white rounded-xl shadow-sm p-12 text-center border border-gray-200">
                  <div className="bg-gray-100 rounded-full h-16 w-16 flex items-center justify-center mx-auto mb-4">
                     <svg className="h-8 w-8 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                     </svg>
                  </div>
                  <p className="text-gray-500 text-lg">No tienes parejas creadas aún.</p>
                  <button onClick={teamModal.open} className="mt-4 text-primary-600 font-medium hover:text-primary-700">Crear una ahora</button>
               </div>
            ) : (
              <div className="grid gap-6 md:grid-cols-2">
                {myTeams.map(team => (
                  <div key={team.id} className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 flex flex-col justify-between hover:shadow-md transition-shadow">
                    <div className="flex items-center justify-between mb-6">
                      <span className="text-xs font-bold uppercase tracking-wider text-gray-400">Estado</span>
                      <Badge status={team.estado} />
                    </div>
                    
                    <div className="flex items-center justify-between gap-4 mb-4">
                       <div className="text-center flex-1">
                          <div className="bg-gray-100 h-12 w-12 rounded-full flex items-center justify-center mx-auto mb-2 text-gray-600 font-bold border-2 border-white shadow-sm text-lg">
                             {team.player1.nombre.charAt(0)}
                          </div>
                          <p className="text-sm font-bold text-gray-900 truncate">{team.player1.nombre} {team.player1.apellido}</p>
                          <p className="text-xs text-gray-500 bg-gray-50 inline-block px-2 py-1 rounded mt-1">{team.player1.categoriaBase.name}</p>
                       </div>
                       
                       <div className="text-gray-300 font-bold text-xl">VS</div>
                       
                       <div className="text-center flex-1">
                          <div className="bg-gray-100 h-12 w-12 rounded-full flex items-center justify-center mx-auto mb-2 text-gray-600 font-bold border-2 border-white shadow-sm text-lg">
                             {team.player2.nombre.charAt(0)}
                          </div>
                          <p className="text-sm font-bold text-gray-900 truncate">{team.player2.nombre} {team.player2.apellido}</p>
                          <p className="text-xs text-gray-500 bg-gray-50 inline-block px-2 py-1 rounded mt-1">{team.player2.categoriaBase.name}</p>
                       </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {activeTab === 'registrations' && (
          <div className="space-y-6 animate-fade-in-up">
            <h2 className="text-2xl font-bold text-gray-900 border-l-4 border-primary-500 pl-3">Mis Inscripciones</h2>
            {myRegistrations.length === 0 ? (
               <div className="bg-white rounded-xl shadow-sm p-12 text-center border border-gray-200">
                  <p className="text-gray-500">No tienes inscripciones activas.</p>
               </div>
            ) : (
              <div className="grid gap-6 md:grid-cols-2">
                {myRegistrations.map(reg => (
                  <div key={reg.id} className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-4">
                       <Badge status={reg.estado} />
                    </div>
                    
                    <div className="pr-12">
                      <h3 className="text-xl font-bold text-gray-900 mb-1">
                        {reg.tournamentCategory.tournament.nombre}
                      </h3>
                      <div className="flex items-center gap-2 mb-4">
                         <span className="text-xs font-bold text-primary-600 bg-primary-50 px-2 py-0.5 rounded uppercase tracking-wide">
                            Categoría {reg.tournamentCategory.category.name}
                         </span>
                      </div>
                      
                      <div className="bg-gray-50 rounded-lg p-3">
                        <p className="text-xs text-gray-500 uppercase font-bold mb-2">Compañeros de Equipo</p>
                        <div className="flex items-center gap-2 text-sm text-gray-800">
                           <span className="font-medium">{reg.team.player1.nombre} {reg.team.player1.apellido}</span>
                           <span className="text-gray-400">/</span>
                           <span className="font-medium">{reg.team.player2.nombre} {reg.team.player2.apellido}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {activeTab === 'points' && (
            <div className="animate-fade-in-up">
               <PlayerPoints />
            </div>
        )}

      <Modal isOpen={teamModal.isOpen} onClose={teamModal.close} title="Crear Pareja">
        <form onSubmit={handleCreateTeam} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">
              DNI del Compañero
            </label>
            <input
              type="text"
              value={companionDni}
              onChange={(e) => setCompanionDni(e.target.value)}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500 transition-all"
              placeholder="Ingresa el DNI de tu compañero"
            />
          </div>
          <div className="flex justify-end space-x-3 pt-4">
            <Button variant="secondary" type="button" onClick={teamModal.close}>
              Cancelar
            </Button>
            <Button variant="primary" type="submit" disabled={loading}>
              {loading ? 'Creando...' : 'Crear Pareja'}
            </Button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={enrollModal.isOpen} onClose={enrollModal.close} title="Inscribirse al Torneo">
        <form onSubmit={handleEnroll} className="space-y-6">
          <div className="bg-primary-50 p-4 rounded-lg border border-primary-100">
            <div className="flex justify-between items-center mb-1">
               <span className="text-xs text-primary-600 font-bold uppercase">Torneo</span>
               <span className="text-xs text-primary-600 font-bold uppercase">Categoría</span>
            </div>
            <div className="flex justify-between items-center">
               <span className="font-bold text-gray-900">{selectedTournamentCategory?.tournament?.nombre}</span>
               <span className="font-bold text-gray-900">{selectedTournamentCategory?.category?.name}</span>
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Selecciona tu Pareja
            </label>
            <select
              value={selectedTeam || ''}
              onChange={(e) => setSelectedTeam(e.target.value)}
              required
              className="block w-full pl-3 pr-10 py-2.5 text-base border-gray-300 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm rounded-md shadow-sm"
            >
              <option value="">Selecciona una pareja...</option>
              {filterActiveTeams(myTeams).map(team => (
                <option key={team.id} value={team.id}>
                  {team.player1.nombre} {team.player1.apellido} / {team.player2.nombre} {team.player2.apellido}
                </option>
              ))}
            </select>
            {filterActiveTeams(myTeams).length === 0 && (
               <p className="mt-2 text-xs text-red-500">
                  No tienes parejas activas compatibles. <button type="button" onClick={() => { enrollModal.close(); teamModal.open(); }} className="underline font-bold">Crear una nueva</button>
               </p>
            )}
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Problemas de Horario (Opcional)
            </label>
            <textarea
              rows={3}
              value={scheduleProblems}
              onChange={(e) => setScheduleProblems(e.target.value)}
              className="shadow-sm focus:ring-primary-500 focus:border-primary-500 mt-1 block w-full sm:text-sm border border-gray-300 rounded-md p-2"
              placeholder="Ej: No puedo jugar el sábado antes de las 14hs"
            />
          </div>
          
          <div className="flex justify-end space-x-3 pt-2">
            <Button variant="secondary" type="button" onClick={enrollModal.close}>
              Cancelar
            </Button>
            <Button variant="primary" type="submit" disabled={loading || !selectedTeam}>
              {loading ? 'Inscribiendo...' : 'Confirmar Inscripción'}
            </Button>
          </div>
        </form>
      </Modal>
    </Layout>
  )
}
