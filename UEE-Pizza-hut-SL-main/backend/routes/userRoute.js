const express = require("express");
const app = express();
const User = require("../modals/user");
const Cart = require("../modals/cart");
const Feedback = require("../modals/feedback");
const Order = require("../modals/Order");
const router = require("express").Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");


//User Registration
router.post("/register", async (req, res) => {

  const isExisting = await User.findOne({ email: req.body.email });

  if (isExisting) {
    res.json({ status: 401, message: "user already exist" });
  } else {

    //cart creation -----------------------------------------------------------------
        //creating a new cart for the user
        var cartId;

        const cartItem = await new Cart({
          user_id : null,
          items : []
        }).save()
    
        cartItem.save().then(data =>{
          cartId = data._id;
          console.log(cartId);
        }).catch(err =>{
          console.log(err);
        })

    


    let full_name = req.body.full_name;
    let email = req.body.email;
    let mobile_number = req.body.mobile_number;
    let delivery_address = req.body.delivery_address;
    let password = req.body.password;

    const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(password, salt);

    const user = await new User({
      fullName: full_name,
      email: email,
      mobileNumber: mobile_number,
      deliveryAddress: delivery_address,
      password: hash,
      cart : cartId
    });

    user.save().then(data => {

      updateCart(data, cartId)

      res.json({ status: 201, message: "user registered" });
    });
  }
});

async function  updateCart (data, cartId){
  console.log(data, cartId);
  //adding the user to cart
  await Cart.findByIdAndUpdate({_id : cartId} , {user_id : data._id});
}


//User Login
router.post("/login", async (req, res) => {
  try {
    let email = req.body.email;
    let password = req.body.password;

    const user = await User.findOne({ email: email }).populate('cart');

    if (user) {
      const auth = await bcrypt.compare(password, user.password);
      if (auth) {
        const accessToken = jwt.sign(
          { user },
          process.env.ACCESS_TOKEN_SECRET_KEY,
          {
            expiresIn: "1h",
          }
        );
        res.json({ status: 200, token: accessToken, user: user });
      } else {
        res.json({ status: 401, message: "unauthorized" });
      }
    } else {
      res.json({ status: 404, message: "user does not exist." });
    }
  } catch (err) {
    res.json({ error: err });
  }
});


//View User Profile
router.get("/:id", async (req, res) => {
  try {
    
    let userID = req.params.id;
    const user = await User.findOne({ _id:userID });

    if (user) {
      const orders = await Order.find({"user": userID}).populate('items');
        res.json({ status: 200, user: user, orders: orders});
    } else {
      res.json({ status: 404, message: "user does not exist." });
    }
  } catch (err) {
    res.json({ error: err });
  }
});


//Update User Profile
router.put("/update/:id", async (req, res) => {

  try{
  const userID = req.params.id;
  let updateUser;

    let full_name = req.body.full_name;
    let email = req.body.email;
    let mobile_number = req.body.mobile_number;
    let delivery_address = req.body.delivery_address;

    updateUser = {
      fullName: full_name,
      email: email,
      mobileNumber: mobile_number,
      deliveryAddress: delivery_address,
    };
  
  await User.findByIdAndUpdate(userID, updateUser).then((user) => {
    res.json({ status: 200, message: "user updated", user: user });
  });

  }

catch(e){
  res.json({ status: 200, error: e });
}

});

//update password
router.put("/update_password/:id", async (req, res) => {

  try{

  const userID = req.params.id;
  let updateUser;

    let user = await User.findOne({_id: userID});
    const auth = await bcrypt.compare(req.body.old_password, user.password);

    if(auth){
      let password = req.body.new_password;
  
      const salt = await bcrypt.genSalt();
      const hash = await bcrypt.hash(password, salt);

      updateUser = {
        password: hash,
      };
    }
    else{
      res.json({ status: 401, error: "Password does not match" });
    }

  await User.findByIdAndUpdate(userID, updateUser).then((user) => {
    res.json({ status: 200, message: "password updated", user: user });
  });
}
catch(e){
  res.json({ status: 200, error: e });
}

});

router.post("/feedback/:id", async (req, res) => {

    const feedback = await new Feedback({

      orderId : req.params.id,
      foodRating : req.body.food_rating,
      deliveryRating : req.body.delivery_rating,
      foodFeedback : req.body.food_feedback,
      deliveryFeedback : req.body.delivery_feedback
    });

    feedback.save().then(() => {
      res.json({ status: 201, message: "Feedback saved" });
    });
  
});


module.exports = router;
