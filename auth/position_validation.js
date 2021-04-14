const AppError = require("../utils/appError");

module.exports = {
    isAdmin: (req, res, next) => {
        if (req.decoded.IdPosition != 4) //4 = Admin
            throw new AppError("You don't have access! Admin only", 400);
        else next();
    }
}