const multer = require("multer");
const path = require("path");
const AppError = require("./appError");
var fs = require('fs');

function removeImageWhenNotValidation(folder, name, req) {
    if (req.files[name]) {
        fs.unlinkSync(folder + req.files[name][0].filename, function (err) {
            if (err) console.log(err);
        });
    }
}

const fileFilter = (req, file, cb) => {
    if (file.mimetype === "image/png" || file.mimetype === "image/jpg" || file.mimetype === "image/jpeg")
        cb(null, true);
    else throw new AppError("Image only format PNG,JPG,JPEG", 400);
}

function Storage(local) {
    return multer.diskStorage({
        destination: local,
        filename: (req, file, cb) => {
            return cb(null, `${Math.floor(Math.random() * 99999) + 10000}_${Date.now()}${path.extname(file.originalname).toLowerCase()}`)
        }
    });
}

function uploadImage(link) {
    return multer({
        storage: Storage(link),
        fileFilter: fileFilter,
        limits: { fileSize: 5000000 }
    });
}

module.exports = {
    uploadImage: uploadImage,
    removeImageWhenNotValidation: removeImageWhenNotValidation,
    folderAvatar: './public/assets/avatar/',
    folderProduct: './public/assets/product/'
};
