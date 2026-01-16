const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Match = sequelize.define('Match', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  bracket_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  round_number: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  round_name: {
    type: DataTypes.STRING(50),
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
  winner_team_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  score_json: {
    type: DataTypes.JSONB,
    allowNull: true
  },
  status: {
    type: DataTypes.ENUM('pending', 'played', 'bye'),
    defaultValue: 'pending'
  },
  next_match_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  next_match_slot: {
    type: DataTypes.ENUM('home', 'away'),
    allowNull: true
  },
  scheduled_at: {
    type: DataTypes.DATE,
    allowNull: true
  },
  venue: {
    type: DataTypes.STRING(200),
    allowNull: true
  },
  home_source_zone_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  home_source_position: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  away_source_zone_id: {
    type: DataTypes.INTEGER,
    allowNull: true
  },
  away_source_position: {
    type: DataTypes.INTEGER,
    allowNull: true
  }
}, {
  tableName: 'matches',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = Match;
