import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import * as XLSX from 'xlsx'
import api from '../../services/api'
import Modal from '../Modal'
import Toast from '../Toast'
import { formatDateForInput } from '../../utils/helpers'

export default function AdminTournamentDetail() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [tournament, setTournament] = useState(null)
  const [categories, setCategories] = useState([])
  const [activeTab, setActiveTab] = useState('categories')
  const [selectedCategory, setSelectedCategory] = useState(null)
  const [registrations, setRegistrations] = useState([])
  const [zones, setZones] = useState([])
  const [zoneMatches, setZoneMatches] = useState([])
  const [playoffs, setPlayoffs] = useState(null)
  const [showCategoryModal, setShowCategoryModal] = useState(false)
  const [showZoneModal, setShowZoneModal] = useState(false)
  const [showManualZoneModal, setShowManualZoneModal] = useState(false)
  const [showResultModal, setShowResultModal] = useState(false)
  const [showRegistrationModal, setShowRegistrationModal] = useState(false)
  const [showScheduleModal, setShowScheduleModal] = useState(false)
  const [zoneMode, setZoneMode] = useState('auto')
  const [manualZones, setManualZones] = useState([])
  const [availableRegistrations, setAvailableRegistrations] = useState([])
  const [editingMatch, setEditingMatch] = useState(null)
  const [scheduleMatch, setScheduleMatch] = useState(null)
  const [scheduleData, setScheduleData] = useState({ scheduled_at: '', venue: '' })
  const [scoreInput, setScoreInput] = useState({ sets: [{ home: '', away: '' }] })
  const [availableTeams, setAvailableTeams] = useState([])
  const [venues, setVenues] = useState([])
  const [selectedTeam, setSelectedTeam] = useState('')
  const [toast, setToast] = useState(null)
  const [loading, setLoading] = useState(false)
  const [editingCategory, setEditingCategory] = useState(null)

  useEffect(() => {
    fetchTournament()
    fetchCategories()
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
    }
  }

  const fetchCategories = async () => {
    try {
      const response = await api.get('/api/categories')
      if (response.data.ok) {
        setCategories(response.data.data)
      }
    } catch (error) {
      console.error('Error fetching categories:', error)
    }
  }

  const fetchCategoryData = async () => {
    try {
      if (activeTab === 'registrations') {
        const response = await api.get(`/api/admin/registrations?tournamentCategoryId=${selectedCategory}`)
        if (response.data.ok) setRegistrations(response.data.data)
      } else if (activeTab === 'zones') {
        const response = await api.get(`/api/tournament-categories/zones?tournament_category_id=${selectedCategory}`)
        if (response.data.ok) setZones(response.data.data)
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

  const handleSaveCategory = async (e) => {
    e.preventDefault()
    setLoading(true)

    const formData = new FormData(e.target)
    
    // Convert text "true"/"false" to boolean for 'inscripcion_abierta'
    const inscripcionAbierta = formData.get('inscripcion_abierta') === 'true'

    const data = {
      tournament_id: id,
      category_id: editingCategory ? editingCategory.category_id : formData.get('category_id'),
      cupo: formData.get('cupo') ? parseInt(formData.get('cupo')) : null,
      inscripcion_abierta: inscripcionAbierta,
      match_format: formData.get('match_format'),
      super_tiebreak_points: parseInt(formData.get('super_tiebreak_points')),
      win_points: parseInt(formData.get('win_points')),
      loss_points: parseInt(formData.get('loss_points')),
      tiebreak_in_sets: formData.get('tiebreak_in_sets') === 'true'
    }

    try {
      let response;
      if (editingCategory) {
        // Update existing
        response = await api.put(`/api/admin/tournament-categories/${editingCategory.id}`, data)
      } else {
        // Create new
        response = await api.post('/api/admin/tournament-categories', data)
      }

      if (response.data.ok) {
        setToast({ message: editingCategory ? 'Categoría actualizada' : 'Categoría agregada', type: 'success' })
        setShowCategoryModal(false)
        setEditingCategory(null)
        fetchTournament()
      }
    } catch (error) {
      console.error('Error saving category:', error);
      if (error.response) {
          console.error('Response data:', error.response.data);
          console.error('Response status:', error.response.status);
      }
      setToast({ message: error.response?.data?.error?.message || error.message || 'Error al guardar categoría', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const [showPlayoffModal, setShowPlayoffModal] = useState(false)
  const [playoffMode, setPlayoffMode] = useState('auto') // 'auto' | 'manual'
  const [manualPlayoffConfig, setManualPlayoffConfig] = useState({
    totalSlots: 8,
    matches: []
  })

  // Initialize manual matches when totalSlots changes
  useEffect(() => {
    if (playoffMode === 'manual') {
      const numMatches = manualPlayoffConfig.totalSlots / 2
      const initialMatches = []
      for (let i = 0; i < numMatches; i++) {
        initialMatches.push({
          match_number: i + 1,
          home: { zone_id: '', position: 1 },
          away: { zone_id: '', position: 2 }
        })
      }
      setManualPlayoffConfig(prev => ({ ...prev, matches: initialMatches }))
    }
  }, [manualPlayoffConfig.totalSlots, playoffMode])

  const handleManualPlayoffSubmit = async () => {
    const matchesToSend = manualPlayoffConfig.matches.map(m => {
      const newM = { match_number: m.match_number }
      if (m.home.zone_id) newM.home = m.home
      if (m.away.zone_id) newM.away = m.away
      return newM
    })

    setLoading(true)
    try {
      const response = await api.post('/api/admin/playoffs/generate-manual', {
        tournament_category_id: selectedCategory,
        total_slots: manualPlayoffConfig.totalSlots,
        matches: matchesToSend
      })
      if (response.data.ok) {
        setToast({ message: 'Playoffs generados exitosamente', type: 'success' })
        setShowPlayoffModal(false)
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleDragStart = (e, team, sourceZoneIndex = null) => {
    e.dataTransfer.setData('teamId', team.id)
    e.dataTransfer.setData('sourceZoneIndex', sourceZoneIndex !== null ? sourceZoneIndex : 'available')
  }

  const handleDrop = (e, targetZoneIndex) => {
    e.preventDefault()
    const teamId = parseInt(e.dataTransfer.getData('teamId'))
    const sourceZoneIndex = e.dataTransfer.getData('sourceZoneIndex')

    if (sourceZoneIndex === 'available' && targetZoneIndex === null) return
    if (String(sourceZoneIndex) === String(targetZoneIndex)) return

    let team
    let newAvailable = [...availableRegistrations]
    let newZones = [...manualZones]

    if (sourceZoneIndex === 'available') {
      team = newAvailable.find(t => t.id === teamId)
      newAvailable = newAvailable.filter(t => t.id !== teamId)
    } else {
      const srcIdx = parseInt(sourceZoneIndex)
      team = newZones[srcIdx].teams.find(t => t.id === teamId)
      newZones[srcIdx].teams = newZones[srcIdx].teams.filter(t => t.id !== teamId)
    }

    if (targetZoneIndex === null) {
      newAvailable.push(team)
    } else {
       newZones[targetZoneIndex].teams.push(team)
    }

    setAvailableRegistrations(newAvailable)
    setManualZones(newZones)
  }

  const addZone = () => {
    setManualZones([...manualZones, { name: String.fromCharCode(65 + manualZones.length), teams: [] }])
  }

  const removeZone = (index) => {
    const zoneToRemove = manualZones[index]
    const newAvailable = [...availableRegistrations, ...zoneToRemove.teams]
    const newZones = manualZones.filter((_, i) => i !== index)
    setAvailableRegistrations(newAvailable)
    setManualZones(newZones)
  }

  const removeTeamFromZone = (zoneIndex, teamId) => {
    const newZones = [...manualZones]
    const team = newZones[zoneIndex].teams.find(t => t.id === teamId)
    newZones[zoneIndex].teams = newZones[zoneIndex].teams.filter(t => t.id !== teamId)
    
    setAvailableRegistrations([...availableRegistrations, team])
    setManualZones(newZones)
  }

  const handleGenerateZones = async (e) => {
    e.preventDefault()
    setLoading(true)

    if (!selectedCategory) {
      setToast({ message: 'Debe seleccionar una categoría primero', type: 'error' })
      setLoading(false)
      return
    }

    const formData = new FormData(e.target)
    const zoneSizeValue = formData.get('zone_size')
    const qualifiersValue = formData.get('qualifiers_per_zone')
    
    const zoneSize = parseInt(zoneSizeValue)
    const qualifiersPerZone = parseInt(qualifiersValue)
    const categoryId = parseInt(selectedCategory)



    // Si es modo manual, abrir modal de asignación manual
    if (zoneMode === 'manual') {
      try {
        // Obtener inscripciones confirmadas
        const response = await api.get(`/api/admin/registrations?tournamentCategoryId=${selectedCategory}`)
        if (response.data.ok) {
          const confirmedRegs = response.data.data.filter(r => r.estado === 'confirmado' || r.estado === 'inscripto')
          setAvailableRegistrations(confirmedRegs)
          
          // Inicializar con una zona vacía o ninguna, el usuario las agregará
          setManualZones([])
          
          setShowZoneModal(false)
          setShowManualZoneModal(true)
        }
      } catch (error) {
        setToast({ message: 'Error al cargar inscripciones', type: 'error' })
      } finally {
        setLoading(false)
      }
      return
    }

    // Validación SOLO para modo automático
    if (isNaN(categoryId) || isNaN(zoneSize) || isNaN(qualifiersPerZone)) {
      setToast({ message: 'Todos los campos deben ser números válidos', type: 'error' })
      setLoading(false)
      return
    }

    // Modo automático
    const data = {
      tournament_category_id: categoryId,
      zone_size: zoneSize,
      qualifiers_per_zone: qualifiersPerZone
    }

    try {
      const response = await api.post('/api/admin/zones/generate', data)
      if (response.data.ok) {
        setToast({ message: 'Zonas generadas exitosamente', type: 'success' })
        setShowZoneModal(false)
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleGeneratePlayoffs = async () => {
    try {
      const response = await api.get(`/api/admin/registrations?tournamentCategoryId=${selectedCategory}`)
      if (response.data.ok) {
        const confirmedCount = Array.isArray(response.data.data)
          ? response.data.data.filter(r => ['inscripto', 'confirmado'].includes(r.estado)).length
          : 0
        const suggestedSlots = confirmedCount > 13 ? 16 : 8
        setManualPlayoffConfig(prev => ({ ...prev, totalSlots: suggestedSlots }))
      }

      const zonesResponse = await api.get(`/api/tournament-categories/zones?tournament_category_id=${selectedCategory}`)
      if (zonesResponse.data.ok) {
        setZones(Array.isArray(zonesResponse.data.data) ? zonesResponse.data.data : [])
      }
    } catch {
      // fallback: keep current selection
    } finally {
      setShowPlayoffModal(true)
    }
  }

  const handleAssignTeamToZone = (registration, zoneIndex) => {
    const newZones = [...manualZones]
    const newAvailable = availableRegistrations.filter(r => r.id !== registration.id)
    
    // Agregar equipo a la zona
    newZones[zoneIndex].teams.push(registration)
    
    setManualZones(newZones)
    setAvailableRegistrations(newAvailable)
  }

  const handleRemoveTeamFromZone = (registration, zoneIndex) => {
    const newZones = [...manualZones]
    
    // Remover equipo de la zona
    newZones[zoneIndex].teams = newZones[zoneIndex].teams.filter(t => t.id !== registration.id)
    
    // Agregar de vuelta a disponibles
    setAvailableRegistrations([...availableRegistrations, registration])
    setManualZones(newZones)
  }

  const handleConfirmManualZones = async () => {
    // Validar que todas las parejas estén asignadas
    if (availableRegistrations.length > 0) {
      setToast({ message: 'Debe asignar todas las parejas a las zonas', type: 'error' })
      return
    }

    setLoading(true)

    try {
      // Preparar datos para enviar al backend
      const zonesData = manualZones.map((zone, index) => ({
        name: zone.name,
        order_index: index,
        teams: zone.teams.map(reg => reg.team_id)
      }))

      const response = await api.post('/api/admin/zones/generate-manual', {
        tournament_category_id: parseInt(selectedCategory),
        zones: zonesData,
        force: true // Permitir sobrescribir si ya existen
      })

      if (response.data.ok) {
        setToast({ message: 'Zonas creadas exitosamente', type: 'success' })
        setShowManualZoneModal(false)
        setManualZones([])
        setAvailableRegistrations([])
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al crear zonas', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const openRegistrationModal = async () => {
    try {
      const response = await api.get('/api/admin/teams?estado=activa')
      if (response.data.ok) {
        // Filter out teams that are already registered in the current category
        const registeredTeamIds = new Set(registrations.map(r => r.team_id))
        let filteredTeams = response.data.data.filter(team => !registeredTeamIds.has(team.id))
        
        // Filter by selected category
        if (selectedCategory && tournament?.categories) {
          const currentCat = tournament.categories.find(c => c.id === parseInt(selectedCategory))
          if (currentCat) {
            const targetCategoryId = currentCat.category.id
            filteredTeams = filteredTeams.filter(team => 
              team.player1.categoria_base_id === targetCategoryId || 
              team.player2.categoria_base_id === targetCategoryId
            )
          }
        }

        setAvailableTeams(filteredTeams)
        setShowRegistrationModal(true)
      }
    } catch (error) {
      setToast({ message: 'Error al cargar parejas', type: 'error' })
    }
  }

  const handleCreateRegistration = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const response = await api.post('/api/admin/registrations', {
        tournament_category_id: parseInt(selectedCategory),
        team_id: parseInt(selectedTeam)
      })
      if (response.data.ok) {
        setToast({ message: 'Inscripción creada exitosamente', type: 'success' })
        setShowRegistrationModal(false)
        setSelectedTeam('')
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al inscribir pareja', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleCancelRegistration = async (registrationId) => {
    if (!confirm('¿Está seguro de cancelar esta inscripción?')) return
    setLoading(true)

    try {
      const response = await api.patch(`/api/admin/registrations/${registrationId}/cancel`)
      if (response.data.ok) {
        setToast({ message: 'Inscripción cancelada', type: 'success' })
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleDeleteRegistration = async (registrationId) => {
    if (!confirm('¿Está seguro de eliminar esta inscripción? Esta acción no se puede deshacer.')) return
    setLoading(true)

    try {
      await api.delete(`/api/admin/registrations/${registrationId}`)
      setToast({ message: 'Inscripción eliminada', type: 'success' })
      fetchCategoryData()
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleAssignPoints = async () => {
    if (!confirm('¿Está seguro de finalizar el torneo y asignar puntos? Esta acción no se puede deshacer.')) return
    setLoading(true)

    try {
      const response = await api.post('/api/admin/points/assign', {
        tournament_category_id: parseInt(selectedCategory)
      })
      if (response.data.ok) {
        setToast({ 
          message: `Puntos asignados exitosamente. ${response.data.data.pointsAssigned} puntos asignados a ${response.data.data.teamsProcessed} equipos.`, 
          type: 'success' 
        })
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al asignar puntos', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const openScheduleModal = async (match, isZone = true) => {
    try {
      const response = await api.get('/api/admin/venues?active=true')
      if (response.data.ok) {
        setVenues(response.data.data)
      }
    } catch (error) {
      console.error('Error loading venues:', error)
    }

    setScheduleMatch({ ...match, isZone })
    setScheduleData({
      scheduled_at: match.scheduled_at ? formatDateForInput(match.scheduled_at) : '',
      venue: match.venue || ''
    })
    setShowScheduleModal(true)
  }

  const handleScheduleMatch = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      const endpoint = scheduleMatch.isZone 
        ? `/api/admin/zone-matches/${scheduleMatch.id}/schedule`
        : `/api/admin/matches/${scheduleMatch.id}/schedule`
      
      const payload = {
        ...scheduleData,
        scheduled_at: scheduleData.scheduled_at ? `${scheduleData.scheduled_at}:00-03:00` : ''
      }

      const response = await api.patch(endpoint, payload)
      if (response.data.ok) {
        setToast({ message: 'Partido programado exitosamente', type: 'success' })
        setShowScheduleModal(false)
        setScheduleMatch(null)
        setScheduleData({ scheduled_at: '', venue: '' })
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error al programar partido', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const handleUpdateResult = async (e) => {
    e.preventDefault()
    setLoading(true)

    const score_json = {
      format: editingMatch.format,
      sets: scoreInput.sets.map(set => ({
        home: parseInt(set.home),
        away: parseInt(set.away),
        type: set.type || undefined
      }))
    }

    try {
      const endpoint = editingMatch.isZone 
        ? `/api/admin/zone-matches/${editingMatch.id}/result`
        : `/api/admin/matches/${editingMatch.id}/result`
      
      const payload = { score_json }
      if (editingMatch.status === 'played') {
        payload.force_override = true
      }
      
      const response = await api.patch(endpoint, payload)
      if (response.data.ok) {
        setToast({ message: 'Resultado actualizado', type: 'success' })
        setShowResultModal(false)
        setEditingMatch(null)
        setScoreInput({ sets: [{ home: '', away: '' }] })
        fetchCategoryData()
      }
    } catch (error) {
      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  const openResultModal = (match, isZone = false) => {
    const currentCategoryObj = tournament?.categories?.find(c => c.id === parseInt(selectedCategory));
    const format = currentCategoryObj?.match_format || 'BEST_OF_3_SUPER_TB';
    
    setEditingMatch({ ...match, isZone, format })
    
    if (match.score_json && match.score_json.sets) {
      setScoreInput({
        sets: match.score_json.sets.map(s => ({
          home: s.home,
          away: s.away,
          type: s.type
        }))
      })
    } else {
      // Iniciar con 2 sets vacíos
      setScoreInput({ sets: [{ home: '', away: '' }, { home: '', away: '' }] })
    }
    setShowResultModal(true)
  }

  const addSet = () => {
    const isSuperTB = editingMatch.format === 'BEST_OF_3_SUPER_TB' && scoreInput.sets.length === 2;
    setScoreInput({ 
      sets: [...scoreInput.sets, { home: '', away: '', type: isSuperTB ? 'SUPER_TB' : undefined }] 
    })
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
      return `Ganador Partido ${sourceMatch.match_number}`
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

  const handleExportExcel = async () => {
    try {
      setLoading(true)
      const response = await api.get(`/api/admin/registrations?tournamentId=${id}`)
      if (response.data.ok) {
        const allRegistrations = response.data.data
        
        // Prepare data for Excel
        const data = allRegistrations.map(reg => ({
          'Categoría': reg.tournamentCategory?.category?.name || 'Desconocida',
          'Pareja': `${reg.team.player1.nombre} ${reg.team.player1.apellido} / ${reg.team.player2.nombre} ${reg.team.player2.apellido}`,
          'Problemas de Horario': reg.schedule_problems || 'Ninguno',
          'Estado': reg.estado
        }))

        // Sort by Category
        data.sort((a, b) => a['Categoría'].localeCompare(b['Categoría']))

        const ws = XLSX.utils.json_to_sheet(data)
        
        // Adjust column widths
        const wscols = [
          { wch: 20 }, // Categoría
          { wch: 40 }, // Pareja
          { wch: 40 }, // Problemas de Horario
          { wch: 15 }  // Estado
        ];
        ws['!cols'] = wscols;

        const wb = XLSX.utils.book_new()
        XLSX.utils.book_append_sheet(wb, ws, "Inscripciones")
        XLSX.writeFile(wb, `Inscripciones_${tournament.nombre.replace(/\s+/g, '_')}.xlsx`)
        
        setToast({ message: 'Exportación exitosa', type: 'success' })
      }
    } catch (error) {
      console.error('Error exporting:', error)
      setToast({ message: 'Error al exportar', type: 'error' })
    } finally {
      setLoading(false)
    }
  }

  if (!tournament) {
    return <div>Cargando...</div>
  }

  return (
    <div>
      {toast && <Toast message={toast.message} type={toast.type} onClose={() => setToast(null)} />}

      <div className="mb-6">
        <button onClick={() => navigate('/admin')} className="text-primary-600 hover:text-primary-700 mb-4">
          ← Volver a Torneos
        </button>
        <h2 className="text-2xl font-bold text-gray-900">{tournament.nombre}</h2>
      </div>

      <div className="mb-6">
        <div className="border-b border-gray-200">
          <nav className="-mb-px flex space-x-8">
            {['categories', 'registrations', 'zones', 'matches', 'playoffs'].map(tab => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`${
                  activeTab === tab
                    ? 'border-primary-500 text-primary-600'
                    : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                } whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm capitalize`}
              >
                {tab === 'categories' ? 'Categorías' : tab === 'registrations' ? 'Inscripciones' : tab === 'zones' ? 'Zonas' : tab === 'matches' ? 'Partidos' : 'Playoffs'}
              </button>
            ))}
          </nav>
        </div>
      </div>

      {activeTab !== 'categories' && tournament.categories?.length > 0 && (
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
      )}

      {activeTab === 'categories' && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-semibold">Categorías del Torneo</h3>
            <button
              onClick={() => setShowCategoryModal(true)}
              className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
            >
              Agregar Categoría
            </button>
          </div>
          <div className="bg-white shadow overflow-hidden sm:rounded-lg">
            {/* Desktop View - Table */}
            <div className="hidden md:block">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categoría</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Género</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Cupo</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Inscripción</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Formato</th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Acciones</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {tournament.categories?.map(tc => (
                    <tr key={tc.id}>
                      <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{tc.category.name}</td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 capitalize">{tc.category.gender}</td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{tc.cupo || 'Sin límite'}</td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <span className={`px-2 py-1 text-xs rounded ${tc.inscripcion_abierta ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                          {tc.inscripcion_abierta ? 'Abierta' : 'Cerrada'}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{tc.match_format}</td>
                      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <button
                          onClick={() => {
                            setEditingCategory(tc)
                            setShowCategoryModal(true)
                          }}
                          className="text-primary-600 hover:text-primary-900"
                        >
                          Editar
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Mobile View - Cards */}
            <div className="md:hidden">
              <ul className="divide-y divide-gray-200">
                {tournament.categories?.map(tc => (
                  <li key={tc.id} className="p-4">
                    <div className="flex justify-between items-center mb-2">
                       <span className="text-sm font-bold text-gray-900">{tc.category.name}</span>
                       <span className={`px-2 py-1 text-xs rounded ${tc.inscripcion_abierta ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                          {tc.inscripcion_abierta ? 'Abierta' : 'Cerrada'}
                        </span>
                    </div>
                    <div className="text-xs text-gray-600 space-y-1">
                      <p>Cupo: {tc.cupo || 'Sin límite'}</p>
                      <p>Formato: {tc.match_format}</p>
                    </div>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      )}

      {activeTab === 'registrations' && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-semibold">Inscripciones ({registrations.length})</h3>
            <div className="flex space-x-2">
              <button
                onClick={handleExportExcel}
                className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700"
              >
                Exportar Excel
              </button>
              <button
                onClick={openRegistrationModal}
                className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
              >
                Inscribir Pareja
              </button>
            </div>
          </div>
          <div className="bg-white shadow overflow-hidden sm:rounded-lg">
            {/* Desktop View - Table */}
            <div className="hidden md:block">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Pareja</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categorías Base</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Estado</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Acciones</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {registrations.map(reg => (
                    <tr key={reg.id}>
                      <td className="px-6 py-4 text-sm text-gray-900">
                        {reg.team.player1.nombre} {reg.team.player1.apellido} / {reg.team.player2.nombre} {reg.team.player2.apellido}
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-500">
                        {reg.team.player1.categoriaBase.name} ({reg.team.player1.categoriaBase.gender}) / {reg.team.player2.categoriaBase.name} ({reg.team.player2.categoriaBase.gender})
                      </td>
                      <td className="px-6 py-4 text-sm text-gray-500 max-w-xs truncate" title={reg.schedule_problems}>
                        {reg.schedule_problems || '-'}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        <span className={`px-2 py-1 text-xs rounded ${
                          reg.estado === 'confirmado' ? 'bg-green-100 text-green-800' :
                          reg.estado === 'inscripto' ? 'bg-primary-100 text-primary-800' :
                          'bg-gray-100 text-gray-800'
                        }`}>
                          {reg.estado}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm">
                        {reg.estado !== 'cancelado' && (
                          <>
                            <button
                              onClick={() => handleCancelRegistration(reg.id)}
                              className="text-yellow-600 hover:text-yellow-900 mr-3"
                            >
                              Cancelar
                            </button>
                            <button
                              onClick={() => handleDeleteRegistration(reg.id)}
                              className="text-red-600 hover:text-red-900"
                            >
                              Eliminar
                            </button>
                          </>
                        )}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>

            {/* Mobile View - Cards */}
            <div className="md:hidden">
              <ul className="divide-y divide-gray-200">
                {registrations.map(reg => (
                  <li key={reg.id} className="p-4">
                     <div className="flex justify-between items-start mb-2">
                        <div className="flex-1">
                           <p className="text-sm font-semibold text-gray-900">
                             {reg.team.player1.nombre} {reg.team.player1.apellido}
                           </p>
                           <p className="text-sm font-semibold text-gray-900">
                             {reg.team.player2.nombre} {reg.team.player2.apellido}
                           </p>
                           <p className="text-xs text-gray-500 mt-1">
                             Cats: {reg.team.player1.categoriaBase.name} / {reg.team.player2.categoriaBase.name}
                           </p>
                           {reg.schedule_problems && (
                             <p className="text-xs text-yellow-600 mt-1 italic">
                               <span className="font-semibold">Nota:</span> {reg.schedule_problems}
                             </p>
                           )}
                        </div>
                        <span className={`px-2 py-1 text-xs rounded ${
                          reg.estado === 'confirmado' ? 'bg-green-100 text-green-800' :
                          reg.estado === 'inscripto' ? 'bg-primary-100 text-primary-800' :
                          'bg-gray-100 text-gray-800'
                        }`}>
                          {reg.estado}
                        </span>
                     </div>
                     
                     {reg.estado !== 'cancelado' && (
                        <div className="flex justify-end gap-3 mt-3 pt-2 border-t border-gray-100">
                            <button
                              onClick={() => handleCancelRegistration(reg.id)}
                              className="text-sm font-medium text-yellow-600 hover:text-yellow-900"
                            >
                              Cancelar
                            </button>
                            <button
                              onClick={() => handleDeleteRegistration(reg.id)}
                              className="text-sm font-medium text-red-600 hover:text-red-900"
                            >
                              Eliminar
                            </button>
                        </div>
                      )}
                  </li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      )}

      {activeTab === 'zones' && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-semibold">Zonas</h3>
            <div className="flex gap-2">
              <button
                onClick={() => {
                  setZoneMode('auto')
                  setShowZoneModal(true)
                }}
                className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
              >
                Generar Zonas
              </button>
              {zones.length > 0 && (
                <button
                  onClick={async () => {
                    setLoading(true)
                    try {
                      // Cargar inscripciones para tener la lista completa de equipos disponibles (aunque estén en zonas)
                      const responseRegs = await api.get(`/api/admin/registrations?tournamentCategoryId=${selectedCategory}`)
                      if (responseRegs.data.ok) {
                        const confirmedRegs = responseRegs.data.data.filter(r => r.estado === 'confirmado' || r.estado === 'inscripto')
                        
                        // Mapear zonas actuales al formato de manualZones
                        const currentZones = zones.map(z => ({
                          name: z.name,
                          teams: z.zoneTeams?.map(zt => {
                            // Encontrar la inscripción correspondiente al equipo
                            const reg = confirmedRegs.find(r => r.team_id === zt.team_id)
                            return reg || { 
                              id: zt.team_id, // Fallback si no encuentra registration
                              team_id: zt.team_id,
                              team: zt.team
                            }
                          }) || []
                        }))

                        setManualZones(currentZones)

                        // Calcular disponibles: aquellos que NO están en ninguna zona
                        const teamsInZones = new Set()
                        currentZones.forEach(z => z.teams.forEach(t => teamsInZones.add(t.team_id || t.team?.id)))
                        
                        const available = confirmedRegs.filter(r => !teamsInZones.has(r.team_id))
                        setAvailableRegistrations(available)

                        setShowManualZoneModal(true)
                      }
                    } catch (error) {
                      setToast({ message: 'Error al cargar datos de zonas', type: 'error' })
                    } finally {
                      setLoading(false)
                    }
                  }}
                  className="bg-yellow-600 text-white px-4 py-2 rounded-md hover:bg-yellow-700"
                >
                  Editar Zonas
                </button>
              )}
            </div>
          </div>
          {zones.length === 0 ? (
            <p className="text-gray-500">No hay zonas generadas</p>
          ) : (
            <div className="grid gap-4 md:grid-cols-2">
              {zones.map(zone => (
                <div key={zone.id} className="bg-white rounded-lg shadow p-6">
                  <h4 className="text-md font-semibold text-gray-900 mb-3">{zone.name}</h4>
                  <div className="space-y-2">
                    {zone.zoneTeams?.map(zt => (
                      <div key={zt.id} className="text-sm text-gray-700">
                        {zt.team.player1.nombre} {zt.team.player1.apellido} / {zt.team.player2.nombre} {zt.team.player2.apellido}
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {activeTab === 'matches' && (
        <div>
          <h3 className="text-lg font-semibold mb-4">Partidos de Zona</h3>
          {zoneMatches.length === 0 ? (
            <p className="text-gray-500">No hay partidos</p>
          ) : (
            <div className="space-y-4">
              {zoneMatches.map(match => (
                <div key={match.id} className="bg-white rounded-lg shadow p-6">
                  <div className="flex justify-between items-start">
                    <div className="flex-1">
                      <div className="mb-2">
                        <span className="text-xs text-gray-500">Zona {match.zone?.name || '?'} - Ronda {match.round_number}</span>
                      </div>
                      <p className="text-sm font-medium text-gray-900">
                        {getZoneMatchTeamLabel(match, 'home')}
                      </p>
                      <p className="text-sm text-gray-500 my-1">vs</p>
                      <p className="text-sm font-medium text-gray-900">
                        {getZoneMatchTeamLabel(match, 'away')}
                      </p>
                      {(match.scheduled_at || match.venue) && (
                        <div className="mt-3 text-xs text-gray-600 space-y-1">
                          {match.scheduled_at && (
                            <div>📅 {new Date(match.scheduled_at).toLocaleString('es-AR', { 
                              day: '2-digit',
                              month: '2-digit',
                              year: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit',
                              hour12: false,
                              timeZone: 'America/Argentina/Buenos_Aires'
                            })}</div>
                          )}
                          {match.venue && <div>📍 {match.venue}</div>}
                        </div>
                      )}
                    </div>
                    <div className="text-right space-y-2">
                      {match.status === 'played' ? (
                        <div className="flex flex-col items-end gap-2">
                          <span className="px-2 py-1 text-xs rounded bg-green-100 text-green-800">Jugado</span>
                          {match.score_json && match.score_json.sets && (
                            <div className="text-xs font-bold text-gray-800">
                              {match.score_json.sets.map((s, idx) => (
                                <span key={idx} className="mr-2">
                                  {s.home}-{s.away}
                                </span>
                              ))}
                            </div>
                          )}
                          <button
                            onClick={() => openResultModal(match, true)}
                            className="text-xs text-primary-600 hover:text-primary-800 underline"
                          >
                            Editar Resultado
                          </button>
                        </div>
                      ) : (
                        <>
                          <button
                            onClick={() => openScheduleModal(match)}
                            className="block w-full text-sm bg-primary-600 text-white px-3 py-1 rounded hover:bg-primary-700 mb-2"
                          >
                            Programar
                          </button>
                          <button
                            onClick={() => openResultModal(match, true)}
                            className="block w-full text-sm bg-primary-600 text-white px-3 py-1 rounded hover:bg-primary-700"
                          >
                            Cargar Resultado
                          </button>
                        </>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {activeTab === 'playoffs' && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-semibold">Playoffs</h3>
            <div className="flex gap-2">
              {!playoffs ? (
                <button
                  onClick={handleGeneratePlayoffs}
                  disabled={loading}
                  className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700 disabled:opacity-50"
                >
                  {loading ? 'Generando...' : 'Generar Playoffs'}
                </button>
              ) : (
                <button
                  onClick={handleAssignPoints}
                  disabled={loading}
                  className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 disabled:opacity-50"
                >
                  {loading ? 'Asignando...' : 'Finalizar y Asignar Puntos'}
                </button>
              )}
            </div>
          </div>
          {!playoffs ? (
            <p className="text-gray-500">No hay playoffs generados</p>
          ) : (
            <div className="space-y-4">
              {playoffs.matches?.map(match => (
                <div key={match.id} className="bg-white rounded-lg shadow p-6">
                  <div className="flex justify-between items-start">
                    <div className="flex-1">
                      <div className="mb-2">
                        <span className="text-sm font-semibold text-gray-700">{match.round_name}</span>
                      </div>
                      <div className="space-y-1">
                        <p className="text-sm text-gray-900">
                          {getPlayoffTeamLabel(match, 'home')}
                        </p>
                        <p className="text-sm text-gray-500">vs</p>
                        <p className="text-sm text-gray-900">
                          {getPlayoffTeamLabel(match, 'away')}
                        </p>
                      </div>
                      {(match.scheduled_at || match.venue) && (
                        <div className="mt-3 text-xs text-gray-600 space-y-1">
                          {match.scheduled_at && (
                            <div>📅 {new Date(match.scheduled_at).toLocaleString('es-AR', { 
                              day: '2-digit',
                              month: '2-digit',
                              year: '2-digit',
                              hour: '2-digit',
                              minute: '2-digit',
                              hour12: false,
                              timeZone: 'America/Argentina/Buenos_Aires'
                            })}</div>
                          )}
                          {match.venue && <div>📍 {match.venue}</div>}
                        </div>
                      )}
                    </div>
                    <div className="text-right space-y-2">
                      {match.status === 'played' ? (
                        <div className="flex flex-col items-end gap-2">
                          <span className="px-2 py-1 text-xs rounded bg-green-100 text-green-800">Jugado</span>
                          {match.score_json && match.score_json.sets && (
                            <div className="text-xs font-bold text-gray-800">
                              {match.score_json.sets.map((s, idx) => (
                                <span key={idx} className="mr-2">
                                  {s.home}-{s.away}
                                </span>
                              ))}
                            </div>
                          )}
                          <button
                            onClick={() => openResultModal(match, false)}
                            className="text-xs text-primary-600 hover:text-primary-800 underline"
                          >
                            Editar Resultado
                          </button>
                        </div>
                      ) : match.status === 'bye' ? (
                        <span className="px-2 py-1 text-xs rounded bg-blue-100 text-blue-800 text-center block">BYE</span>
                      ) : (
                        <>
                          <button
                            onClick={() => openScheduleModal(match, false)}
                            className="block w-full text-sm bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700 mb-2"
                          >
                            Programar
                          </button>
                          {match.team_home_id && match.team_away_id && (
                            <button
                              onClick={() => openResultModal(match, false)}
                              className="block w-full text-sm bg-primary-600 text-white px-3 py-1 rounded hover:bg-primary-700"
                            >
                              Cargar Resultado
                            </button>
                          )}
                        </>
                      )}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      <Modal isOpen={showCategoryModal} onClose={() => { setShowCategoryModal(false); setEditingCategory(null); }} title={editingCategory ? "Editar Categoría" : "Agregar Categoría"}>
        <form onSubmit={handleSaveCategory} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Categoría</label>
            <select 
              name="category_id" 
              required 
              defaultValue={editingCategory?.category_id || ''}
              disabled={!!editingCategory} 
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="">Selecciona una categoría</option>
              {categories.map(cat => (
                <option key={cat.id} value={cat.id}>{cat.name} ({cat.gender})</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Cupo (opcional)</label>
            <input 
              name="cupo" 
              type="number" 
              defaultValue={editingCategory?.cupo || ''} 
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" 
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Inscripción Abierta</label>
            <select 
              name="inscripcion_abierta" 
              required 
              defaultValue={editingCategory?.inscripcion_abierta?.toString() || 'true'}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="true">Sí</option>
              <option value="false">No</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Formato de Partido</label>
            <select 
              name="match_format" 
              required 
              defaultValue={editingCategory?.match_format || 'BEST_OF_3_SUPER_TB'}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="BEST_OF_3_SUPER_TB">Best of 3 + Super TB</option>
              <option value="BEST_OF_3_FULL">Best of 3 Full</option>
            </select>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">Puntos TB</label>
              <input 
                name="super_tiebreak_points" 
                type="number" 
                defaultValue={editingCategory?.super_tiebreak_points || 10} 
                required 
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" 
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Puntos Victoria</label>
              <input 
                name="win_points" 
                type="number" 
                defaultValue={editingCategory?.win_points || 2} 
                required 
                className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" 
              />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Puntos Derrota</label>
            <input 
              name="loss_points" 
              type="number" 
              defaultValue={editingCategory?.loss_points || 0} 
              required 
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" 
            />
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => { setShowCategoryModal(false); setEditingCategory(null); }} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Guardando...' : editingCategory ? 'Actualizar' : 'Agregar'}
            </button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={showZoneModal} onClose={() => setShowZoneModal(false)} title="Generar Zonas">
        <form onSubmit={handleGenerateZones} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">Modo de Generación</label>
            <div className="space-y-2">
              <label className="flex items-center">
                <input
                  type="radio"
                  name="zone_mode"
                  value="auto"
                  checked={zoneMode === 'auto'}
                  onChange={(e) => setZoneMode(e.target.value)}
                  className="mr-2"
                />
                <span className="text-sm">Automático (distribución aleatoria)</span>
              </label>
              <label className="flex items-center">
                <input
                  type="radio"
                  name="zone_mode"
                  value="manual"
                  checked={zoneMode === 'manual'}
                  onChange={(e) => setZoneMode(e.target.value)}
                  className="mr-2"
                />
                <span className="text-sm">Manual (asignar parejas manualmente)</span>
              </label>
            </div>
          </div>
          {zoneMode === 'auto' && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-700">Tamaño de Zona</label>
                <input name="zone_size" type="number" min="2" defaultValue="4" required className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700">Clasificados por Zona</label>
                <input name="qualifiers_per_zone" type="number" min="1" defaultValue="2" required className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500" />
              </div>
            </>
          )}
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowZoneModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Generando...' : zoneMode === 'manual' ? 'Continuar' : 'Generar'}
            </button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={showResultModal} onClose={() => setShowResultModal(false)} title="Cargar Resultado">
        <form onSubmit={handleUpdateResult} className="space-y-4">
          {scoreInput.sets.map((set, idx) => (
            <div key={idx} className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700">
                  {set.type === 'SUPER_TB' ? 'Super Tie-break' : `Set ${idx + 1}`} - Local
                </label>
                <input
                  type="number"
                  min="0"
                  value={set.home}
                  onChange={(e) => {
                    const newSets = [...scoreInput.sets]
                    newSets[idx].home = e.target.value
                    setScoreInput({ sets: newSets })
                  }}
                  required
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700">
                  {set.type === 'SUPER_TB' ? 'Super Tie-break' : `Set ${idx + 1}`} - Visitante
                </label>
                <input
                  type="number"
                  min="0"
                  value={set.away}
                  onChange={(e) => {
                    const newSets = [...scoreInput.sets]
                    newSets[idx].away = e.target.value
                    setScoreInput({ sets: newSets })
                  }}
                  required
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
                />
              </div>
            </div>
          ))}
          {scoreInput.sets.length < 3 && (
            <button
              type="button"
              onClick={addSet}
              className="text-sm text-primary-600 hover:text-primary-700"
            >
              + Agregar Set
            </button>
          )}
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowResultModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Guardando...' : 'Guardar'}
            </button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={showRegistrationModal} onClose={() => setShowRegistrationModal(false)} title="Inscribir Pareja">
        <form onSubmit={handleCreateRegistration} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Seleccionar Pareja</label>
            <select
              value={selectedTeam}
              onChange={(e) => setSelectedTeam(e.target.value)}
              required
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="">Seleccione una pareja</option>
              {availableTeams.map(team => (
                <option key={team.id} value={team.id}>
                  {team.player1.nombre} {team.player1.apellido} / {team.player2.nombre} {team.player2.apellido} ({team.player1.categoriaBase.name} [{team.player1.categoriaBase.gender}] / {team.player2.categoriaBase.name} [{team.player2.categoriaBase.gender}])
                </option>
              ))}
            </select>
          </div>
          <div className="flex justify-end space-x-3">
            <button type="button" onClick={() => setShowRegistrationModal(false)} className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50">
              Cancelar
            </button>
            <button type="submit" disabled={loading} className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50">
              {loading ? 'Inscribiendo...' : 'Inscribir'}
            </button>
          </div>
        </form>
      </Modal>

      <Modal isOpen={showScheduleModal} onClose={() => setShowScheduleModal(false)} title="Programar Partido">
        <form onSubmit={handleScheduleMatch} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Fecha y Hora</label>
            <input
              type="datetime-local"
              value={scheduleData.scheduled_at}
              onChange={(e) => setScheduleData({ ...scheduleData, scheduled_at: e.target.value })}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700">Complejo</label>
            <select
              value={scheduleData.venue}
              onChange={(e) => setScheduleData({ ...scheduleData, venue: e.target.value })}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="">Seleccione un complejo</option>
              {venues.map(venue => (
                <option key={venue.id} value={venue.name}>
                  {venue.name} ({venue.courts_count} canchas)
                </option>
              ))}
            </select>
            <p className="mt-1 text-xs text-gray-500">
              Puede agregar más complejos desde el menú "Complejos"
            </p>
          </div>
          <div className="flex justify-end space-x-3 pt-4 border-t">
            <button
              type="button"
              onClick={() => setShowScheduleModal(false)}
              className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              Cancelar
            </button>
            <button
              type="submit"
              disabled={loading}
              className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50"
            >
              {loading ? 'Guardando...' : 'Programar'}
            </button>
          </div>
        </form>
      </Modal>

      {/* MODAL DE GENERACIÓN DE ZONAS MANUAL */}
      <Modal isOpen={showManualZoneModal} onClose={() => setShowManualZoneModal(false)} title="Generar Zonas Manualmente" size="large">
        <div className="space-y-4">
          <p className="text-gray-600">
            Arrastre las parejas a las zonas deseadas. Las parejas no asignadas no serán incluidas en las zonas.
          </p>
          <div className="grid grid-cols-3 gap-4">
            {/* Columna de Parejas Disponibles */}
            <div className="col-span-1 bg-gray-50 p-4 rounded-md border border-gray-200 max-h-[60vh] overflow-y-auto">
              <h3 className="font-semibold text-gray-800 mb-3">Parejas Disponibles ({availableRegistrations.length})</h3>
              <div
                className="space-y-2"
                onDragOver={(e) => e.preventDefault()}
                onDrop={(e) => handleDrop(e, null)}
              >
                {availableRegistrations.map(team => (
                  <div
                    key={team.id}
                    draggable
                    onDragStart={(e) => handleDragStart(e, team)}
                    className="bg-white p-2 border border-gray-200 rounded-md shadow-sm text-sm cursor-grab"
                  >
                    {team.team?.player1?.nombre || team.player1?.nombre} {team.team?.player1?.apellido || team.player1?.apellido} / {team.team?.player2?.nombre || team.player2?.nombre} {team.team?.player2?.apellido || team.player2?.apellido}
                  </div>
                ))}
              </div>
            </div>

            {/* Columnas de Zonas */}
            <div className="col-span-2 grid grid-cols-2 gap-4 max-h-[60vh] overflow-y-auto">
              {manualZones.map((zone, zoneIndex) => (
                <div
                  key={zoneIndex}
                  className="bg-white p-4 rounded-md border border-gray-200"
                  onDragOver={(e) => e.preventDefault()}
                  onDrop={(e) => handleDrop(e, zoneIndex)}
                >
                  <div className="flex justify-between items-center mb-3">
                    <input
                      type="text"
                      value={zone.name}
                      onChange={(e) => {
                        const newZones = [...manualZones]
                        newZones[zoneIndex].name = e.target.value
                        setManualZones(newZones)
                      }}
                      className="font-semibold text-gray-800 border-b border-gray-300 focus:outline-none focus:border-primary-500 w-full mr-2"
                      placeholder={`Zona ${zoneIndex + 1}`}
                    />
                    <button
                      type="button"
                      onClick={() => removeZone(zoneIndex)}
                      className="text-red-500 hover:text-red-700 text-sm"
                    >
                      Eliminar
                    </button>
                  </div>
                  <div className="space-y-2 min-h-[50px] border border-dashed border-gray-300 p-2 rounded-md">
                    {zone.teams.map(team => (
                      <div
                        key={team.id}
                        draggable
                        onDragStart={(e) => handleDragStart(e, team, zoneIndex)}
                        className="bg-gray-100 p-2 border border-gray-200 rounded-md shadow-sm text-sm cursor-grab flex justify-between items-center"
                      >
                        <span>{team.team?.player1?.nombre || team.player1?.nombre} {team.team?.player1?.apellido || team.player1?.apellido} / {team.team?.player2?.nombre || team.player2?.nombre} {team.team?.player2?.apellido || team.player2?.apellido}</span>
                        <button
                          type="button"
                          onClick={() => removeTeamFromZone(zoneIndex, team.id)}
                          className="text-red-400 hover:text-red-600 text-xs ml-2"
                        >
                          x
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
              <button
                type="button"
                onClick={addZone}
                className="col-span-2 bg-gray-100 border border-dashed border-gray-300 rounded-md p-4 text-gray-500 hover:bg-gray-200 flex items-center justify-center space-x-2"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                  <path fillRule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clipRule="evenodd" />
                </svg>
                <span>Agregar Zona</span>
              </button>
            </div>
          </div>
          <div className="flex justify-end space-x-3 pt-4 border-t">
            <div className="flex-1 text-xs text-red-600 font-semibold flex items-center">
              ⚠️ Al confirmar, se regenerarán todos los partidos. Si ya había resultados cargados, se perderán.
            </div>
            <button
              type="button"
              onClick={() => setShowManualZoneModal(false)}
              className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              Cancelar
            </button>
            <button
              type="button"
              onClick={handleConfirmManualZones}
              disabled={loading || availableRegistrations.length > 0}
              className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary-600 hover:bg-primary-700 disabled:opacity-50"
            >
              Confirmar y Generar Partidos
            </button>
          </div>
        </div>
      </Modal>

      {/* MODAL DE GENERACIÓN DE PLAYOFFS */}
      <Modal isOpen={showPlayoffModal} onClose={() => setShowPlayoffModal(false)} title="Generar Playoffs" size="large">
        <div className="space-y-4">
          <div className="flex space-x-4 border-b border-gray-200">
            <button
              className={`py-2 px-4 ${playoffMode === 'auto' ? 'border-b-2 border-primary-500 text-primary-600 font-medium' : 'text-gray-500'}`}
              onClick={() => setPlayoffMode('auto')}
            >
              Automático
            </button>
            <button
              className={`py-2 px-4 ${playoffMode === 'manual' ? 'border-b-2 border-primary-500 text-primary-600 font-medium' : 'text-gray-500'}`}
              onClick={() => setPlayoffMode('manual')}
            >
              Manual
            </button>
          </div>

          {playoffMode === 'auto' ? (
            <div className="py-4">
              <p className="text-gray-600 mb-4">
                El sistema generará el cuadro automáticamente basándose en los resultados de las zonas y las reglas de clasificación.
              </p>
              <div className="flex justify-end">
                <button
                  onClick={async () => {
                    if (!confirm('¿Generar playoffs con los clasificados actuales?')) return
                    setLoading(true)
                    try {
                      const response = await api.post('/api/admin/playoffs/generate', {
                        tournament_category_id: selectedCategory
                      })
                      if (response.data.ok) {
                        setToast({ message: 'Playoffs generados exitosamente', type: 'success' })
                        setShowPlayoffModal(false)
                        fetchCategoryData()
                      }
                    } catch (error) {
                      setToast({ message: error.response?.data?.error?.message || 'Error', type: 'error' })
                    } finally {
                      setLoading(false)
                    }
                  }}
                  className="bg-primary-600 text-white px-4 py-2 rounded-md hover:bg-primary-700"
                >
                  Confirmar Generación Automática
                </button>
              </div>
            </div>
          ) : (
            <div className="space-y-4 max-h-[70vh] overflow-y-auto pr-2">
              <div>
                <label className="block text-sm font-medium text-gray-700">Ronda Inicial</label>
                <select
                  value={manualPlayoffConfig.totalSlots}
                  onChange={(e) => setManualPlayoffConfig({ ...manualPlayoffConfig, totalSlots: parseInt(e.target.value) })}
                  className="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-primary-500 focus:border-primary-500 sm:text-sm rounded-md"
                >
                  <option value="4">Semifinales (4 Equipos)</option>
                  <option value="8">Cuartos de Final (8 Equipos)</option>
                  <option value="16">Octavos de Final (16 Equipos)</option>
                  <option value="32">16vos de Final (32 Equipos)</option>
                </select>
              </div>

              <div className="space-y-3">
                <h4 className="font-medium text-gray-900">Configuración de Cruces (Ronda 1)</h4>
                {manualPlayoffConfig.matches.map((match, idx) => (
                  <div key={idx} className="bg-gray-50 p-3 rounded-md border border-gray-200">
                    <p className="text-sm font-bold text-gray-700 mb-2">Partido {match.match_number}</p>
                    <div className="grid grid-cols-2 gap-4">
                      {/* HOME TEAM */}
                      <div>
                        <span className="block text-xs font-semibold text-gray-500 uppercase">Local</span>
                        <div className="flex space-x-2">
                          <select
                            className="text-sm border-gray-300 rounded-md w-2/3"
                            value={match.home.zone_id}
                            onChange={(e) => {
                              const newMatches = [...manualPlayoffConfig.matches]
                              newMatches[idx].home.zone_id = e.target.value
                              setManualPlayoffConfig({ ...manualPlayoffConfig, matches: newMatches })
                            }}
                          >
                            <option value="">(Bye / Vacío)</option>
                            {zones.map(z => (
                              <option key={z.id} value={z.id}>{z.name}</option>
                            ))}
                          </select>
                          <select
                            className="text-sm border-gray-300 rounded-md w-1/3"
                            value={match.home.position}
                            onChange={(e) => {
                              const newMatches = [...manualPlayoffConfig.matches]
                              newMatches[idx].home.position = parseInt(e.target.value)
                              setManualPlayoffConfig({ ...manualPlayoffConfig, matches: newMatches })
                            }}
                          >
                            {[1, 2, 3, 4, 5, 6].map(p => (
                              <option key={p} value={p}>{p}º</option>
                            ))}
                          </select>
                        </div>
                      </div>

                      {/* AWAY TEAM */}
                      <div>
                        <span className="block text-xs font-semibold text-gray-500 uppercase">Visitante</span>
                        <div className="flex space-x-2">
                          <select
                            className="text-sm border-gray-300 rounded-md w-2/3"
                            value={match.away.zone_id}
                            onChange={(e) => {
                              const newMatches = [...manualPlayoffConfig.matches]
                              newMatches[idx].away.zone_id = e.target.value
                              setManualPlayoffConfig({ ...manualPlayoffConfig, matches: newMatches })
                            }}
                          >
                            <option value="">(Bye / Vacío)</option>
                            {zones.map(z => (
                              <option key={z.id} value={z.id}>{z.name}</option>
                            ))}
                          </select>
                          <select
                            className="text-sm border-gray-300 rounded-md w-1/3"
                            value={match.away.position}
                            onChange={(e) => {
                              const newMatches = [...manualPlayoffConfig.matches]
                              newMatches[idx].away.position = parseInt(e.target.value)
                              setManualPlayoffConfig({ ...manualPlayoffConfig, matches: newMatches })
                            }}
                          >
                            {[1, 2, 3, 4, 5, 6].map(p => (
                              <option key={p} value={p}>{p}º</option>
                            ))}
                          </select>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>

              <div className="flex justify-end pt-4">
                 <button
                  type="button"
                  onClick={handleManualPlayoffSubmit}
                  className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700"
                >
                  Generar Cuadro Manual
                </button>
              </div>
            </div>
          )}
        </div>
      </Modal>
    </div>
  )
}

