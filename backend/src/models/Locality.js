const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Locality = sequelize.define('Locality', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: DataTypes.STRING(100),
    allowNull: false,
    set(val) {
      this.setDataValue('name', val ? val.toUpperCase() : val);
    }
  },
  province: {
    type: DataTypes.STRING(100),
    allowNull: false,
    defaultValue: 'Buenos Aires'
  }
}, {
  tableName: 'localities',
  timestamps: false
});

module.exports = Locality;
