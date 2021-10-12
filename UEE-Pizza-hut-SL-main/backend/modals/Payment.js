const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const Payment = new Schema({

    totalAmmount: {
        type: String,
        required: true
    },
    deliveryChargers:{
        type:String,
        required: true
    },
    discount:{
        type: String, 
        required: true, 
    },
    grossTotal:{
        type: String, 
        required: true, 
    },
    PaymentCard:{
        type : Schema.Types.ObjectId , ref : 'PaymentCard',
        required: true
    }
})

const PaymentObj = mongoose.model("Payment", Payment);
module.exports = PaymentObj;