const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const cart_item = new Schema({

    size:{
        type:String,
        required: true
    },
    crust:{
        type: String, 
        required: true, 
    },
    additions: {
        type: Array,
        required: true
    },
    totPrice : {
        type : Number,
        required : false
    },
    isSelected : {
        type : Boolean,
        required : false
    },
    pizzaPrice : {
        type : Number,
        required : false
    },
    image : {
        type : String,
        required : false
    },
    productName : {
        type : String,
        required : false
    },
    count : {
        type : Number,
        required : true
    },
})

const cart_itemObj = mongoose.model("cart_item", cart_item);
module.exports = cart_itemObj;
