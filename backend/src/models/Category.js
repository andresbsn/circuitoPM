const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Category = sequelize.define('Category', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING(50),
    allowNull: false,
    set(val) {
      this.setDataValue('name', val ? val.toUpperCase() : val);
    }
  },
  rank: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  gender: {
    type: DataTypes.ENUM('caballeros', 'damas'),
    allowNull: false,
    defaultValue: 'caballeros'
  },
  active: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  }
}, {
  tableName: 'categories',
  timestamps: true,
  createdAt: 'created_at',
  updatedAt: 'updated_at',
  indexes: [
    {
      unique: true,
      fields: ['name', 'gender']
    },
    {
      unique: true,
      fields: ['rank', 'gender']
    }
  ]
});

module.exports = Category;
