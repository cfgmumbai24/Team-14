const express = require('express')
const User = require('../models/user')
const Mentor = require('../models/mentor')
const userRouter = express.Router()

userRouter.post('/api/users/:userId/addMentor', async (req, res) => {
  try {
    const { userId } = req.params
    const { mentorId } = req.body

    // Check if both user and mentor exist
    const user = await User.findById(userId)
    const mentor = await Mentor.findById(mentorId)

    if (!user) {
      return res.status(404).json({ msg: 'User not found' })
    }
    if (!mentor) {
      return res.status(404).json({ msg: 'Mentor not found' })
    }

    // Add the mentor to the user
    user.mentor = mentorId
    await user.save()

    res.status(200).json(user)
  } catch (e) {
    res.status(500).json({ error: e.message })
  }
})

userRouter.put('/api/users/:userId/update-mentor', async (req, res) => {
  try {
    const userId = req.params.userId
    const { mentorId } = req.body

    // Validate the mentorId
    if (!mongoose.Types.ObjectId.isValid(mentorId)) {
      return res.status(400).json({ msg: 'Invalid mentor ID' })
    }
    const mentor = await User.findById({ _id: mentorId })
    if (!mentor) {
      return res.status(400).json({ msg: 'Mentor not found' })
    }

    // Find the user by ID and update the mentor field
    const user = await User.findByIdAndUpdate(
      userId,
      { mentor: mentorId },
      { new: true, runValidators: true }
    )

    if (!user) {
      return res.status(404).json({ msg: 'User not found' })
    }

    res.json(user)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

module.exports = userRouter
