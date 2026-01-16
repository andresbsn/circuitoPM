const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const ZoneTeam = sequelize.define('ZoneTeam', {
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
  }
}, {
  tableName: 'zone_teams',
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

module.exports = ZoneTeam;
