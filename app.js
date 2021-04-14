require("dotenv").config();
const express = require("express");
const AppError = require("./utils/appError");
const app = express();
const userRouter = require("./api/user/user.router");
const errorController = require("./utils/errorController");

app.use(express.json());
app.use(express.static(__dirname + "/public"));
app.use(express.urlencoded({ extended: true }));

//Controller API
app.use("/api/user", userRouter);
//End API

app.all("*", (req, res) => {
    throw new AppError(`Requested URL ${req.path} not found!`, 404);
});
app.use(errorController);

app.listen(process.env.APP_PORT || 3000, () => {
    console.log("Server is running port: " + process.env.APP_PORT);
});