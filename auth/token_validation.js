const jwt = require("jsonwebtoken");
const AppError = require("../utils/appError");

module.exports = {
    checkToken: (req, res, next) => {
        let token = req.get("authorization");
        if (token) {
            token = token.slice(7); // Remove Bearer from string
            jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
                if (err)
                    throw new AppError("Invalid token...", 400);
                else {
                    req.decoded = decoded;
                    next();
                }
            });
        }
        else throw new AppError("Access Denied! Unauthorized User", 400);
    }
};