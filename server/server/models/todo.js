'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Todo extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Todo.hasMany(models.TodoItem, {
        foreignKey: 'todoId',
        as: 'todoItems',
      });
    }
  }
  Todo.init({
    title: {
      type: DataTypes.STRING,
      allowNull: false
     },
  }, {
    sequelize,
    modelName: 'Todo',
  });
  return Todo;
};