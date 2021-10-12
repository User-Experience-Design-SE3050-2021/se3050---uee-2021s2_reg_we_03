const express = require('express');
const Promotion = require('../modals/promotion');
const app = express()

const router = express.Router({});

router.get('/', async (_req, res, _next) => {
    const data = await Promotion.find()

    res.send(data)
});

router.post('/', async (req, res, _next) => {
    const data = await Promotion.create({
        promotionTitle : req.body.promotionTitle,
        promoCode : req.body.promoCode,
        description : req.body.description,
        imageUrl : req.body.imageUrl,
        discount : req.body.discount,
    })

    res.send(data)
});

module.exports = router;