const mongoose = require('mongoose')

const feedbackSchema = new mongoose.Schema({
  overallSatisfaction: {
    type: String,
  },
  courseContent: {
    type: String,
  },
  courseMaterials: {
    type: String,
  },
  pacing: {
    type: String,
  },
  instructorEffectiveness: {
    type: String,
  },
  courseOrganization: {
    type: String,
  },
  additionalComments: {
    type: String,
  },
})

const Feedback = mongoose.model('Feedback', feedbackSchema)

module.exports = Feedback
