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
    minute: '2-digit'
  })
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
