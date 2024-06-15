const express = require('express')
const formRouter = express.Router()
const Feedback = require('../models/feedbackForm')

// POST endpoint to save feedback data
formRouter.post('/api/feedback', async (req, res) => {
  try {
    const {
      overallSatisfaction,
      courseContent,
      courseMaterials,
      pacing,
      instructorEffectiveness,
      courseOrganization,
      additionalComments,
    } = req.body
    console.log(req.body)

    // Create a new Feedback instance
    const feedback = new Feedback({
      overallSatisfaction,
      courseContent,
      courseMaterials,
      pacing,
      instructorEffectiveness,
      courseOrganization,
      additionalComments,
    })

    // Save the feedback to MongoDB
    const savedFeedback = await feedback.save()

    res.status(201).json(savedFeedback)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

module.exports = formRouter
