const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const BlogHelper = require('../helpers/blog.helper');

const imageStorage = multer.diskStorage({
    destination: 'uploads',
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '_' + Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: imageStorage });

router.get('/allBlogs', async (req, res) => {
    var allBlogs = await BlogHelper.getAllBlogs();
    console.log(allBlogs);
    
    res.send(allBlogs);
});

router.post('/newblog', upload.single('image'), async (req, res) => {
    var filename = req.file.filename
    var newBlog = BlogHelper.newBlog(req.body,filename);

    console.log(newBlog);
    res.send("Successfully added blog");
});

module.exports = router;
