const { userSignUp } = require("./user.schema");
const { removeImageWhenNotValidation, folderAvatar } = require("../../utils/uploadImage");
const AppError = require("../../utils/appError");

module.exports = {
    userValidation: async (req, res, next) => {
        try {
            const value = await userSignUp.validateAsync(req.body);
            if (!req.files['avatar'])
                throw new AppError('Avatar is require', 400);
            else if (value.error)
                throw new AppError(value.error.details[0].message, 400);
            else next();
        } catch (err) {
            // Remove image when not validation
            removeImageWhenNotValidation(folderAvatar, 'avatar', req);
            next(err);
        }
    }
}