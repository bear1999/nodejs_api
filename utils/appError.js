class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.success = 0;
        this.statusCode = statusCode;
        this.isOperational = true;
        Error.captureStackTrace(this, this.constructor);
    }
}

module.exports = AppError;