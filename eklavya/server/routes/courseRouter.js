const express = require('express')
const { Course } = require('../models/courses.js')

const courseRouter = express.Router()

// Route to add a new course
courseRouter.post('/api/add-course', async (req, res) => {
  try {
    const { name, videos, duration, type } = req.body

    // Create a new course instance
    const course = new Course({
      name,
      videos,
      duration,
      type,
    })

    // Save the course to the database
    const savedCourse = await course.save()

    // Respond with the saved course
    res.status(201).json(savedCourse)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

module.exports = courseRouter
