var { Sequelize, DataTypes } = require("sequelize");
var config = require("../config/config");

var sequelize = new Sequelize(config.database, config.user, config.password, { 
  host: config.host, 
  dialect: 'mysql' 
});

sequelize.authenticate().then(() => {
   console.log('Connection has been established successfully.');
}).catch((error) => {
   console.error('Unable to connect to the database: ', error);
});

const Blogs = sequelize.define('blogs', {
    id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
    },
    title: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    description: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    image: {
        type: DataTypes.STRING,
        allowNull: true,
    },
}, {
    tableName: 'blogs',
    timestamps: false,
});

sequelize.sync()
  .then(() => {
    console.log('Blogs table has been successfully created, if one doesn\'t exist')
  })
  .catch(error => console.log('This error occurred', error));

module.exports = Blogs;
