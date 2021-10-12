const express = require('express');
const addons = require('../modals/addons');
const app = express()

const router = express.Router({});


router.get('/', async (_req, res, _next) => {
    const data = await addons.find()

    res.send(data)
});

router.post('/', async (req, res, _next) => {
    const data = await addons.create({
        name : req.body.name,
        imageUrl : req.body.imageUrl,
        price : req.body.price
    })

    res.send(data)
});

// export router with all routes included
module.exports = router;