const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const addons = new Schema({

    name: {
        type: String,
        required : true
    },
    imageUrl:{
        type:String,
        required: true
    },
    price:{
        type: Number, 
        required: true, 
    }
})

const addon = mongoose.model("addons", addons);
module.exports = addon;