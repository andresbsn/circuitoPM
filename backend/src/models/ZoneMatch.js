const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ZoneMatch = sequelize.define('ZoneMatch', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  zone_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  round_number: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  match_number: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  team_home_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  team_away_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  parent_match_home_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  parent_match_away_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  parent_condition_home: {
    type: DataTypes.STRING(20),
    allowNull: true
  },
  parent_condition_away: {
    type: DataTypes.STRING(20),
    allowNull: true
  },
  status: {
    type: DataTypes.ENUM('pending', 'played'),
    defaultValue: 'pending'
  },
  score_json: {
    type: DataTypes.JSONB,
    allowNull: true
  },
  winner_team_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  played_at: {
    type: DataTypes.DATE,
    allowNull: true
  },
  scheduled_at: {
    type: DataTypes.DATE,
    allowNull: true
  },
  venue: {
    type: DataTypes.STRING(200),
    allowNull: true
  }
}, {
  tableName: 'zone_matches',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = ZoneMatch;
