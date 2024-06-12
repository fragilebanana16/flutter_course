'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class TodoItem extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      TodoItem.belongsTo(models.Todo, {
        foreignKey: 'todoId',
        onDelete: 'CASCADE',
      });
    }
  }
  TodoItem.init({
    content: DataTypes.STRING,
    complete: DataTypes.BOOLEAN
  }, {
    sequelize,
    modelName: 'TodoItem',
  });
  return TodoItem;
};