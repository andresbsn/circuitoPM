const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ZoneStanding = sequelize.define('ZoneStanding', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  zone_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  team_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  played: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  wins: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  losses: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  points: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  sets_for: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  sets_against: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  sets_diff: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  games_for: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  games_against: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  },
  games_diff: {
    type: DataTypes.INTEGER,
    defaultValue: 0
  }
}, {
  tableName: 'zone_standings',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      unique: true,
      fields: ['zone_id', 'team_id']
    }
  ]
});

module.exports = ZoneStanding;
