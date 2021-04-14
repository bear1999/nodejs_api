const { genSaltSync, hashSync, compareSync } = require("bcrypt");
const { sign } = require("jsonwebtoken");
const AppError = require("../../utils/appError");
const catchAsync = require("../../utils/catchAsync");
var fs = require('fs');
const { folderAvatar } = require("../../utils/uploadImage");

//Service
const {
    create,
    getUsers,
    getUserByUserId,
    updateUser,
    deleteUser,
    getUserByEmail, //Login
    getNameStore
} = require("../user/user.service");

module.exports = {
    getNameStore: catchAsync(async (req, res, next) => {
        const result = await getNameStore(req.decoded.IDUser);
        if (result)
            return res.status(200).json({
                success: 1,
                message: result
            })
        else throw new AppError('Name Store not found!', 404);
    }),
    //Login
    Login: catchAsync(async (req, res, next) => {
        const body = req.body;
        const results = await getUserByEmail(body.Email);
        if (!results)
            throw new AppError('Invalid Email!', 400);
        const result = compareSync(body.Password, results.Password);
        if (result) {
            results.Password = undefined;
            const jsontoken = sign({ IDUser: results.IDUser, IdPosition: results.IdPosition }, process.env.JWT_KEY, {
                expiresIn: "1h"
            });
            return res.status(200).json({
                success: 1,
                message: "Login success",
                token: jsontoken
            });
        }
        else throw new AppError('Invalid Password!', 400);
    }),
    //CREATE User
    createUser: catchAsync(async (req, res, next) => {
        const body = req.body;
        let nameAvatar;
        const salt = genSaltSync(10);
        body.Password = hashSync(body.Password, salt);
        if (req.files['avatar'])
            nameAvatar = req.files['avatar'][0].filename;
        await create(body, nameAvatar);
        return res.status(200).json({
            success: 1,
            message: "Register success"
        });
    }),
    //GET User
    getUsers: catchAsync(async (req, res, next) => {
        const result = await getUsers();
        return res.status(200).json({
            success: 1,
            message: result
        });
    }),
    //GET User By Id
    getUserByUserId: catchAsync(async (req, res, next) => {
        const id = req.params.id;
        const results = await getUserByUserId(id);
        if (!results) {
            throw new AppError('Record not found!', 404);
        }
        results.Password = undefined;
        return res.status(200).json({
            success: 1,
            message: results
        });
    }),
    //UPDATE User
    updateUser: catchAsync(async (req, res, next) => {
        const body = req.body;
        // Remove imageAvatar
        const getInfo = await getUserByUserId(body.id);
        getInfo.Password = undefined;
        if (getInfo.imageAvatar && req.fileName) {
            fs.unlinkSync(folderAvatar + getInfo.imageAvatar, function (err) {
                if (err) console.log(err);
            });
        }
        const result = await updateUser(body, req.fileName);
        if (result.affectedRows) {
            return res.status(200).json({
                success: 1,
                message: "Update success"
            });
        } else throw new AppError('Update fail', 400);
    }),
    deleteUser: catchAsync(async (req, res, next) => {
        const body = req.body;
        const result = await deleteUser(body);
        if (result.affectedRows) {
            return res.status(200).json({
                success: 1,
                message: "Remove success"
            });
        } else throw new AppError('Remove fail!', 400);
    })
}