import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import api from '../services/api'

export default function TournamentView() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [tournament, setTournament] = useState(null)
  const [selectedCategory, setSelectedCategory] = useState(null)
  const [activeTab, setActiveTab] = useState('zones')
  const [zones, setZones] = useState([])
  const [standings, setStandings] = useState([])
  const [zoneMatches, setZoneMatches] = useState([])
  const [playoffs, setPlayoffs] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchTournament()
  }, [id])

  useEffect(() => {
    if (selectedCategory) {
      fetchCategoryData()
    }
  }, [selectedCategory, activeTab])

  const fetchTournament = async () => {
    try {
      const response = await api.get(`/api/tournaments/${id}`)
      if (response.data.ok) {
        setTournament(response.data.data)
        if (response.data.data.categories?.length > 0) {
          setSelectedCategory(response.data.data.categories[0].id)
        }
      }
    } catch (error) {
      console.error('Error fetching tournament:', error)
    } finally {
      setLoading(false)
    }
  }

  const fetchCategoryData = async () => {
    try {
      if (activeTab === 'zones') {
        const response = await api.get(`/api/tournament-categories/zones?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setZones(response.data.data)
      } else if (activeTab === 'standings') {
        const response = await api.get(`/api/tournament-categories/standings?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setStandings(response.data.data)
      } else if (activeTab === 'matches') {
        const response = await api.get(`/api/tournament-categories/zone-matches?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setZoneMatches(response.data.data)
      } else if (activeTab === 'playoffs') {
        const response = await api.get(`/api/tournament-categories/playoffs?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setPlayoffs(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching category data:', error)
    }
  }

  const formatScore = (scoreJson) => {
    if (!scoreJson || !scoreJson.sets) return '-'
    return scoreJson.sets.map(set => 
      set.type === 'SUPER_TB' ? `${set.home}-${set.away} (TB)` : `${set.home}-${set.away}`
    ).join(' ')
  }

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center">Cargando...</div>
  }

  if (!tournament) {
    return <div className="min-h-screen flex items-center justify-center">Torneo no encontrado</div>
  }

  return (
    <div className="min-h-screen bg-gray-100">
      <nav className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <button onClick={() => navigate('/dashboard')} className="text-primary-600 hover:text-primary-700 mr-4">
                ← Volver
              </button>
              <h1 className="text-xl font-bold text-gray-900">{tournament.nombre}</h1>
            </div>
          </div>
        </div>
      </nav>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-6">
          <label className="block text-sm font-medium text-gray-700 mb-2">Categoría</label>
          <select
            value={selectedCategory || ''}
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="block w-full max-w-xs px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
          >
            {tournament.categories?.map(tc => (
              <option key={tc.id} value={tc.id}>{tc.category.name}</option>
            ))}
          </select>
        </div>

        <div className="mb-6">
          <div className="border-b border-gray-200">
            <nav className="-mb-px flex space-x-8">
              {['zones', 'standings', 'matches', 'playoffs'].map(tab => (
                <button
                  key={tab}
                  onClick={() => setActiveTab(tab)}
                  className={`${
                    activeTab === tab
                      ? 'border-primary-500 text-primary-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                  } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm capitalize`}
                >
                  {tab === 'zones' ? 'Zonas' : tab === 'standings' ? 'Tabla' : tab === 'matches' ? 'Partidos' : 'Playoffs'}
                </button>
              ))}
            </nav>
          </div>
        </div>

        {activeTab === 'zones' && (
          <div className="space-y-6">
            {zones.length === 0 ? (
              <p className="text-gray-500">No hay zonas generadas aún</p>
            ) : (
              zones.map(zone => (
                <div key={zone.id} className="bg-white rounded-lg shadow p-6">
                  <h3 className="text-lg font-semibold text-gray-900 mb-4">{zone.name}</h3>
                  <div className="space-y-2">
                    {zone.zoneTeams?.map(zt => (
                      <div key={zt.id} className="flex items-center justify-between py-2 border-b">
                        <span className="text-sm">
                          {zt.team.player1.nombre} {zt.team.player1.apellido} / {zt.team.player2.nombre} {zt.team.player2.apellido}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === 'standings' && (
          <div className="space-y-6">
            {standings.length === 0 ? (
              <p className="text-gray-500">No hay tabla de posiciones aún</p>
            ) : (
              standings.map(zone => (
                <div key={zone.id} className="bg-white rounded-lg shadow overflow-hidden">
                  <div className="px-6 py-4 bg-gray-50 border-b">
                    <h3 className="text-lg font-semibold text-gray-900">{zone.name}</h3>
                  </div>
                  <div className="overflow-x-auto">
                    <table className="min-w-full divide-y divide-gray-200">
                      <thead className="bg-gray-50">
                        <tr>
                          <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Pos</th>
                          <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Pareja</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">PJ</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">PG</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">PP</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">Pts</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">Sets</th>
                          <th className="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase">Games</th>
                        </tr>
                      </thead>
                      <tbody className="bg-white divide-y divide-gray-200">
                        {zone.standings?.map((standing, idx) => (
                          <tr key={standing.id}>
                            <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{idx + 1}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                              {standing.team.player1.nombre} {standing.team.player1.apellido} / {standing.team.player2.nombre} {standing.team.player2.apellido}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-500">{standing.played}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-500">{standing.wins}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-500">{standing.losses}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center font-semibold text-gray-900">{standing.points}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-500">{standing.sets_diff > 0 ? '+' : ''}{standing.sets_diff}</td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-center text-gray-500">{standing.games_diff > 0 ? '+' : ''}{standing.games_diff}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === 'matches' && (
          <div className="space-y-4">
            {zoneMatches.length === 0 ? (
              <p className="text-gray-500">No hay partidos programados</p>
            ) : (
              zoneMatches.map(match => (
                <div key={match.id} className="bg-white rounded-lg shadow p-6">
                  <div className="flex justify-between items-center">
                    <div className="flex-1">
                      <p className="text-sm font-medium text-gray-900">
                        {match.teamHome.player1.nombre} {match.teamHome.player1.apellido} / {match.teamHome.player2.nombre} {match.teamHome.player2.apellido}
                      </p>
                      <p className="text-sm text-gray-500 mt-1">vs</p>
                      <p className="text-sm font-medium text-gray-900 mt-1">
                        {match.teamAway.player1.nombre} {match.teamAway.player1.apellido} / {match.teamAway.player2.nombre} {match.teamAway.player2.apellido}
                      </p>
                    </div>
                    <div className="text-right">
                      <span className={`px-2 py-1 text-xs rounded ${match.status === 'played' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}`}>
                        {match.status === 'played' ? 'Jugado' : 'Pendiente'}
                      </span>
                      {match.status === 'played' && (
                        <p className="text-sm font-semibold text-gray-900 mt-2">
                          {formatScore(match.score_json)}
                        </p>
                      )}
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === 'playoffs' && (
          <div>
            {!playoffs ? (
              <p className="text-gray-500">No hay playoffs generados aún</p>
            ) : (
              <div className="bg-white rounded-lg shadow p-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4">Cuadro de Playoffs</h3>
                <div className="overflow-x-auto">
                  {Object.entries(
                    playoffs.matches.reduce((acc, match) => {
                      if (!acc[match.round_name]) acc[match.round_name] = []
                      acc[match.round_name].push(match)
                      return acc
                    }, {})
                  ).map(([roundName, matches]) => (
                    <div key={roundName} className="mb-6">
                      <h4 className="text-md font-semibold text-gray-800 mb-3">{roundName}</h4>
                      <div className="space-y-3">
                        {matches.map(match => (
                          <div key={match.id} className="border rounded-lg p-4">
                            <div className="space-y-2">
                              <div className={`flex justify-between items-center ${match.winner_team_id === match.team_home_id ? 'font-semibold' : ''}`}>
                                <span className="text-sm">
                                  {match.teamHome ? `${match.teamHome.player1.nombre} ${match.teamHome.player1.apellido} / ${match.teamHome.player2.nombre} ${match.teamHome.player2.apellido}` : 'TBD'}
                                </span>
                                {match.status === 'played' && match.winner_team_id === match.team_home_id && <span className="text-green-600">✓</span>}
                              </div>
                              <div className={`flex justify-between items-center ${match.winner_team_id === match.team_away_id ? 'font-semibold' : ''}`}>
                                <span className="text-sm">
                                  {match.teamAway ? `${match.teamAway.player1.nombre} ${match.teamAway.player1.apellido} / ${match.teamAway.player2.nombre} ${match.teamAway.player2.apellido}` : 'TBD'}
                                </span>
                                {match.status === 'played' && match.winner_team_id === match.team_away_id && <span className="text-green-600">✓</span>}
                              </div>
                            </div>
                            {match.status === 'played' && (
                              <p className="text-xs text-gray-500 mt-2">{formatScore(match.score_json)}</p>
                            )}
                            {match.status === 'bye' && (
                              <p className="text-xs text-gray-500 mt-2">BYE</p>
                            )}
                          </div>
                        ))}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  )
}
