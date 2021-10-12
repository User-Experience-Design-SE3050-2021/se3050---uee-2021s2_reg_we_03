const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const Order = new Schema({

    status: {
        type: Number,
        required: true
        // 1 for : Accepted
        // 2 for : Dispatched
        // 3 for : Delivering
        // 4 for : Confirmed/Closed
    },
    paymentDateTime:{
        type:String,
        required: true
    },
    totalAmmount:{
        type: Number, 
        required: true, 
    },
    deliveryCost:{
        type: Number, 
        required: true, 
    },
    discount:{
        type: Number, 
        required: true, 
    },
    PaymentCard:{
        type : Schema.Types.ObjectId , ref : 'PaymentCard',
        required: true
    },
    user:{
        type : Schema.Types.ObjectId , 
        ref : 'user',
        required: true
    },
    feedback:{
        type : Schema.Types.ObjectId , 
        ref : 'feedback',
        required: false
    },
    items:[{
        type : Schema.Types.ObjectId , 
        ref : 'cart_item',
        required: false
    }]
})

const OrderObj = mongoose.model("Order", Order);
module.exports = OrderObj;