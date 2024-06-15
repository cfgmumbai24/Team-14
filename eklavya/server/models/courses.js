const mongoose = require('mongoose')

const courseSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
  },
  videos: [
    {
      type: String,
      required: true,
    },
  ],
  duration: {
    type: Number,
    required: true,
  },
  type: {
    type: String,
    required: true,
  },
})

const Course = mongoose.model('Course', courseSchema)
module.exports = { Course, courseSchema }
