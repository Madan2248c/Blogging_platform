const express = require('express');
const bodyParser = require('body-parser');
const BlogRoute = require("./routes/blog.route");

app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use("/blog", BlogRoute)
app.use("/uploads",express.static('./uploads'))
app.get("/", (req, res) => {
    res.send("Hello World")
})

app.listen(3000, () => {
    console.log("server running on port 3000");
})
