var {Sequelize,DataTypes} = require("sequelize");
var models = require("../models")


var BlogHelper = {
    route : '/blogs',
    
    getAllBlogs : async function () {
        let blogs = await models.blogs.findAll()
        return blogs;
        // console.log(blogs);
    },

    newBlog : async function (body,filename) {
        let blog = await models.blogs.create({title : body.title, image : filename, description : body.content})
        if(blog){
            return blog;
        }
        return null;
    }
}

module.exports = BlogHelper