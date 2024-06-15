const express = require('express')
const User = require('../models/user')
const Mentor = require('../models/mentor')
const bcryptjs = require('bcryptjs')

const authRouter = express.Router()

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { name, email, password } = req.body

    // Check if the user with the same email already exists
    const existingUser = await User.findOne({ email })
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: 'User with the same email already exists!' })
    }

    // Hash the password before saving the user
    const hashedPassword = await bcryptjs.hash(password, 8)

    // Create a new user instance
    let user = new User({
      ...req.body,
      password: hashedPassword,
    })

    // Save the user to the database
    user = await user.save()

    // Respond with the created user
    res.json(user)
  } catch (e) {
    res.status(500).json({ error: e.message })
  }
})
authRouter.post('/api/signup-mentor', async (req, res) => {
  try {
    const { name, email, password } = req.body

    // Check if the user with the same email already exists
    const existingMentor = await Mentor.findOne({ email })
    if (existingMentor) {
      return res
        .status(400)
        .json({ msg: 'Mentor with the same email already exists!' })
    }

    // Hash the password before saving the mentor
    const hashedPassword = await bcryptjs.hash(password, 8)

    // Create a new mentor instance
    let mentor = new Mentor({
      ...req.body,
      password: hashedPassword,
    })

    // Save the mentor to the database
    mentor = await mentor.save()

    // Respond with the created mentor
    res.json(mentor)
  } catch (e) {
    res.status(500).json({ error: e.message })
  }
})

authRouter.post('/api/signin', async (req, res) => {
  // console.log(req.body);
  try {
    const { email, password } = req.body
    const user = await User.findOne({ email })
    if (!user) {
      return res
        .status(400)
        .json({ msg: 'User with this email does not exists!' })
    }
    const isMatch = await bcryptjs.compare(password, user.password)
    if (!isMatch) {
      return res.status(400).json({ msg: 'Incorrect password' })
    }
    res.json(user)
  } catch (e) {
    res.status(500).json({ error: e.message })
  }
})

module.exports = authRouter
