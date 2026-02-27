const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Venue = sequelize.define('Venue', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING(200),
    allowNull: false,
    set(val) {
      this.setDataValue('name', val ? val.toUpperCase() : val);
    }
  },
  address: {
    type: DataTypes.STRING(300),
    allowNull: true
  },
  courts_count: {
    type: DataTypes.INTEGER,
    allowNull: true,
    defaultValue: 1
  },
  active: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  }
}, {
  tableName: 'venues',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at'
});

module.exports = Venue;
