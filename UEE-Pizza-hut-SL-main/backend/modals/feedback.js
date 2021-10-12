const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const feedBackSchema = new Schema({

    orderId:{
        type: String,
        required: true
    },
    foodRating: {
        type: String,
    },
    deliveryRating:{
        type:String,
    },
    foodFeedback:{
        type: String,  
    },
    deliveryFeedback : {
        type : String
    }
})

const Feedback = mongoose.model("feedback", feedBackSchema);
module.exports = Feedback;