const joi = require("@hapi/joi");

//repeat_password: joi.ref('password')
const schema = {
    userSignUp: joi.object({
        Username: joi.string().max(35).required(),
        Gender: joi.string().valid("Nam", "Nữ", "Khác").required(),
        Email: joi.string().email().required(),
        NumberPhone: joi.string().length(10).pattern(new RegExp("^[0-9]{10}$")).required(),
        Password: joi.string().alphanum().min(6).pattern(new RegExp('^[a-zA-Z0-9]{3,30}$')).required(),
        IdPosition: joi.number().integer().min(1).message("Invalid Position")
            .max(4).message("Invalid Position").required(),
        idStore: joi.number().integer().min(1000).message("idStore min is 1000").required()
    }),
    userTest: joi.object({
        IdPosition: joi.number().integer().min(1).message("Invalid Position")
            .max(4).message("Invalid Position").required(),
        idStore: joi.number().integer().min(1000).message("idStore min is 1000").required()
    })
}

module.exports = schema;