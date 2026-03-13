export const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString('es-AR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

export const formatDateTime = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleString('es-AR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
    timeZone: 'America/Argentina/Buenos_Aires'
  })
}

export const formatDateForInput = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  // Get Argentina time parts
  const formatter = new Intl.DateTimeFormat('en-GB', {
    timeZone: 'America/Argentina/Buenos_Aires',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  })
  
  const parts = formatter.formatToParts(date)
  const getPart = (type) => parts.find(p => p.type === type).value
  
  // en-GB parts: day, month, year, hour, minute
  // We need YYYY-MM-DDTHH:mm
  return `${getPart('year')}-${getPart('month')}-${getPart('day')}T${getPart('hour')}:${getPart('minute')}`
}

export const formatMatchDate = (dateString) => {
  if (!dateString) return 'A confirmar'
  const date = new Date(dateString)
  
  const weekday = date.toLocaleDateString('es-AR', { 
    weekday: 'short', 
    timeZone: 'America/Argentina/Buenos_Aires' 
  }).toUpperCase().replace('.', '')

  const formatter = new Intl.DateTimeFormat('es-AR', {
    timeZone: 'America/Argentina/Buenos_Aires',
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    hour12: false
  })

  const parts = formatter.formatToParts(date)
  const getPart = (type) => parts.find(p => p.type === type).value

  return `${weekday}, ${getPart('day')}-${getPart('month')}-${getPart('year')} ${getPart('hour')}:${getPart('minute')}`
}

export const getPlayerFullName = (player) => {
  if (!player) return ''
  return `${player.nombre} ${player.apellido}`
}

export const getTeamName = (team) => {
  if (!team) return ''
  const player1Name = getPlayerFullName(team.player1)
  const player2Name = getPlayerFullName(team.player2)
  return `${player1Name} / ${player2Name}`
}

export const handleApiError = (error) => {
  return error.response?.data?.error?.message || 'Error en la solicitud'
}

export const isActiveTeam = (team) => {
  return team?.estado === 'activa'
}

export const filterActiveTeams = (teams) => {
  return teams.filter(isActiveTeam)
}
