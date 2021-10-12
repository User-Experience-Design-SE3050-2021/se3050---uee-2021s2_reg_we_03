const mongoose = require('mongoose');
const  Schema = mongoose.Schema;

const itemSchema = new Schema({

    itemTitle: {
        type: String,
        required: true,
        index: true
    },
    description:{
        type:String,
        required: true,
        index: true
    },
    price:{
        type: Number, 
        required: true, 
    },
    imageUrl: {
        type: String,
        required: true
    },
    additions: {
        type: Array,
        required: true
    },
    mini_desc: {
        type: String,
        required: true
    },
    type: {
        type: String,
        required: true
    }
}).index({ itemTitle: 'text', description: 'text'});

// adSchema.index({ itemTitle: 'text', description: 'text'});
// const Ad = Local.model('Ad', adSchema);
// Ad.createIndexes();

// Ad.createIndexes();

const Item = mongoose.model("item", itemSchema);
Item.createIndexes();
module.exports = Item;