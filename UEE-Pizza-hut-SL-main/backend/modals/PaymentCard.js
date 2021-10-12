const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const PaymentCard = new Schema({

    cardNumber: {
        type: String,
        required: true
    },
    expiryDate:{
        type:String,
        required: true
    },
    cardHolderName:{
        type: String, 
        required: true, 
    },
    cvvCode:{
        type: String, 
        required: true, 
    },
    cardHolder: {
        type: Schema.Types.ObjectId,
        ref: 'user',
        required: true, 
    },
    
})

const card = mongoose.model("PaymentCard", PaymentCard);
module.exports = card;