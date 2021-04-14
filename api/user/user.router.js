const router = require("express").Router();
const { checkToken } = require("../../auth/token_validation");
const { isAdmin } = require("../../auth/position_validation");
const { userValidation } = require("../../validation/user/user.validation");
//Upload single Image
const { folderAvatar, uploadImage } = require("../../utils/uploadImage");
//User Controller
const {
    createUser,
    getUsers,
    getUserByUserId,
    updateUser,
    deleteUser,
    Login,
    getNameStore,
} = require("./user.controller");

router.post("/", uploadImage(folderAvatar).fields([{ name: 'avatar', maxCount: 1 }]), userValidation, createUser);
router.get("/", getUsers);
router.get("/:id", getUserByUserId);
router.patch("/", checkToken, isAdmin, uploadImage(folderAvatar).fields([{ name: 'avatar', maxCount: 1 }]), updateUser);
router.delete("/", deleteUser);
//Login
router.post("/login", Login);
//Test
router.get("/check/getNameStore", checkToken, getNameStore);

module.exports = router;