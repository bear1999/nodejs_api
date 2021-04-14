const pool = require("../../config/database");

module.exports = {
    getNameStore: (id) => {
        return new Promise((resolve, reject) => {
            pool.query(`SELECT b.nameStore 
                        FROM user a 
                        JOIN store b ON a.idStore = b.idStore
                        WHERE a.IDUser = ?`, [id],
                (error, results, fields) => {
                    if (error) return reject(error);
                    return resolve(results[0]);
                });
        });
    },
    //Login
    getUserByEmail: (Email) => {
        return new Promise((resolve, reject) => {
            pool.query("SELECT * FROM user WHERE Email = ?", [Email],
                (error, results, fields) => {
                    if (error) return reject(error);
                    return resolve(results[0]);
                }
            );
        });
    },
    //CREATE User
    create: (data, fileName) => {
        return new Promise((resolve, reject) => {
            pool.query("INSERT INTO user VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)",
                [data.Username, data.Gender, data.Email, data.Password, data.NumberPhone, data.IdPosition, fileName, data.idStore],
                (error, results) => {
                    if (error) return reject(error);
                    return resolve(results);
                }
            );
        });
    },
    //GET User
    getUsers: () => {
        return new Promise((resolve, reject) => {
            pool.query("SELECT `IDUser`, `Username`, `Gender`, `Email`, `NumberPhone`, `imageAvatar` FROM user", [],
                (error, results, fields) => {
                    if (error) return reject(error);
                    return resolve(results);
                }
            );
        });
    },
    //GET User by ID
    getUserByUserId: (id) => {
        return new Promise((resolve, reject) => {
            pool.query("SELECT * FROM user WHERE IDUser = ?", [id],
                (error, results, fields) => {
                    if (error) return reject(error);
                    return resolve(results[0]);
                }
            );
        });
    },
    //UPDATE User
    updateUser: (data, fileName) => {
        return new Promise((resolve, reject) => {
            let query, value;
            if (fileName) {
                query = "UPDATE user SET `Username` = ?, `Gender` = ?, `Email` = ?, `NumberPhone` = ?, imageAvatar = ? WHERE IDUser = ?";
                value = [data.Username, data.Gender, data.Email, data.NumberPhone, fileName, data.id];
            } else {
                query = "UPDATE user SET `Username` = ?, `Gender` = ?, `Email` = ?, `NumberPhone` = ? WHERE IDUser = ?";
                value = [data.Username, data.Gender, data.Email, data.NumberPhone, data.id];
            }
            pool.query(query, value, (error, results, fields) => {
                if (error) return reject(error);
                return resolve(results);
            });
        });
    },
    //DELETE User
    deleteUser: (data) => {
        return new Promise((resolve, reject) => {
            pool.query("DELETE FROM user WHERE IDUser = ?",
                [data.id],
                (error, results, fields) => {
                    if (error) return reject(error);
                    return resolve(results);
                }
            );
        });
    }
};