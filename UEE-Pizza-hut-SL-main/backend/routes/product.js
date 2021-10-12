const express = require('express');
const Item = require('../modals/item');
const Cart_Item = require('../modals/cart_item')
const Cart = require('../modals/cart')
const app = express()

const router = express.Router({});

router.get('/', async (_req, res, _next) => {
    const data = await Item.find({})

    res.send(data)
});


router.get('/search/:txt', async (_req, res, _next) => {
    // const index = Item.createIndex( { itemTitle: "text", description: "text" } )
    const data = await Item.find({$text:{$search: _req.params.txt}})

    res.send(data)
});

router.get('/:type', async (_req, res, _next) => {
    const data = await Item.find({type : _req.params.type})

    res.send(data)
});

router.post('/', async (req, res, _next) => {
    const data = await Item.create({
        itemTitle : req.body.itemTitle,
        description : req.body.description,
        price : req.body.price,
        imageUrl : req.body.imageUrl,
        size : req.body.size,
        crust : req.body.crust,
        additions : req.body.additions,
        mini_desc : req.body.mini_desc,
        type : req.body.type
    })

    res.send(data)
});

router.post('/cart-item', async (req, res, _next) => {
    //console.log(req.body.additions);

    var totPrice = 0;
    for(i = 0; i < req.body.additions.length; i++){
        console.log(JSON.parse(req.body.additions[i]).price);
        totPrice = totPrice + JSON.parse(req.body.additions[i]).price
    }

    totPrice = totPrice + JSON.parse(req.body.pizzaPrice)

    // console.log(totPrice);
    // console.log(req.body.userId);

    console.log(req.body.count);


    const data = await Cart_Item.create({
        size : req.body.size,
        crust : req.body.crust,
        additions : req.body.additions,
        count : req.body.count,
        totPrice : totPrice,
        isSelected : false,
        pizzaPrice : req.body.pizzaPrice,
        image : req.body.image,
        productName : req.body.productName
    })

    console.log(data);

    const updateCart = await Cart.findOneAndUpdate({user_id : req.body.userId}, {$push : {items : data._id}})

    res.status(200).send(data)
});


//get cart items from the cart fro logged in user
router.get('/get-cart-items/:id',async (req,res) =>{
    
    try {
        const items = await Cart.findOne({user_id : req.params.id}).populate('items')
        console.log(items);

        res.status(200).send(items['items'])
    } catch (error) {
        res.status(500).send(error)
    }

});

router.post('/cart-item/:id', async (req, res, _next) => {
    console.log(req.body.isSelcted);
    try {
        await Cart_Item.findOneAndUpdate({_id : req.params.id}, {isSelected : req.body.isSelcted})
    } catch (error) {
        
    }
    
});

//get cart items from the cart fro logged in user
router.get('/get-selected/:id',async (req,res) =>{
    
    try {
        var totSel = 0;
        var totMoney = 0;
        const items = await Cart.findOne({user_id : req.params.id}).populate('items')
        console.log(items);

        for(i = 0; i < items['items'].length; i++){
            console.log(items['items'][i].isSelected);
            if(items['items'][i].isSelected){
                totSel = totSel + 1;
                totMoney = totMoney + items['items'][i].totPrice;
            }
        }

        res.status(200).json({"sel" : totSel, "price" : totMoney})
    } catch (error) {
        res.status(500).send(error)
    }

});


// export router with all routes included
module.exports = router;