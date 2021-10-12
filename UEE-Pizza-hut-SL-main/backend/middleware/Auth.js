const jwt = require("jsonwebtoken");



module.exports = auth = (req,res,next) =>{
    const authToken = req.header('auth_token');
    if (!authToken) return  res.json({status: 401, message: 'Authentication token not found!'})
    try {
        req.user = jwt.verify(authToken, process.env.ACCESS_TOKEN_SECRET_KEY);
        next();
    } catch (e) {
        res.json({status: 401, message: 'unauthorized'})
    }
}
