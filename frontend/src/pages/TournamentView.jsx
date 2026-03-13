import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import api from '../services/api'
import { formatMatchDate } from '../utils/helpers'

import { useAuth } from '../context/AuthContext'

export default function TournamentView() {
  const { id } = useParams()
  const navigate = useNavigate()
  const { user } = useAuth()
  const [tournament, setTournament] = useState(null)
  const [selectedCategory, setSelectedCategory] = useState(null)
  const [activeTab, setActiveTab] = useState('zones')
  const [zones, setZones] = useState([])
  const [standings, setStandings] = useState([])
  const [zoneMatches, setZoneMatches] = useState([])
  const [playoffs, setPlayoffs] = useState(null)
  const [loading, setLoading] = useState(true)
  const [venues, setVenues] = useState([])

  useEffect(() => {
    fetchTournament()
    fetchVenues()
  }, [id])

  useEffect(() => {
    if (selectedCategory) {
      fetchCategoryData()
    }
  }, [selectedCategory, activeTab])

  const fetchVenues = async () => {
    try {
      const response = await api.get('/api/tournament-categories/venues')
      if (response.data.ok) {
        setVenues(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching venues:', error)
    }
  }

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
        const response = await api.get(`/api/tournament-categories/standings?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setStandings(response.data.data)
      } else if (activeTab === 'matches') {
        const response = await api.get(`/api/tournament-categories/zone-matches?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setZoneMatches(Array.isArray(response.data.data) ? response.data.data : [])
        else setZoneMatches([])
      } else if (activeTab === 'playoffs') {
        const response = await api.get(`/api/tournament-categories/playoffs?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setPlayoffs(response.data.data)
        else setPlayoffs(null)
      }
    } catch (error) {
      console.error('Error fetching category data:', error)
    }
  }

  const getVenueBorderColor = (venueName) => {
    if (!venueName) return ''
    const venue = venues.find(v => v.name === venueName)
    if (!venue) return ''
    
    switch (venue.id) {
      case 1: return 'border-blue-500'
      case 3: return 'border-green-500'
      case 4: return 'border-red-500'
      default: return ''
    }
  }

  const formatScore = (scoreJson) => {
    if (!scoreJson || !scoreJson.sets) return '-'
    return scoreJson.sets.map(set => 
      set.type === 'SUPER_TB' ? `${set.home}-${set.away} (TB)` : `${set.home}-${set.away}`
    ).join(' ')
  }

  const getPlayoffTeamLabel = (match, side) => {
    const team = side === 'home' ? match.teamHome : match.teamAway
    if (team?.player1 && team?.player2) {
      return `${team.player1.nombre} ${team.player1.apellido} / ${team.player2.nombre} ${team.player2.apellido}`
    }

    const sourceZoneId = side === 'home' ? match.home_source_zone_id : match.away_source_zone_id
    const sourcePosition = side === 'home' ? match.home_source_position : match.away_source_position
    const sourceZone = side === 'home' ? match.homeSourceZone : match.awaySourceZone

    if (sourceZoneId && sourcePosition) {
      return `${sourcePosition}° Zona ${sourceZone?.name || '?'}`
    }

    const sourceMatch = playoffs?.matches?.find(m => m.next_match_id === match.id && m.next_match_slot === side)
    if (sourceMatch) {
      let roundPrefix = 'Partido'
      const rName = (sourceMatch.round_name || '').toLowerCase()
      if (rName.includes('octavos')) roundPrefix = 'Oct'
      else if (rName.includes('cuartos')) roundPrefix = 'Cuartos'
      else if (rName.includes('semi')) roundPrefix = 'Semi'
      
      return `Ganador ${roundPrefix} ${sourceMatch.match_number}`
    }

    return 'TBD'
  }

  const getZoneMatchTeamLabel = (match, side) => {
    const team = side === 'home' ? match.teamHome : match.teamAway
    if (team?.player1 && team?.player2) {
      return `${team.player1.nombre} ${team.player1.apellido} / ${team.player2.nombre} ${team.player2.apellido}`
    }

    const parentMatchId = side === 'home' ? match.parent_match_home_id : match.parent_match_away_id
    const parentCondition = side === 'home' ? match.parent_condition_home : match.parent_condition_away

    if (parentMatchId && parentCondition) {
      const parentMatch = zoneMatches?.find(m => m.id === parentMatchId)
      const parentLabel = parentMatch ? `Partido ${parentMatch.match_number}` : 'Partido'
      if (parentCondition === 'winner') return `Ganador ${parentLabel}`
      if (parentCondition === 'loser') return `Perdedor ${parentLabel}`
    }

    return 'TBD'
  }

  const handleBack = () => {
    if (user) {
      navigate(user.role === 'admin' ? '/admin' : '/dashboard')
    } else {
      navigate('/')
    }
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
              <button onClick={handleBack} className="text-primary-600 hover:text-primary-700 mr-4">
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
              <option key={tc.id} value={tc.id}>{tc.category.name} ({tc.category.gender})</option>
            ))}
          </select>
        </div>

        <div className="mb-6">
          <div className="border-b border-gray-200">
            <nav className="-mb-px flex space-x-8">
              {['zones', 'matches', 'playoffs'].map(tab => (
                <button
                  key={tab}
                  onClick={() => setActiveTab(tab)}
                  className={`${
                    activeTab === tab
                      ? 'border-primary-500 text-primary-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                  } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm capitalize`}
                >
                  {tab === 'zones' ? 'Zonas' : tab === 'matches' ? 'Partidos' : 'Playoffs'}
                </button>
              ))}
            </nav>
          </div>
        </div>

        {activeTab === 'zones' && (
          <div className="space-y-6">
            {standings.length === 0 ? (
              <p className="text-gray-500">No hay zonas/tabla de posiciones aún</p>
            ) : (
              standings.map(zone => (
                <div key={zone.id} className="bg-white rounded-lg shadow overflow-hidden">
                  <div className="px-6 py-4 bg-gray-50 border-b">
                    <h3 className="text-lg font-semibold text-gray-900">{zone.name}</h3>
                  </div>
                  {/* Desktop View (Table) */}
                  <div className="hidden md:block overflow-x-auto">
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

                  {/* Mobile View (Cards) */}
                  <div className="md:hidden">
                    <div className="divide-y divide-gray-100">
                      {zone.standings?.map((standing, idx) => (
                        <div key={standing.id} className="p-4 bg-white">
                          <div className="flex items-start justify-between mb-3">
                            <div className="flex items-center gap-3">
                              <div className={`
                                w-8 h-8 flex items-center justify-center rounded-full text-sm font-bold
                                ${idx === 0 ? 'bg-yellow-100 text-yellow-800' : 
                                  idx === 1 ? 'bg-gray-100 text-gray-800' :
                                  idx === 2 ? 'bg-orange-100 text-orange-800' : 'bg-slate-100 text-slate-600'}
                              `}>
                                {idx + 1}
                              </div>
                              <div className="text-sm font-medium text-gray-900 leading-tight">
                                <div className="mb-0.5">{standing.team.player1.nombre} {standing.team.player1.apellido}</div>
                                <div>{standing.team.player2.nombre} {standing.team.player2.apellido}</div>
                              </div>
                            </div>
                            <div className="flex flex-col items-center bg-gray-50 px-3 py-1 rounded min-w-[3.5rem]">
                              <span className="text-[10px] text-gray-500 uppercase font-bold">Pts</span>
                              <span className="text-lg font-bold text-gray-900">{standing.points}</span>
                            </div>
                          </div>
                          
                          <div className="grid grid-cols-5 gap-2 text-center text-xs border-t border-gray-100 pt-3">
                            <div>
                              <div className="text-gray-400 mb-1">PJ</div>
                              <div className="font-medium text-gray-700">{standing.played}</div>
                            </div>
                            <div>
                              <div className="text-gray-400 mb-1">PG</div>
                              <div className="font-medium text-green-600">{standing.wins}</div>
                            </div>
                            <div>
                              <div className="text-gray-400 mb-1">PP</div>
                              <div className="font-medium text-red-500">{standing.losses}</div>
                            </div>
                            <div>
                              <div className="text-gray-400 mb-1">Sets</div>
                              <div className="font-medium text-gray-700">{standing.sets_diff > 0 ? '+' : ''}{standing.sets_diff}</div>
                            </div>
                            <div>
                              <div className="text-gray-400 mb-1">Games</div>
                              <div className="font-medium text-gray-700">{standing.games_diff > 0 ? '+' : ''}{standing.games_diff}</div>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
        )}

        {activeTab === 'matches' && (
          <div className="space-y-8">
            {zoneMatches.length === 0 ? (
              <p className="text-gray-500">No hay partidos programados</p>
            ) : (
                Object.entries(
                  zoneMatches.reduce((acc, match) => {
                    const zoneName = match.zone?.name || 'Otras';
                    if (!acc[zoneName]) acc[zoneName] = [];
                    acc[zoneName].push(match);
                    return acc;
                  }, {})
                ).sort().map(([zoneName, matches]) => (
                  <div key={zoneName} className="bg-white rounded-lg shadow overflow-hidden">
                    <div className="px-6 py-3 bg-gray-100 border-b">
                      <h3 className="text-md font-bold text-gray-800">Zona {zoneName}</h3>
                    </div>
                    <div className="divide-y divide-gray-200">
                      {matches.map(match => (
                        <div key={match.id} className={`p-6 hover:bg-gray-50 transition-colors border-l-4 ${getVenueBorderColor(match.venue) || 'border-transparent'}`}>
                          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 items-center">
                            {/* Fecha y Lugar */}
                            <div className="md:col-span-1 text-sm text-gray-500 space-y-1">
                              <div className="flex items-center gap-2">
                                <span>📅</span>
                                {match.scheduled_at ? (
                                  <span>{formatMatchDate(match.scheduled_at)}</span>
                                ) : (
                                  <span className="italic">A confirmar</span>
                                )}
                              </div>
                              {match.venue && (
                                <div className="flex items-center gap-2">
                                  <span>📍</span>
                                  <span>{match.venue}</span>
                                </div>
                              )}
                            </div>

                            {/* Equipos y Resultado */}
                            <div className="md:col-span-2 flex justify-between items-center">
                              <div className="flex-1">
                                <p className={`text-sm font-medium ${match.winner_team_id === match.team_home_id ? 'font-bold text-gray-900' : 'text-gray-700'}`}>
                                  {getZoneMatchTeamLabel(match, 'home')}
                                </p>
                                <p className="text-xs text-gray-400 my-1">vs</p>
                                <p className={`text-sm font-medium ${match.winner_team_id === match.team_away_id ? 'font-bold text-gray-900' : 'text-gray-700'}`}>
                                  {getZoneMatchTeamLabel(match, 'away')}
                                </p>
                              </div>
                              <div className="text-right ml-4">
                                <span className={`inline-block px-2 py-1 text-xs rounded mb-2 ${match.status === 'played' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}`}>
                                  {match.status === 'played' ? 'Jugado' : 'Pendiente'}
                                </span>
                                {match.status === 'played' && (
                                  <p className="text-lg font-bold text-gray-900">
                                    {formatScore(match.score_json)}
                                  </p>
                                )}
                              </div>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                ))
            )}
          </div>
        )}

        {activeTab === 'playoffs' && (
          <div className="bg-white rounded-lg shadow-xl p-8 overflow-hidden">
            {!playoffs ? (
              <p className="text-center text-gray-500 py-10">No hay playoffs generados aún</p>
            ) : (
              <div className="relative">
                <div className="flex gap-12 pb-10 overflow-x-auto min-h-[600px] scrollbar-hide">
                  {(() => {
                    const rounds = [];
                    // Agrupar y ordenar matches por ronda
                    const sortedMatches = [...playoffs.matches].sort((a, b) => {
                      if (a.round_number !== b.round_number) return a.round_number - b.round_number;
                      return a.match_number - b.match_number;
                    });

                    sortedMatches.forEach(match => {
                      let round = rounds.find(r => r.number === match.round_number);
                      if (!round) {
                        round = { number: match.round_number, name: match.round_name, matches: [] };
                        rounds.push(round);
                      }
                      round.matches.push(match);
                    });

                    // Helper para agrupar en pares
                    const chunkPairs = (arr) => {
                      const pairs = [];
                      for (let i = 0; i < arr.length; i += 2) {
                        pairs.push(arr.slice(i, i + 2));
                      }
                      return pairs;
                    };

                    return rounds.map((round, roundIdx) => {
                      const isLastRound = roundIdx === rounds.length - 1;
                      const pairs = chunkPairs(round.matches);

                      return (
                        <div key={round.number} className="flex flex-col min-w-[280px] relative">
                          {/* Título de la Ronda */}
                          <div className="text-center mb-8">
                            <h4 className="text-xs font-black uppercase tracking-widest text-gray-400 bg-gray-50 py-2 rounded-full border border-gray-100">
                              {round.name}
                            </h4>
                          </div>
                          
                          {/* Contenedor de Matches */}
                          <div className="flex-1 flex flex-col w-full relative">
                            {pairs.map((pair, pairIdx) => (
                              <div key={pairIdx} className="flex-1 flex flex-col justify-around relative group/pair">
                                {pair.map((match) => (
                                  <div key={match.id} className="relative group">
                                    {/* La "caja" del partido */}
                                    <div className={`
                                      relative z-10 bg-white border-2 transition-all duration-300 rounded-lg overflow-hidden shadow-sm
                                      ${getVenueBorderColor(match.venue) || (match.status === 'played' ? 'border-primary-100' : 'border-gray-200')}
                                      group-hover:shadow-md group-hover:border-primary-300
                                    `}>
                                      {/* Equipo 1 (Home) */}
                                      <div className={`
                                        flex justify-between items-center p-3 border-b border-gray-100
                                        ${match.winner_team_id === match.team_home_id ? 'bg-primary-50' : ''}
                                      `}>
                                        <div className="flex items-center gap-2 overflow-hidden">
                                          <span className="text-[10px] font-bold text-gray-400 w-4">
                                            {match.home_source_position || ''}
                                          </span>
                                          <span className={`text-[11px] truncate ${match.winner_team_id === match.team_home_id ? 'font-bold text-primary-900' : 'text-gray-700'}`}>
                                            {getPlayoffTeamLabel(match, 'home')}
                                          </span>
                                        </div>
                                      </div>

                                      {/* Equipo 2 (Away) */}
                                      <div className={`
                                        flex justify-between items-center p-3
                                        ${match.winner_team_id === match.team_away_id ? 'bg-primary-50' : ''}
                                      `}>
                                        <div className="flex items-center gap-2 overflow-hidden">
                                          <span className="text-[10px] font-bold text-gray-400 w-4">
                                            {match.away_source_position || ''}
                                          </span>
                                          <span className={`text-[11px] truncate ${match.winner_team_id === match.team_away_id ? 'font-bold text-primary-900' : 'text-gray-700'}`}>
                                            {getPlayoffTeamLabel(match, 'away')}
                                          </span>
                                        </div>
                                      </div>

                                      {/* Información de Programación */}
                                      {(match.scheduled_at || match.venue) && match.status !== 'played' && match.status !== 'bye' && (
                                        <div className="bg-gray-50 px-3 py-1.5 border-t border-gray-100 flex flex-wrap gap-x-3 gap-y-1">
                                          {match.scheduled_at && (
                                            <div className="flex items-center text-[10px] text-gray-500 font-medium">
                                              <span className="mr-1">📅</span>
                                              {formatMatchDate(match.scheduled_at)}
                                            </div>
                                          )}
                                          {match.venue && (
                                            <div className="flex items-center text-[10px] text-gray-500 font-medium truncate max-w-[150px]">
                                              <span className="mr-1">📍</span>
                                              {match.venue}
                                            </div>
                                          )}
                                        </div>
                                      )}

                                      {/* Resultado del Partido */}
                                      {match.status === 'played' && (
                                        <div className="bg-gray-50 px-3 py-1.5 border-t border-gray-100 flex items-center justify-center">
                                          <span className="text-xs font-bold text-gray-900">
                                            {formatScore(match.score_json)}
                                          </span>
                                        </div>
                                      )}
                                    </div>

                                    {/* Información Extra (BYE) */}
                                    {match.status === 'bye' && (
                                      <div className="absolute -bottom-5 right-0 text-[10px] font-bold text-blue-500 uppercase tracking-tighter">BYE</div>
                                    )}
                                  </div>
                                ))}

                                {/* CONECTORES (Corchetes) - Solo si no es la última ronda */}
                                {!isLastRound && pair.length === 2 && (
                                  <>
                                    {/* Línea Vertical */}
                                    <div className="absolute -right-6 top-1/4 bottom-1/4 w-[2px] bg-gray-200 transition-colors duration-300 group-hover/pair:bg-primary-300"></div>
                                    {/* Brazo Superior */}
                                    <div className="absolute -right-6 top-1/4 w-6 h-[2px] bg-gray-200 transition-colors duration-300 group-hover/pair:bg-primary-300"></div>
                                    {/* Brazo Inferior */}
                                    <div className="absolute -right-6 bottom-1/4 w-6 h-[2px] bg-gray-200 transition-colors duration-300 group-hover/pair:bg-primary-300"></div>
                                    {/* Cola hacia la siguiente ronda */}
                                    <div className="absolute -right-12 top-1/2 w-6 h-[2px] bg-gray-200 transition-colors duration-300 group-hover/pair:bg-primary-300"></div>
                                  </>
                                )}
                                
                                {/* Conector Simple (si queda impar y no es la última ronda, ej: estructura atípica) */}
                                {!isLastRound && pair.length === 1 && (
                                  <div className="absolute -right-12 top-1/2 w-12 h-[2px] bg-gray-200 transition-colors duration-300 group-hover/pair:bg-primary-300"></div>
                                )}
                              </div>
                            ))}
                          </div>
                        </div>
                      );
                    });
                  })()}
                  
                  {/* Columna de Campeón (opcional) */}
                  {(() => {
                    const lastMatch = playoffs.matches[playoffs.matches.length - 1];
                    if (lastMatch?.status === 'played' && lastMatch?.winnerTeamId) {
                       // Podríamos agregar una columna de "Campeón"
                    }
                  })()}
                </div>
              </div>
            )}
            
            {/* Leyenda en el fondo */}
            <div className="mt-8 pt-6 border-t border-gray-100 flex justify-center gap-6">
              <div className="flex items-center gap-2">
                <div className="w-3 h-3 bg-primary-50 border border-primary-200 rounded"></div>
                <span className="text-xs text-gray-500">Ganador del partido</span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-3 h-3 bg-white border border-gray-200 rounded"></div>
                <span className="text-xs text-gray-500">Pendiente</span>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
