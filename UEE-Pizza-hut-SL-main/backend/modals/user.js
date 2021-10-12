const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const userSchema = new Schema({

    fullName: {
        type: String,
        required: true
    },
    email:{
        type:String,
        required: true
    },
    mobileNumber:{
        type: String, 
        required: true, 
    },
    deliveryAddress:{
        type: String, 
        required: true, 
    },
    password:{
        type: String, 
        required: true, 
    },
    cart : {
        type : Schema.Types.ObjectId,
        ref : 'cart'
    },
    PaymentCards:[{
        type : Schema.Types.ObjectId , ref : 'PaymentCard'
    }]
})

const User = mongoose.model("user", userSchema);
module.exports = User;