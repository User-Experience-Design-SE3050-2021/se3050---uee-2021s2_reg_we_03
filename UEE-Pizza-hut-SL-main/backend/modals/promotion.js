const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const promotionSchema = new Schema({

    promotionTitle: {
        type: String,
        required: true
    },
    promoCode: {
        type: String,
        required: true
    },
    description:{
        type:String,
        required: true
    },
    discount:{
        type: Number, 
        required: true, 
    },
    imageUrl: {
        type: String,
        required: true
    },
})

const Promotion = mongoose.model("promotion", promotionSchema);
module.exports = Promotion;