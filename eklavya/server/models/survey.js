const mongoose = require('mongoose')

const surveySchema = new mongoose.Schema({
  ageGroup: {
    type: String,
  },
  gender: {
    type: String,
  },
  educationLevel: {
    type: String,
  },
  fieldOfStudy: {
    type: String,
  },
  currentStatus: {
    type: String,
  },
  learningStyles: [{
    type: String,
  }],
  studyEnvironment: {
    type: String,
  },
  studyHours: {
    type: String,
  },
  devicesUsed: [{
    type: String,
  }],
  onlineResourceUsage: {
    type: String,
  },
  courseSatisfaction: {
    type: String,
  },
  curriculumRelevance: {
    type: String,
  },
  instructorQuality: {
    type: String,
  },
  advisingHelpfulness: {
    type: String,
  },
  academicResources: [{
    type: String,
  }],
  challenges: [{
    type: String,
  }],
  suggestions: {
    type: String,
  },
  postGraduationPlans: {
    type: String,
  },
  careerAspirations: {
    type: String,
  },
  overallSatisfaction: {
    type: String,
  },
  recommendationLikelihood: {
    type: String,
  },
})

const Survey = mongoose.model('Survey', surveySchema)
module.exports = Survey
