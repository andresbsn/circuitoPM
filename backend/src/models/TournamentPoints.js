const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const TournamentPoints = sequelize.define('TournamentPoints', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  tournament_category_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'tournament_categories',
      key: 'id'
    }
  },
  player_dni: {
    type: DataTypes.STRING(20),
    allowNull: false,
    references: {
      model: 'player_profiles',
      key: 'dni'
    }
  },
  team_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'teams',
      key: 'id'
    }
  },
  points: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  },
  position: {
    type: DataTypes.STRING(50),
    allowNull: false,
    comment: 'Campeón, Subcampeón, Semifinal, Cuartos, Octavos, Zona'
  },
  awarded_at: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: DataTypes.NOW
  }
}, {
  tableName: 'tournament_points',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      fields: ['player_dni']
    },
    {
      fields: ['tournament_category_id']
    },
    {
      unique: true,
      fields: ['tournament_category_id', 'player_dni']
    }
  ]
});

module.exports = TournamentPoints;
