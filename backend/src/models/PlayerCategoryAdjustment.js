const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const PlayerCategoryAdjustment = sequelize.define('PlayerCategoryAdjustment', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  player_dni: {
    type: DataTypes.STRING(20),
    allowNull: false
  },
  category_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  source_category_id: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  points: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  },
  reason: {
    type: DataTypes.STRING(50),
    allowNull: false,
    defaultValue: 'ascenso'
  }
}, {
  tableName: 'player_category_adjustments',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = PlayerCategoryAdjustment;
